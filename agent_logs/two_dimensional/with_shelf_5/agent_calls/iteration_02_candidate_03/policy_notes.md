# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The assigned parent is the common target-blind oscillator. Its released
keyframes show an initially diagonal fish curling into a nearly vertical
descent and leaving through the lower boundary without entering the target
corridor. The metrics agree: it exits after `50.127`, displaces
`(-3.545,-13.300)L`, reaches only `8.615L` minimum distance, and ends at
`12.123L`. Mean velocity is only about `0.038U` from mean local flow, while
both joint rate and acceleration reach their hard limits. The parent therefore
has a useful traveling-bend scaffold but lacks target-directed mean steering;
more scalar drive is not supported.

The sampled `solver_0e81665db579` provides positive mechanism evidence. Its
released sheet shows a sustained curved diagonal route from the upper-right
release region to the second-row target rather than the parent's downward
plunge. It terminates `target_reached` after `93.032`, with mean/final distance
`4.033/0.749L`, progress `0.940`, and displacement `(-10.915,-4.204)L`.
Relative-to-local-flow motion is materially stronger than the parent's, and
mean command energy and power fall from `1496/115.7` to `972.5/66.9`, although
the successful trajectory still reaches the joint envelope and carries higher
RMS force and moment. This is evidence for preserving its compact steering
mechanism, not for adding more actuation.

The other completed variants identify a useful boundary. With the same fast
carrier but a `12 deg` head bias and `0.75` posterior share,
`solver_c1f78d94eff2` shows little visible traveling bend, drifts out of the
right boundary in `16.791`, and has progress `-0.147`. Reducing the carrier to
`14 deg` amplitude and period `0.90` likewise exits right in `17.457` with
progress `-0.145`. The inherited period-`1.1` variant with heading-rate damping
becomes `unstable_dynamics` after `14.508`, with RMS force/moment exploding to
`22068/382309`. Thus neither larger static curvature, scalar carrier relief,
nor an uncalibrated yaw-damping addition survives the current evidence.

## Candidate hypothesis

Use the one demonstrated successful mechanism: map body-frame target bearing
through a smooth saturation to an `8 deg` anterior mean-curvature bias, center
the parent's joint-state oscillator on that bias, and give the posterior mean
component a `0.65` share while retaining the original velocity-dependent lag.
This keeps the successful propulsive carrier intact and changes only its mean
curvature. Do not add crossflow, force, moment, or heading-rate feedback because
the compact evidence has no sign-resolved event history that calibrates such a
residual, and the inherited heading-rate variant was unstable.

Expected evaluation evidence is the already demonstrated topology: visible
traveling bend, sustained target-bearing closure, survival beyond the early
right/lower exits, and target capture. Falsify the candidate if it loses the
diagonal approach, exits a boundary before entering the wake corridor, or
retains hard-limit action without target-directed progress. High force and
moment in the successful sample remain an explicit later optimization target,
but should be reduced only after retaining semantic success.

bookshelf_consulted: true
source_domain: biological and robotic-fish direction control
source_mechanism: bounded mean-curvature bias superposed on a posterior-lagged propulsive rhythm
transferable_invariant: persistent body-frame target error can shift mean curvature while the oscillatory traveling bend remains intact
nontransferable_details: published gains, species-specific envelopes, clocked CPG phase, exact vortex phases, and task-specific routes
policy_translation: smoothly saturate observed bearing into separate anterior and posterior joint-center biases around the existing joint-state oscillator and posterior lag
falsification: reject if target-bearing closure or trajectory topology does not improve, propulsion collapses, or actuation and load growth occur without semantic progress
