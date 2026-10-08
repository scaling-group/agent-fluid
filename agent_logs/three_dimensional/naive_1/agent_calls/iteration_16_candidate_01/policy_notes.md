# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, capture
  termination, and no reported instability. The sampled top-down sheets show
  the fish continuously self-propelling along the same target-directed curve
  behind an alternating red/blue caudal street rather than coasting. The
  complete oblique sheets for the broad-relief reference and the
  phase-qualified candidate show discrete three-dimensional Lambda2
  structures from developed swimming through capture. The
  translation-alignment candidate's oblique row is blank, so its numerical
  and top-down result is usable but is not independent 3D-wake evidence.
- Qualifying the inherited closing-deficit relief by the target-side anterior
  stroke is the strongest sampled result. It captures in 4,420 steps at
  `24.310009T` and `0.749162L` with score `-0.325172`, versus 4,423 steps,
  `24.326511T`, `0.749329L`, and `-0.325310` for broad relief. The translation
  alignment replacement is weaker at 4,426 steps and `24.343010T`. The
  phase-qualified trace retains the broad controller's peak normalized planar
  force and yaw moment near `0.031649/0.016385`, so the three-step improvement
  is evidence for stroke allocation rather than more rudder magnitude.
- The positive result has a sharp boundary. The phase-qualified trace slightly
  raises mean action norm below `1.5L` from about `42.934` to `43.000` and
  crosses with full target error about `1.324 rad` rather than `1.307 rad`.
  It is an earlier crossing, not better terminal alignment or lower effort.
  The inherited velocity-alignment and seven-sample bearing-response
  replacements were both later, so another response-sensor substitution is
  not supported.
- Replaying the joint-state gates locates the remaining allocation mismatch.
  At about `24.19T`, the anterior useful-stroke gate is already about `0.998`
  while the posterior joint is still returning away from the negative rudder
  offset (posterior loading gate about `0.42`). The current law therefore
  releases steering before the tail begins its target-side loading stroke.
  By about `24.25T`, both gates exceed `0.90`. This motivates posterior phase
  concordance while leaving the measured closing trigger, 20% ceiling, and
  all preterminal behavior intact.

## One candidate hypothesis

Start from the sampled phase-qualified winner. Keep its joint-state traveling
carrier, anterior redirect, posterior carrier redistribution, target-gated
reactive-rudder sign, one-step closing-deficit response, and tested 20% relief
ceiling. Add one smooth posterior loading gate: terminal relief is permitted
only when target-side anterior motion and posterior motion into the rudder
offset agree. During the lag interval and posterior return stroke, full rudder
authority remains available; once the tail loads toward the offset, the
existing bounded relief applies. The added gate is reflection equivariant and
dimensionless because it combines target-side sign with posterior joint rate
normalized by the carrier rate scale.

Falsify this candidate if it loses capture, does not beat the sampled
`24.310009T`/4,420-step boundary, raises score loss, worsens the roughly
`1.324 rad` terminal target error or near-target action effort, changes the
trajectory before the closing-deficit gate first activates near `22.61T`, or
materially increases rate-cap occupancy, peak normalized force/moment beyond
`0.031649/0.016385`, or disrupts the coherent top-down and oblique wake.
Success at the fixed pose would still not establish held-out robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and half-cycle asymmetry
source_mechanism: preserve a rhythmic propulsive carrier while sensory steering is reallocated only during the actuator phase that loads the requested turn
transferable_invariant: separate propulsion from steering and condition bounded steering relief on observed posterior loading phase so the return stroke retains directional authority
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, duty ratios, exact vortex phases, prescribed timing, and task-specific routes
policy_translation: combine normalized full-angle target-side sign with posterior joint velocity to form a smooth reflection-equivariant loading gate, then multiply it into the existing closing-deficit and anterior-stroke relief without changing the carrier
falsification: reject if capture is not earlier than 24.310009T, if preterminal motion changes, or if terminal alignment, effort, saturation, force, moment, or either wake view worsens
