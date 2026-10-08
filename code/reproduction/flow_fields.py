"""Derive physical fields and vortex meshes from frozen simulator records.

No rendered image is read or stored. Contour/smoothing operations follow the
field selections in code/reproduction/*.index.json; parameters and source replay are recorded per frame.
"""
from pathlib import Path
import json, csv, io, gzip, sys, tempfile, gc
import numpy as np
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'code/plotting'))
from extract_derived_data import read_json, read_csv, read_bytes, sha

def negative_threshold(grid, scalar, percentile):
    values=np.asarray(grid[scalar]);negative=values[np.isfinite(values)&(values<0)]
    if negative.size<100:raise RuntimeError('Too few negative Lambda2 samples')
    return float(np.percentile(negative,percentile))

def prepare_geometry(grid, *, percentile, body_buffer_cells, smoothing_iterations,
                     weak_percentile, weak_core_fraction, field_smoothing_sigma,
                     field_smoothing_radius, color_smoothing_sigma, color_field,
                     color_limit_percentile, fixed_color_limit, weak_opacity, **unused):
    body = grid.contour(isosurfaces=[0.0], scalars="BodySDF")
    display_grid = grid.copy(deep=True)
    if field_smoothing_sigma > 0.0:
        lambda_source = grid.copy(deep=True)
        lambda_source.set_active_scalars("Lambda2")
        lambda_grid = lambda_source.gaussian_smooth(
            radius_factor=field_smoothing_radius,
            std_dev=field_smoothing_sigma,
            scalars="Lambda2",
        )
        lambda2 = np.asarray(lambda_grid["Lambda2"])
    else:
        lambda2 = np.asarray(grid["Lambda2"])

    if color_field == "speed":
        color_raw = np.linalg.norm(np.asarray(grid["Velocity"]), axis=1)
    else:
        derivative_grid = grid.compute_derivative(
            scalars="Velocity",
            gradient=False,
            vorticity="Vorticity",
            faster=True,
        )
        color_raw = np.asarray(derivative_grid["Vorticity"])[:, 2]
    display_grid["ColorDisplay"] = color_raw
    if color_smoothing_sigma > 0.0:
        speed_source = display_grid.copy(deep=True)
        speed_source.set_active_scalars("ColorDisplay")
        speed_grid = speed_source.gaussian_smooth(
            radius_factor=field_smoothing_radius,
            std_dev=color_smoothing_sigma,
            scalars="ColorDisplay",
        )
        display_grid["ColorDisplay"] = np.asarray(speed_grid["ColorDisplay"])

    body_sdf = np.asarray(grid["BodySDF"])
    display_grid["Lambda2Display"] = np.where(body_sdf >= body_buffer_cells, lambda2, 0.0)
    threshold = float("nan")
    cores = None
    try:
        threshold = negative_threshold(display_grid, "Lambda2Display", percentile)
        cores = display_grid.contour(isosurfaces=[threshold], scalars="Lambda2Display")
    except RuntimeError:
        # The release frame is still water.  Showing the body alone is the
        # physically faithful result; it must not be padded with a fabricated
        # vortex surface merely to make all frames look equally busy.
        cores = None

    weak_cores = None
    weak_threshold = float("nan")
    if weak_opacity > 0.0 and cores is not None:
        percentile_threshold = negative_threshold(
            display_grid, "Lambda2Display", weak_percentile
        )
        # In early frames the percentile can lie arbitrarily close to zero and
        # produce a domain-scale translucent slab.  Tie the outer surface to
        # the resolved vortex-core level so that it remains a wake envelope.
        weak_threshold = min(
            percentile_threshold, threshold * weak_core_fraction
        )
        weak_cores = display_grid.contour(isosurfaces=[weak_threshold], scalars="Lambda2Display")
    if not body.n_points:
        raise RuntimeError("body contour is empty")
    if cores is not None and not cores.n_points:
        raise RuntimeError("Lambda2 contour is empty")
    if weak_cores is not None and not weak_cores.n_points:
        raise RuntimeError("weak Lambda2 contour is empty")

    if smoothing_iterations > 0:
        body = body.smooth_taubin(
            n_iter=smoothing_iterations,
            pass_band=0.12,
            feature_smoothing=False,
            boundary_smoothing=True,
        )
        if cores is not None:
            cores = cores.smooth_taubin(
                n_iter=smoothing_iterations,
                pass_band=0.08,
                feature_smoothing=False,
                boundary_smoothing=True,
            )
        if weak_cores is not None:
            weak_cores = weak_cores.smooth_taubin(
                n_iter=smoothing_iterations,
                pass_band=0.08,
                feature_smoothing=False,
                boundary_smoothing=True,
            )

    if cores is not None:
        cores = cores.sample(display_grid)
        color_values = np.asarray(cores["ColorDisplay"])
        finite_color = color_values[np.isfinite(color_values)]
    else:
        finite_color = np.asarray([], dtype=float)
    if color_field == "speed" and cores is not None:
        color_min = max(0.0, float(np.percentile(finite_color, 2.0)))
        color_max = max(color_min + 1.0e-6, float(np.percentile(finite_color, 98.0)))
    elif color_field == "speed":
        color_min, color_max = 0.0, 1.0
    else:
        color_limit = (
            fixed_color_limit
            if fixed_color_limit > 0.0
            else max(
                1.0e-6,
                float(np.percentile(np.abs(finite_color), color_limit_percentile))
                if finite_color.size
                else 1.0,
            )
        )
        color_min, color_max = -color_limit, color_limit
    if weak_cores is not None:
        weak_cores = weak_cores.sample(display_grid)

    return body, cores, weak_cores, threshold, weak_threshold


