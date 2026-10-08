# Candidate visual diagnosis and policy hypothesis

## Evidence diagnosis

- The shared prewarm sheet shows the fish held above and downstream of the
  asymmetric four-cylinder array while all four vortex streets develop.  It is
  a common initial condition, so no candidate-specific gain is attributed to
  its wake pattern.
- The target-blind `0.55`-period seed is propelled upstream only `3.55L` while
  falling `13.30L` and leaving the lower domain after `50.13` released units.
  Its keyframes show lateral escape without useful wake entry; both joint
  rates and both acceleration commands reach the hard limits.
- The current finite anchor (`0.90` period, `28 deg` amplitude, positive
  bearing-to-posterior-tail bias) moves upstream `2.73L`, reaches `6.34L` from
  the target, and survives `73.39` units.  Its released sheet shows genuine
  upstream travel toward the developed wake followed by an excessive upward
  loop and domain exit.  This is consistent with the posterior joint reaching
  `45 deg`, both rates reaching `260 deg/time`, both commands reaching
  `1650 deg/time^2`, and RMS force/moment rising to `196/2014`.
- Moving the steering equilibrium into the anterior oscillator is not a safe
  source of damping: that sample curls at release and becomes unstable within
  `1.52` units, with RMS force/moment `61379/660629`.  Conversely, the sampled
  posterior-only `1.10`-period, `14 deg` gait has low loads (`15/387`) but is
  advected `2.45L` downstream and exits after `19.22` units.  Because it kept
  the positive steering sign while changing period, amplitude, lag, damping,
  and command limit together, it is evidence against weakening propulsion
  wholesale, not evidence for reversing the steering sign.

## Candidate hypothesis

Keep the finite anchor's `0.90`-period, `28 deg` anterior oscillator and keep
target steering exclusively in the posterior mean tail tangent.  Reduce the
static bias ceiling from `10` to `8 deg`, then subtract a bounded
`bearing_window_rate` term from the normalized positive-bearing command.  A
rising bearing therefore relaxes the turn before the proportional term drives
the broad loop; a falling bearing permits the positive posterior correction to
recover.  The rate input and final steering request are both bounded before
the unchanged joint servo and acceleration clamp.

This isolates rate damping from gait strength and avoids the unstable anterior
equilibrium mechanism.  The falsifiable expectation is preserved upstream
head displacement with a smaller lateral excursion, no posterior angle/rate
saturation, lower force/moment loads, and a minimum distance below `6.34L`.
If upstream progress disappears, later candidates should restore the `10 deg`
ceiling before changing period or oscillator amplitude; if the loop worsens,
the bearing-rate sign or scale should be tested independently.
