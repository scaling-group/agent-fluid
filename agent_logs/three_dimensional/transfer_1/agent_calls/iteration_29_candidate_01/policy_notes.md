# Energy-governed posterior-lag launch candidate

## Completed evidence and visual diagnosis before editing

- All four sampled solver examples and the assigned-parent rollout are finite
  `capture` episodes from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  The strongest completed
  route remains the v43 axis-selective energy launch: capture at `17.75400 T`,
  score `-0.07917`, and total/observed distance integrals
  `1.96508/1.34990 L`.
- I inspected the combined sheets from release through capture.  The v43 best
  and v45 axial-cadence prefill have readable top-down and oblique rows: both
  actively self-propel on a smooth target-signed arc, and the compact startup
  disturbance develops into an organized alternating posterior street with
  paired caudal Lambda2 structures.  There is no passive advection, reversal,
  collision, boundary exit, or visible wake collapse.  The slower v44 cadence
  and v45 late-turn samples retain the same organized top-down wake but have
  black oblique rows, so they are rendering failures and provide no
  comparative 3D-wake evidence.
- Metrics agree with that visual diagnosis.  Across the sampled policies,
  mean/max speed stays near `0.717/0.960 L/T`, peak absolute normalized
  lateral force/yaw moment stays `0.03225/0.01609`, and all trajectories are
  identical through the `2.1 L` approach boundary.  The policy differences
  therefore do not create a new propulsive or route topology.
- The assigned parent's posterior-only approach-wave residual captures one
  integration step earlier than v43 and marginally improves observed integral
  from `1.349898` to `1.349854 L`, but total integral worsens from `1.965079`
  to `1.965200 L` and approach acceleration-limit residence rises from
  `68.45%` to `69.55%`.  Whole-carrier response retention is weaker
  (`1.966395 L`, `70.15%` approach residence), axial whole-carrier retention
  is weaker again (`1.966254 L`, `71.05%`), and divergence-retained late turn
  also regresses total integral to `1.965276 L`.  These completed comparisons
  do not support more proximity-only propulsion or steering authority.
- Inherited logs instead preserve a larger, earlier causal opportunity.  A
  phase-insensitive posterior-energy deficit improved the prior v41 launch,
  and confining axial-response semantics to that deficient-wave residual then
  produced v43.  Beat-side concentration, an energy-conditioned whole-launch
  bridge, route-wide load confidence, flow-dropout bridging, reverse
  spillover, and whole-wave rate projection already regressed or failed.  The
  useful v43 carrier, amplitude residual, target sensing, selective crossflow
  pose cue, curvature, and carrier-first allocation should remain unchanged.

## One-candidate policy hypothesis

Materialize v43 as the single base candidate.  Add one small compatible
propulsive mechanism at launch: use the existing reflection-even posterior
wave-energy deficit and normalized positive forward-axis response to increase
posterior lag, in parallel with (not instead of) the completed posterior
amplitude residual.  The lag term is multiplied by the same closing, distance,
and turn-load context, so it vanishes as axial closure and the traveling wave
form and cannot change route or redirect mean curvature.

This tests whether the remaining weak first-`2 T` closure is partly a
traveling-wave formation deficit rather than a request for more reciprocal
amplitude.  The intended signature is a lead by `2-4 T` that persists through
the middle route, capture before `17.754 T`, and total/observed integrals below
`1.96508/1.34990 L`, without materially exceeding the completed
`0.9603 L/T`, `44.15%`, and `0.03225/0.01609` speed, acceleration-residence,
and normalized force/moment envelope.  Reject the mechanism if the early lead
does not persist, posterior saturation grows, capture or route integral
regresses, or the organized two-view wake loses coherence.  Formal CFD occurs
only after this worker exits; none of these intended outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Taylor traveling-wave propulsion, Lighthill elongated-body reactive thrust, and sensor-modulated robotic-fish CPG coupling
source_mechanism: a directed posterior-lagged bend develops reactive thrust more effectively than reciprocal in-phase motion, while feedback should release added coupling once the propulsive wave is established
transferable_invariant: when reflection-even two-joint posterior wave energy and normalized forward response are both deficient, temporarily strengthen posterior lag rather than treating more joint amplitude as the only launch authority
nontransferable_details: published gains, dimensional frequencies, species or robot envelopes, full-body phase distributions, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: add one bounded phase-insensitive posterior-lag residual driven by the existing normalized wave-energy deficit, forward-axis speed deficit, closing response, distance, and target-turn load; preserve the completed amplitude residual and all target-derived mean curvature
falsification: reject if first-2T closure or middle checkpoints fail to improve, capture or either distance integral regresses, posterior clipping or normalized loads grow materially, or readable top-down and oblique evidence loses the coherent target-signed alternating wake
```

## Evidence boundary

All completed outcomes and visual claims above come from the assigned parent,
sampled solver results, inherited optimizer logs, and inherited durable
guidance.  The policy proposed here has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v46_energy_governed_posterior_lag`, with SHA-256
  `34063f33134ead6f1d7b7079e6ecdf2d92ba822a24b3926c3dfe9ccf9787344e`.
  Its diff from completed v43 adds one parameter-owned lag residual and leaves
  the public policy contract, curvature path, amplitude residual, and actuator
  projection intact.
- Reconstruction on all `3228` states of the completed v43 trace localizes the
  action change to release through `2.123 T`.  The anterior action is byte-
  equal throughout; the maximum posterior acceleration delta is bounded at
  `1.3554 rad/T^2`, and frozen-trace acceleration-limit residence changes by
  only five states.  A deficient-wave synthetic state changes only the
  posterior action, while a developed-wave state recovers the completed
  action.  These are structural checks, not closed-loop performance claims.
- The required configured check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported for this account.  Its three exact
  non-CFD commands were therefore run locally and separately: the material-
  guidance check, lightweight Julia policy contract, and solver editable-
  boundary check pass.  A direct schema assertion confirms all `66`
  `params.FIELD` names resolve among the `68` fields returned by
  `target_policy_params()`.  No CFD was run.
