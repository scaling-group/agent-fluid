# Candidate hypothesis: carrier-demodulated anterior half-cycle relief

## Evidence read before the edit

- All four sampled solvers contain the same v31 policy, score
  (`-0.064000433`), `18.0125T` capture, trajectory, and combined keyframe
  sheet. They are exact determinism repeats rather than four independent
  controller mechanisms. All report direct uniform quiescent initialization,
  zero cylinders, and 251 moving-window shifts. No sampled failure is present
  for the visual skill's requested success/failure contrast; the inherited
  completed failures in `guidance/control_experience.md` supply the negative
  comparisons instead.
- The top-down row shows self-propelled target closure with a coherent,
  alternating traveling wake from release through capture. There is no visible
  advection event, wake breakup, or boundary interaction. The oblique Lambda2
  row confirms the same persistent three-dimensional vortex train and a
  stable body, rather than a planar rendering artifact.
- The useful transit is already strong, but the approach remains dynamically
  poor: below `2.1L`, mean course alignment is `0.6688`, mean signed course
  error is `0.5931`, final alignment is `0.1297`, final speed is `0.8806U`,
  and final absolute yaw rate is `0.8077 rad/T`. Acceleration-ceiling residence
  is `69.29/75.89%` on the two joints. The inherited guidance shows that common
  cadence, common amplitude, anterior rate-onset, posterior signed-work,
  mean-bend redistribution, raw-yaw, and raw course-error variants did not
  preserve closure while fixing this terminal state.
- A no-intercept fit after propulsion is established on the successful
  pre-approach samples (`distance > 2.1L`, speed `>0.15U`) predicts normalized
  lateral body velocity from observed anterior
  carrier phase as
  `-0.0987*(q1/A) - 0.6800*(qdot1/(omega*A))`. The residual has mean `0.0053`
  in the far region and `0.0467` in the middle region, but mean `0.1427`, RMS
  `0.1709`, and positive sign on `93.1%` of samples below `2.1L`. This separates
  a persistent approach slip response from the large alternating carrier
  motion without treating raw yaw as a slow signal.

## Policy hypothesis written before the edit

Preserve v31 exactly outside the established `2.1L` approach. During only a
moving, misaligned approach, form a bounded reflection-odd lateral-slip
residual by subtracting the fitted joint-state carrier component from normalized
body-frame lateral velocity. When this residual calls for the opposite signed
turn, reduce only anterior acceleration that (a) does positive joint work and
(b) lies on the carrier half-cycle predicted to reinforce that residual.
Leave nominal cadence, oscillator amplitude target, posterior propulsion and
lag, mean steering, posterior duty logic, and every anterior braking/reversal
command unchanged. This is a new joint/half-cycle allocation surface, not
another closing-stride threshold or scalar carrier contraction.

Expected signature: all commands are identical to v31 above `2.1L`; below it,
the intervention is bounded and one-sided in work/phase, reducing persistent
lateral slip and anterior limit residence without moving the bottleneck to the
posterior joint. Accept only if capture and observed closure are retained while
path/cross-track, approach alignment/yaw, and non-migrating limit residence
improve together. Falsify if the fitted carrier residual changes sign or scale
under reflection/disturbance, if the coherent two-view wake degrades, if
arrival or the distance integral regresses materially, or if posterior limit
residence rises.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and feedback-modulated robotic-fish half-cycle control
source_mechanism: preserve posterior traveling-wave thrust while applying bounded state-feedback asymmetry only to the anterior half-cycle that reinforces an observed lateral error
transferable_invariant: use observed carrier phase to allocate corrective work without replacing the traveling wave or adding an unbounded mean bend
nontransferable_details: published gains, species-specific envelopes, dimensional cadence, exact vortex phase, full-body kinematics, and source-task routes
policy_translation: subtract the evidenced normalized anterior-phase component from body-frame lateral velocity, then use the bounded residual and joint work sign to relieve only the reinforcing anterior positive-work half-cycle inside the existing approach gate
falsification: reject unless transit remains exactly inactive and capture, observed closure, path, alignment/yaw, and non-migrating actuator residence improve together under CFD; also reject if reflection does not reverse the residual while preserving the scalar relief gate

## Pre-evaluation contract audit

Counterfactual replay of the selector on the inherited v31 trace (not a new
CFD result) confirms exact zero authority above `2.1L`. On the 394 inherited
approach samples, the combined response/work/half-cycle gate is nonzero on
`9.64%`; the resulting anterior relief averages `0.0033` and peaks at `0.1342`
under the configured `0.24` hard bound. This is
localized but nonredundant authority rather than a chronic carrier reduction.
The deterministic schema audit confirms that every direct `params.FIELD`
reference is returned by `target_policy_params()`; formal CFD remains deferred
to the downstream evaluator.
