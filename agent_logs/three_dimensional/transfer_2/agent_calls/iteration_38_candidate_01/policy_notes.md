# Joint-local full-demand carrier-guard candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture`. There is no
  failed termination in this batch, so the informative negative is a
  protection/propulsion tradeoff among successful mechanisms.
- I inspected every combined keyframe sheet from release through capture,
  including both the top-down mid-plane vorticity row and the oblique 3D
  body/Lambda2 row. In the strongest finite sample `solver_6dada5e7a98a` and
  the lowest-score sample `solver_0e3ccca5bc77`, as well as the two intermediate
  policies, the fish self-propels from quiescent water along a target-directed
  shallow arc. Compact alternating caudal vortices and discrete coherent 3D
  structures persist to capture; no advection, collision, domain exit,
  instability, or wake collapse explains the metric differences. The proven
  traveling carrier and full course redirect should therefore be preserved.
- Metrics expose a distinction hidden by the similar wake sheets. The
  steering-aware full-demand preview `solver_6dada5e7a98a` is fastest and has
  the best distance integral, capturing at `15.604T/1.79354L`, but its
  inherited diagnostics report a `13.137L` head path, peak planar force/yaw
  moment `0.04226/0.02076`, and anterior/posterior greater-than-90%-rate
  residence `17.45/6.66%`. The joint-selective carrier-only preview
  `solver_7d26cc24fc23` captures later at `15.730T/1.80572L`, yet shortens path
  to `12.848L`, lowers load peaks to `0.03558/0.01724`, and lowers rate
  residence to `17.10/5.77%`. Thus full pre-limit demand is the more useful
  contact predictor, while joint-local positive-work withdrawal is the more
  protective allocation.
- The two remaining samples reinforce the boundary rather than motivating
  another terminal gate. All-distance response release
  `solver_0e3ccca5bc77` is slowest at `16.088T/1.82203L`; course-resolved
  release `solver_86f1e218c49a` captures at `15.730T/1.80710L`. Both retain
  the same coherent wake and late-arc topology. The assigned parent and its
  inherited step-37/38 notes likewise identify joint 1 as the repeated rate
  bottleneck and propose composing full-demand prediction with joint-local
  carrier allocation instead of tuning response, distance, load, slip, or
  steering scalars.

## One-candidate policy hypothesis

Preserve the corrected-sign body-frame target geometry, distance/closing
drive relief, velocity-course redirect, joint-phase steering, posterior wave
handoff, carrier/steering decomposition, response-aware reversal release,
soft bounds, and public two-joint contract. Replace the common carrier guard
with joint-local smooth guards. Each joint predicts rate-envelope contact
from its own complete pre-limit acceleration demand, including steering, but
attenuates only its own same-sign positive-work carrier. A shared unresolved-
redirect guard may still subordinate phase-coupled reversal; measured
same-sign yaw retains the inherited far-field release.

Expected signature: retain capture, early milestones, and both coherent wake
views while moving path, load peaks, and rate residence toward the protective
joint-local sample. Falsify if capture or coherent propulsion is lost;
timing/integral regresses beyond sampled repeat variation; posterior work no
longer advances milestones; or path, joint margin, rate residence, command
effort, loads, terminal course, or finite-action checks leave the sampled
useful class. The candidate CFD result occurs only after this worker exits and
is not evidence claimed here.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: protect a constrained rhythmic actuator while preserving the direction, posterior contribution, and target-conditioned residual of the traveling bend
transferable_invariant: contact prediction may use full local demand, but protective withdrawal should act on the same joint's positive carrier work rather than erase steering, reversal, or the other joint's useful carrier
nontransferable_details: published gains, dimensional cadence, clocked phase, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific coordinates or routes
policy_translation: use normalized joint rate and bounded same-joint full acceleration to preview contact, then attenuate only same-joint positive-work carrier while retaining body-frame steering and shared response-aware reversal
falsification: reject if timing/integral, early milestones, capture, path, joint margin, rate residence, loads, terminal course, finite action, or coherent top-down and oblique wakes regress outside the sampled useful class
