# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  finite `capture` termination, and no reported instability. The assigned
  phase-allocated parent is represented by two byte-identical evaluations,
  `solver_43e27134a723` and `solver_c85ef8d2aea3`. Both capture at
  `24.310009T` in 4,420 steps, cross at `0.749162L`, and have score-metric mean
  distance `2.223959L`. This independently reproduces the strongest sampled
  result but remains one fixed pose, not robustness evidence.
- The top-down sheets show continuous self-propelled approach and an
  alternating red/blue caudal street through capture rather than advection or
  an inertial coast. The complete oblique rows for the phase-allocated
  `solver_43e27134a723` and broad-relief `solver_392ed1eddf30` show discrete
  three-dimensional Lambda2 structures at the developed-gait, approach, and
  capture frames. The oblique rows for `solver_c85ef8d2aea3` and the
  translation-alignment `solver_a9222453ae0c` are blank render artifacts, so
  their matching numerical/top-down evidence is not counted as independent
  three-dimensional-wake confirmation.
- The most informative weaker comparisons preserve capture and the same
  visible route topology. Broad closing-deficit relief takes `24.326511T` with
  mean distance `2.224097L`; replacing it with translation alignment takes
  `24.343010T` with mean distance `2.224020L`. The inherited logs also report
  that a closing-deficit rudder boost was harmful and a bearing-response
  replacement weaker, while direct recent-yaw unloading collapsed joint
  motion and the wake. The evidence therefore favors phase allocation of a
  bounded posterior mean offset, not more tail load, a new response sensor, or
  suppression of the rhythmic carrier.
- The sampled phase allocation uses anterior joint velocity as its phase
  proxy. Replaying its normalized joint-state gates shows that, below `1.0L`,
  the existing target-side anterior gate averages `0.553`, while a smooth
  target-side posterior-sweep gate formed from actual tail velocity averages
  `0.653`; their overlap averages `0.465`. Including the closing-deficit gate,
  the mean active relief gate falls from `0.309` to `0.236`. The overlap is
  thus a genuinely narrower actuator-local phase condition, not a scalar gain
  change. It preserves the parent gate and selects only the part of that phase
  in which the posterior joint is itself sweeping into the target-signed
  rudder bend.

## One candidate hypothesis

Preserve the assigned parent's target geometry, anterior redirect, traveling
carrier, posterior-rudder sign and recruitment, one-step closing-deficit
sensor, and tested 20% relief ceiling. Add one normalized proprioceptive
condition to terminal relief: multiply the existing target-side anterior
half-cycle gate by a smooth gate of
`-geometric_turn * qd2 / (omega * oscillator_amplitude)`. Relief then occurs
only when the anterior stroke is useful and the actual posterior actuator is
moving into the target-signed mean rudder bend. The return stroke, carrier-
opposed tail motion, and all preterminal behavior retain full rudder authority;
the propulsive carrier itself is never scaled by the new gate.

This tests whether the small phase-allocation gain is an actuator-load effect
rather than merely correlation with anterior phase. Falsify it if capture is
lost or later than `24.310009T`, mean distance exceeds `2.223959L`, behavior
changes before the existing terminal response activates, or target error,
near-field action, rate-cap occupancy, the `0.031649/0.016385` peak normalized
force/moment envelope, or either wake view materially worsens. A positive
fixed-pose result would still require a complete oblique render and a changed
pose or hydrodynamic test before being called robust.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric flapping
source_mechanism: preserve rhythmic propulsion while sensory feedback allocates a bounded steering residual by observed actuator phase
transferable_invariant: keep the traveling carrier intact and relieve a mean steering load only during the joint-observed phase in which the steered posterior actuator moves into that load
nontransferable_details: published gains, robot linkage geometry, species-specific envelopes, dimensional frequencies, duty ratios, exact vortex phases, prescribed timing, and task-specific routes
policy_translation: qualify the existing normalized closing-deficit and anterior-stroke relief with a smooth reflection-equivariant posterior-velocity gate; leave carrier phase, amplitude, rudder sign, and the tested relief ceiling unchanged
falsification: reject if capture is lost or later than 24.310009T, mean distance exceeds 2.223959L, preterminal behavior changes, or wake, saturation, effort, force, moment, or terminal alignment worsens
