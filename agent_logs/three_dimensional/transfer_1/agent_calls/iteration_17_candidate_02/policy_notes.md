# Correct-response posterior-wave release candidate

## Evidence and visual diagnosis before editing

- All four sampled solver evaluations satisfy the frozen Phase-2 contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and semantic `capture`.  Three
  independently written v33 bidirectional-allocation variants reproduce the
  same trajectory exactly: capture at `18.765995 T`, score `-0.1702724`, and
  distance integral `2.0583469 L`.  The assigned-parent v32 closing-response
  controller captures at `18.754995 T`, score `-0.1711448`, and integral
  `2.0588626 L`.  Thus reverse recovery of posterior-rejected target steering
  is reproducible but only marginal here: it improves the integral by
  `0.000516 L` and score by `0.000872`, while delaying capture by `0.011 T`.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows of the
  combined keyframe sheets for the strongest sampled v33 capture and the
  inherited whole-wave-rate failure.  The capture is visibly self-propelled
  from quiescent water along a smooth target-signed arc.  Its compact startup
  disturbance develops into an orderly alternating mid-plane street and
  compact posterior 3D structures through capture, with no passive advection,
  collision, domain-exit, or instability precursor.
- The rate-projection failure retains an organized propulsive wake, but the
  top-down path turns upward and then nearly vertically away from the target
  before an upper-boundary exit at `8.4755 T`.  It closes only to `12.2107 L`,
  finishes at `12.7296 L`, and raises peak normalized planar force/yaw moment
  from the successful v33 envelope of `0.03068/0.01564` to
  `0.30254/0.13474`.  A fitted posterior joint-rate correlation is therefore
  not a safe route-observation correction; the candidate retains the proven
  head-only rate projection.
- Metrics support the visual reading of v33 as productive but still
  correction-limited rather than wake- or speed-limited.  It reaches
  `9.2472/6.2164/2.8396 L` at `8/12/16 T`, with mean/max center speed
  `0.6855/0.9402 L/T` and any-joint acceleration-limit residence `41.35%`.
  Around `12 T` the target remains at a large body-frame error while the
  observed yaw response has the correct sign; by `16 T` that large error has
  contracted.  The existing posterior progress residual is deliberately
  suppressed by turn load in precisely this interval, leaving a testable slot
  for a bounded redirect-to-propulsion transition without changing carrier
  amplitude, cadence, route sensing, or physical limits.

## One-candidate policy hypothesis

Use the evaluated v33 closing-response plus bidirectional steering-allocation
controller as the base.  Preserve raw redirect geometry, mean-preserving
whole-wave pose projection, head-only derivative rejection, raw half-cycle
phase, approach scheduling, both target-residual spillover paths, carrier-first
composition, and componentwise acceleration bounds.  Add one state-feedback
transition: while raw body-frame target error still requests a large redirect
and the observed yaw response has the requested sign, use that response to
fill otherwise unused capacity in the existing posterior-lag envelope.  Sum
this response term with the closing-deficit residual and cap their total at
the already evaluated `progress_tail_lag_gain`; when the error contracts or
the response has the wrong sign, the term vanishes continuously.

The expected outcome is to preserve capture and the coherent alternating wake
while converting the productive middle-route redirect into posterior thrust,
improving distance at `12-16 T` and the integral without expanding the
carrier-frequency, tail-lag, speed, action, or load envelope.  Falsify the
mechanism if capture is lost or later than `18.766 T`, distance integral
exceeds `2.05835 L`, the middle/late lead fails to improve, the target-signed
arc reverses, the wake loses coherence, or max speed, any-joint limit
residence, normalized force, or yaw moment materially exceed
`0.9402/41.35%/0.03068/0.01564` without compensating progress.

```text
bookshelf_consulted: true
source_domain: biological burst redirection and classical posterior traveling-wave propulsion
source_mechanism: release a large-error body bend into a stronger posterior traveling beat only after observed yaw confirms the requested turn
transferable_invariant: keep target-signed mean curvature separate from propulsion, and gate added posterior wave shape by normalized geometric error plus correct body response rather than time or a prescribed phase
nontransferable_details: species-specific C-start timing, published gains, full-body curvature envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: combine the existing body-frame redirect-error gate and correct-turn-response gate to fill only unused posterior-lag capacity under the unchanged two-joint acceleration contract
falsification: reject if middle or late closure does not improve, capture is lost or delayed, the route turns with the wrong sign, the alternating wake degrades, or saturation, speed, force, or yaw-moment bounds grow without compensating progress
```

## Evidence boundary

All outcome and visual claims above come from completed sampled CFD, the
assigned parent, and inherited optimizer logs.  This candidate receives
formal CFD evaluation only after worker exit; no same-worker performance is
claimed.

## No-CFD implementation audit

- A deterministic `5760`-state grid spanning target side and large-error
  magnitude, distance, positive and negative closure, joint phase, and body
  yaw response found finite commands within the unchanged
  `31.41593 rad/T^2` componentwise bound throughout.
- Zeroing `redirect_response_tail_lag_gain` provides the v33 mechanism
  baseline.  The active candidate differs on `712` grid states, all `712`
  have nonzero large-redirect and correct-turn-response gates, and no ungated
  state changes.  The largest fixed-state command change is
  `5.69023 rad/T^2`.  This verifies gating and mechanism isolation, not
  closed-loop performance.
