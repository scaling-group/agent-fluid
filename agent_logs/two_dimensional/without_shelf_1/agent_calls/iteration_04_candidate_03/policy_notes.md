# Wake-policy candidate diagnosis

## Visual and metric diagnosis

- The shared prewarm sheet shows the fish held in the upper-right while the
  four staggered cylinder streets develop across the target corridor. This is
  the common initial condition, not a policy-specific advantage.
- The target-blind `0.55`-period seed is largely swept downward. Its released
  sheet shows no sustained target turn before lower-boundary exit; the metrics
  agree (`-3.55L` head x displacement, `-13.30L` y displacement, minimum
  distance `8.61L`, and both action/rate caps reached).
- The strongest finite sample is the `0.90`-period, positive posterior-tail
  bias policy. It visibly self-propels diagonally toward the target at first,
  reaches `6.34L`, and has upstream head velocity beyond its mean local flow
  (`-0.0447` versus `-0.0293`). It never enters the useful second-row wake
  corridor, however: the trajectory bends into a broad upper-right loop and
  exits after `73.39` release units. The loop coincides with the posterior
  angle limit, both joint-rate limits, both `1650 deg/time^2` candidate command
  limits, and RMS force/moment `196/2014`.
- The sampled posterior-only bearing-rate damper preserves upstream motion but
  does not arrest the visible loop. It exits sooner (`53.53`), never gets as
  close (`7.90L`), and still reaches the posterior angle limit plus both
  rate/command limits, with similar RMS force/moment (`201/2115`). Thus damping
  target-bearing rate is a concrete negative result, not evidence that rate
  feedback in general is ineffective: that signal mixes body rotation with
  translation of the target vector.
- The lower-amplitude rate-lead sample also loops and exits. Its `22 deg`
  oscillator scale still yields `38.9 deg` anterior motion and reaches the
  anterior rate limit, while minimum distance worsens to `9.31L` and RMS
  force/moment rises to `388/5262`. Changing amplitude, lag, damping, command
  ceiling, and predictive bearing rate together did not produce useful
  desaturation.
- Inherited guidance supplies the complementary boundary: a globally weakened
  `1.10`-period, `14 deg` gait reduced loads but moved downstream and never
  improved on initial target distance. Low loads from weakening propulsion are
  therefore not evidence of a better controller.

## Policy hypothesis

Keep the complete upstream-capable `0.90`-period, `28 deg` propulsion gait and
positive `10 deg` posterior steering anchor unchanged. Isolate one different
bounded repair: subtract a limited `state.heading_rate` term from the positive
bearing command. Unlike the failed bearing-window-rate term, normalized body
turn rate isolates rotation from target-vector translation and should release
posterior steering authority as the fish begins the sampled broad loop. This
single mechanism also avoids confounding the rate signal with the inherited
downstream failure of globally weakened gaits.

The next CFD evaluation should retain negative mean upstream velocity while
reducing sustained posterior saturation and preventing the upper-right loop.
The hypothesis is falsified if upstream progress collapses before turn-rate
damping activates, or if yaw-rate damping leaves the same saturated loop; a
later worker should then test the turn-rate sign or scale separately rather
than revive bearing-rate lead or weaken all gait parameters at once.
