# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet is common initial-condition evidence: the held fish
starts above and downstream of the target while the four staggered cylinders
have developed interacting vortex streets across the approach corridor. The
released sheet shows active upstream swimming rather than passive advection.
The fish first turns clockwise from its initial heading, propels into the
disturbed wake, makes a broad loop above the target, and then descends
diagonally through the target circle. The metrics support that reading: it
reaches `0.747L` after `88.13` release units, travels `(-10.92,-4.44)L`, and
has mean head velocity x about `-0.124` versus mean local flow x `-0.092`.
The route therefore retains self-propulsion while correcting the inherited
upper-exit topology.

All four sampled solver artifacts are the same controller behaviorally: their
source differences are comments only, their released keyframe sheets have the
same hash, and every physical metric is identical. They reproduce capture,
`2.736L` mean distance, `0.940` progress, RMS relative crossflow `0.289`, and
RMS force/moment `445/4597`. This is strong deterministic reproducibility at
the assigned snapshot, but it is one control point rather than evidence over
held-out wake phase or layout. No sampled solver in this workspace supplies a
failure sheet, so the counterexample boundary comes from inherited optimizer
logs: the isolated `0.50` phase-headroom controller reaches only `2.13L` and
hooks out of the upper domain, while late bearing-to-lateral replacement
reaches `1.89L` and repeats that exit. Those failures support preserving the
early additive `0.18*tanh(target_body_L[2]/2L)` correction unchanged.

The remaining defect is actuator saturation. The successful rollout reaches
the exact `45 deg` posterior angle limit, both `260 deg/time` joint-rate
limits, and both sides of the policy's `1650 deg/time^2` acceleration ceiling;
command energy is `76354.5`. Capture therefore validates arrival but not
desaturation. Prior desired-posterior clipping at `42 deg` destroyed
propulsion (`8.21L` closest approach), and direct-body-rate sweeps away from
`0.70/0.35` worsened approach or loads, so neither angle clipping nor another
rate-feedback change is justified here.

## Single candidate hypothesis

Keep the reproduced arrival controller unchanged except for lowering its
policy-owned symmetric acceleration ceiling from `1650` to
`1500 deg/time^2`. This is one conservative desaturation axis: it preserves
the `0.90`-period gait, `11 deg` posterior request, `0.70/0.35` direct-body-rate
feedback, `0.50` opposing-phase allocation, and additive `0.18` cross-track
term. It uses no elapsed time, global coordinates, fixed route, prescribed
inflow, or remote wake signal.

The hypothesis is supported only if the fish still reaches the `0.75L` target
with the same diagonal topology while peak command and preferably RMS load or
command energy fall; an earlier arrival or lower mean distance would be a
score improvement. It is falsified by loss of capture, return of the upper
hook, materially slower approach, or unchanged rate/angle saturation with no
load benefit. A negative result should close simple acceleration-ceiling
reduction and restore `1650 deg/time^2`; later workers should not compensate
by stacking the already falsified clipping, velocity, recovery, or
phase-headroom overlays.
