# Source Notes for Fish Control Primitives

Use this file when a source family informs a policy mechanism or when
provenance is needed. Extract the transferable principle; do not paste source
prose into optimization notes or copy numerical settings. The first four
sections retain the source shelf from the earlier dogfish target-policy
program; the final section adds wake-specific sources already present in the
project literature database.

## Classical fish-swimming models

- Taylor swimming sheet and long/narrow animal swimming: traveling lateral
  waves and the limitations of a reciprocal standing-wave primitive.
  - https://doi.org/10.1098/rspa.1951.0058
  - https://doi.org/10.1098/rspa.1952.0199
- Lighthill elongated-body theory: reactive force model for slender fish,
  emphasizing tail kinematics, added mass, and reactive thrust.
  - https://doi.org/10.1098/rspb.1971.0085
  - https://cir.nii.ac.jp/crid/1361981469143134592?lang=en
- Bainbridge body/caudal-fin kinematics: classic measurements relating fish
  speed, tail-beat frequency, and amplitude.
  - https://doi.org/10.1242/jeb.40.1.23
- Undulatory and oscillatory swimming review: gait taxonomy and Strouhal
  discussion.
  - https://doi.org/10.1017/jfm.2019.284

## Efficiency and scaling

- Triantafyllou/Taylor/Nudds/Thomas Strouhal result: cruising swimmers and
  flyers often occupy a moderate `St = fA/U` range. Use it as a guardrail, not a
  fixed target.
  - https://doi.org/10.1038/nature02000
- Eloy optimal Strouhal number: Lighthill-based optimality discussion across
  animal scales.
  - https://doi.org/10.1016/j.jfluidstructs.2012.02.008
  - https://www.irphe.fr/~eloy/assets/pdf/JFS2012.pdf
- Gazzola, Argentina, and Mahadevan scaling: swimming speed related to body
  kinematics across scales.
  - https://doi.org/10.1038/nphys3078

## CFD and simulation-control work

- Kern and Koumoutsakos: evolutionary optimization of three-dimensional
  anguilliform body motion with wake and efficiency analysis.
  - https://doi.org/10.1242/jeb.02526
  - https://cse-lab.seas.harvard.edu/files/cse-lab/files/kern2006b.pdf
- Gazzola, Hejazialhosseini, and Koumoutsakos: vortex-method simulation and
  reinforcement learning for self-propelled swimmers.
  - https://doi.org/10.1137/130943078
  - https://experts.illinois.edu/en/publications/reinforcement-learning-and-wavelet-adapted-vortex-methods-for-sim/
- WaterLily dogfish/shark examples: body shape, amplitude envelope,
  Strouhal/Reynolds controls, and dynamic body maps.
  - https://julialang.org/blog/2021/08/sharks/
  - https://github.com/WaterLily-jl/WaterLily.jl

## Robotic fish and CPG control

- Ijspeert CPG review: coupled oscillators as low-dimensional commands for
  rhythmic locomotion.
  - https://doi.org/10.1016/j.neunet.2008.03.014
- Xie, Zhong, Du, and Li: amplitude, angular velocity, offset, and duty-ratio
  parameters, including asymmetric flapping for turning.
  - https://doi.org/10.1007/s42235-019-0019-2
  - https://research.cuhk.edu.hk/en/publications/central-pattern-generator-cpg-control-of-a-biomimetic-robot-fish--2/
- Chen et al.: closed-loop CPG modulation with sensor feedback for avoidance
  and direction tracking.
  - https://doi.org/10.1007/s42235-021-0008-0
- Robotic-fish turning and averaging models: tail-beat bias, amplitude, and
  frequency as turning primitives.
  - https://fileadmin.cs.lth.se/ai/Proceedings/ICRA2010/MainConference/data/papers/1329.pdf
  - https://www.egr.msu.edu/~xbtan/Papers/Journal/2015/TRO15-RoboticFish-Averaging.pdf
- DRL/CPG path following: learning over CPG parameters or residual commands
  instead of raw high-frequency joint torque.
  - https://www.sciencedirect.com/science/article/pii/S2405896320329724
  - https://www.frontiersin.org/articles/10.3389/frobt.2021.809427/full

## Wake interaction and adaptive swimming

- Liao, Beal, Lauder, and Triantafyllou: Kármán gait kinematics and reduced
  muscle activity when trout interact with an organized vortex street. These
  results motivate inspecting phase and load response, not forcing a Kármán
  gait in the present transient four-cylinder task.
  - https://doi.org/10.1242/jeb.00209
  - https://doi.org/10.1126/science.1088295
- Zhu, Tian, Young, Liao, and Lai: coupled fish simulation and recurrent deep
  reinforcement learning for prey capture, rheotaxis, and position holding in
  a Kármán vortex street; useful for state/history design comparisons.
  - https://doi.org/10.1038/s41598-021-81124-8

The source set provides qualitative mechanisms and provenance. It does not
supply numerical gains or establish validity for this L64 two-joint controller.
