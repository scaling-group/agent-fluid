# Evidence-selected v41 candidate after the nominal-allocation stall

## Visual diagnosis before candidate selection

- All four sampled solvers are byte-identical v41 evaluations under direct
  uniform still-water initialization (`U_infinity=[0,0,0]`), with no cylinders
  or prewarm.  Their policies, `4480`-row trajectories, combined sheets, and
  view-specific sheets match.  Each captures at `24.640015T`, with
  minimum/final distance `0.748356L`, mean distance `2.347937L`, score
  `-0.448328283`, and 284 inertial moving-window shifts.  These are replicas of
  one nominal trajectory, not four distinct mechanisms or held-out tests.
- I inspected both required visual rows from release through capture.  The
  top-down row starts wake-free, develops a coherent alternating vortex street
  behind sustained diagonal travel, and ends in a pronounced transverse hook
  through the target disk.  The oblique Lambda2 row retains compact paired
  three-dimensional structures through the same hook.  Since the imposed flow
  is zero, the progress is self-propelled rather than advected; neither view
  shows wake breakup, out-of-plane escape, collision, or numerical instability.
- The metrics and inherited trace analysis agree with the images: v41 has zero
  sampled joint-position hard-stop occupancy and remains in the low peak planar
  force/yaw-moment class (`0.02303/0.03169/0.01559`).  Its capture is dynamic
  and narrow, however: radial margin is only `0.001644L`, terminal yaw rate is
  `1.887 rad/T`, any-joint exact-rate exposure is about `13.839%`, and raw
  acceleration-envelope exposure is `73.594%`.
- No sampled solver supplies a distinct failed keyframe sheet, so a visual
  success/failure contrast cannot be manufactured.  The informative completed
  failures are the assigned-parent and inherited trace-level controls on the
  same hook.  V42 transfers a safety-rejected posterior terminal share into
  anterior headroom; it crosses one row earlier but worsens final/mean distance
  to `0.749001/2.348455L`, score to `-0.448986`, and raw acceleration exposure
  to `74.124%`.  V43 applies the opposite coupling by vetoing the anterior share
  when posterior safety rejects its mate; it captures later at `24.656513T`,
  reduces crossing margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516` without a better command or load class.

## Candidate hypothesis

Keep exactly one materializable candidate: the prefilled v41 terminal
phase-allocation controller, byte-identical in dynamics and parameter schema to
the four sampled successful solvers.  Preserve its observed-state anterior
phase anchor, lagged posterior traveling bend, normalized body-frame
predicted-miss corridor, aligned-half-cycle terminal residual, posterior
stopping-stroke reserve, and posterior rate coast.  Do not add a terminal gain,
carrier hold, cross-joint recovery, or flow/force/yaw residual: the first three
branches have completed negative controls, and the replicated nominal self-wake
does not identify the sign or scale of a disturbance correction.

This is an evidence-backed negative transfer and candidate selection, not a
same-worker CFD claim.  Post-worker evaluation should reproduce capture, the
coherent two-view wake, the established far route, zero position-hard-stop
occupancy, and the low-load class.  Reject the selection if nominal capture
fails.  Reopen disturbance feedback only after a reflected pose, perturbed
release, or external-flow rollout supplies a distinct normalized body-frame
trigger; require it to remain null before that trigger and to preserve the
captured far route.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, asymmetric fish turning, and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve an anterior-to-posterior traveling bend and allocate bounded sensory steering only for a diagnosed error on a compatible observed half-cycle
transferable_invariant: infer propulsion phase from joint state, retain the anterior phase anchor and posterior lag, and require a normalized body-frame error with evidenced sign and scale before adding a correction
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant predicted-miss residual, lagged-wave phase gate, independent anterior anchor, posterior stopping-stroke reserve, and posterior coast; add no unsupported scalar, cross-joint transfer, or nominal self-wake residual
falsification: reject if nominal capture, far-route locality, coherent wake, zero position-hard-stop occupancy, or the low-load class fails to repeat; reject a future residual if it activates without a distinct body-frame disturbance or removes necessary correction on a held-out route

## Evaluation boundary

Formal CFD is reserved for the post-worker evaluator.  Repetition of this fixed
nominal case does not establish reflection, release-pose, imposed-flow, or
external-wake robustness.

## Pre-evaluation validation

- The mandated check runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account.  Its three declared no-CFD commands were then
  run directly and separately.  After removing the duplicated assigned-parent
  marker from the rendered workspace README, the reusable-guidance check,
  Julia public policy contract, and solver editable-boundary audit pass.
- The contract probe returns finite accelerations
  `(-14.3858335, 0.0005062)`.  All 87 direct `params.FIELD` references resolve
  among the 89 fields returned by `target_policy_params()`.
- The single materializable candidate remains non-empty and byte-identical to
  all four sampled successful policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  No sibling candidate was created and no formal CFD was run.
