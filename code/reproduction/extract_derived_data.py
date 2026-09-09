"""Extract manuscript measurements from original experimental records, offline.

Derived data are regenerated from raw records and versioned scientific code.
No manuscript checkout, figure, or previous derived data is an extraction input.
An optional comparison checks reconstructed values against reference derived data.
Missing inputs and unmatched outputs produce a nonzero exit status.
"""
from __future__ import annotations

import argparse
from collections import defaultdict
import csv
import gzip
import hashlib
import io
import json
import math
from pathlib import Path
import re
import statistics
import struct
import xml.etree.ElementTree as ET

import numpy as np
import yaml

ROOT = Path(__file__).resolve().parents[2]
AB_FIELDS = 'condition run iteration worker candidate navigation_score distance_integral_L release_elapsed total_horizon success'.split()
DRL_FIELDS = 'view method run episode score best_score distance_integral_score training_return cfd_steps teacher_cfd_steps cumulative_cfd_steps candidate iteration'.split()
NUMERIC_TOLERANCES = {
    'float64': {'rtol': 1e-7, 'atol': 1e-9},
    'float32': {'rtol': 1e-6, 'atol': 1e-7},
}


def read_bytes(path):
    path = Path(path)
    data = path.read_bytes()
    return gzip.decompress(data) if path.suffix == '.gz' else data


def read_json(path):
    return json.loads(read_bytes(path))


def read_score(path):
    return yaml.safe_load(read_bytes(path))


def read_csv(path):
    return list(csv.DictReader(io.StringIO(read_bytes(path).decode('utf-8-sig'))))


def sha(data):
    return hashlib.sha256(data).hexdigest()


