"""Draw the agent framework directly from code, with real illustrative data."""
import argparse
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch
from paths import OUTPUT_DIR, DERIVED_DIR, external_output
from fields import field_2d

def export(output):
    output=external_output(output);output.mkdir(parents=True,exist_ok=True)
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':8,'pdf.fonttype':42,'svg.fonttype':'none'})
    fig=plt.figure(figsize=(180/25.4,120/25.4));ax=fig.add_axes([0,0,1,1]);ax.set(xlim=(0,1),ylim=(0,1));ax.axis('off')
    def box(x,y,w,h,title,detail,face='#f3f5f7'):
        ax.add_patch(FancyBboxPatch((x,y),w,h,boxstyle='round,pad=.008,rounding_size=.012',lw=.7,ec='#9aa5ae',fc=face))
        ax.text(x+w/2,y+h-.035,title,ha='center',va='top',weight='bold',fontsize=8.4)
        ax.text(x+w/2,y+.025,detail,ha='center',va='bottom',linespacing=1.5,fontsize=7.3)
    def arrow(a,b,label=None):
        ax.add_patch(FancyArrowPatch(a,b,arrowstyle='-|>',mutation_scale=10,lw=.8,color='#596774'))
        if label:ax.text((a[0]+b[0])/2,(a[1]+b[1])/2+.022,label,ha='center',fontsize=7)
    ax.text(.035,.96,'Self-evolving agents for fluid control',fontsize=12,weight='bold',va='top')
    box(.035,.65,.25,.22,'Knowledge Shelf','Reference solutions\nPrior observations\nReusable control ideas','#edf3f9')
    box(.355,.65,.25,.22,'Evolving population','Executable policies\nMeasured performance\nRecorded lineage')
    box(.675,.65,.285,.22,'Parallel agent workers','Propose control changes\nImplement candidate policies\nInspect evaluation feedback','#f8eeee')
    arrow((.29,.76),(.35,.76),'retrieve');arrow((.61,.76),(.67,.76),'select')
    box(.04,.33,.245,.21,'Policy code','Observations → joint commands\nEditable control logic')
    box(.355,.33,.25,.21,'CFD environment','Coupled swimmer–fluid dynamics\nTarget-reaching task')
    box(.675,.33,.285,.21,'Evaluation and selection','Navigation score and capture\nTrajectories and flow fields')
    arrow((.81,.64),(.81,.58));arrow((.81,.58),(.16,.58));arrow((.16,.58),(.16,.55))
    arrow((.29,.435),(.35,.435));arrow((.61,.435),(.67,.435))
    arrow((.965,.44),(.985,.44));arrow((.985,.44),(.985,.91));arrow((.985,.91),(.48,.91));arrow((.48,.91),(.48,.875))
    ax.text(.76,.92,'retain and improve',fontsize=7,ha='center')
    trajectory=pd.read_csv(DERIVED_DIR/'figure_02/data/trajectory_centerlines.csv');p=trajectory[trajectory.iteration==19]
    path_ax=fig.add_axes([.07,.07,.19,.19]);path_ax.plot(p.center_x/64,p.center_y/64,color='#2166ac',lw=1)
    path_ax.set_aspect('equal');path_ax.axis('off');path_ax.set_title('Recorded trajectory',fontsize=7,pad=2)
    image,_,_=field_2d('02','i19');flow_ax=fig.add_axes([.355,.06,.25,.21]);flow_ax.imshow(image);flow_ax.axis('off');flow_ax.set_title('Computed flow field',fontsize=7,pad=2)
    score=pd.read_csv(DERIVED_DIR/'figure_02/data/figure_02_ab_candidates.csv')
    curve=score[(score.condition=='with_shelf')&(score.run==1)].groupby('iteration').navigation_score.max().cummax()
    score_ax=fig.add_axes([.72,.105,.205,.135]);score_ax.plot(curve.index,curve.values,color='#2166ac',lw=1)
    score_ax.spines[['top','right']].set_visible(False);score_ax.tick_params(labelsize=6,length=2)
    score_ax.set(xlabel='Iteration',ylabel='Score');score_ax.xaxis.label.set_size(6.5);score_ax.yaxis.label.set_size(6.5)
    score_ax.set_title('Measured policy improvement',fontsize=7,pad=3)
    from panels import save_panel
    save_panel(fig, output/'figure_01_workflow')
    plt.close(fig)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--output-dir',type=external_output,default=OUTPUT_DIR);export(p.parse_args().output_dir)
