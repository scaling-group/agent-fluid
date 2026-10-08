# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

The assigned-parent rollout and all three distinct sampled policies were read
through their score, observation, metrics/diagnostics, trajectory, and combined
keyframe evidence. Each evaluation reports direct uniform initialization with
`U_infinity=(0,0,0)`, no cylinders, and a finite `capture`; there is no
prewarm artifact or informative non-capture in this sample. I therefore compare
the highest-scoring finite capture (course-observer stabilization handoff) with
the lowest-scoring finite capture (the assigned-parent demand handoff; its
duplicate rollout is bit-identical).

In both combined sheets, the top-down row shows self-propulsion rather than
advection: a compact alternating vorticity street lengthens behind the fish as
the body follows a smooth left-and-down target arc. The oblique row confirms a
coherent alternating three-dimensional Lambda2 wake, continued body undulation,
and no out-of-plane instability or wake collapse. The sheets are visually very
similar, so the small score ordering must come from trajectory/load histories,
not a claimed vortex-topology change.

Relative to the assigned parent, the sampled carrier-rejected course observer
improves score/mean/final distance from
`-0.5034147/2.400748L/0.747085L` to
`-0.5016915/2.399184L/0.746948L`. Inside `3L`, it reduces mean absolute yaw
from `1.71472` to `1.68733 rad/T`, mean/peak target-line cross-track speed
from `0.23486/0.62108U` to `0.22592/0.58298U`, and mean/peak absolute moment
from `0.006597/0.014923` to `0.006393/0.013886`. Smoothly projected peak
commands remain comparable and both joint-speed traces reach the same physical
cap. The tradeoff is capture at `23.4410T` rather than `23.3750T`, and peak
terminal yaw rises from `3.27552` to `3.34971 rad/T`.

## Candidate

Replay the sampled semantic improvement exactly: replace body-lateral velocity
in the slow geometric and carrier-rejected route requests with a normalized
target-line course residual. Compute target-line cross-track translation in
the body frame, subtract the anterior joint-rate carrier coordinate scaled by
the nominal state-feedback oscillator rate, normalize by swimmer speed, and
gate the undefined direction near rest. Retain the sampled bounded union of
continuous and phase-selected stabilization demands for handing off only the
small cadence reserve. Keep all propulsion, C-bend polarity, posterior lag,
steering authority, and component-wise command projection unchanged.

This is a mechanism selection backed by a completed sampled rollout, not a
scalar gain tune. The next CFD evaluation is a repeatability test. Falsify the
candidate if it loses capture or coherent propulsion; if it fails to retain
the sampled distance, cross-track, and moment improvements within rollout
variation; or if the higher peak yaw becomes a larger load/feasibility defect.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-feedback modulation of robotic-fish oscillators
source_mechanism: separate slow persistent route error from fast carrier or disturbance motion, then apply the residual through bounded feedback without erasing the propulsive wave
transferable_invariant: route steering should respond to target-relative course after rejecting the observed joint-state carrier, while the state-feedback traveling bend continues to own propulsion
nontransferable_details: published gains, dimensional beat frequencies, species kinematics, exact vortex phases, cylinder-wake assumptions, and task-specific routes
policy_translation: use the rotation-invariant body-frame target/velocity cross product minus normalized anterior joint rate in both slow route requests; preserve the two-joint posterior-lag oscillator and bounded command projection
falsification: reject if repeat CFD loses capture or wake coherence, regresses score/distance/cross-track/moment toward the assigned parent, or worsens peak yaw and actuator feasibility
