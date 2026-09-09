import pyvista as pv, numpy as np, glob, math
from PIL import Image, ImageFilter
import imageio
pv.OFF_SCREEN=True
N=96; WIN=820; DIST=3.0; EL=18.0
d="/tmp/vtk3d/L128_full"; Lf=128.0
fp=sorted(glob.glob(d+"/flow3d_*.vti"))[-1]
g=pv.read(fp)
if not list(g.point_data.keys()): g=g.cell_data_to_point_data()
nx,ny,nz=g.dimensions; g=g.extract_subset((2,nx-3,2,ny-3,2,nz-3))
body=g.contour([0.0],scalars="BodySDF").connectivity('largest')
try: body=body.subdivide(2,subfilter="loop").smooth_taubin(n_iter=40,pass_band=0.08)
except Exception as e: print("body",e)
body=body.compute_normals(auto_orient_normals=True)
l2=np.asarray(g["Lambda2"]); thr=float(np.percentile(l2[l2<0],65))
cores=g.contour([thr],scalars="Lambda2").sample(g)
cores["speed"]=np.linalg.norm(np.asarray(cores["Velocity"]),axis=1)
cores=cores.extract_surface()
try: cores=cores.smooth_taubin(n_iter=18,pass_band=0.1)
except Exception: pass
bb=body.bounds; fx,fy,fz=(bb[0]+bb[1])/2,(bb[2]+bb[3])/2,(bb[4]+bb[5])/2
span=max(bb[1]-bb[0],bb[3]-bb[2],bb[5]-bb[4]); dist=DIST*span
pl=pv.Plotter(off_screen=True,window_size=(int(WIN*1.5),WIN))
try: pl.set_background("#05080f", top="#0f2138")
except: pl.set_background("#05080f")
for fn,a in [("enable_depth_peeling",(16,)),("enable_anti_aliasing",("fxaa",))]:
    try: getattr(pl,fn)(*a)
    except Exception as e: print(fn,e)
pl.add_mesh(body, color="#eef4fd", pbr=True, metallic=0.4, roughness=0.22, smooth_shading=True,
            silhouette=dict(color="#d7e7ff", line_width=2.2))
sp=np.asarray(cores["speed"]); clim=[0,max(1e-6,float(np.percentile(sp,95)))]
pl.add_mesh(cores, scalars="speed", cmap="turbo", clim=clim, opacity=0.42, smooth_shading=True,
            show_scalar_bar=False, specular=0.15, diffuse=1.0, ambient=0.32)
try: pl.enable_ssao(radius=18,bias=0.01)
except Exception as e: print("ssao",e)
pl.enable_lightkit()
def blur(a,r): return np.asarray(Image.fromarray(a.clip(0,255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(r))).astype(np.float32)
el=math.radians(EL); frames=[]
for i in range(N):
    az=2*math.pi*i/N
    cp=(fx+dist*math.cos(el)*math.cos(az), fy+dist*math.cos(el)*math.sin(az), fz+dist*math.sin(el))
    pl.camera.position=cp
    pl.camera.focal_point=(fx,fy,fz)
    pl.camera.up=(0,0,1)
    pl.renderer.reset_camera_clipping_range()
    pl.render()
    img=np.asarray(pl.screenshot(return_img=True)).astype(np.float32)
    if i in (0,24,48): print('frame',i,'campos',tuple(round(c,1) for c in cp))
    lum=img.mean(2); mask=np.clip((lum-120)/135,0,1)[...,None]; br=img*mask
    out=np.clip(img+blur(br,5)*0.5+blur(br,14)*0.36,0,255).astype(np.uint8)
    if frames: print('frame',i,'pixel-diff vs prev %.2f'%float(np.abs(out.astype(float)-frames[-1].astype(float)).mean()))
    frames.append(out)
    if i%16==0: print("frame",i)
imageio.mimwrite("/Users/sunxiaoshu/Downloads/dogfish_orbit_L128.mp4", frames, fps=30, codec="libx264", quality=8, macro_block_size=2)
print("wrote orbit mp4", len(frames), "frames")
