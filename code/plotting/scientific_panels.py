"""Vector panels and in-memory rendering from physical derived arrays."""
from io import BytesIO
import json
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon, Circle
import pymupdf
from paths import DERIVED_DIR
from fields import field_2d

def fish_geometry(phi1=0, phi2=0, heading=0, center=(0,0), length=1):
    """Solver width/angle definitions, 32-node arc and 96-strip centroid quadrature."""
    def theta(t):
        total=np.zeros_like(t)
        for phi,joint in [(phi1,1/3),(phi2,2/3)]:
            u=np.clip((t-(joint-1/8))/(1/4),0,1)
            total+=phi*u**3*(u*(6*u-15)+10)
        return total
    def width(t):
        profile=np.asarray([.02,.07,.06,.048,.03,.019,.01],dtype=np.float32).astype(float)
        u=np.asarray(t)*6;i=np.minimum(np.floor(u).astype(int),5)
        alpha=u-i;alpha=alpha**2*(3-2*alpha)
        return profile[i]+alpha*(profile[i+1]-profile[i])
    def spine(t):
        t=np.asarray(t);ds=t[:,None]/32
        angles=theta((np.arange(32)+.5)*ds)
        return np.c_[(np.cos(angles)*ds).sum(1),(np.sin(angles)*ds).sum(1)]
    t=np.unique(np.r_[np.linspace(0,1,161),1/3,2/3])
    points=spine(t);angles=theta(t)
    mid=(np.arange(96)+.5)/96
    centroid=np.average(spine(mid),weights=width(mid),axis=0)
    normal=np.c_[-np.sin(angles),np.cos(angles)]
    upper=points+width(t)[:,None]*normal;lower=points-width(t)[:,None]*normal
    rotation=np.array([[np.cos(heading),-np.sin(heading)],[np.sin(heading),np.cos(heading)]])
    def world(x):return ((x-centroid)*length)@rotation.T+center
    return {"s":t,"spine":world(points),"upper":world(upper),"lower":world(lower),
            "outline":world(np.vstack([upper,lower[::-1]]))}

def fish_outline(phi1=0,phi2=0,heading=0,center=(0,0),length=1):
    return fish_geometry(phi1,phi2,heading,center,length)["outline"]

def _pdf(fig):
    stream=BytesIO();fig.savefig(stream,format='pdf',dpi=300,metadata={'CreationDate':None,'ModDate':None})
    plt.close(fig);return pymupdf.open(stream=stream.getvalue(),filetype='pdf')

def trajectory_2d(width,height):
    plt.rcParams.update({'font.size':7.2,'pdf.fonttype':42})
    base=DERIVED_DIR/'figure_02/data'
    paths=pd.read_csv(base/'trajectory_centerlines.csv');poses=pd.read_csv(base/'swimmer_pose_states.csv')
    fig=plt.figure(figsize=(width/72,height/72));ax=fig.add_axes([.09,.21,.88,.68])
    with np.load(base/'fields/seed.npz',allow_pickle=False) as field:
        # The solid obstacles are fixed; use their SDF rather than inferred circles.
        sdf=field['BodySDF'];xx=field['origin'][0]+np.arange(sdf.shape[1]);yy=field['origin'][1]+np.arange(sdf.shape[0])
        ax.contourf(xx/64,yy/64,np.ma.masked_where(sdf>0,sdf),levels=[-1e9,0],colors=['#b8bec3'])
    for iteration,label,color in [(0,'Seed','#66727D'),(6,'Iteration 6','#B2182B'),(19,'Iteration 19','#2166AC')]:
        p=paths[paths.iteration==iteration]
        ax.plot(p.center_x/64,p.center_y/64,color=color,lw=.7,label=label)
        for r in poses[poses.iteration==iteration].itertuples():
            boundary=fish_outline(r.phi1,r.phi2,r.heading,(r.center_x/64,r.center_y/64))
            ax.add_patch(Polygon(boundary,facecolor=color,edgecolor='white',lw=.15))
    _,_,record=field_2d('02','i19');target=np.array(record['summary']['target'])/64
    ax.add_patch(Circle(target,record['summary']['success_radius']/64,fill=False,color='#2b8a62',lw=.65))
    ax.plot(*target,marker='+',color='#2b8a62',ms=4)
    ax.set(xlim=(0,24),ylim=(0,16),aspect='equal');ax.set_xticks([]);ax.set_yticks([])
    fig.text(.04,.92,'d',weight='bold',fontsize=9.8);fig.text(.12,.92,'Policy trajectories',fontsize=8.8)
    ax.text(.02,.96,'U = 0.18',transform=ax.transAxes,va='top',fontsize=6.4)
    ax.text(.98,.96,'24L × 16L | Re = 1000',transform=ax.transAxes,ha='right',va='top',fontsize=6.4)
    ax.legend(loc='upper center',bbox_to_anchor=(.5,-.04),ncol=3,frameon=False,fontsize=6.4,handlelength=1,columnspacing=.8)
    return _pdf(fig)

def flows_2d(width,height):
    from reportlab.pdfgen import canvas
    from reportlab.lib.utils import ImageReader
    from reportlab.lib.colors import HexColor
    from fields import draw_trajectory
    from swimmer_foreground import foreground_patch
    from fields import draw_colorbar
    buffer=BytesIO();pdf=canvas.Canvas(buffer,pagesize=(width,height),invariant=1)
    pdf.setFont('Helvetica-Bold',9.8);pdf.drawString(9,height-13,'e')
    paths=pd.read_csv(DERIVED_DIR/'figure_02/data/trajectory_centerlines.csv')
    for j,(identity,iteration,label) in enumerate([('seed',0,'Seed'),('i6',6,'Iteration 6'),('i19',19,'Iteration 19')]):
        image,mask,record=field_2d('02',identity);image=image.crop((0,0,1538,864))
        x=8+j*156;w=150;h=w*864/1538;y=height-23-h
        pdf.drawImage(ImageReader(image),x,y,w,h)
        p=paths[paths.iteration==iteration];points=np.c_[p.center_x+.5,1024.5-p.center_y]
        draw_trajectory(pdf,points,(x,y,w,h))
        patch=foreground_patch(image,mask)
        if patch:
            fg,(x0,y0,x1,y1)=patch;pdf.drawImage(ImageReader(fg),x+x0*w/1538,y+(864-y1)*h/864,(x1-x0)*w/1538,(y1-y0)*h/864,mask='auto')
        pdf.setStrokeColor(HexColor('#c9cfd5'));pdf.setLineWidth(.4);pdf.rect(x,y,w,h,stroke=1,fill=0)
        pdf.setFillColor(HexColor('#202831'));pdf.setFont('Helvetica',7.4)
        pdf.drawCentredString(x+w/2,4,f"{label}, t = {record['elapsed_T']:.1f}")
    draw_colorbar(pdf,width-31,24,6,64)
    pdf.showPage();pdf.save();return pymupdf.open(stream=buffer.getvalue(),filetype='pdf')
