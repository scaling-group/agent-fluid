# Multi-wake target-policy candidate notes

## Visual and quantitative diagnosis before the edit

- All four sampled rollouts use the required direct-uniform still-water
  initialization (`U_infinity=[0,0,0]`), with no cylinders or prewarm.  Both
  rows of their combined keyframe sheets were inspected.  The top-down rows
  show translating fish with alternating vortex streets, and the oblique
  Lambda2 rows show compact three-dimensional structures behind the bodies;
  the failures are self-propelled route failures rather than advection or a
  missing wake.
- The assigned policy parent, curvature-release `solver_045019f39c2a`, is the
  strongest sampled finite approach: it moves from `12.328L` to `4.141L` at
  `20.669T`.  Its wake stays coherent, but the fish is already below the
  target and its signed velocity-to-target course error has grown from about
  `-0.36 rad` at `14T` to `-1.53 rad` at closest approach.  It then continues
  down-left and exits the lower boundary at `32.197T` with distance `9.570L`.
  Peak yaw rate is `2.953 rad/T`, thresholded yaw reversals increase to 95,
  and at least one raw acceleration exceeds `1800 deg/T^2` on `98.1%` of
  samples.  Local flow remains at most `0.023U` versus body speed `0.844U`, so
  a still-water wake-rejection term is not supported.
- The closest like-for-like sampled parent, response-release
  `solver_dc5e319e8345`, has the same coherent-wake lower-exit topology and
  `98.0%` raw over-limit exposure; curvature release improves its minimum from
  `4.660L` to `4.141L` and delays the minimum by about `2.1T`, but does not
  supply a better termination class.  The globally slower soft-limited
  `solver_a1d9e06dfe8a` removes raw acceleration exceedance but instead exits
  above at `14.911T` after reaching only `8.752L`, so wholesale carrier
  slowing is not a safe actuator fix.
- The assigned optimizer logs provide two further negative controls.  Late
  cadence relief keeps the lower exit and worsens the minimum to `5.347L`.
  Course-qualified half-cycle asymmetry also keeps the coherent-wake lower
  exit, removes raw over-limit output, but worsens the minimum to `5.529L`.
  Thus neither another cadence allocation nor another independent course
  residual is warranted.  The remaining untested failure is structural: the
  parent's direct target steering is added underneath a carrier whose raw
  acceleration is almost always clipped, so the existing corrective residual
  can have no guaranteed authority exactly when the mean-curvature veto opens.

## Policy hypothesis

Preserve the assigned parent's joint-state oscillator, posterior lag,
target/rate feedback, and evidence-supported curvature-release gate.  Add one
actuator-allocation mechanism: only while that normalized body-frame gate is
withdrawing a contradicted mean bend, reserve the already computed direct
two-joint steering residual inside the known acceleration envelope and fit the
remaining carrier into the leftover headroom.  With the gate closed, the
returned action is exactly the evaluator-clipped parent action; with it open,
the corrective residual cannot be erased on both saturated half-cycles.  This
is a change in how existing steering and propulsion share a constrained
actuator, not a new route signal or scalar gain sweep.

Expected evidence is unchanged release and early targetward translation,
followed by a course bend toward the target before or near the parent's
`20.669T` minimum, without an immediate upper exit or loss of the alternating
wake.  Falsify the mechanism if the minimum materially worsens, either sampled
boundary-exit topology persists without useful trajectory change, the wake or
speed collapses, or internal envelope allocation simply replaces raw clipping
with persistent bang-bang action.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and biological burst redirect layered on posterior-lagged reactive propulsion
source_mechanism: preserve the traveling propulsive rhythm while giving a bounded corrective turn temporary actuator priority during a material route error
transferable_invariant: propulsion and route steering must be separated at a saturated actuator so observed persistent target error can release contradicted curvature and retain corrective turn authority
nontransferable_details: published gains, dimensional cadence, species-specific bend envelopes, open-loop CPG phase, exact vortex phase, motor dynamics, and task-specific routes
policy_translation: use the existing normalized body-frame curvature-contradiction gate to reserve the existing two-joint steering residual within the acceleration envelope, then project the state-feedback carrier into the remaining headroom
falsification: reject the transfer if early propulsion changes while the gate is closed, the fish enters the inherited immediate upper exit, the coherent wake degrades, or the same lower exit remains without a meaningful approach or trajectory improvement

## Candidate scope

This workspace will contain one candidate.  Its only new active constant is
the fixed actuator-envelope magnitude owned by `target_policy_params()`;
formal CFD remains deferred to EvE after this worker exits.

## Pre-evaluation checks

- Recorded-state algebraic replay against the evaluated curvature-release
  parent opens the contradiction gate first at `10.626T`, changes no action
  through `10T`, and changes the physically clipped action on `32.4%` of all
  samples.  On changed samples the mean two-joint L1 difference is
  `11.684 rad/T^2` and the maximum component difference is
  `16.704 rad/T^2`; every returned component remains inside
  `1800 deg/T^2`.  This is a branch-selectivity test on fixed parent states,
  not a prediction of the closed-loop CFD result.
- Synthetic aligned-state checks recover the parent's evaluator-clipped
  action exactly.  Off-axis checks activate the gate finitely, keep both
  actions bounded, and confirm that the new allocator is odd under simultaneous
  action/steering sign reversal.
- The prescribed guidance-delta, lightweight Julia policy-contract, and
  solver-boundary checks pass.  A separate deterministic schema audit confirms
  that all 58 direct `params.FIELD` references are returned by
  `target_policy_params()`.  The configured check-runner agent was invoked but
  its pinned model was unavailable, so its three exact no-CFD commands were
  run directly and separately.
