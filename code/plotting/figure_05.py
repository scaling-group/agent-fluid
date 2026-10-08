"""Rebuild all Figure 5 panels from derived arrays and trajectories.

Panel a's midplane and panel b's 12 T volume use the same original VTI.
The 9 T thumbnail retains the original separate visualization replay.
"""
import argparse
import json
import math
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Rectangle
from matplotlib.colors import Normalize
from matplotlib.cm import ScalarMappable
from pathlib import Path
from paths import OUTPUT_DIR, DERIVED_DIR, external_output

DATA=DERIVED_DIR/'figure_05/data'

def render_volume(record,parameters):
    import pyvista as pv
    with np.load(DATA/record['array'],allow_pickle=False) as data:
        meshes={key:pv.PolyData(data[key+'_points'],data[key+'_faces']) for key in ('body','core','weak')}
        for key in ('core','weak'):meshes[key]['omega_z']=data[key+'_omega_z']
    p=pv.Plotter(off_screen=True,window_size=(1400,1000));p.set_background('white')
    p.enable_anti_aliasing('ssaa');p.enable_depth_peeling(number_of_peels=12,occlusion_ratio=0)
    p.add_mesh(meshes['weak'],color='#aebdca',opacity=parameters['weak_opacity'],smooth_shading=True,show_scalar_bar=False,ambient=.78,diffuse=.2)
    p.add_mesh(meshes['core'],scalars='omega_z',cmap='RdBu_r',clim=(-parameters['fixed_color_limit'],parameters['fixed_color_limit']),
               opacity=parameters['core_opacity'],smooth_shading=True,show_scalar_bar=False,ambient=.62,diffuse=.34,specular=.08)
    p.add_mesh(meshes['body'],color='#8f99a2',opacity=1,smooth_shading=True,ambient=.36,diffuse=.53,specular=.11)
    p.add_mesh(meshes['body'],style='wireframe',color='#4e5962',opacity=.18,line_width=.5)
    row=record['frame'];center=np.array([float(row['center_x']),float(row['center_y']),float(row['z_plane'])]);heading=float(row['heading'])
    forward=np.array([math.cos(heading),math.sin(heading),0]);lateral=parameters['side']*np.array([-math.sin(heading),math.cos(heading),0])
    focus=center-parameters['focus_aft_l']*64*forward;elevation=math.radians(parameters['elevation_deg']);yaw=math.radians(parameters['yaw_offset_deg'])
    distance=parameters['distance_l']*64
    camera=focus+distance*math.cos(elevation)*(math.cos(yaw)*lateral+math.sin(yaw)*forward)+[0,0,distance*math.sin(elevation)]
    p.camera_position=[camera.tolist(),focus.tolist(),[0,0,1]];p.camera.view_angle=parameters['view_angle_deg'];p.camera.clipping_range=(1,1000)
    if record['id']=='t18':
        scene=json.loads((DATA/'replay_scene.json').read_text());trajectory=pd.read_csv(DATA/'replay_trajectory.csv');last=trajectory.iloc[-1]
        target=(np.array(scene['target_L'])-last[['frame_origin_x_L','frame_origin_y_L']].to_numpy(float))*64
        sphere=pv.Sphere(center=(target[0],target[1],48),radius=scene['success_radius_L']*64,theta_resolution=36,phi_resolution=18)
        p.add_mesh(sphere,color='#35a56f',opacity=.045,smooth_shading=True)
        p.add_mesh(sphere,style='wireframe',color='#25965f',opacity=.55,line_width=.65)
    p.add_axes(interactive=False,viewport=(0,.68,.18,.95),color='#26313d')
    p.render();image=p.screenshot(return_img=True);p.close()
    return image

