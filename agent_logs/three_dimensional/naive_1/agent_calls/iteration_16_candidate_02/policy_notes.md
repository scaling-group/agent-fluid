# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts use direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, capture
  termination, and no reported instability. The phase-allocated candidate
  `solver_43e27134a723` is the strongest finite sample: it captures at
  `24.310009T` in 4,420 steps with score mean distance `2.223959L` and a
  `0.749162L` crossing. The replicated unscheduled-relief samples capture at
  `24.326511T` in 4,423 steps with mean distance `2.224097L`; the prefilled
  translation-alignment replacement takes `24.343010T` and 4,426 steps with
  mean distance `2.224020L`. Thus the new phase allocation improves arrival,
  mean distance, and scalar score over both comparisons, although only by a
  few control steps.
- The complete top-down sheets for the phase-allocated and unscheduled-relief
  samples show the same self-propelled curved approach and an alternating
  red/blue caudal street through capture. Their complete oblique rows show
  discrete three-dimensional Lambda2 structures at `8T`, `16T`, `24T`, and
  capture rather than wake collapse or inertial coasting. The prefilled
  sample's top-down route is consistent, but its oblique row is blank; that is
  a render artifact, not independent three-dimensional wake evidence.
- Peak normalized planar force and yaw moment are unchanged to the reported
  precision at about `0.031649` and `0.016385`. Anterior/posterior rate-cap
  occupancy changes only from about `11.282/5.924%` to `11.290/5.928%` under
  one consistent trajectory-based threshold. The benefit is nevertheless
  bounded: mean action norm inside `1.5L` rises from about `42.934` to
  `43.000`, and full head-relative error at crossing rises from about `1.307`
  to `1.324 rad`. This is evidence for phase allocation of a steering offset,
  not for greater total tail load or better terminal alignment.
- The inherited logs explain the comparison. A symmetric `+20%` closing-
  deficit rudder boost delayed capture and raised effort; symmetric relief
  improved it; translation- and bearing-response replacements were weaker.
  On the sampled terminal trace below `0.9L`, the one-step deficit gate is
  substantially correlated with the already defined target-side anterior
  half-cycle gate. The latest sample tests the resulting semantic hypothesis
  directly and improves capture while preserving the carrier and load
  envelope.

## One candidate hypothesis

Use the evaluated response-plus-stroke schedule as the single downstream
candidate: retain the joint-state traveling carrier, anterior redirect,
posterior reactive-rudder sign, target geometry, and the tested 20% relief
ceiling, but apply closing-deficit relief only on the smooth target-side
anterior half-cycle. Relative to the prefilled translation-alignment policy,
this restores the sensor and phase allocation that the sampled CFD actually
supports. It remains bounded and reflection equivariant because target-side
sign and anterior joint-rate sign reverse together.

This candidate is a conservative selection of the strongest completed sample,
not a claim of held-out robustness. Falsify its reuse if it fails to reproduce
capture near `24.310009T`, changes before the terminal deficit gate activates,
or materially worsens mean distance, wake coherence, saturation, effort,
force, or moment. Do not interpret a repeated fixed-pose crossing as evidence
for changed initial pose or hydrodynamic conditions.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and half-cycle asymmetry
source_mechanism: preserve a rhythmic propulsive carrier while sensory feedback reallocates a bounded steering offset by observed stroke phase
transferable_invariant: separate propulsion from steering and release only the competing mean steering load on the joint-observed half-cycle supported by the measured response
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, duty ratios, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: combine normalized one-step closing deficit with the reflection-equivariant product of target-side sign and anterior joint velocity; leave carrier phase, carrier amplitude, rudder sign, and the tested relief ceiling unchanged
falsification: reject if capture is lost or later than 24.310009T, mean distance exceeds 2.223959L, behavior changes before terminal gate activation, or wake, saturation, effort, force, or moment envelopes worsen
