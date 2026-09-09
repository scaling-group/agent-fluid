# Candidate wake-policy notes

## Evidence diagnosis

Only the common naive seed is sampled, so it is both the best finite example
and the informative failure; there is no inherited optimizer log to supply an
additional trajectory. The shared prewarm sheet shows a fully developed,
interacting four-cylinder wake before release. In the released sheet the fish
is visibly self-propelled, but it yaws from its initial diagonal pose into a
near-vertical descent and never enters the target/wake corridor. Its centerline
track continues downward until the lower-domain exit rather than curling back
toward the target.

The metrics support that reading: the seed exits after only `50.1269` of the
`300` release horizon, displaces `-3.545L` in x but `-13.300L` in y, and turns
an initial `8.615L` closest approach into a `12.123L` terminal miss with only
`0.0243` progress. It is therefore not passively advected or propulsion-starved;
it has strong but target-blind motion. The exact velocity and acceleration caps
are both reached (`4.5379 rad/time` and `31.4159 rad/time^2`), command energy is
`75002.3`, and the tailbeat/shedding-frequency ratio is `32.83`. Those facts
make a small additive steering acceleration likely to disappear under clipping.
The wake load is nontrivial (`RMS force_y=21.94`, `RMS moment_z=541.70`), but
there is no sampled target-directed baseline from which to infer a signed
crossflow or force residual, so this candidate does not guess one.

## Policy hypothesis

Preserve a joint-state oscillator and posterior lag because the seed visibly
self-propels. Add one bounded target-geometry-to-mean-curvature mechanism:
center the anterior oscillation on a body-frame bearing command, give the
posterior target a smaller same-sign mean bias, and damp the command with
observed heading rate. Slow and narrow the carrier enough that this feedback
has actuator headroom rather than competing with persistent hard-cap clipping.
The steering command remains continuous, symmetric under a lateral reflection,
and independent of time, coordinates, cylinder identity, or wake phase.

Expected result: the fish should retain a traveling bend, rotate toward the
body-frame target vector, avoid the immediate lower exit, and obtain materially
more x progress and a longer finite trajectory. Reject the mechanism if the
turn sign is wrong, propulsion collapses, joint clipping remains persistent,
or the rollout preserves the same near-vertical left-domain topology. Only a
later CFD evaluation can establish improvement.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and tail-beat-bias turning
source_mechanism: sensor-modulated rhythmic propulsion with bounded mean-curvature bias
transferable_invariant: a slow body-frame direction error can bias the mean of a traveling bend while measured yaw rate damps overshoot
nontransferable_details: published gains, robot geometry, clocked CPG phase, species-specific amplitudes, exact vortex phases, and task routes
policy_translation: map normalized body-frame bearing and heading rate to a bounded bias shared across the two joint targets while retaining joint-state oscillator phase and posterior lag
falsification: reject if target progress does not improve beyond 0.024, the fish still exits downward near 50 time units, the target turn has the wrong sign, or restored headroom fails to reduce cap-dominated motion
