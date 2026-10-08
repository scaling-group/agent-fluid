# Candidate diagnosis and hypothesis

## Evidence read before editing

- The four sampled solver examples are byte-identical v33 policies with the
  same combined keyframe sheet. They are one repeated strong finite result,
  not four independent controller outcomes: capture at `23.8425T`, score
  `-0.535091`, mean distance `2.433543L`, and final distance `0.746165L`.
- The observation and diagnostics confirm direct uniform initialization in
  still water (`U_infinity=[0,0,0]`), no prewarm, and 236 moving-window
  shifts. The top-down row shows self-propelled target approach with an
  alternating attached-to-shed vorticity street from release through capture.
  The oblique row shows compact alternating Lambda2 structures behind the
  caudal region rather than passive advection or wake collapse.
- The terminal path remains productive but not course-aligned. Inside `3L`,
  v33 closes at a mean `0.681L/T`, while mean absolute yaw is `1.680 rad/T`,
  mean absolute target-line cross-track speed is `0.239U`, and peak yaw and
  moment are `3.185 rad/T` and `0.01373`. Reconstructed body-frame samples
  show course error growing from about `0.21 rad` at `3L` to `0.60 rad` at
  `1.5L`, even as distance keeps decreasing. Thus cancelling all yaw is not
  warranted; the missing distinction is between productive closing yaw and a
  velocity vector that predicts lateral miss.
- Inherited results bound simpler alternatives. V35 reduced terminal yaw and
  lateral speed but delayed capture and worsened score/distance; v36 restored
  cadence without improving the objective. Earlier hard cue consensus, moment
  feedback, fixed allocation transfer, posterior relief, and phase-lag
  damping likewise failed. Those results argue against another yaw damper,
  cadence gain, sign gate, or actuator-share retune.

## Policy hypothesis

Preserve v33's oscillator, redirect, anterior phase-selected correction,
posterior traveling wave, terminal continuous course bend, and cadence. Add
one bounded collision-cone route residual: compare the carrier-rejected
cross-track speed with the actual target-line closing speed, express the
result as a dimensionless course angle, and feed it continuously into the
mean turn request only inside the existing `3L` terminal band. This asks for
the yaw needed to align translation with the collision line instead of merely
reducing yaw magnitude. It uses only normalized body-frame geometry,
velocity, joint state, and distance; there is no clock, world direction, or
memorized route.

The candidate is falsified if it loses capture, delays capture beyond v33,
worsens mean/final distance, breaks the alternating top-down/Lambda2 wake,
raises joint-limit exposure, or reduces yaw while also reducing closing speed
as v35 did. A useful outcome must retain v33-scale closure and improve course
alignment, with terminal yaw/load no worse.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal fish-swimming control
source_mechanism: sensor feedback modulates a mean turn command while the rhythmic carrier remains intact
transferable_invariant: separate propulsive rhythm from a bounded body-frame course correction and reject only motion that predicts lateral miss
nontransferable_details: published CPG gains, robot geometry, species kinematics, dimensional frequencies, exact vortex phase, and task routes
policy_translation: convert carrier-rejected target-line cross-track speed and closing speed into a soft collision-cone angle, proximity-gate it, and add it to the existing two-joint mean-curvature request
falsification: reject if capture or distance regresses, coherent paired shedding degrades, limit exposure rises, or quieter yaw again trades away closure
