# Multi-wake candidate diagnosis

## Visual and metric diagnosis before editing

- The shared prewarm sheet shows the fish held at the upper-right while four
  mature, interacting cylinder streets fill the route to the second-row
  target. This is the common initial condition and is not credited to any
  candidate.
- The undamped positive-bearing anchor (`0.90` period, `28 deg` anterior
  oscillator, `10 deg` posterior bias) visibly self-propels diagonally toward
  the wake, reaches `6.34L`, and remains in-domain for `73.39` released units,
  then makes a broad upper loop. Its mean head velocity is upstream relative
  to its local flow (`-0.0447` versus `-0.0293`), but the posterior angle and
  both rate/command limits are reached; RMS force/moment are `196/2014`.
- Direct normalized heading-rate damping has a useful monotone sampled effect
  on upstream approach. Raising its gain from `0.35` to `0.70` improves mean
  head velocity from `-0.0878` to `-0.1300`, progress from `0.255` to `0.380`,
  mean distance from `9.48L` to `8.03L`, and minimum distance from `7.30L` to
  `5.33L`. The released sheet shows genuine faster travel toward the target,
  not passive advection, because mean local flow is only `-0.0908`.
- The `0.70` gain is not a loop cure. It exits through the same upper boundary
  after `55.38` units, retains the roughly `6.09L` maximum lateral target
  offset and both rate/command caps, and raises RMS force/moment to
  `325/3331`. Its posterior angle peaks at `44.1 deg`, below the exact
  `45 deg` hard stop, so the angle stop alone does not explain the loop.
- Adding a bounded `0.20` body-lateral-velocity correction to the `0.35`
  controller is a negative result. The corresponding sheet repeats the upper
  curl while upstream speed falls to `-0.0695`, progress to `0.174`, and
  minimum distance worsens to `7.73L`; posterior/rate/command saturation
  remains. Inherited bearing-window-rate and closing-bearing brakes likewise
  either retain the loop/caps or remove swimming authority. Those rate-like
  channels are not supported as the next repair.

## Single candidate hypothesis

Use the complete strongest sampled `0.70` direct-heading-rate controller, and
change only the posterior steering ceiling from `10 deg` to `8 deg`. The
heading-rate term can suppress steering while the body is rotating, but its
contribution vanishes as rotation slows; the still-saturated geometric request
then restores the full mean tail bend and can sustain the visible upper loop.
A modest static-ceiling reduction directly tests that residual request without
changing oscillator period, amplitude, phase lag, posterior servo damping,
bearing sign, or command cap. The earlier confounded `8 deg` bearing-rate
candidate retained upstream motion, so this ceiling is a bounded test rather
than wholesale gait weakening.

The falsifiable expectation is to retain clearly negative mean head velocity
and improve survival or lateral containment relative to the `0.70` sample,
while preserving its approach advantage over the `0.35` parent. Reject the
mechanism if upstream progress falls back toward the undamped anchor or if the
same upper loop and rate/command caps persist; later workers should then restore
the `10 deg` ceiling and isolate bearing sensitivity or posterior servo
bandwidth, not add more heading damping or revive lateral/bearing-rate brakes.
