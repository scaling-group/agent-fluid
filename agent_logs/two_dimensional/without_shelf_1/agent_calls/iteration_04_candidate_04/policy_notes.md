# Multi-wake candidate diagnosis and hypothesis

## Visual and metric diagnosis

- The shared prewarm sheet is a common initial condition: the held fish starts
  above and downstream of four mature, interacting vortex streets, with the
  target inside the merged wake behind the second row.  It does not distinguish
  policies.
- The target-blind `0.55`-period seed initially self-propels upstream, but its
  released sheet shows a nearly vertical dive that misses the wake corridor and
  exits the lower domain.  The metrics agree: head displacement is
  `(-3.55,-13.30)L`, progress is only `0.024`, and both joint rates and
  acceleration commands hit their hard caps.
- The strongest finite sample keeps a `0.90`-period, `28 deg` oscillator and
  adds a positive, posterior-only proportional bearing bias capped at `10 deg`.
  Its sheet shows genuine targetward/upstream motion followed by a broad upward
  loop and upper-domain exit.  It survives `73.39` released units, reaches
  `6.34L`, and moves its head `-2.73L` upstream while mean local flow is nearly
  zero.  The late loop coincides with posterior angle saturation at `45 deg`,
  both rates at `260 deg/time`, both commands at the `1650 deg/time^2` policy
  cap, and RMS force/moment of `196/2014`.
- The sampled subtractive bearing-rate policy preserves that gait but changes
  both the bias ceiling (`10` to `8 deg`) and the rate path.  Its sheet retains
  the same broad upward loop.  It moves upstream slightly faster and ends with
  progress `0.145`, but reaches only `7.90L`, exits after `53.53` units, and
  leaves posterior angle, both rates, both commands, and RMS loads essentially
  saturated (`201/2115`).  Thus it does not validate rate damping and does not
  isolate the lower static ceiling.
- The assigned prefill weakens several gait/servo parameters while adding a
  small positive bearing-rate look-ahead.  Its sheet again retains the upward
  loop; closest approach worsens to `9.31L`, upstream head displacement falls
  to `2.18L`, and RMS force/moment rise to `388/5262` despite lower command
  acceleration.  An inherited anchor-strength positive look-ahead trial is an
  even clearer negative boundary: it moves `2.24L` downstream, never improves
  on the initial `12.42L` distance, and exits after `22.61` units.  Across the
  available evidence neither rate-feedback sign improves the proportional
  anchor.

## Candidate hypothesis

Restore the strongest finite sample's propulsion oscillator, phase lag,
posterior servo, distance fade, and acceleration cap.  Keep steering out of
the anterior oscillator and remove bearing-rate feedback.  Change only the
posterior static bias ceiling from `10` to `8 deg`, retaining the demonstrated
positive body-frame bearing sign.  This cleanly tests the one parameter that
the subtractive-rate sample confounded: a modestly lower proportional ceiling
may preserve its useful upstream authority while slowing the excessive turn
without rate-driven reinforcement or reversal.

The next CFD rollout supports this hypothesis only if it preserves upstream
head displacement, improves on the `6.34L` closest approach or `73.39`-unit
survival, and reduces the visible upward loop or posterior saturation.  It is
falsified if target approach weakens without a corresponding desaturation or
survival gain; later workers should then restore the `10 deg` ceiling and test
a posterior joint-state limiter or damping change, rather than another
bearing-rate sign or a globally weaker gait.