def read_vti(path):
    """Read the original uncompressed, appended-raw WaterLily VTI format."""
    data = read_bytes(path)
    tag = data.index(b'<AppendedData')
    start = data.index(b'_', data.index(b'>', tag)) + 1
    tree = ET.fromstring(data[:tag] + b'</VTKFile>')
    if tree.get('compressor') or tree.get('byte_order') != 'LittleEndian':
        raise ValueError('Unsupported VTI encoding; use the archived VTK renderer')
    image = tree.find('ImageData')
    extent = list(map(int, image.get('WholeExtent').split()))
    dims = [extent[2*i+1] - extent[2*i] + 1 for i in range(3)]
    origin = list(map(float, image.get('Origin').split()))
    spacing = list(map(float, image.get('Spacing').split()))
    header = '<Q' if tree.get('header_type') == 'UInt64' else '<I'
    fields = {}
    for node in image.findall('.//PointData/DataArray'):
        if node.get('type') != 'Float32' or node.get('format') != 'appended':
            raise ValueError('Unexpected VTI field encoding')
        offset = start + int(node.get('offset'))
        size, = struct.unpack_from(header, data, offset)
        components = int(node.get('NumberOfComponents', '1'))
        a = np.frombuffer(data, dtype='<f4', count=size//4, offset=offset+struct.calcsize(header))
        if len(a) != math.prod(dims)*components:
            raise ValueError('VTI array length does not match geometry')
        fields[node.get('Name')] = a.reshape((*dims[::-1], components)).squeeze()
    return fields, dims, origin, spacing


class Extractor:
    def __init__(self, output):
        self.output = output
        self.records = {}
        self.failures = []
        self.validation = {}

    def target(self, name):
        path = self.output / name
        path.parent.mkdir(parents=True, exist_ok=True)
        return path

    def record(self, name, sources, operation):
        self.records[name] = {
            'operation': operation,
            'inputs': {p.relative_to(ROOT).as_posix(): sha(p.read_bytes()) for p in sources},
            'output_sha256': sha((self.output/name).read_bytes()),
        }

    def csv(self, name, fields, rows, sources, operation):
        with self.target(name).open('w', newline='', encoding='utf-8') as stream:
            writer = csv.DictWriter(stream, fields, extrasaction='ignore', lineterminator='\n')
            writer.writeheader()
            writer.writerows(rows)
        self.record(name, sources, operation)

    def json(self, name, value, sources, operation):
        self.target(name).write_text(json.dumps(value, indent=2)+'\n', encoding='utf-8')
        self.record(name, sources, operation)

    def copy(self, name, source):
        self.target(name).write_bytes(read_bytes(source))
        self.record(name, [source], 'Lossless copy of an original simulator or controller artifact')

    def illustrated_generalization(self):
        fields = ['frame_index', 'sim_time', 'center_x', 'center_y']
        for case in ('a1', 'b3', 'c1', 'd3'):
            source = ROOT / f'raw_data/illustrated_generalization/{case}/simulation/episode/vtk/frames.csv.gz'
            self.csv(f'figure_03/data/{case}_trajectory.csv', fields, read_csv(source), [source],
                     'Original frame-pose samples used by the manuscript vector trajectories; no interpolation')

    def rendering_settings(self):
        for figure in ('02', '03'):
            source = ROOT / f'code/reproduction/figure_{figure}.index.json'
            recipe = read_json(source)
            inputs = [source]
            for name, expected in recipe['inputs'].items():
                local_name = name
                path = ROOT / local_name
                if sha(path.read_bytes()) != expected:
                    raise ValueError('Rendering input identity mismatch: ' + local_name)
                inputs.append(path)
            name = f'figure_{figure}/data/flow_rendering.json'
            self.target(name).write_bytes(source.read_bytes())
            self.record(name, inputs, 'Scientific frame selections, coordinates and color scale; every raw input hash is verified')

    def training(self):
        runs = [{'condition': condition, 'run': run}
                for condition in ('without_shelf', 'with_shelf') for run in range(1, 6)]
        candidates, cost, initial, sources = [], [], [], []
        for run in runs:
            scores = ROOT/'raw_data/policy_scores/two_dimensional'/f"{run['condition']}_{run['run']}"
            seed_path = scores/'seed_policy.yaml'
            sources.append(seed_path)
            seed_score = read_score(seed_path)
            seed = {**seed_score['metrics'], 'score': seed_score['score']}
            cumulative = int(seed['steps'])
            best = -math.inf
            if run['condition']=='with_shelf':
                score = -float(seed['distance_integral_L'])
                initial.append(dict(view='initialization',method='SEAS',run=run['run'],score=score,best_score=score,
                    distance_integral_score=score,training_return=seed['score'],cfd_steps=cumulative,
                    teacher_cfd_steps=0,cumulative_cfd_steps=cumulative))
            for iteration, worker in ((i, w) for i in range(1, 21) for w in range(4)):
                score_path = scores/f'iteration_{iteration:02d}_candidate_{worker+1:02d}_policy.yaml'
                sources.append(score_path)
                payload=read_score(score_path); m=payload['metrics']
                score=-float(m['distance_integral_L'])
                candidate=(iteration-1)*4+worker+1
                candidates.append(dict(condition=run['condition'],run=run['run'],iteration=iteration,worker=worker,
                    candidate=candidate,navigation_score=score,distance_integral_L=m['distance_integral_L'],
                    release_elapsed=m['release_elapsed'],total_horizon=m['total_horizon'],
                    success=bool(m.get('task_success',m.get('success_score',0)>0))))
                cumulative+=int(m['steps']);best=max(best,score)
                if run['condition']=='with_shelf':
                    cost.append(dict(view='cost',method='SEAS',run=run['run'],score=score,best_score=best,
                        distance_integral_score=score,training_return=payload['score'],cfd_steps=m['steps'],
                        teacher_cfd_steps=0,cumulative_cfd_steps=cumulative,candidate=candidate,iteration=iteration))
        candidates.sort(key=lambda x:(x['condition'],x['run'],x['iteration'],x['worker']))
        self.csv('figure_02/data/figure_02_ab_candidates.csv',AB_FIELDS,candidates,sources,
            'Read each saved policy score; navigation_score = -distance_integral_L; preserve all 800 candidates')
        summary=[]
        for panel in ['a','b']:
            for condition in ['with_shelf','without_shelf']:
                for iteration in range(1,21):
                    values=[]
                    for run in range(1,6):
                        selected=[r for r in candidates if r['condition']==condition and r['run']==run and r['iteration']<=iteration]
                        if panel=='a':values.append(max(r['navigation_score'] for r in selected))
                        else:
                            times=[float(r['release_elapsed']) for r in selected if r['success'] and r['iteration']==iteration]
                            if times:values.append(float(np.median(times)))
                    if panel=='a':center,lower,upper=np.mean(values),min(values),max(values)
                    elif values:lower,center,upper=np.quantile(values,[.25,.5,.75])
                    else:center=lower=upper=''
                    summary.append(dict(panel=panel,condition=condition,iteration=iteration,center=center,lower=lower,upper=upper,run_count=len(values)))
        self.csv('figure_02/data/figure_02_ab_reference_summary.csv','panel condition iteration center lower upper run_count'.split(),summary,sources,
            'Panel a: cumulative best score, mean/range across runs. Panel b: successful candidate median within each iteration/run, then median/IQR across runs')
        episodes,drlcost,drlinitial,cohort=[],[],[],[]
        policy_index=ROOT/'code/generalization/policies/index.json'
        policies=read_json(policy_index)
        for run in range(1,6):
            base=ROOT/f'raw_data/drl_training/DRL_{run}'
            path=base/'episodes.jsonl.gz';manifest=base/'configuration.json'
            configuration=read_json(manifest)
            bc_path=base/configuration['bc_metrics'];bc=read_json(bc_path)
            selected_policy=next(p for p in policies if p['policy']==f'DRL_{run}')
            if configuration['arguments']['seed']!=selected_policy['training_seed']:
                raise ValueError('DRL training seed differs from fixed policy: '+str(manifest))
            if (len(bc['epoch_mse'])!=bc['epochs'] or bc['epochs']!=configuration['arguments']['bc_epochs']
                    or bc['training_samples']+bc['validation_samples']!=configuration['bc_dataset']['policy_transitions']):
                raise ValueError('Inconsistent behavior-cloning records: '+str(bc_path))
            inputs=[ROOT/configuration[key]['path'] for key in ['environment_config','teacher_seed_policy']]
            for key,source in zip(['environment_config','teacher_seed_policy'],inputs):
                if sha(source.read_bytes())!=configuration[key]['sha256']:
                    raise ValueError('DRL training input identity differs: '+str(source))
            sources.extend([path,manifest,bc_path]+inputs)
            raw=[json.loads(line) for line in read_bytes(path).splitlines() if line.strip()]
            unique={int(r['training_episode']):r for r in raw}
            if set(unique)!=set(range(1,601)):raise ValueError('DRL episode coverage: '+str(path))
            teacher=int(configuration['bc_dataset']['cfd_transitions'])
            accounting=configuration['data_efficiency_accounting']
            if (accounting['ppo_completed_episodes']!=len(unique) or accounting['ppo_execution_records']!=len(raw)
                    or accounting['teacher_cfd_transitions']!=teacher
                    or accounting['teacher_completed_episodes']!=configuration['bc_dataset']['completed_teacher_episodes']):
                raise ValueError('DRL computation accounting differs from recorded data: '+str(manifest))
            cohort.append(dict(run=run,run_label=selected_policy['policy'],
                original_training_episodes=len(unique),charged_training_records=len(raw),teacher_cfd_steps=teacher,
                policy=f'DRL_{run}',training_records=path.relative_to(ROOT).as_posix(),training_records_sha256=sha(path.read_bytes())))
            best=-math.inf;cumulative=teacher
            for row in raw:
                score=float(row['distance_integral_score']);best=max(best,score);cumulative+=int(row['cfd_steps'])
                drlcost.append(dict(view='cost',method='BC-PPO',run=run,episode=row['training_episode'],score=score,best_score=best,
                    distance_integral_score=score,training_return=row['raw_score'],cfd_steps=row['cfd_steps'],teacher_cfd_steps=teacher,
                    cumulative_cfd_steps=cumulative))
            best=-math.inf
            for episode,row in sorted(unique.items()):
                score=float(row['distance_integral_score']);best=max(best,score)
                episodes.append(dict(view='episode',method='BC-PPO',run=run,episode=episode,score=score,best_score=best,
                    distance_integral_score=score,training_return=row['raw_score']))
            drlinitial.append(dict(view='initialization',method='BC-PPO',run=run,cfd_steps=teacher,teacher_cfd_steps=teacher,cumulative_cfd_steps=teacher))
        self.csv('figure_02/data/figure_02_drl_comparison.csv',DRL_FIELDS,drlcost+cost+episodes+drlinitial+initial,sources,
            'All append-only DRL cost records; last duplicate per episode for episode view; teacher cost from recorded training configuration')
        self.json('figure_02/data/figure_02_drl_cohort.json',{
            'schema':'agent-fluid.figure2-drl-cohort.v2',
            'episode_view':'600 original training episodes per execution; last record retained for duplicate episode indices',
            'cost_view':'All append-only training records and one demonstration collection per execution',
            'score':'Unaugmented distance_integral_score s; training_return is separately retained',
            'rows':len(drlcost+cost+episodes+drlinitial+initial),'drl_episode_rows':len(episodes),'drl_cost_rows':len(drlcost),
            'runs':cohort,'policy_index':'code/generalization/policies/index.json'},
            sources+[policy_index]+[ROOT/r['training_records'] for r in cohort],
            'Count original JSONL records and unique episodes; verify training inputs and identify the frozen policy cohort')

    def mechanisms(self):
        fields0='episode_time_T distance_L center_x_L center_y_L yaw_moment_z_L2 bearing_steering_clipped_effect_a1 bearing_steering_clipped_effect_a2 phase_asymmetry_clipped_effect_a1 phase_asymmetry_clipped_effect_a2 response_burst_clipped_effect_a1 response_burst_clipped_effect_a2'.split()
        for phase in range(3):
            path=ROOT/f'raw_data/physical_mechanisms/phase_{phase}.csv.gz'
            fields=fields0 if phase==0 else ['episode_time_T','distance_L']
            self.csv(f'figure_04/data/phase_{phase}.csv',fields,read_csv(path),[path],'Select documented columns; retain every original time sample')
        path=ROOT/'raw_data/physical_mechanisms/ablation.csv.gz'
        fields='ablation phase_id nominal_target_reached ablated_target_reached nominal_time_to_capture_T ablated_time_to_capture_T delta_time_to_capture_T'.split()
        self.csv('figure_04/data/ablation.csv',fields,read_csv(path),[path],'Select the seven manuscript columns from all 18 paired records')
        source=ROOT/'raw_data/physical_mechanisms/vtk/frames.csv';frames=read_csv(source)
        selected=[]
        for i,number in enumerate([1,2,4]):
            row=next(r for r in frames if int(r['frame_index'])==number)
            row=dict(row,frame_path=f'field_{i}.npz');selected.append(row)
            vti=ROOT/f'raw_data/physical_mechanisms/vtk/wake_flow_{number:06}.vti.gz'
            fields,dims,origin,spacing=read_vti(vti)
            ox,oy=origin[:2];sx,sy=spacing[:2]
            name=f'figure_04/data/field_{i}.npz'
            np.savez_compressed(self.target(name),pressure=fields['Pressure'],vorticity=fields['Vorticity'],sdf=fields['BodySDF'],
                x=ox+np.arange(dims[0])*sx,y=oy+np.arange(dims[1])*sy,ox=ox,oy=oy,sx=sx,sy=sy)
            self.record(name,[vti],'Decode original VTI pressure, vorticity, signed distance and grid coordinates without interpolation')
        self.csv('figure_04/data/frames.csv','sim_time center_x center_y heading frame_path'.split(),selected,[source],
            'Select recorded release, redirect and capture frames 1, 2 and 4')

    def illustrated_2d(self):
        trajectory_index = ROOT/'raw_data/illustrated_2d/trajectories.json'
        trajectory_paths = read_json(trajectory_index)
        centerlines,poses,sources=[],[],[trajectory_index]
        for stage,iteration,label in [('seed',0,'seed'),('i6',6,'iteration_6_champion'),('i19',19,'iteration_19_champion')]:
            folder=ROOT/'raw_data/illustrated_2d'/stage
            path=ROOT/trajectory_paths[stage];frames=folder/'frames.csv.gz';video=folder/'watch_render.mp4'
            sources.extend([path,frames,video])
            data=read_bytes(path);rows=read_csv(path)
            # The accepted centerline archive sampled every 30 solver updates and the endpoint.
            indices=sorted(set(range(0,len(rows),30))|{len(rows)-1})
            for i,j in enumerate(indices):centerlines.append(dict(iteration=iteration,frame_index_zero_based=i,center_x=rows[j]['center_x'],center_y=rows[j]['center_y']))
            count=len(read_csv(frames))
            for i,j in enumerate(np.round(np.linspace(0,len(rows)-1,count)).astype(int)):
                sim_time=200.0+float(rows[j]['time'])
                poses.append(dict(iteration=iteration,source_episode=label,frame_index_zero_based=i,sim_time=sim_time,
                    trajectory_time=rows[j]['time'],**{k:rows[j][k] for k in ['center_x','center_y','heading','phi1','phi2']},
                    trajectory_sha256=sha(data),video_sha256=sha(video.read_bytes())))
        self.csv('figure_02/data/trajectory_centerlines.csv','iteration frame_index_zero_based center_x center_y'.split(),centerlines,sources,
            'Original trajectory rows at stride 30 plus endpoint; no interpolation')
        self.csv('figure_02/data/swimmer_pose_states.csv','iteration source_episode frame_index_zero_based sim_time trajectory_time center_x center_y heading phi1 phi2 trajectory_sha256 video_sha256'.split(),poses,sources,
            'Evenly spaced trajectory row indices, rounded to nearest integer, including both endpoints; 7/6/5 poses matching the archived episode frame counts')

    def moving_window(self):
        for label in ['moving_window4x3','fullfield24x16']:
            base=ROOT/'raw_data/moving_window_validation/southwest_to_center'/label
            summary=base/'summary.json';trajectory=base/'trajectory.csv.gz';frame_index=base/'midplane/frames.csv.gz'
            self.copy(f'supplementary_figure_03/data/{label}/trajectory.csv',trajectory)
            data=read_json(summary)
            self.json(f'supplementary_figure_03/data/{label}/summary.json',{k:data[k] for k in ['domain_scale_L','runtime_resolution']},[summary],
                'Select simulation domain and resolution from original summary')
            row=read_csv(frame_index)[-1]
            binary=base/'midplane'/row['file'];payload=read_bytes(binary)
            nx,ny,elapsed=struct.unpack_from('<iid',payload)
            a=np.frombuffer(payload,dtype='<f4',offset=16)
            if len(a)!=2*nx*ny:raise ValueError('Truncated midplane record')
            omega=a[:nx*ny].reshape((nx,ny),order='F')[1:-1,1:-1]
            occupancy=a[nx*ny:].reshape((nx,ny),order='F')[1:-1,1:-1]
            name=f'supplementary_figure_03/data/{label}/midplane/field.npz'
            np.savez_compressed(self.target(name),elapsed=elapsed,omega=omega,occupancy=occupancy)
            self.record(name,[binary],'Decode simulator Float32 midplane arrays; remove the one-cell halo')
            row['file']='field.npz'
            self.csv(f'supplementary_figure_03/data/{label}/midplane/frames.csv',list(row),[row],[frame_index],
                'Select the final original t=10 frame and assign its portable filename')

    def moving_window_table(self):
        from moving_window_validation import FIELDS, reconstruct
        rows, sources, _ = reconstruct(ROOT)
        self.csv('supplementary_table_01/data/paired_releases.csv', FIELDS, rows, sources,
            'Compare five matched 10T trajectory pairs on moving-window solver times; '
            'unwrap and wrap heading differences; calculate RMS and full-field/moving-window step-cost ratios')

    def generalization(self):
        from verify import inspect
        paths=sorted((ROOT/'raw_data/generalization').glob('*/*/result.json'))
        records=[read_json(p) for p in paths]
        for r in records:inspect(r)
        matrix=[]
        for case in ['nominal']+[f'{letter}{i}' for letter in 'abcd' for i in range(1,4)]:
            selected=[r for r in records if r['case']==case];shown=next(r for r in selected if r['policy']=='SEAS_1')['summary']
            row=dict(case=case,seas_captures=sum(r['summary']['target_reached'] for r in selected if r['method']=='SEAS'),seas_total=5,
                drl_captures=sum(r['summary']['target_reached'] for r in selected if r['method']=='DRL'),drl_total=5,shown_policy='SEAS_1',
                t_end=shown['release_elapsed'],s=shown['distance_integral_score'],target_x_L=shown['target_x_L'],target_y_L=shown['target_y_L'],flow_speed=shown['flow_speed'])
            for dest,source in [('cylinder_x_L','cylinder_centers_x_L'),('cylinder_y_L','cylinder_centers_y_L'),('cylinder_diameters_L','cylinder_diameters_L')]:
                row[dest]=json.dumps(shown[source])
            matrix.append(row)
        sources=paths+[p.parent/'trajectory.csv.gz' for p in paths]
        self.csv('table_01/data/matrix.csv',list(matrix[0]),matrix,sources,
            'Validate all trajectory distances, captures, termination events and distance integrals; aggregate the 13 fixed cases')
        index=ROOT/'raw_data/generalization/index.csv';index_rows=read_csv(index)
        lookup={(r['policy'],r['case']):r for r in records}
        if len(index_rows)!=len(lookup):raise ValueError('Generalization index coverage differs')
        rows=[]
        for row in index_rows:
            r=lookup[(row['policy'],row['case'])];s=r['summary'];prefix=f"raw_data/generalization/{r['policy']}/{r['case']}"
            regenerated=dict(method=r['method'],policy=r['policy'],case=r['case'],target_reached=s['target_reached'],
                termination=s['termination'],s=s['distance_integral_score'],release_elapsed=s['release_elapsed'],cfd_steps=s['steps'],
                result=prefix+'/result.json',trajectory=prefix+'/trajectory.csv.gz',trajectory_sha256=r['trajectory_sha256'])
            rows.append(regenerated)
        self.csv('table_01/data/policy_results.csv',list(index_rows[0]),rows,sources+[index],
            'Regenerate outcomes, steps and trajectory identities from all independently verified result records')

    def three_dimensional(self):
        from extract_3d_curve import build
        import tempfile
        temporary = tempfile.TemporaryDirectory(prefix='agent-fluid-curve-')
        output = Path(temporary.name)/'curve'
        _, provenance = build(output)
        sources = [ROOT/name for name in provenance['inputs']]
        for name in ['learning_curves.csv', 'iteration40_measured_candidates.csv',
                     'iteration40_endpoints.csv', 'point_provenance.csv']:
            destination = 'figure_05/data/' + name
            self.target(destination).write_bytes((output/name).read_bytes())
            self.record(destination, sources, provenance['transformation'])
        self.validation['three_dimensional'] = read_json(output/'validation.json')
        temporary.cleanup()

    def controllers(self):
        spec=read_json(ROOT/'code/reproduction/index.json')
        for name,source in spec.get('controller_sources',{}).items():self.copy(name,ROOT/source)

    def validation_transition(self):
        groups=defaultdict(list);sources=[]
        for rec in read_json(ROOT/'code/reproduction/index.json')['transition_cases']:
            base=ROOT/rec['directory'];path=base/'summary.json';s=read_json(path)
            binary=base/(s['vorticity_snapshot']['file']+'.gz');sources.extend([path,binary])
            shape=s['vorticity_snapshot']['array_shape']
            omega=np.frombuffer(read_bytes(binary),dtype='<f4').reshape(shape,order='F')
            grid=float(s['grid_L']);mid=float(s['domain_c'][1])/2
            x=np.arange(shape[0])/grid;y=np.arange(shape[1])/grid
            ix=(x>=7)&(x<=11);iy=np.abs(y-mid)<=2
            field=omega[np.ix_(ix,iy)].astype(float);yy=y[iy]-mid
            finite=np.isfinite(field);scale=float(np.nanpercentile(np.abs(field[finite]),99))
            weight=np.abs(field)*(finite & (np.abs(field)>=.35*scale))
            metric=float(np.sum(np.sign(field)*yy[None,:]*weight)/np.sum(weight))
            groups[(round(float(s['Sr']),8),round(float(s['A_D']),8))].append(metric)
        points=[(sr,ad,float(np.mean(v))) for (sr,ad),v in groups.items()]
        rows=[]
        for sr in sorted({p[0] for p in points}):
            series=[p for p in points if p[0]==sr]
            lower=max((p for p in series if p[2]<=0),key=lambda p:p[1])
            upper=min((p for p in series if p[2]>0),key=lambda p:p[1])
            if lower[1]>=upper[1]:raise ValueError('Nonmonotone transition bracket')
            m0,m1=lower[2],upper[2];ref=.1236*sr**-1.139+.09983
            root=lower[1]-m0/(m1-m0)*(upper[1]-lower[1])
            rows.append(dict(Sr=sr,reference_A_D=ref,lower_A_D=lower[1],upper_A_D=upper[1],interpolated_A_D=root,
                lower_factor=lower[1]/ref,upper_factor=upper[1]/ref,interpolated_factor=root/ref,
                relative_difference_percent=100*(root/ref-1),lower_metric=m0,upper_metric=m1))
        if len(rows)!=7:raise ValueError('Expected seven independently bracketed transition points')
        self.csv('supplementary_figure_01/data/lagopoulos_transition_summary_7sr.csv',list(rows[0]),rows,sources,
            'Original Float32 final vorticity snapshots; signed vortex-row separation in x/c=7..11, |y-y0|/c<=2, 35% of p99 core threshold; average replicates and interpolate the zero crossing')

    def validation_grid(self):
        rows=[];waveforms=[];sources=[];nodes=np.linspace(0,1,401,endpoint=False)
        for n in [16,32,64,128]:
            base=ROOT/f'raw_data/cfd_validation/grid_convergence/Nc{n}'
            sp=base/'summary.json';trace=base/'force_history.csv.gz';sources.extend([sp,trace]);s=read_json(sp)
            a=np.genfromtxt(io.BytesIO(read_bytes(trace)),delimiter=',',names=True)
            cycles=np.floor(a['cycle']+1e-8).astype(int);waves=[]
            for cycle in np.unique(cycles):
                mask=cycles==cycle;phase=np.mod(a['cycle'][mask],1);thrust=a['C_T'][mask]
                if len(phase)<3:continue
                order=np.argsort(phase);phase,thrust=phase[order],thrust[order]
                waves.append(np.interp(nodes,np.r_[phase[-1]-1,phase,phase[0]+1],np.r_[thrust[-1],thrust,thrust[0]]))
            waveform=np.mean(waves,axis=0)
            row=dict(N_c=n,mean_C_T=s['mean_C_T'],phase_averaged_peak_to_peak_C_T=float(np.ptp(waveform)),
                rms_C_L=s['rms_C_L'],fixed_grid_dt=s['fixed_grid_dt'],fixed_phase_dt=s['fixed_phase_dt'],
                adjacent_waveform_rmse=float(np.sqrt(np.mean((waveforms[-1]-waveform)**2))) if waveforms else '',
                mean_change_percent_from_previous=100*abs(s['mean_C_T']-rows[-1]['mean_C_T'])/abs(s['mean_C_T']) if rows else '')
            rows.append(row);waveforms.append(waveform)
        self.csv('supplementary_figure_01/data/lagopoulos_grid_convergence.csv',list(rows[0]),rows,sources,
            'Original four-grid force histories; periodic phase interpolation to 401 nodes, cycle averaging, adjacent-waveform RMSE and mean change')
        rows=[];sources=[]
        for n in range(16,129,16):
            base=ROOT/f'raw_data/cfd_validation/grid_ct_eta/Nc{n}';sp=base/'summary.json.gz';trace=base/'force_history.csv.gz'
            sources.extend([sp,trace]);s=read_json(sp)
            if int(s['grid_L'])!=n:raise ValueError('Grid identity differs')
            a=np.genfromtxt(io.BytesIO(read_bytes(trace)),delimiter=',',names=True)
            cycles=np.floor(a['cycle']-a['cycle'][0]+1e-8).astype(int)
            if np.unique(cycles).tolist()!=[0,1,2,3]:raise ValueError('Expected four observed cycles')
            ct=np.array([np.mean(a['C_T'][cycles==i]) for i in range(4)])
            cp=np.array([np.mean(a['C_P_input'][cycles==i]) for i in range(4)])
            rows.append(dict(N_c=n,mean_C_T=np.mean(ct),ct_95_halfwidth=3.182446305284263*np.std(ct,ddof=1)/2,
                mean_C_P_input=np.mean(cp),eta=np.mean(ct)/np.mean(cp),eta_95_halfwidth=3.182446305284263*np.std(ct/cp,ddof=1)/2))
        self.csv('supplementary_figure_01/data/lagopoulos_grid_ct_eta_convergence.csv',list(rows[0]),rows,sources,
            'Four original cycle means per resolution; eta=mean CT/mean input CP; descriptive Student-t intervals with df=3')

    def validation_cylinder(self):
        rows=[];sources=[]
        def average(t,y):
            return sum((t[i+1]-t[i])*(y[i+1]+y[i])/2 for i in range(len(t)-1))/(t[-1]-t[0])
        for n in [16,32,48,64,72,80,96,112,128]:
            base=ROOT/f'raw_data/cfd_validation/oscillating_cylinder/n{n}';sp=base/'summary.json.gz';trace=base/'forces.csv.gz'
            sources.extend([sp,trace]);s=read_json(sp);samples=read_csv(trace)
            if len(samples)!=801 or int(s['sample_periods'])!=8 or int(s['samples_per_period'])!=100:raise ValueError('Cylinder sampling differs')
            t=[float(r['t_ctu']) for r in samples];cp=[float(r['CP_official_signed']) for r in samples]
            means=[average(t[i*100:(i+1)*100+1],cp[i*100:(i+1)*100+1]) for i in range(8)]
            mean=float(s['mean_CP_official_signed']);std=statistics.stdev(means);sem=std/math.sqrt(8)
            source=base.relative_to(ROOT).as_posix()
            rows.append(dict(root=source,n=n,D_cells=s['D_cells'],h_over_D=1/float(s['D_cells']),mean_CP=mean,
                error_vs_official=mean-(-4.39),relative_error_vs_official=abs(mean-(-4.39))/4.39,
                error_vs_experiment=mean-(-4.52),relative_error_vs_experiment=abs(mean-(-4.52))/4.52,
                wall_seconds=s['wall_seconds'],force_sample_count=len(samples),actual_final_t_ctu=s['actual_final_t_ctu'],
                waterlily_version=s['waterlily_version'],cycle_mean_CP=statistics.mean(means),cycle_std_CP=std,cycle_sem_CP=sem,
                cycle_95_halfwidth_CP=2.364624251*sem,cycle_means_CP=json.dumps(means),cycle_count=8))
        self.csv('supplementary_figure_02/data/oscillating_cylinder_resolution_convergence.csv',list(rows[0]),rows,sources,
            'Original simulator summaries and 801 force records per resolution; integrate each of eight cycles and compute descriptive Student-t intervals')


def same_number(actual, expected):
    """Allow floating-point roundoff; integer counts remain exact."""
    if isinstance(actual, int) or isinstance(expected, int):
        return actual == expected
    tolerance = NUMERIC_TOLERANCES['float64']
    return ((math.isnan(actual) and math.isnan(expected)) or
            math.isclose(actual, expected, rel_tol=tolerance['rtol'], abs_tol=tolerance['atol']))


def same_json(actual, expected):
    if isinstance(actual, dict) and isinstance(expected, dict):
        return actual.keys() == expected.keys() and all(same_json(actual[key], expected[key]) for key in actual)
    if isinstance(actual, list) and isinstance(expected, list):
        return len(actual) == len(expected) and all(same_json(a, b) for a, b in zip(actual, expected))
    if isinstance(actual, bool) or isinstance(expected, bool):
        return type(actual) is type(expected) and actual == expected
    if isinstance(actual, (int, float)) and isinstance(expected, (int, float)):
        return same_number(actual, expected)
    return type(actual) is type(expected) and actual == expected


def compare_csv(actual,expected):
    a,b=read_csv(actual),read_csv(expected)
    if len(a)!=len(b):raise ValueError(f'Row count {len(a)} != {len(b)}')
    if not a:return {'rows':0}
    if set(a[0])!=set(b[0]):raise ValueError('CSV columns differ')
    # Comparison keys are scientific identities, never output positions chosen to match values.
    if actual.name=='figure_02_drl_comparison.csv':
        key=lambda r:(r['view'],r['method'],int(r['run']),float(r['cumulative_cfd_steps'] or 0),int(r['episode'] or 0),int(r['candidate'] or 0))
        a.sort(key=key);b.sort(key=key)
    maximum=0.0
    for index,(left,right) in enumerate(zip(a,b),1):
        for key,x in left.items():
            y=right[key]
            if x==y:continue
            try:
                xf = int(x) if re.fullmatch(r'[+-]?\d+', x.strip()) else float(x)
                yf = int(y) if re.fullmatch(r'[+-]?\d+', y.strip()) else float(y)
                if not same_number(xf,yf):raise ValueError
                if math.isnan(xf) and math.isnan(yf):continue
                maximum=max(maximum,abs(xf-yf))
            except (ValueError,TypeError):
                # Numeric arrays embedded in CSV follow the same floating-point tolerance.
                try:
                    lx,ly=json.loads(x),json.loads(y)
                    equal=same_json(lx,ly)
                except (ValueError,TypeError):equal=False
                if not equal:raise ValueError(f'Row {index}, {key}: {x!r} != {y!r}')
    return {'rows':len(a),'maximum_numeric_difference':maximum}


def compare_file(actual,expected):
    same=actual.read_bytes()==expected.read_bytes()
    if actual.suffix=='.csv':detail=compare_csv(actual,expected)
    elif actual.suffix=='.npz':
        with np.load(actual,allow_pickle=False) as a,np.load(expected,allow_pickle=False) as b:
            if set(a.files)!=set(b.files):raise ValueError('Array keys differ')
            for key in a.files:
                left,right=a[key],b[key]
                if left.shape!=right.shape:raise ValueError('Array shape mismatch: '+key)
                if left.dtype.kind=='f' and right.dtype.kind=='f':
                    precision='float32' if min(left.dtype.itemsize,right.dtype.itemsize)<=4 else 'float64'
                    equal=np.allclose(left,right,**NUMERIC_TOLERANCES[precision],equal_nan=True)
                else:
                    equal=np.array_equal(left,right)
                if not equal:raise ValueError('Array mismatch: '+key)
            detail={'arrays':len(a.files),'array_values':'consistent'}
    elif actual.suffix=='.json':
        if not same_json(read_json(actual),read_json(expected)):raise ValueError('JSON values differ')
        detail={'json_values':'consistent'}
    else:
        if not same:raise ValueError('Artifact bytes differ')
        detail={}
    return {'status':'PASS','byte_identical':same,**detail}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir',type=Path,default=ROOT/'derived_data')
    parser.add_argument('--compare-dir',type=Path)
    args=parser.parse_args()
    output=args.output_dir.resolve()
    if output!=ROOT/'derived_data' and (output==ROOT or output.is_relative_to(ROOT) or ROOT.is_relative_to(output)):
        parser.error('Use derived_data/ or a dedicated directory outside the repository')
    output.mkdir(parents=True,exist_ok=True)
    e=Extractor(output)
    stages=['training','mechanisms','illustrated_2d','illustrated_generalization','rendering_settings','moving_window','moving_window_table','generalization','controllers','validation_transition','validation_grid','validation_cylinder','three_dimensional']
    for name in stages:
        print('Extracting '+name,flush=True)
        getattr(e,name)()
    from flow_fields import extract_fields
    extract_fields(e)
    required=read_json(ROOT/'code/reproduction/index.json')
    missing=sorted(set(required['required_derived_data'])-set(e.records))
    comparisons={}
    if args.compare_dir:
        for name in e.records:
            reference=args.compare_dir/name
            if not reference.is_file():raise ValueError('Reference derived data is missing: '+str(reference))
            try:
                comparisons[name]=compare_file(output/name,reference)
            except ValueError as error:
                raise ValueError(f'{name}: {error}') from error
    result={'status':'PASS' if not missing else 'INCOMPLETE','generated_files':len(e.records),'failures':[],
            'unreconstructed_derived_data':missing,'comparisons':comparisons,'provenance':e.records,
            'numeric_tolerances':NUMERIC_TOLERANCES}
    result['validation']=e.validation
    modules=('extract_derived_data.py','flow_fields.py','moving_window_validation.py',
             'extract_3d_curve.py','extract_3d_evaluations.py','score_3d.py','verify.py')
    result['code']={'code/reproduction/'+name:sha((ROOT/'code/reproduction'/name).read_bytes()) for name in modules}
    result['code'].update({str(Path('code/plotting')/name).replace('\\','/'):sha((ROOT/'code/plotting'/name).read_bytes())
                           for name in ('swimmer_foreground.py','raw_2d_frames.py')})
    result['configuration']={'code/reproduction/index.json':sha((ROOT/'code/reproduction/index.json').read_bytes())}
    (output/'extraction_report.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({k:v for k,v in result.items() if k not in {'provenance','code','comparisons'}},indent=2))
    return 0 if result['status']=='PASS' else 1


if __name__=='__main__':raise SystemExit(main())
