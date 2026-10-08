# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, finite actions, and `capture` termination.
  The complete top-down sheets for the prefilled broad-relief policy and the
  strongest phase-qualified policy show continuous curved translation toward
  the target behind a developed alternating red/blue caudal street, so the
  fish is self-propelled rather than advected. Their complete oblique rows show
  discrete three-dimensional Lambda2 structures at `8T`, `16T`, `24T`, and
  capture rather than wake decay or an inertial terminal coast. The smaller
  oblique sheets in two replicated samples are blank render artifacts; their
  top-down and numerical evidence cannot be counted as additional 3D-wake
  confirmation.
- The response-plus-stroke schedule in `solver_43e27134a723` and
  `solver_c85ef8d2aea3` is the strongest finite sampled policy and reproduces
  exactly across those two runs. It captures at `24.310009T` in 4,420 steps,
  crosses at `0.749162L`, and has score-metric mean distance `2.223959L`.
  The prefilled broad closing-deficit relief captures at `24.326511T` in 4,423
  steps with `0.749329L` crossing and `2.224097L` mean distance. Restricting
  relief to the smooth target-side anterior half-cycle therefore improves
  arrival, crossing, mean distance, and scalar score by a small but repeated
  amount without changing the visible route or carrier.
- The improvement is an allocation result, not evidence for more actuation.
  Broad and phase-qualified relief share the same peak normalized planar force
  and yaw moment (`0.031649/0.016385`). Their anterior/posterior rate-cap
  fractions are nearly identical (`14.27/6.96%` versus `14.28/6.97%` with one
  consistent threshold), while near-target mean action norm rises modestly
  from `42.934` to `43.000`. Preserve the tested 20% relief ceiling and do not
  interpret the few-step gain as a reason to increase tail load.
- The assigned parent and inherited logs supply useful negative controls. A
  normalized translation-alignment replacement captures later at
  `24.343010T`; an earlier alignment formulation takes `24.354012T`; and the
  later joint-state carrier/rudder-reinforcement gate returns to 4,423 steps
  with worse mean distance (`2.224136L`). These completed iterations preserve
  the same termination and useful trajectory, so the bookshelf was consulted
  again. It supports phase-localized steering allocation, but current CFD—not
  the source literature—is the reason to select it over another terminal
  sensor or gain edit.

## One candidate hypothesis

Use the twice-reproduced response-plus-stroke schedule as the single
downstream candidate. Preserve the joint-state traveling carrier, anterior
redirect, posterior reactive-rudder sign, full body-frame target geometry,
closing-deficit response gate, and the tested 20% relief bound. Multiply only
the posterior-rudder relief by the existing smooth target-side anterior
half-cycle gate, leaving full rudder authority on the return stroke. This is a
bounded, reflection-equivariant phase-allocation mechanism because target-side
sign and anterior joint-rate sign reverse together; it neither changes the
carrier amplitude nor introduces time, world coordinates, or route memory.

Falsify the candidate if it loses capture, arrives later than `24.310009T`,
raises mean distance above `2.223959L`, changes before the terminal
closing-deficit gate activates, or materially worsens the coherent wake,
saturation, effort, force, or moment envelope. Two identical fixed-pose runs
establish repeatability only, not robustness to pose or hydrodynamic changes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric flapping
source_mechanism: preserve a rhythmic propulsive carrier while sensory feedback reallocates a bounded steering offset by observed stroke phase
transferable_invariant: separate propulsion from steering and release only the competing mean steering load on the joint-observed half-cycle supported by measured response
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, duty ratios, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: combine the normalized closing-deficit gate with the reflection-equivariant product of target-side sign and anterior joint velocity while leaving carrier phase, amplitude, rudder sign, and relief ceiling unchanged
falsification: reject if capture is lost or later than 24.310009T, mean distance exceeds 2.223959L, early behavior changes, or wake, saturation, effort, force, or moment envelopes worsen
