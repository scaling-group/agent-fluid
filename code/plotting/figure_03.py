"""Draw four generalization subpanels from the 24 selected original fields."""
import argparse
import json
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patheffects as pe
from matplotlib.colors import LinearSegmentedColormap, Normalize
from matplotlib.cm import ScalarMappable
from paths import DERIVED_DIR, OUTPUT_DIR, external_output
from fields import field_2d
from swimmer_foreground import foreground_patch
from panels import save_panel

CASES = [("a1", "a", "Target shift"), ("b3", "b", "Staggered rear row"),
         ("c1", "c", "Three cylinders"), ("d3", "d", "Faster background flow")]

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir",type=external_output,default=OUTPUT_DIR)
    args=parser.parse_args()
    plt.rcParams.update({"font.family":"DejaVu Sans","font.size":8,
                         "pdf.fonttype":42,"svg.fonttype":"none"})
    base=DERIVED_DIR/"figure_03/data"
    records=json.loads((base/"fields.json").read_bytes())
    cmap=LinearSegmentedColormap.from_list("vorticity",["#2166AC","#FFFFFF","#B2182B"])
    for case,letter,title in CASES:
        frames=sorted((r for r in records if r["id"].startswith(case+"_")),key=lambda r:r["elapsed_T"])
        if len(frames)!=6:raise ValueError("Expected six selected fields: "+case)
        trajectory=pd.read_csv(base/(case+"_trajectory.csv"))
        fig,axes=plt.subplots(2,3,figsize=(7.2,3.65))
        fig.subplots_adjust(left=.015,right=.985,bottom=.15,top=.88,wspace=.05,hspace=.23)
        fig.suptitle(letter+"  "+title,fontsize=10,x=.015,ha="left")
        for i,(ax,record) in enumerate(zip(axes.flat,frames)):
            image,mask,_=field_2d("03",record["id"])
            image=image.crop((0,0,1538,864))
            ax.imshow(image,extent=(0,1538,864,0))
            if i==5:
                line,=ax.plot(trajectory.center_x+.5,1024.5-trajectory.center_y,
                              color="#66727D",lw=1.05)
                line.set_path_effects([pe.Stroke(linewidth=1.55,foreground="white"),pe.Normal()])
            patch=foreground_patch(image,mask)
            if patch:
                fg,(x0,y0,x1,y1)=patch
                ax.imshow(fg,extent=(x0,x1,y1,y0))
            ax.set(xlim=(0,1538),ylim=(864,0))
            ax.set_title("t = "+format(record["elapsed_T"],".2f"),fontsize=8,loc="left",pad=2)
            ax.axis("off")
        bar=fig.colorbar(ScalarMappable(norm=Normalize(-.8,.8),cmap=cmap),
                        cax=fig.add_axes([.32,.08,.36,.025]),orientation="horizontal",ticks=[-.8,0,.8])
        bar.set_label("Vorticity",fontsize=8);bar.ax.tick_params(labelsize=7)
        save_panel(fig,args.output_dir/("figure_03_"+case))
        plt.close(fig)
    print("Generated four cases, each with six measured flow frames.")

if __name__=="__main__":main()
