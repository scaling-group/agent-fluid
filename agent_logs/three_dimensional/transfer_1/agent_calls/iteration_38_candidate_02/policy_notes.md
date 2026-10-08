# Restore the geometrically qualified posterior response

## Completed evidence and visual diagnosis before editing

- All four sampled policies start directly from uniform still water with
  `U_infinity=(0,0,0)` and terminate by `capture` at the same logged
  `17.41299 T` step.  Two byte-identical v50 evaluations are strongest at
  score `-0.0595203`, total/observed distance integrals
  `1.945327/1.329976 L`, and final distance `0.745094 L`.
- The prefilled posterior course-shape residual preserves capture but regresses
  to `-0.0595473` and `1.945350/1.329982 L`.  It is indistinguishable from
  v50 at the sampled `2-16 T` distance checkpoints, yet posterior acceleration-
  limit residence rises from `5.15%` to `5.91%` and any-joint residence from
  `40.11%` to `40.90%`.  The response-arbitrated desired-yaw-rate placement is
  worse again at `-0.0599362`, `1.945663/1.329978 L`, and final distance
  `0.745498 L`, without reducing the v50 action envelope.
- I inspected both rows of the combined sheets for a reproduced v50 result,
  the prefilled posterior residual, and the informative desired-yaw-rate
  failure.  Their top-down rows show active target-directed self-propulsion:
  compact startup vorticity develops into a coherent alternating street along
  the same smooth arc, with no reversal, collision, boundary exit, or wake
  collapse.  Readable oblique panels show compact paired caudal Lambda2
  structures at release, `4 T`, `12 T`, `16 T`, and capture; the shared black
  `8 T` panel is a rendering limitation.  Neither course-feedback placement
  introduces a visible beneficial wake topology.
- The trajectory metrics agree with the visual comparison.  All policies keep
  the same sampled `0.98310 L/T` maximum speed and
  `0.032252/0.016092` peak normalized planar force/moment.  The posterior
  course residual therefore spends tail authority without measurable route,
  arrival, load, or wake benefit; relocating the same instantaneous cue into
  the yaw-response loop does not rescue it.

## One-candidate policy hypothesis

Materialize the completed v50 geometry-qualified posterior-response policy as
the sole candidate.  Preserve its normalized body-frame target sensing,
state-feedback traveling-wave carrier, posterior lag, selective crossflow pose
confidence, route and redirect steering, axis-selective launch residual,
carrier-first spillover, half-cycle steering, proportional geometric
qualification of supplementary posterior curvature, approach priority, and
componentwise acceleration projection.  Remove the prefilled instantaneous
target/velocity course-slip observation and posterior shape residual, returning
exactly to the twice-reproduced v50 artifact.

The next CFD evaluation should reproduce capture near `17.413 T`, score and
total/observed integrals near `-0.05952` and `1.94533/1.32998 L`, the smooth
target-signed arc, coherent two-view wake, and the established
speed/saturation/load envelope.  Falsify this selection if v50 does not
reproduce, capture or middle/late closure regresses, target-signed curvature or
wake coherence is lost, or speed, limit residence, force, or moment materially
exceeds the completed envelope.  Do not retry course feedback until completed
traces define a de-gaited or history-consistent direction signal.  Formal CFD
runs only after this worker exits.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction studies
source_mechanism: preserve the propulsive oscillator while separating persistent route error from fast carrier-correlated lateral motion before applying corrective steering
transferable_invariant: instantaneous lateral motion is not automatically target-course error in an undulatory swimmer; added direction feedback must be response-coherent and must not spend authority cancelling the productive gait
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, full-body CPG states, exact vortex phases, and task-specific routes
policy_translation: remove the normalized instantaneous target/velocity course-slip residual and restore the v50 two-joint state-feedback carrier, geometric response arbitration, and actuator allocation
falsification: reject if v50 capture and integral performance do not reproduce; revisit direction feedback only when a de-gaited or history-consistent body-frame cue predicts target-signed correction with bounded posterior occupancy on completed traces

## Evidence boundary

All numerical and visual claims above come from the assigned-parent guidance,
sampled completed solver results, and inherited optimizer notes.  The sole
candidate is an evidence-backed reproducibility selection; no same-worker CFD
outcome is claimed.

## No-CFD implementation audit

- The sole materialized policy is
  `dogfish_target_control_v50_geometrically_qualified_posterior_response`,
  SHA-256 `cf9ca6aa2892b1aa4298d75c1359d84c467330129e0ea6167857742403b046ab`;
  it is byte-identical to both strongest sampled v50 artifacts.
- All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.  The lightweight Julia policy
  contract, material-guidance check, and solver editable-boundary check pass.
- The required check runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this ChatGPT account.  Its three exact no-CFD commands were
  run locally and separately.  The guidance check first exposed a duplicated
  assigned-parent marker in the rendered workspace `README.md`; removing only
  that duplicate repaired provenance, and the rerun passed.  No formal CFD was
  run.
