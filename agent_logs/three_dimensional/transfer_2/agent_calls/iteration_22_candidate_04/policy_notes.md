# Terminal course-residual steering candidate

## Visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders, no prewarm, and the
  L64 moving storage window.  All capture after `4486` steps at `24.6730T`.
  Three v35/v36 samples are dynamically identical; v36's sign-only
  course-consistency veto is a confirmed no-op.
- The combined top-down vorticity and oblique Lambda2 sheets for the replicated
  v35 capture and the best finite v38 capture were inspected from release to
  termination.  Both show self-propulsion rather than advection: a coherent
  alternating mid-plane vortex street and compact three-dimensional structures
  follow the fish through a long diagonal approach and bounded final hook.
  Their visible routes and wakes are indistinguishable at sheet resolution.
  No failed-rollout keyframe is sampled here, so failure comparisons below use
  inherited audited metrics rather than an invented visual claim.
- V38's terminal course-continuity bridge is active, but it is not a meaningful
  semantic improvement over v35.  It changes the trajectory hash and improves
  final/mean distance only from `0.748684/2.348256L` to
  `0.748641/2.348228L` (score `-0.448647` to `-0.448610`), while arrival time,
  step count, route class, zero posterior hard-stop occupancy, raw-command
  exposure (`73.473%`), posterior exact-rate occupancy (`4.637%`), and the
  low peak-load class remain unchanged.  More importantly, its final
  target-relative course angle worsens slightly from `58.59` to `58.83 deg`.
  Across the final `2.10L`, mean absolute normalized course error remains
  `0.7573` and peaks near one.  Continuing the course request only through
  posterior mean curvature therefore does not resolve the evidenced
  transverse crossing.
- The assigned-parent logs and inherited guidance also close two adjacent
  branches: reducing both carriers near the target regressed score, crossing
  margin, and loads, while broad dual-joint rate barriers lost capture despite
  better saturation counts.  The carrier, anterior phase anchor, posterior
  coast, and braking reserve should remain unchanged.

## Policy hypothesis

Start from the evaluated v38 controller and add one scheduling/allocation
mechanism: inside the existing `approach_distance_L` neighborhood, while speed
and measured closing remain positive, translate the already bounded,
mirror-equivariant target-relative course request into an opposite-signed
residual on the established two-joint turn channel.  Admit it continuously
through unused turn-request headroom.  This differs from another course gain or
another posterior bend: the observed inertial miss direction now modulates the
coupled steering rhythm, while v38's posterior mean-curvature path and every
carrier/safety layer remain intact.  The residual is exactly zero at and beyond
`2.10L`, on zero course error, on zero speed, or on non-closing motion.

The expected result is the same far path and coherent wake, with a smaller
terminal course angle than v35/v38 and capture no later than `24.6730T`.
Reject the mechanism if any command changes at or beyond `2.10L`, capture is
lost, final course angle does not beat `58.59 deg`, the crossing margin shrinks,
or posterior hard-stop, exact-rate, raw-command, force, or moment classes
regress.  The current worker cannot claim the new CFD outcome.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and terminal capture control
source_mechanism: apply closed-loop direction-tracking feedback as a bounded residual over a stable propulsive rhythm
transferable_invariant: preserve the self-propelled traveling wave while target-relative velocity error modulates steering until the observed intercept is complete
nontransferable_details: published gains, dimensional cadence, robot morphology, species-specific kinematics, prescribed paths, exact vortex phases, and task-specific routes
policy_translation: inside normalized near range and positive closing, send the existing body-frame course request through unused two-joint turn headroom while retaining posterior mean-curvature continuity and all safety filters
falsification: reject if the far route changes, capture or coherent wake is lost, terminal course alignment fails to improve, or hard-stop, rate, raw-command, force, or moment classes regress

## Pre-evaluation validation

- A deterministic fixed-state replay over all `4486` rows of the completed v38
  trace changes `490` commands, from `2.0986L` and `21.9835T` through capture,
  with zero change at or beyond `2.10L`.  The residual reaches `0.3971` of turn
  request and the largest same-state acceleration delta is
  `2.6474 rad/T^2`, well below the owned `31.416 rad/T^2` envelope.  This is a
  locality/materiality audit, not coupled-CFD evidence.
- Across `720` deterministic reflected observation pairs, the near-range gate
  is reflection invariant and both the course request and raw course residual
  are exactly mirror-odd; every tested residual is finite.  The established
  controller retains its inherited signed-gain asymmetry outside this new raw
  residual.
- The Julia public-contract smoke test returns two finite accelerations.  All
  `85` direct `params.FIELD` references resolve among the `87` fields returned
  by `target_policy_params()`.  Guidance semantics and the solver editable
  boundary pass.  The configured checker was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account; its three exact TOML
  checks were therefore run locally.  The guidance check first exposed and,
  after removal of one duplicate marker for the same assigned parent in the
  rendered workspace README, passed.
