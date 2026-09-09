# Multi-Wake Policy Candidate Notes

## Evidence diagnosis

The only sampled rollout is the common target-blind seed, so it is both the
best finite example available and the informative failure.  The shared
prewarm sheet shows four developed, interacting vortex streets with the held
fish starting above and to the right of the target.  After release, the fish
self-propels rather than merely drifting: its head moves `-3.545L` in x in
`50.127` release-time units.  The motion is nevertheless not target-directed.
The released keyframes show a tightening, near-vertical descent that never
enters the cylinder/target corridor and ends at the lower boundary.

The metrics support that visual diagnosis.  Vertical head displacement is
`-13.300L`, versus the desired target offset of roughly `-4.30L` in y.  Target
bearing grows from `8.8 deg` initially to `85.5 deg` just after the best
approach.  Distance reaches `8.61495L` at `t=31.944`, then exceeds `9L` again
by `t=36.377` and finishes at `12.1226L`.  This is not a collision or numerical
failure; it is loss of route control followed by `left_domain`.  The seed also
spends about `61.8%` and `64.2%` of samples at the joint-acceleration cap, so a
small additive steering acceleration could be hidden by clipping.

## Policy hypothesis

Keep the demonstrated state-feedback traveling bend, but add one missing
controller mechanism: map bounded body-frame target bearing to mean curvature.
Implement the curvature as a slowly varying equilibrium shift for joint 1 and
as a compatible mean component of joint 2's lagged target.  This preserves an
oscillation around the steering shape and gives the posterior joint a smaller
share of the bias.  Do not add uncalibrated wake or yaw terms on this first
test, and do not use cylinder locations, wake probes, elapsed time, or a
world-frame route.

Expected evidence after evaluation: bearing should fall rather than remain in
the `60--86 deg` range, the fish should avoid the lower-domain exit for longer,
and upstream x progress should be retained.  Reject the mechanism if the turn
sign is wrong, the minimum-distance improvement disappears, acceleration
clipping increases, or the rollout repeats the same descending exit topology.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and biological mean-curvature turning
source_mechanism: bounded tail-beat curvature bias driven by target-direction feedback
transferable_invariant: a persistent body-frame direction error can steer an undulatory gait by shifting its mean curvature while retaining posterior phase lag
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, exact vortex phase, and any fixed route through the cylinders
policy_translation: bound normalized body-frame target bearing with `tanh`, shift the joint-1 oscillator equilibrium, and give joint 2 a smaller compatible bias around its lagged target
falsification: reject if body-frame bearing does not decrease, target progress or upstream propulsion is lost, joint clipping/load severity worsens, or the fish still exits through the lower boundary
