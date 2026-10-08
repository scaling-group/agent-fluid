# Terminal capture-allocation candidate

## Evidence diagnosis before editing

All three finite sampled rollouts satisfy the experiment contract: direct
uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm, and
no cylinders. Their motion and wakes are therefore policy-generated rather
than imposed advection.

The assigned parent's phase-demodulated redirect is a concrete negative
result, not a mechanism to retain. Its top-down sheet shows an early upward
curl with little targetward displacement and only a short wake; the oblique
Lambda2 row agrees that the swimmer remains intact and sheds vortices, so this
is wrong course allocation rather than numerical instability. It improves
distance only from `12.328L` to `12.120L`, then exits the upper boundary at
`8.48T` with `12.654L` remaining. Thus the inherited replay reduction in
acceleration clipping did not survive coupled CFD as useful propulsion or
route control, and the fitted phase correction plus reversed curvature must
not be treated as validated merely because it smoothed recorded-state replay.

The transferred seed supplies coherent propulsion but inadequate redirect.
Its top-down alternating wake and oblique vortex loops persist through useful
leftward progress, reducing distance to `4.780L`; it then continues downward
and exits at `27.49T`. Raw requests exceed the acceleration envelope on about
`71%/78%` of joint samples, so adding another small acceleration residual is
not a credible fix.

The strongest sampled policy instead reallocates the two joints to bounded
whole-body curvature at large body-frame target angle. Both visual rows show
that it retains a coherent alternating wake and changes the trajectory
topology: it approaches for roughly `27T`, reaches `1.1347L`, and has no raw
command above its `1750 deg/T^2` guard. It misses the `0.75L` capture circle,
then follows a large loop and eventually exits. At closest approach the head
is `(8.614,8.433)L`, about `1.07L` below the target, while body speed is still
about `0.64L/T`; the target-relative radial speed is already negative on some
beat phases and tangential miss speed is about `0.62L/T`. The large-error
redirect is therefore useful and should be preserved. The remaining defect is
terminal turning radius/excess carrier speed, not weak far-field propulsion.

## Policy hypothesis

Start from the evidenced large-error redirect and add one continuous terminal
capture-allocation mechanism. Inside a distance band outside the capture
circle, compute radial closure and tangential miss speed from normalized
`target_body_L` and `velocity_body_U`. When proximity coincides with poor
closure or large tangential motion, reduce the oscillatory carrier amplitude
and proportionally strengthen the already correct-sign bounded curvature
equilibrium. This allocates the same guarded two-joint command toward a tighter
turn without a clock, route, mutable mode, or world coordinate. The gate
vanishes on the successful far approach and when terminal motion is already
target-directed.

The next CFD rollout should retain the large-error policy's coherent far wake
and approach, begin carrier relief near the observed `2L` terminal miss, and
cross `0.75L` rather than pass roughly `1L` below the target. Falsify the
mechanism if minimum distance does not improve on `1.1347L`, the same
post-target loop remains, the far trajectory changes before the proximity
gate can activate, propulsion collapses, or joint/command limits become the
new persistent controller.

bookshelf_consulted: true
source_domain: robotic-fish target-modulated rhythmic control and closed-loop prey capture
source_mechanism: observation-gated allocation from propulsive oscillation to bounded steering during terminal approach
transferable_invariant: when proximity combines with tangential miss motion or lost radial closure, temporarily reserve more two-joint authority for target-relative curvature and restore the carrier as risk falls
nontransferable_details: published CPG gains, dimensional speeds, species-specific capture maneuvers, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target and velocity dot/cross products gate a bounded reduction of oscillator amplitude and a bounded increase of the existing target-relative curvature equilibrium
falsification: reject if the far approach or coherent wake weakens, closest approach fails to beat `1.1347L`, the same large departure loop remains, or terminal joint and command histories become persistently limit-dominated

## Non-CFD activation audit after editing

Replaying the strongest completed rollout's recorded observations through the
new algebra, without advancing fish or fluid state, leaves the terminal gate
exactly zero for every sample at `distance >= 2.60L`. It is `0.03` at
`2.35L`, `0.46` at `1.88L`, `0.85` at `1.47L`, and approximately `0.99` near
the prior `1.13L` miss. The resulting scheduled carrier scale stays in
`[0.42,1]` and curvature scale in `[1,1.32]`. On those fixed joint states the
internal `1750 deg/T^2` guard is active on about `32%/28%` of samples, close
to the evaluated large-error policy's `32%/26%`; the schedule therefore does
not claim to remove limiting, only to change terminal allocation without
altering the far command. These are contract and activation checks, not new
CFD evidence or an improvement claim.