def extract_fields(e):
    from swimmer_foreground import read_field
    for number in ('02', '03'):
        recipe_path=ROOT/f'code/reproduction/figure_{number}.index.json'
        recipe=read_json(recipe_path)
        records=[]
        for selected in recipe['frames']:
            source=ROOT/selected['raw_field']
            if sha(source.read_bytes())!=recipe['inputs'][selected['raw_field']]:
                raise ValueError('Raw field identity differs: '+str(source))
            if number=='02':
                base=ROOT/'raw_data/illustrated_2d'/selected['stage']
                frame_path=base/'frames.csv.gz';summary_path=base/'summary.json'
                frame=read_csv(frame_path)[-1]
                identity=selected['stage']
            else:
                base=ROOT/'raw_data/illustrated_generalization'/selected['case']/'simulation/episode'
                frame_path=base/'vtk/frames.csv.gz';summary_path=base/'summary.json'
                frame=next(r for r in read_csv(frame_path) if int(r['frame_index'])==selected['frame_index'])
                identity=selected['id']
            if abs(float(frame['sim_time'])-selected['sim_time'])>1e-10:
                raise ValueError('Frame time differs from manuscript selection')
            arrays,origin,spacing=read_field(source)
            name=f'figure_{number}/data/fields/{identity}.npz'
            np.savez_compressed(e.target(name),**arrays,origin=origin,spacing=spacing)
            e.record(name,[source],'Lossless Float32 Vorticity/BodySDF arrays decoded from VTI; geometry unchanged')
            summary=read_json(summary_path)
            records.append({'id':identity,'array':f'fields/{identity}.npz','frame':frame,
                            'summary':{k:summary[k] for k in ('target','success_radius')},
                            'elapsed_T':float(frame['sim_time'])-200,
                            'source':selected['raw_field']})
        e.json(f'figure_{number}/data/fields.json',records,
               [recipe_path]+[ROOT/n for n in recipe['inputs']],
               'Join the exact displayed VTI frames to their simulator times, poses and target geometry')
    import pyvista as pv
    recipe_path=ROOT/'code/reproduction/figure_05.index.json'
    recipe=read_json(recipe_path);records=[]
    for selected in recipe['frames']:
        print('Extracting 3D '+selected['id'],flush=True)
        source=ROOT/selected['raw_field']
        if sha(source.read_bytes())!=selected['sha256']:raise ValueError('3D raw field identity differs')
        frame_source=ROOT/selected['frame_index_source']
        matches=[row for row in read_csv(frame_source)
                 if row['frame_index']==selected['frame']['frame_index']]
        if len(matches)!=1 or matches[0]!=selected['frame']:
            raise ValueError('3D frame time/pose differs from its original frame index')
        with tempfile.TemporaryDirectory(prefix='agent-fluid-field-') as temporary:
            local=Path(temporary)/'field.vti';local.write_bytes(read_bytes(source))
            original=pv.read(local)
            if not list(original.point_data):original=original.cell_data_to_point_data()
            nx,ny,nz=original.dimensions
            grid=original.extract_subset(voi=(2,nx-3,2,ny-3,2,nz-3))
            del original
            body,cores,weak,threshold,weak_threshold=prepare_geometry(grid,**recipe['parameters'])
            arrays={}
            for key,mesh in [('body',body),('core',cores),('weak',weak)]:
                if mesh is None:raise ValueError('Missing vortex mesh in a nonzero manuscript frame')
                arrays[key+'_points']=np.asarray(mesh.points)
                arrays[key+'_faces']=np.asarray(mesh.faces)
                if key!='body':arrays[key+'_omega_z']=np.asarray(mesh['ColorDisplay'])
            name=f"figure_05/data/fields/{selected['id']}.npz"
            np.savez_compressed(e.target(name),**arrays)
            e.record(name,[source,frame_source,recipe_path],
                     'BodySDF=0 and smoothed Lambda2 isosurfaces; curl(Velocity).z sampled on meshes; see pinned recipe')
            records.append({**selected,'array':f"fields/{selected['id']}.npz",'core_threshold':threshold,'weak_threshold':weak_threshold})
            if selected['id']=='t12':
                v=grid.compute_derivative(scalars='Velocity',gradient=False,vorticity='Vorticity',faster=True)
                shape=tuple(grid.dimensions)
                z=int(round((float(selected['frame']['z_plane'])-grid.origin[2])/grid.spacing[2]))
                omega=np.asarray(v['Vorticity'])[:,2].reshape(shape,order='F')[:,:,z]
                sdf=np.asarray(grid['BodySDF']).reshape(shape,order='F')[:,:,z]
                name='figure_05/data/midplane_t12.npz'
                np.savez_compressed(e.target(name),omega_z=omega,body_sdf=sdf,origin=grid.origin,spacing=grid.spacing,z=grid.origin[2]+z*grid.spacing[2])
                e.record(name,[source,frame_source,recipe_path],'Exact z=48 midplane of curl(Velocity).z and BodySDF; no image reconstruction')
                del v
            del grid,body,cores,weak,arrays
            gc.collect()
    e.json('figure_05/data/fields.json',{'frames':records,'parameters':recipe['parameters'],'description':recipe['description']},
           [recipe_path]+[ROOT/r[key] for r in recipe['frames'] for key in ('raw_field','frame_index_source')],
           'Exact frame selections, source replay identities, measured contour thresholds and fixed plotting parameters')
    base=ROOT/'raw_data/three_dimensional/illustrated_replay'
    e.copy('figure_05/data/replay_trajectory.csv',base/'trajectory.csv.gz')
    s=read_json(base/'summary.json.gz')
    e.json('figure_05/data/replay_scene.json',{k:s[k] for k in ['domain_scale_L','runtime_resolution','target_L','success_radius_L','fish_initial_center_L']},
           [base/'summary.json.gz'],'Physical domain, target and scale for the illustrated replay')
