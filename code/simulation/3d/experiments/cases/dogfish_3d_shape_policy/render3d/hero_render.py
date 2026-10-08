import pyvista as pv, numpy as np, glob, math, sys
pv.OFF_SCREEN=True
THR_PCT=float(sys.argv[1]); CORE_OP=float(sys.argv[2]); PEEL=float(sys.argv[3])
WIN=int(sys.argv[4]); AA=sys.argv[5]; OUT=sys.argv[6]; DIST=float(sys.argv[7]) if len(sys.argv)>7 else 2.55
OPMODE=sys.argv[8] if len(sys.argv)>8 else "flat"
d="/tmp/vtk3d/L128_full"; Lf=128.0
fp=sorted(glob.glob(d+"/flow3d_*.vti"))[-1]
g=pv.read(fp)
if not list(g.point_data.keys()): g=g.cell_data_to_point_data()
nx,ny,nz=g.dimensions; g=g.extract_subset(voi=(2,nx-3,2,ny-3,2,nz-3))
l2=np.asarray(g["Lambda2"]); neg=l2[l2<0]; thr=float(np.percentile(neg,THR_PCT))
body=g.contour([0.0],scalars="BodySDF").connectivity('largest')
try: body=body.subdivide(2, subfilter="loop")
except Exception as e: print("subdiv",e)
try: body=body.smooth_taubin(n_iter=40, pass_band=0.08)
except Exception as e: print("smooth",e)
body=body.compute_normals(auto_orient_normals=True, feature_angle=60)
cores=g.contour([thr],scalars="Lambda2").sample(g)
cores["speed"]=np.linalg.norm(np.asarray(cores["Velocity"]),axis=1)
if PEEL>0: cores=cores.threshold(PEEL*Lf, scalars="BodySDF")
cores=cores.extract_surface()
bsdf=np.asarray(cores["BodySDF"])
try: cores=cores.smooth_taubin(n_iter=24, pass_band=0.1)
except Exception as e: print("csmooth",e)
bb=body.bounds; fx,fy,fz=(bb[0]+bb[1])/2,(bb[2]+bb[3])/2,(bb[4]+bb[5])/2
span=max(bb[1]-bb[0],bb[3]-bb[2],bb[5]-bb[4]); dist=DIST*span
az=math.radians(-150); el=math.radians(28)
campos=(fx+dist*math.cos(el)*math.cos(az),fy+dist*math.cos(el)*math.sin(az),fz+dist*math.sin(el)); cam=[campos,(fx,fy,fz),(0,0,1)]
pl=pv.Plotter(off_screen=True,window_size=(int(WIN*1.5),WIN))
try: pl.set_background("#05080f", top="#0f2138")
except: pl.set_background("#05080f")
for fn,a in [("enable_depth_peeling",(16,)),("enable_anti_aliasing",(AA,))]:
    try: getattr(pl,fn)(*a)
    except Exception as e: print(fn,"skip",e)
pl.add_mesh(body, color="#f7fbff", pbr=True, metallic=0.12, roughness=0.40, smooth_shading=True,
            diffuse=1.0, ambient=0.34, specular=0.55, specular_power=18, silhouette=dict(color="#e6f0ff", line_width=2.6))
sp=np.asarray(cores["speed"]); clim=[0,max(1e-6,float(np.percentile(sp,95)))]
kw=dict(scalars="speed", cmap="turbo", clim=clim, smooth_shading=True, show_scalar_bar=False, specular=0.15, diffuse=1.0, ambient=0.32)
if OPMODE=="dist":
    alpha=np.clip((bsdf-6.0)/(0.12*Lf), 0.0, 0.62)
    try: pl.add_mesh(cores, opacity=alpha, **kw)
    except Exception as e: print("op-array fail",e); pl.add_mesh(cores, opacity=CORE_OP, **kw)
else:
    pl.add_mesh(cores, opacity=CORE_OP, **kw)
try: pl.enable_ssao(radius=14,bias=0.01)
except Exception as e: print("ssao",e)
pl.enable_lightkit()
try:
    kl=pv.Light(position=campos, focal_point=(fx,fy,fz), color="#ffffff", intensity=0.6); kl.positional=False; pl.add_light(kl)
except Exception as e: print("light",e)
pl.camera_position=cam
pl.screenshot(OUT)
print("wrote",OUT,"cores=",cores.n_points,"body=",body.n_points)
