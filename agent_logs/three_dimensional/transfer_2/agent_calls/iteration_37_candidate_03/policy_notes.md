# Evidence-selected v41 candidate after the multi-generation nominal stall

## Visual diagnosis before candidate selection

- The four assigned solver examples are byte-identical v41 evaluations under
  the frozen direct-uniform still-water contract (`U_infinity=[0,0,0]`, no
  cylinders and no prewarm).  Their policies, `4480`-row trajectories,
  top-down sheets, and oblique sheets match.  Each captures at `24.640015T`
  with minimum/final distance `0.748356L`, mean distance `2.347937L`, score
  `-0.448328283`, and 284 inertial moving-window shifts.  The eight completed
  rollouts in the assigned parent's inherited logs have the same policy and
  trajectory hashes, so the accessible evidence represents twelve nominal
  repetitions, not twelve different controller mechanisms or held-out tests.
- I inspected the combined and view-specific sheets from release through
  capture.  The top-down row begins wake-free, develops an alternating
  mid-plane vortex street behind sustained diagonal motion, and ends in a
  compact transverse hook through the target disk.  The oblique Lambda2 row
  retains compact three-dimensional structures through the same hook.  With
  zero imposed flow this is self-propulsion rather than advection; neither view
  shows wake breakup, out-of-plane escape, collision, or numerical instability.
- The trace cross-check agrees with the visual diagnosis.  Peak absolute
  planar body-frame force and yaw-moment coefficients are
  `0.02303/0.03169/0.01559`; neither joint occupies the `45 deg` position stop.
  The result is still a narrow dynamic crossing: final radial margin is only
  `0.001644L`, terminal yaw rate is `1.887 rad/T`, and inherited analysis finds
  `13.839%` any-joint exact-rate exposure and `73.594%` raw acceleration-
  envelope exposure.
- No assigned or inherited materialized rollout supplies a distinct failed
  keyframe sheet.  The most informative distinct failures are therefore the
  inherited completed trace-level allocation regressions.  V42 transfers a
  safety-rejected posterior terminal share to anterior headroom: it crosses
  one control row earlier but worsens final/mean distance to
  `0.749001/2.348455L`, score to `-0.448986`, and raw acceleration exposure to
  `74.124%`.  V43 tests the opposite coupling by vetoing the anterior share
  when posterior safety rejects its mate: it captures later at `24.656513T`,
  reduces crossing margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516` without a better command or load class.  Older broad
  dual-joint rate barriers and posterior reference-velocity feedforward lower
  selected saturation counts but change the route and lose capture.

## Candidate hypothesis

Keep exactly one materializable candidate: the existing v41 terminal
phase-allocation controller, byte-identical in dynamics and parameter schema
to the four assigned successful policies.  Preserve its observed-state
anterior phase anchor, lagged posterior traveling bend, normalized body-frame
projected-miss corridor, bounded phase-compatible terminal residual,
posterior stopping-stroke reserve, and posterior rate coast.  Do not add a
force, moment, or crossflow residual from this nominal self-wake, and do not
recycle a posterior safety rejection through the anterior oscillator in
either direction.

This is a completed-evidence selection and a concrete negative result after a
semantic stall, not a same-worker CFD claim or a scalar-only tune.  Post-exit
evaluation should reproduce capture, the coherent two-view wake, the
established far route, zero position-hard-stop occupancy, and the low-load
class.  Reject the selection if nominal capture fails.  A later active
disturbance mechanism requires a reflected pose, perturbed release, or genuine
external-flow event that identifies a normalized body-frame trigger and its
sign; it must remain null before that trigger and preserve the established
route.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, asymmetric fish turning, and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve an anterior-to-posterior traveling bend and allocate bounded sensory steering only for a diagnosed error on a compatible observed half-cycle
transferable_invariant: infer propulsion phase from joint state, retain the anterior phase anchor and posterior lag, and require a normalized body-frame error with evidenced sign and scale before adding a correction
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, anterior anchor, posterior stopping-stroke reserve, and posterior coast; add no unsupported scalar, cross-joint transfer, or self-wake residual
falsification: reject if nominal capture, far-route locality, coherent wake, zero position-hard-stop occupancy, or the low-load class fails to repeat; reject a future residual if it activates without a distinct body-frame disturbance or removes necessary correction on a held-out route

## Evaluation boundary

Formal CFD is reserved for the post-worker evaluator.  Repetition of this
fixed nominal case does not establish reflection, release-pose, imposed-flow,
or external-wake robustness.

## Pre-evaluation validation

- The mandated check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account.  Its three declared no-CFD commands were
  then run directly and separately.  After removing the duplicated assigned-
  parent marker from the rendered workspace README, the reusable-guidance
  check, Julia public policy contract, and solver editable-boundary audit pass.
- The public contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.  The deterministic schema audit resolves all 87
  direct `params.FIELD` references among the 89 fields returned by
  `target_policy_params()`.
- The single materializable candidate remains non-empty and byte-identical to
  the four assigned successful policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  No sibling candidate was created; formal CFD remains deferred to the
  post-worker evaluator.
