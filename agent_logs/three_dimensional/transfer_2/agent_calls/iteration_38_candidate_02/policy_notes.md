# Evidence-selected v41 candidate after the terminal-hold audit

## Visual diagnosis before candidate selection

- All four sampled policies, `4480`-row trajectories, and combined keyframe
  sheets are byte-identical.  Each rollout satisfies the direct-uniform
  still-water contract (`U_infinity=[0,0,0]`, no cylinders and no prewarm),
  captures at `24.640015T` and `0.748356L`, has mean distance `2.347937L` and
  score `-0.448328283`, and uses 284 inertial moving-window shifts.  They are
  deterministic replicas of one v41 response, not four wake conditions.
- I inspected the combined and view-specific sheets from release through
  capture.  The top-down row begins wake-free, develops a regular alternating
  vortex street behind sustained diagonal translation, and ends in a compact
  transverse hook through the target disk.  The oblique Lambda2 row retains
  compact three-dimensional structures through that hook.  In zero imposed
  flow this is coherent self-propulsion, not advection; neither view shows
  wake breakup, out-of-plane escape, collision, or numerical instability.
- The trace agrees with the images: minimum/final distance is `0.748356L`,
  neither joint occupies the position hard stop, and inherited analysis places
  peak absolute planar force/yaw-moment coefficients in the low
  `0.02303/0.03169/0.01559` class.  The capture is nevertheless a narrow,
  moving crossing: radial margin is `0.001644L`, terminal yaw rate is
  `1.887 rad/T`, and raw acceleration-envelope exposure is `73.594%`.
- No sampled or inherited materialized rollout supplies a distinct failure
  sheet, so a visual success/failure comparison cannot be fabricated.  The
  informative completed negative controls are trace-level: two-joint and
  posterior-only terminal carrier holds regress score to `-0.449580` and
  `-0.448786`; v42 cross-joint headroom transfer worsens final/mean distance
  and raw acceleration exposure; and v43 coupled anti-windup consumes most of
  the crossing margin without improving the load class.
- The final transverse heading and yaw are not, by themselves, a diagnosed
  control error.  The fish is still closing through the capture disk with a
  coherent wake, while both directions of terminal carrier/cross-joint
  intervention regress.  The sampled nominal self-wake also cannot establish
  the sign of a force-, moment-, slip-, or local-flow rejection branch.

## Candidate hypothesis

Keep exactly one materializable candidate: the existing v41 terminal
phase-allocation controller, byte-identical in dynamics and parameter schema
to all four sampled captures.  Preserve its observed-state anterior phase
anchor, lagged posterior traveling bend, normalized body-frame predicted-miss
corridor, bounded aligned-half-cycle residual, posterior stopping-stroke
reserve, and posterior rate coast.  Do not add a terminal drive hold, generic
yaw damping, uncalibrated self-wake residual, or cross-joint redistribution.

This is a concrete negative mechanism-selection result, not scalar-only gain
tuning or a same-worker CFD claim.  Post-exit evaluation should reproduce the
coherent captured route, zero position-hard-stop occupancy, and low-load
class.  Reopen approach hold only when a distinct rollout shows near-target
progress reversal or overshoot rather than a successful positive-closing
crossing.  Reopen disturbance feedback only when a reflected,
release-perturbed, or genuinely disturbed rollout identifies a normalized
body-frame trigger and its corrective sign; any new branch must remain null on
the established nominal route.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated robotic-fish oscillators, asymmetric turning, and terminal approach control
source_mechanism: preserve the anterior-to-posterior traveling bend and use bounded phase-compatible modulation only for a measured persistent target or disturbance error
transferable_invariant: retain joint-state phase, the independent anterior anchor, and posterior lag; require a normalized body-frame error with evidenced sign and scale before reducing drive or adding a residual
nontransferable_details: published gains, dimensional cadence, duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's predicted-miss corridor, aligned-half-cycle terminal allocation, posterior stopping reserve, and posterior coast; do not interpret a successful transverse crossing as evidence for a new approach hold or disturbance controller
falsification: reject on loss of nominal capture, coherent wake, crossing margin, zero position-hard-stop occupancy, or low-load class; reject a future hold or residual if it activates without observed progress reversal, overshoot, or a distinct body-frame disturbance

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The current evidence
supports this single nominal candidate but does not establish robustness to
reflection, release-pose perturbation, imposed inflow, or an external wake.

## Pre-evaluation validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were run
  directly and separately: the reusable-guidance check, Julia public policy
  contract, and solver editable-boundary audit all pass.
- The contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.  The deterministic schema audit resolves all 87
  direct `params.FIELD` references among the 89 fields returned by
  `target_policy_params()`.
- The sole materializable candidate remains non-empty and byte-identical to
  all four sampled policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  No sibling candidate was created; formal CFD remains reserved for the
  post-worker evaluator.
