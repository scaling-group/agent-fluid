# Bearing-response curvature-release candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and semantic `capture`.  The assigned
  response-arbitrated prefill captures at `18.754995 T`, score `-0.169758`,
  and distance integral `2.057473 L`; its closed-loop result is effectively
  the established one-way closing-response controller because productive
  closure suppresses the reverse-allocation path.
- I inspected both rows of the combined keyframe sheets and the view-specific
  top-down sheets for that prefill and the strongest sampled result from
  release through capture.  Both fish self-propel from quiescent water on
  smooth target-directed arcs, with compact startup structures becoming a
  coherent alternating mid-plane street and organized three-dimensional
  posterior structures.  Neither sheet shows background advection, wake
  collapse, collision, domain exit, or numerical instability.  At matched
  frames the divergence-recovery fish is visibly farther along the same useful
  route, while preserving the carrier and wake topology.
- The sampled bearing-divergence recovery is a material route improvement,
  not a terminal-threshold artifact.  It captures at `18.403006 T`, score
  `-0.140449`, and distance integral `2.027810 L`, leading the assigned prefill
  by `0.061/0.148/0.230/0.225/0.201 L` at `4/8/12/16/18 T`.  Mean speed rises
  only from `0.6852` to `0.6961 L/T`, maximum speed remains
  `0.9458/0.9476 L/T`, any-joint acceleration-limit residence falls slightly
  from `42.35%` to `42.14%`, peak normalized force remains `0.03067`, and peak
  moment changes from `0.01564` to `0.01587`.  The better closure therefore
  comes from feedback topology rather than a stronger carrier or a larger
  physical envelope.
- A reconstruction on the completed winner's recorded states shows its
  divergence term is active on `38.70%` of states with mean/max magnitude
  `0.1214/0.4498` in route-request units.  It also exposes the complementary
  gap: `34.07%` of states have an out-of-band de-gaited bearing already
  contracting while distance remains above `2.1 L`, where the inherited
  near-target sweep damper is identically inactive.  The controller can thus
  add curvature when geometry worsens but continues its ordinary pursuit
  curvature without an equivalent far/middle response release once geometry
  improves.
- The current sampled set has no termination failure, so no unavailable image
  is treated as visual evidence.  The inherited completed whole-wave
  route-rate projection remains the informative negative boundary: it was
  reported to retain an organized wake but reverse the route and exit at
  `8.4755 T`, minimum/final distance `12.2107/12.7296 L`.  This candidate does
  not revive fitted joint-rate common modes or infer disturbance causality
  from frozen-trajectory correlation.

## One-candidate policy hypothesis

Use the evaluated bearing-divergence recovery as the base, preserving its
state-feedback traveling wave, posterior lag, raw-geometry large-error
redirect, whole-wave pose projection, head-only route-rate correction,
response-gated cadence release, raw half-cycle steering, carrier-first
allocation, head-to-tail rejected-steering path, approach scheduling, and
componentwise physical bounds.  Add one response-gated mean-curvature release
inside route feedback.  When the already de-gaited body-frame bearing and its
trend show contraction, attenuate only the portion of the ordinary route
request signed toward that bearing.  Fade this release continuously on final
approach; leave opposite-signed braking, positive recovery, centerline rate
braking, and the propulsive carrier untouched.  Diverging geometry continues
to receive the separately evidenced bounded recovery.

This is the response half of the same burst-redirect invariant, not a global
gain change: add curvature while target geometry worsens, then yield curvature
when the observed geometry contracts.  It should reduce the broad
turn-past/reverse pattern without following exact beat phase or weakening the
alternating posterior wave.  Falsify the candidate if it loses capture,
arrives later than `18.403006 T`, raises the distance integral above
`2.027810 L`, erases the winner's `4--18 T` lead, enlarges bearing sweeps,
changes the target-signed arc or wake coherence, or materially exceeds the
winner's `0.9476 L/T`, `42.14%`, `0.03067`, and `0.01587`
speed/saturation/force/moment envelope without compensating progress.

```text
bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: apply bounded large-error curvature, then release mean turning as observed target geometry responds while retaining the posterior propulsive rhythm
transferable_invariant: separate route curvature from the traveling-wave carrier and gate the route contribution by normalized body-frame error response rather than time or exact vortex phase
nontransferable_details: species-specific C-start envelopes, published gains, dimensional cadence, robot linkage geometry, clocked CPG phase, exact vortex phases, duty ratios, and prescribed routes
policy_translation: on the sampled divergence-recovery base, smoothly attenuate only target-signed route request while de-gaited bearing contracts, fade the release on approach, and preserve explicit braking/recovery and both bounded joint carriers
falsification: reject if capture or middle/late closure regresses, bearing excursions grow, the target-signed arc or coherent wake changes, or speed, saturation, normalized force, or yaw moment materially worsens without compensating progress
```

## Evidence boundary

All numerical and visual outcome claims above come from completed sampled CFD,
the assigned parent, and inherited optimizer logs.  The curvature-release
candidate receives formal CFD only after worker exit; no same-worker
performance improvement is claimed.

## Non-CFD implementation audit

- The deterministic schema audit finds all `60` direct `params.FIELD`
  references among the `62` fields returned by `target_policy_params()`.
- Replaying the candidate and sampled winner algebra on `3346` reconstructed
  winner states activates the convergence release on `50.12%` of states and
  changes at least one final joint command on `19.49%`.  The active release
  has mean/max magnitude `0.2469/0.3199` as a fractional reduction of only
  target-directed route request; all active states have
  `bearing*bearing_trend < 0`.  The largest frozen-state joint-command change
  is `3.0813 rad/T^2` (`9.81%` of the physical acceleration limit).
- Every replayed command is finite and remains within the unchanged
  `31.41593 rad/T^2` componentwise limit.  These checks establish semantic
  activity, sign targeting, and envelope preservation only; they are not
  closed-loop CFD evidence.
