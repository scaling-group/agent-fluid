# Multi-wake candidate diagnosis and hypothesis

## Evidence diagnosis before the policy edit

- The four current sampled rollouts are all finite captures, so no current
  failure keyframe sheet exists. Their certified prewarm sheets are
  byte-identical: the fish is held at the upper-right release pose while the
  four staggered-cylinder streets develop and overlap through the target
  corridor. This ranks neither policy. For contrast I compared the strongest
  current finite rollout with the weaker static anchor, the inherited `0.10`
  continuation, and the inherited optimizer record of the horizon miss.
- The current `0.08` sign-gated lateral-translation pair is the strongest
  available evidence. Its released sheet shows self-propelled upstream travel,
  a broad acquisition turn, alternating wake-band crossings, and an earlier
  central-corridor approach without collision, domain exit, or instability.
  It captures at `224.488` with mean distance `6.311L`; mean body velocity x
  `-0.04895` exceeds mean local-flow x magnitude `0.03293`, giving `0.01602`
  controller-relative upstream transport. RMS relative crossflow, force, and
  moment are `0.13427/17.943/361.014`, and anterior acceleration remains
  `31.055` below the `31.2` local guard.
- The otherwise matched zero-lateral-lookahead anchor visibly takes a longer,
  jagged sequence of turn reversals and captures at `244.547` with mean
  distance `6.452L`. Its relative upstream margin is only `0.00793`, while
  RMS force/moment are higher at `18.263/362.214`. Thus the `0.08` gain is a
  steering-timing improvement rather than added propulsion: gait, maximum
  lateral offset `4.293L`, and anterior acceleration maximum are unchanged.
- The inherited `0.10` continuation is the informative local negative. Its
  sheet shows more late zig-zagging after the initial wake acquisition and
  does not enter the target until rendered frame `30`, versus frame `25` for
  `0.08`. Metrics confirm regression: capture is delayed to `263.346`, mean
  distance rises to `6.974L`, score falls to `-4.949`, relative upstream
  margin falls to `0.00931`, RMS force rises to `18.310`, and mean command
  energy rises to `707.479`. Its slightly lower relative crossflow `0.13295`
  is not useful given the route regression. The same `4.293L` lateral offset
  and `31.055` anterior maximum again isolate steering timing.
- The inherited optimizer logs describe the available hard failure boundary:
  a sign-asymmetric bearing-rate branch made wide reversals, missed the horizon
  after a `3.290L` minimum, and ended at `3.632L` despite lower force and the
  same propulsion maximum. Together these observations argue against stronger
  lateral correction, more drive, or another heading/rate retune.

## Single candidate hypothesis

Keep the evaluated `20.25 deg`, `0.67`-period oscillator, posterior
lag/damping, `10 deg` steering limit, `0.30` bearing scale, `0.25` bounded
bearing-rate lookahead, `0.10` lateral-velocity clamp, and `31.2` acceleration
guard. Change only `lateral_velocity_lookahead` from `0.08` to `0.075`. This is
a one-sided `6.25%` retreat from the demonstrated best after the stronger
`0.10` continuation failed; it preserves the evidenced sign gate while
slightly reducing late counter-drift authority. At the velocity clamp the
candidate contributes at most `0.0075 rad` before the steering nonlinearity,
only when `bearing * velocity_body_U[2] < 0`. It uses no coordinate, route,
clock, prescribed inflow, or remote wake probe.

The falsifiable expectation is retained capture no later than the static
anchor, mean distance no worse than `6.452L`, positive upstream margin, and no
force/moment or guard regression, with a smoother or earlier late corridor
than the `0.10` sheet. Improvement over `0.08` requires capture before
`224.488` or a lower mean distance/load without slower capture. Reject this
local refinement if it loses capture, delays past the anchor, increases route
integral/load, reduces upstream transport, touches the guard, or introduces
zero-bearing switching. Because all evidence uses one fixed prewarm phase,
even a positive result remains local until a held-out wake phase reproduces it.
