# Multi-Wake Policy Candidate Notes

## Evidence diagnosis

The shared prewarm sheet shows the fish held in the upper-right release pose
while four interacting vortex streets develop across the target neighborhood.
This is a common initial condition, not candidate-specific evidence.

The assigned posterior-curvature policy visibly retains a traveling bend and
self-propels upstream, but after approaching to only `2.43L` it passes above
the target corridor, hooks toward the upper boundary, and exits at `84.22`.
Its `-10.51/+1.80L` head displacement and `116/1278` force/moment RMS agree
with that low-load but wrong lateral topology. Its low aggregate loads do not
compensate for losing the target.

In contrast, all three sampled yaw-gated distributed-half-cycle policies have
the same finite result: a continuous diagonal down-left trajectory through the
developed wake, first target crossing at `51.47`, final/minimum distance
`0.748L`, mean distance `1.82L`, and `-11.28/-4.94L` head displacement. The
released keyframes show a persistent traveling body wave rather than passive
advection. Force/moment RMS remains high at `426/4084`, but it is below the
inherited ungated heading-response result (`487/4680`), which approached to
`1.65L` before folding into a lower exit at `75.09`.

## Policy hypothesis

Replace the assigned posterior-only mean-curvature steering equilibrium with
the sampled successful architecture. Preserve the zero-centered state-feedback
oscillator, posterior velocity lag, and smooth acceleration limit. Form a
body-frame route request from bearing minus bounded observed heading response,
distribute it as half-cycle acceleration asymmetry across both joints, and
smoothly gate only that steering residual with normalized yaw-moment magnitude
while retaining a nonzero authority floor. This changes a controller mechanism,
not just a scalar gain, and leaves propulsion active during large wake/body yaw.

The candidate is falsified if evaluation loses `target_reached`, materially
regresses the successful upstream/downward displacement or `1.82L` mean-distance
history, or raises loads without a route benefit. A directional moment residual
is deliberately excluded: aggregate RMS and sparse keyframes do not establish
the event-level sign relation between moment and requested turn.

bookshelf_consulted: true
source_domain: robotic-fish sensor-feedback CPG control and wake-interaction adaptive swimming
source_mechanism: preserve rhythmic propulsion while feedback modulates a bounded steering residual instead of cancelling all wake-induced motion
transferable_invariant: separate the propulsive traveling bend from body-frame route correction and attenuate only correction when normalized yaw interaction is already strong
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, and single-cylinder routes
policy_translation: bearing minus bounded heading response forms route turn; absolute normalized yaw moment smoothly gates distributed two-joint half-cycle asymmetry with a nonzero floor
falsification: reject if target success or useful displacement is lost, load worsens without route benefit, or the prior upper/lower exit topology returns; require signed event evidence before adding directional rejection
