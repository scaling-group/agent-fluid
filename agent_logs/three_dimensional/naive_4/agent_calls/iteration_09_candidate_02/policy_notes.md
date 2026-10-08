# Approach-local phase-separated course feedback

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled evaluations are finite captures under the required direct
  uniform initialization, with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Their translation is self-propelled rather than imposed advection.
- I inspected both rows of the combined keyframe sheets for the highest-scored
  sample, `solver_4c0e1314ad61`, and the weaker allocator-only sample,
  `solver_57f7c1352c72`. From release through capture, both top-down rows grow
  a coherent alternating red/blue street and both oblique rows show compact
  three-dimensional Lambda2 structures behind the traveling bend. Neither
  policy loses wake coherence, leaves the virtual domain, collides, or becomes
  unstable. The informative weakness is therefore terminal feedback quality,
  not propulsion or route topology.
- The assigned parent's inherited allocator-plus-approach rollout captured at
  `16.225T` but scored `-0.067754`, crossing at `0.7492L`. Its approach-local
  redirect-onset descendant, `solver_4c0e1314ad61`, preserves the coherent
  wake and the `16.225T` arrival while improving the discrete crossing to
  `0.744808L`, distance integral to `1.946697L`, and score to `-0.063208`.
  This satisfies the inherited mechanism's capture and score expectations,
  although posterior hard-limit residence rises from the parent's reported
  `21.4%` to `32.2%` on the sampled trace. It remains well below the
  unallocated policies' `59-60%` range.
- Simply increasing approach-local course weight is not supported. Relative
  to selective approach relief alone (`solver_a5dc27216aa2`, score
  `-0.066121`), full course weight (`solver_1243aba027e1`) keeps the same
  `16.258T` termination but regresses to `-0.066256`. The useful next test is
  therefore not more authority on the same noisy course observation.
- Across all four sampled traces, posterior angle and instantaneous body-frame
  lateral velocity have correlation magnitude `0.913-0.916`. In the best
  trace's approach segment, raw lateral velocity swings from about `-0.655U`
  to `+0.554U` at representative distance crossings even though the keyframes
  show a smooth target-directed path. A one-term fit over the whole best trace
  gives approximately `v_lateral = -1.16 q2` for the carrier-synchronous
  component (`R^2=0.84`). This is strong evidence that the instantaneous
  course signal contains predictable beat sway, while the fit is not evidence
  for changing the established gait.
- Inherited logs rule out shared anterior bias, two-sided lobe amplification,
  short-window yaw-rate feedback, scalar carrier shrink, and removal of the
  terminal mean bend. Those mechanisms quenched propulsion, increased hard
  limiting, or retained an inferior trajectory, so none is reintroduced.

## Policy hypothesis

Start from `solver_4c0e1314ad61` and preserve its anterior oscillator,
posterior lag, response-gated mean redirect, attenuation-only opposing-wave
relief, mean-first acceleration allocation, approach drive relief, and
approach-conditioned redirect continuity. Add one observation mechanism only:
as the existing proximity-plus-closing gate opens, subtract the expected
posterior-angle-synchronous lateral sway from body-frame lateral velocity
before forming both course residuals. The correction is zero outside reliable
approach, is bounded by the already bounded posterior angle, and uses no clock,
world coordinate, route, or mutable state.

The transferable idea is to steer on persistent course slip rather than on
the known within-beat sway of the propulsive carrier. Use a conservative
`1.10 U/rad` compensation, slightly below the sampled one-term fit, so the
closed-loop rollout tests the mechanism instead of exactly cancelling one
recorded trajectory. Expected evidence is identical pre-approach motion and
wake, less beat-to-beat redirect-gate cycling during approach, capture no later
than `16.225T`, and no increase in posterior limiting or force/moment peaks.
Reject the mechanism if capture or score regresses, behavior changes before
the `1.75L` approach neighborhood, coherent propulsion weakens, or the
compensated course still produces equal or larger terminal steering chatter.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG direction tracking and two-timescale swimming control
source_mechanism: preserve the rhythmic propulsive carrier while separating its fast lateral oscillation from the slower course error used for direction tracking
transferable_invariant: route feedback should respond to persistent body-frame slip rather than spend steering authority on predictable carrier-synchronous sway
nontransferable_details: published CPG gains, species-specific body envelopes, dimensional beat settings, exact vortex phase, morphology-specific torque, and task-specific routes
policy_translation: during normalized body-frame proximity-plus-closing approach only, compensate lateral velocity by a bounded posterior-joint-state estimate before computing course; retain the evidenced two-joint actuation and all far-field behavior
falsification: reject if pre-approach motion changes, capture is later than 16.225T or lost, score regresses below -0.063208, posterior limiting or loads increase, or terminal redirect cycling is not reduced

The candidate has no same-worker CFD result. Deterministic checks can establish
schema, boundedness, symmetry, and exact recovery of the sampled parent outside
approach; only the later closed-loop rollout can test the wake and trajectory
claims.

## Non-CFD verification

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable in this account context. I ran its three prescribed commands
  directly: the material-guidance check, Julia policy-contract check, and
  solver-boundary check all pass. The guidance check required removing a
  duplicated rendering of the same assigned-parent marker from `README.md`.
- The explicit schema audit finds `30` direct parameter references and the
  same `30` fields returned by `target_policy_params()`, with none missing.
- On all `2,950` recorded states from the sampled parent, candidate actions
  are finite and bounded, lateral reflection error is exactly zero, and every
  state at or beyond `1.75L` matches the parent exactly. On the fixed approach
  trace, posterior-command total variation falls from `216.96` to `201.84`
  (about `7%`); this is a command audit, not a closed-loop performance claim.
- A deterministic `6,561`-state sweep over joint state, body-frame target
  geometry, and body-frame velocity also returns finite bounded actions and
  exact lateral-reflection equivariance.
