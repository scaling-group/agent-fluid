# Course-stabilized terminal mean-curvature candidate

## Evidence and visual diagnosis before editing

All sampled and inherited rollouts inspected here satisfy the direct-uniform
still-water contract (`U_infinity=(0,0,0)`, no prewarm, no cylinders). Their
top-down rows show body-connected alternating vorticity, and the oblique rows
show three-dimensional Lambda2 structures that travel with a freely swimming
fish. The common failure is directional, not passive advection or absent
propulsion.

The four README samples preserve useful leftward translation but all pass high
and exit through the upper boundary at `y=15.20L`. Their closest distances are
`2.595--4.650L`; the best scalar sample still misses by `4.650L`. The assigned
parent's pure course-residual policy changes the topology, but overcorrects into
a low pass (`3.176L`) and a lower-boundary exit. Thus the target/course signal
has real turn authority, while replacing target geometry with a beat-scale
course angle is not a stable capture mechanism.

The inherited course-error family contains the strongest useful evidence. A
co-scaled half-cycle controller reaches `1.276L`, and its later terminal
mean-curvature handoff reaches `1.033L`, only `0.283L` outside capture. The
latter retains a compact alternating wake, has zero joint dwell above `40 deg`,
and peaks at only `0.034/0.017` normalized planar force/moment before exiting
lower-left. Its trace identifies the actuator-routing error: when distance
first reaches `2.50L`, body-frame pursuit requests `-0.093 rad`, even though
the rotation-invariant target-versus-velocity course residual already requests
the correcting side at `+0.712 rad`. The terminal mean bend follows the
phase-sensitive pursuit request, so the persistent course correction remains
confined to half-cycle modulation until too late. At `1.20L`, speed is still
`1.121L/T`, course error is `1.192 rad`, and closing speed has fallen to only
`0.415L/T`.

## Single policy hypothesis

Preserve the inherited low-load course-residual carrier, posterior lag,
terminal distance gate, maximum mean bend, and bounded half-cycle actuator.
Change one mechanism: inside the existing terminal handoff, center both joint
oscillations from the same speed-blended target/course navigation residual
already used by the half-cycle channel, rather than from instantaneous body
bearing alone. This gives persistent translational misalignment a slowly
varying mean-curvature actuator without adding another threshold, gain sweep,
or static world-frame cue. Low speed still falls back continuously to pursuit;
the inherited smooth gate leaves the far-field carrier practically unchanged.

Expected evidence is capture, or at minimum a pass below `1.033L` with an
earlier target-side turn and a better return/termination topology. Falsify the
mechanism if it loses the alternating wake, degrades the close pass, retains
the lower-left escape, creates persistent `40 deg` joint dwell, or materially
exceeds the inherited `0.034/0.017` force/moment reference without capture.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG direction tracking and classical mean-curvature turning
source_mechanism: persistent direction feedback shifts the mean of a rhythmic propulsive carrier while the oscillation remains active
transferable_invariant: separate the traveling propulsive wave from a bounded mean-curvature channel driven by persistent target-versus-course error
nontransferable_details: published gains, clocked CPG phase, linkage geometry, species-specific bends, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity invariants to center both joint oscillations from the speed-blended navigation residual only inside the existing terminal handoff
falsification: reject if the 1.033L approach, low loads, zero 40-degree dwell, or coherent wake is lost, or if capture/return topology does not improve

## Dry validation after editing

The prescribed non-CFD checks pass the guidance materiality, parameter schema,
finite two-action contract, and editable boundary. A deterministic reflection
grid over target/velocity geometry and joint state has maximum action symmetry
error `0.0`. Replaying both policies on the inherited `1.033L` trajectory is
not new CFD evidence, but confirms isolation: for recorded states beyond `5L`,
the smooth terminal-gate tail changes action norm by at most `0.0341`; at the
first `2.50L` crossing the intended rerouting changes the two-joint command
from `(-27.229,-29.912)` to `(-22.272,-29.393) rad/T^2`, with finite commands
remaining inside the `30 rad/T^2` smooth envelope. Formal CFD after worker exit
must decide every physical falsifier above.