def trajectory_panel(ax):
    trajectory=pd.read_csv(DATA/'replay_trajectory.csv');scene=json.loads((DATA/'replay_scene.json').read_text())
    record=json.loads((DATA/'fields.json').read_text());frame=next(r for r in record['frames'] if r['id']=='t12')
    row=trajectory.iloc[int(np.argmin(np.abs(trajectory.elapsed-float(frame['frame']['sim_time']))))]
    if abs(row.elapsed-float(frame['frame']['sim_time']))>1e-9:raise ValueError('Midplane and trajectory times do not match')
    ox,oy=row.frame_origin_x_L,row.frame_origin_y_L
    with np.load(DATA/'midplane_t12.npz',allow_pickle=False) as data:
        omega,sdf=data['omega_z'],data['body_sdf'];origin,spacing=data['origin'],data['spacing']
        x=ox+(origin[0]+np.arange(omega.shape[0])*spacing[0])/64;y=oy+(origin[1]+np.arange(omega.shape[1])*spacing[1])/64
        ax.imshow(omega.T,origin='lower',extent=(x[0],x[-1],y[0],y[-1]),cmap='RdBu_r',vmin=-.08,vmax=.08,interpolation='bilinear')
        ax.contourf(x,y,sdf.T,levels=[-1e9,0],colors=['#26313d'])
    ax.add_patch(Rectangle((ox,oy),4,3,fill=False,ls='--',lw=.75,ec='#26313d'))
    x,y=trajectory.head_x_L,trajectory.head_y_L
    ax.plot(x,y,color='white',lw=2);ax.plot(x,y,color='#2166ac',lw=1.05)
    ax.scatter([x.iloc[0]],[y.iloc[0]],s=17,color='#66727d',zorder=5)
    ax.scatter([x.iloc[-1]],[y.iloc[-1]],s=20,facecolor='white',edgecolor='#2166ac',zorder=5)
    target=scene['target_L'];ax.add_patch(Circle(target,scene['success_radius_L'],fill=False,ls='--',ec='#26313d',lw=.75));ax.plot(*target,marker='*',ms=6,color='#26313d')
    ax.text(x.iloc[0]-.1,y.iloc[0]+.7,'release',ha='center',fontsize=7)
    ax.text(x.iloc[-1]+.6,y.iloc[-1]-.6,'capture',fontsize=7)
    ax.text(ox+2,oy+3.45,'window at t = 12',ha='center',fontsize=7)
    ax.text(23.5,7.5,'window 4L × 3L',ha='right',fontsize=7,color='#66727d')
    ax.set(xlim=(8,24),ylim=(7,16),aspect='equal',xlabel=r'$x/L$',ylabel=r'$y/L$');ax.set_xticks([8,12,16,20,24]);ax.set_yticks([8,10,12,14,16])

def main():
    from panels import save_panel
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir",type=external_output,default=OUTPUT_DIR)
    args=parser.parse_args()
    plt.rcParams.update({"font.family":"DejaVu Sans","font.size":8,
                         "pdf.fonttype":42,"svg.fonttype":"none","axes.linewidth":.7})
    fig,ax=plt.subplots(figsize=(4.5,3.3))
    fig.subplots_adjust(left=.13,right=.98,bottom=.18,top=.87)
    trajectory_panel(ax)
    ax.set_title("a  Moving-window trajectory",loc="left",fontsize=10,pad=16)
    save_panel(fig,args.output_dir/"figure_05_a")
    plt.close(fig)
    data=json.loads((DATA/"fields.json").read_bytes())
    records={r["id"]:r for r in data["frames"]}
    fig=plt.figure(figsize=(6.2,5.2))
    grid=fig.add_gridspec(2,3,left=.02,right=.98,bottom=.16,top=.91,
                          height_ratios=(2.2,1),hspace=.1,wspace=.08)
    for identity,slot in [("t12",grid[0,:]),("t03",grid[1,0]),("t09",grid[1,1]),("t18",grid[1,2])]:
        ax=fig.add_subplot(slot)
        ax.imshow(render_volume(records[identity],data["parameters"]))
        ax.axis("off")
        value=float(records[identity]["frame"]["sim_time"])
        ax.set_title(f"t = {value:.2f}",loc="left",fontsize=8,pad=2)
    fig.suptitle("b  Three-dimensional vortical wake",x=.02,ha="left",fontsize=10)
    limit=data["parameters"]["fixed_color_limit"]
    bar=fig.colorbar(ScalarMappable(norm=Normalize(-limit,limit),cmap="RdBu_r"),
                    cax=fig.add_axes([.30,.095,.40,.025]),orientation="horizontal",ticks=[-.08,0,.08])
    bar.ax.tick_params(labelsize=8,length=2)
    bar.set_label("Vertical vorticity, ωz",fontsize=8)
    save_panel(fig,args.output_dir/"figure_05_b")
    plt.close(fig)
    print("Generated Figure 5a/b from measured trajectory and original VTK fields.")

if __name__=="__main__":main()
