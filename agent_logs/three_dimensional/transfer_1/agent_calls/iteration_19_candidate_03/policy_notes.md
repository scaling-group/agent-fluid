# Response-confirmed centerline-sweep brake candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and `capture` termination.  Three functionally
  identical v34 bearing-divergence rollouts capture at `18.403006 T`, score
  `-0.140449`, total distance integral `2.027810 L`, and observed integral
  `1.418099 L`.  The v35 response-release variant captures at `18.414005 T`,
  score `-0.141536`, total integral `2.028719 L`, and observed integral
  `1.418269 L`.
- I inspected both the top-down mid-plane vorticity and oblique body/Lambda2
  rows of the combined sheets for v34 and v35 from direct release through
  capture.  Both fish visibly self-propel from quiescent water along the same
  smooth target-directed arc.  Compact startup structures develop into a
  coherent alternating posterior wake in both views; neither rollout shows
  passive advection, wake collapse, collision, domain exit, instability, or a
  prewarm artifact.  The sheets are visually indistinguishable at their
  resolution, so the small but consistent metric regression—not a claimed
  wake change—is the informative comparison.  The current sampled set has no
  termination failure; the inherited `left_domain` whole-wave-rate result is
  retained only as a wrong-route boundary from its completed logs.
- The v34 result validates full target-signed correction while de-gaited
  bearing is outside the centerline band and diverging.  V35 changes commands
  on only `166/3346` frozen states, but releasing that correction merely
  because target-signed yaw and positive closure appear delays capture by
  `0.011 T` and worsens both distance integrals.  Translational inertia can
  therefore keep line of sight worsening after body yaw looks useful; actual
  geometric contraction remains the evidenced release condition.
- Reconstructing v34 on its completed history shows the remaining route
  opportunity without implying new CFD evidence.  The de-gaited bearing is
  about `-0.309 rad` at `12 T`, crosses the centerline repeatedly near
  `13.67--14.27 T` while distance falls from `4.52 L` to `4.00 L`, and reaches
  about `+0.457 rad` at `16 T`.  Closure remains strongly positive and the
  two-view wake remains coherent.  The existing contraction brake is
  multiplied by terminal proximity, so it is inactive during those earlier
  response-confirmed centerline crossings and can only act inside the final
  `2.1 L` approach region.
- Inherited logs delimit unsafe alternatives.  Full posterior-to-anterior
  rejected-steering recovery is non-additive with closing-response cadence,
  terminal-only recovery reproduces the slower carrier, and a fitted
  posterior joint-rate common mode reversed the route and exited at
  `8.4755 T` with `12.7296 L` final distance and much larger load peaks.  This
  candidate leaves carrier cadence, posterior lag, actuator allocation, pose
  projection, and head-only derivative correction unchanged.

## One-candidate policy hypothesis

Preserve v34's evaluated state-feedback traveling bend, posterior lag,
whole-wave pose projection with deliberate curvature retained, head-only
route-rate correction, raw half-cycle steering, closing-response cadence
release, one-way head-to-tail rejected-steering allocation, approach schedule,
and componentwise physical limits.  Keep bearing-divergence recovery at full
authority until the de-gaited bearing actually contracts.  During contraction
only, allow the existing smooth sweep damping to act before terminal approach
when three normalized body-frame observations agree: bearing is moving toward
centerline, body yaw is target-signed, and target closure is positive.  The
ordinary near-target brake remains available even when that response gate is
weak.

This response-confirmed contraction brake should reduce continued steering
through the productive middle-route centerline crossing without weakening the
v34 divergence recovery or touching the coherent carrier.  Falsify it if
capture is lost or later than `18.403006 T`, either distance integral exceeds
`2.027810/1.418099 L`, the established `4--16 T` lead regresses, the arc or
alternating wake changes qualitatively, or maximum speed, any-joint limit
residence, normalized force, or yaw moment materially exceeds approximately
`0.948 L/T`, `42.14%`, `0.03068`, and `0.01587` without compensating closure.

```text
bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG control
source_mechanism: retain a bounded redirect until geometric error contracts, then reduce continued steering only after sensed body response confirms the turn is taking effect
transferable_invariant: separate the traveling carrier from route steering and use agreement among normalized body-frame error contraction, target-signed yaw, and positive closure to brake a completed turn
nontransferable_details: published gains, species-specific C-start timing and kinematics, clocked CPG phase, full-body envelopes, linkage geometry, dimensional cadence, exact vortex phases, and prescribed routes
policy_translation: keep v34 divergence recovery unchanged; extend only its existing bounded sweep damping beyond terminal approach when de-gaited bearing contracts and normalized yaw and closing responses are jointly target-productive
falsification: reject if capture or middle-route closure regresses, the target-signed coherent wake changes, or speed, saturation, normalized force, or yaw moment exceeds the sampled envelope without compensating progress
```

## Evidence boundary

All rollout outcomes and visual claims above come from completed sampled CFD,
the assigned parent guidance, and inherited optimizer logs.  The new candidate
receives formal CFD only after worker exit; frozen-history checks are contract
and targeting audits, not performance evidence.

## Non-CFD contract replay

- Replaying v36 and the evaluated v34 policy on all `3346` recorded v34 states
  changes at least one joint command on `1350` states (`40.35%`).  The mean/max
  largest-joint command difference is `0.1090/1.6500 rad/T^2`; the maximum is
  about `5.3%` of the unchanged `31.41593 rad/T^2` physical acceleration
  limit.  Every candidate command is finite and within that envelope.
- The response-confirmed extension of sweep damping is active on `1267`
  frozen states, with mean/max added damping factors `0.1250/0.2413`.  The
  bearing-divergence residual is numerically identical to v34 on every replayed
  state, confirming that the new response gate does not revive v35's premature
  divergence release.  This audit establishes bounded semantic activity only;
  it is not a claim about the pending closed-loop CFD result.
