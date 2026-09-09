# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four sampled shared-prewarm sheets are byte-identical. They show the
  held fish above and downstream of the four staggered cylinders while the
  developed streets overlap through the target corridor. This is the common
  initial condition, not controller-ranking evidence.
- The assigned-parent magnitude schedule,
  `0.07 + 0.01 * away_drift_weight`, is the fastest current finite rollout.
  Its sheet preserves the broad release turn and productive wake-band
  crossings but reaches an almost horizontal target entry by rendered frame
  `23`, rather than frame `25` for constant `0.08` or frame `28` for constant
  `0.07`. It captures at `196.900`, with `6.211L` mean distance and a
  `0.01735` controller-relative upstream margin. RMS relative crossflow,
  lateral force, and moment are `0.13206/17.672/352.909`.
- The independent rolling-progress schedule, which moves from `0.08` while
  receding toward `0.07` while closing, is the strongest current result by
  score and distance integral. Its sheet reaches the same central-wake
  approach by rendered frame `24`; it captures at `213.659`, improves score
  and mean distance to `-3.863/5.856L`, and lowers force/moment to
  `17.761/354.838`. Its controller-relative upstream margin remains positive
  at `0.01261`, confirming active transport rather than passive advection.
- The constant `0.07` rollout is the most informative current policy failure,
  although it still reaches the target. Its longer visible reversal sequence
  delays capture to `245.449`, reduces upstream margin to `0.01284`, and raises
  force/moment to `18.399/363.454`. Constant `0.08` captures at `224.488` with
  `6.311L` mean distance and `17.943/361.014` force/moment. All four samples
  retain the same `4.293L` maximum lateral offset and `31.055 rad/time^2`
  maximum anterior acceleration below the `31.2` policy guard, isolating the
  gains to steering timing rather than thrust, a smaller excursion envelope,
  or saturation.
- Inherited optimizer logs bound the same mechanism on both sides: constant
  `0.10` delayed capture to `263.346` with a visible late lower-corridor
  excursion, while alignment-gated heading-rate steering captured at
  `265.298` with negative upstream margin and sign-asymmetric bearing-rate
  steering missed the horizon. More constant gain, propulsion, or rotational
  feedback is therefore unsupported.

## Single candidate hypothesis

Preserve the assigned parent's demonstrated `20.25 deg`, `0.67`-period gait,
posterior lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lookahead, `0.10` lateral-velocity clamp, and `31.2` acceleration
guard. Keep its target-away drift-magnitude schedule and add only the sampled
rolling-progress gate. Set the `0.07--0.08` lookahead interpolation weight to
the maximum of away-drift weight and progress-loss weight, where progress loss
uses the evaluated `0.02L/time` closing-speed scale.

This union never weakens the fast assigned-parent response and matches it
exactly whenever away-drift weight is the dominant gate. It raises lookahead
toward `0.08` during stalled or receding windows that the independent progress
schedule identifies even before drift becomes strong. The actual correction
remains multiplied by away-drift weight, so weak target-away motion still
produces a weak action; it is exactly zero for stationary or targetward lateral
motion and remains bounded by the already sampled `0.008 rad`
pre-nonlinearity envelope. It adds no coordinate, route, clock,
prescribed-inflow value, or remote wake probe, and all active constants remain
policy-owned.

Call the union an improvement only if it retains capture no later than
`196.900`, approaches the progress schedule's `5.856L` mean distance and
`17.761/354.838` load envelope, preserves positive upstream margin and the
existing excursion/guard bounds, and introduces no visible switching. Reject
it on lost or later capture, mean distance above the assigned parent's
`6.211L`, upstream margin below `0.01261`, larger crossflow/load/effort, guard
contact, or a new late corridor rebound. These thresholds apply only to the
certified fixed-prewarm phase; this worker claims no same-worker CFD result.
