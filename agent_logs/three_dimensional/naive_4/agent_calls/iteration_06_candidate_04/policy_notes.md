# Redirect-priority posterior allocation candidate

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the Phase 2 evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and finite dynamics. Their translation is
  therefore self-propelled rather than imposed advection.
- I inspected both rows of the combined sheets for the captured parent,
  `solver_e44c6b14905f`, and the informative closest non-capture,
  `solver_c0ba6ee601b1`. Both top-down rows develop coherent alternating
  red/blue caudal wakes, and both oblique rows show persistent three-dimensional
  Lambda2 structures. The failure keeps that propulsive wake but curls toward
  the upper boundary, reaches `5.086L`, and exits at center y=`15.201L` after
  `19.201T`. The parent instead sustains a much straighter left/down approach
  and captures at `0.746L` after `16.291T`; its semantic improvement is a
  steering response, not stronger advection or a disappearance of the wake.
- The response-gated redirect is therefore positive evidence that should be
  preserved. It also exposes the next actuator-quality defect: posterior
  acceleration occupies the hard limit in `60.4%` of its samples, versus
  `35.9%` for `solver_324d10ed189d` and `36.2%` for
  `solver_c0ba6ee601b1`. The parent reaches only `30.4 deg` posterior angle,
  well inside the `42 deg` policy target bound and `45 deg` joint limit, while
  its saturated posterior runs last roughly a half-beat (`0.264T` median,
  `0.275T` maximum). This is sustained wave-plus-redirect competition, not an
  isolated switch or posterior angle exhaustion.
- Inherited logs independently rule out replacing the captured structure with
  shared anterior bias, two-sided half-cycle amplification, acceleration-lobe
  gating, or bearing-gated anterior envelope reduction. Those mechanisms
  either quenched the carrier or retained the upper-exit topology. The sampled
  capture instead supports keeping the anterior oscillator, response gate,
  strong posterior mean bend, and one-sided opposing-wave relief intact.

## Policy hypothesis

Start from the captured parent without changing its observations, anterior
carrier, response gate, posterior mean-curvature target, or one-sided phase
relief. Add one actuator-aware allocation after the posterior target is split
into its mean-tracking/damping acceleration and its joint-state wave
acceleration. As redirect authority rises, reserve a small bounded part of the
posterior acceleration envelope for the mean bend: an oscillatory contribution
that would consume that reserve is reduced, while an oscillatory contribution
that unloads the mean command is retained. Never amplify a wave lobe, and let
mean tracking use the full hard envelope when it alone requires it. At zero
redirect the captured cruise law is unchanged.

This is a response-conditioned allocation mechanism rather than a new scalar
carrier setting. Expected downstream evidence is retention of the coherent
alternating wake and capture at no worse than approximately `16.291T`, with
posterior hard-limit residence materially below `60.4%`. Reject it if capture
is lost, arrival or distance integral regresses materially, the wake/early x
progress weakens, or posterior limit residence remains near the parent despite
the reserved wave headroom.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-feedback robotic-fish direction tracking
source_mechanism: temporarily prioritize observed-error curvature over the oscillatory propulsive component, then release full propulsion as measured motion realigns
transferable_invariant: preserve the established traveling bend in cruise, but during a large target-versus-course response allocate limited actuation to the redirect before admitting the joint-state wave contribution
nontransferable_details: species-specific C-start shapes, published CPG gains and duty ratios, dimensional beat settings, exact vortex phase, morphology-specific torque, and task-specific routes
policy_translation: use the existing normalized body-frame response gate to reserve posterior acceleration headroom; retain mean-target tracking and damping, admit only the wave acceleration that fits or unloads that demand, and keep the two-joint hard bound
falsification: reject if the coherent wake or capture disappears, arrival exceeds the 16.291T parent materially, posterior hard-limit residence does not fall below 60.4%, or redirect tracking is weakened enough to restore the upper-exit topology

The candidate has no same-worker CFD result. A fixed-trace command audit may
check boundedness and separation, but only the downstream closed-loop rollout
can establish capture retention or improvement.
