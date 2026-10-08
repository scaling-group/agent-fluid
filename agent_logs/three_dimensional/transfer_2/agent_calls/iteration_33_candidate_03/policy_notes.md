# Evidence-selected v41 candidate after the nominal semantic stall

## Visual diagnosis before candidate selection

- All four sampled solver examples are exact v41 replications.  Their policy,
  `4480`-row trajectory, and combined keyframe-sheet hashes match.  Each uses
  direct uniform still-water initialization (`U_infinity=[0,0,0]`), no
  cylinders, and no prewarm snapshot; each captures at `24.640015T` and
  `0.748356L`, with mean distance `2.347937L`, score `-0.448328283`, and 284
  moving-window shifts.  This establishes deterministic nominal repeatability,
  not four independent mechanisms or held-out robustness.
- I inspected the top-down and oblique rows from release through capture.  The
  top-down sequence begins wake-free, then shows self-propelled diagonal
  progress, an orderly alternating vortex street, and a compact transverse
  hook through the target disk.  The oblique Lambda2 sequence retains paired,
  compact three-dimensional structures through the hook.  With zero background
  velocity, the motion is not passive advection; there is no visible wake
  breakup, out-of-plane escape, collision, or numerical instability.
- The trajectory agrees with the visual diagnosis.  Peak absolute body-frame
  planar force and yaw-moment coefficients are
  `0.02303/0.03169/0.01559`; neither joint reaches the `45 deg` hard stop,
  although any-joint exact-rate exposure remains `13.839%` and raw
  acceleration-envelope exposure is `73.594%`.  The head crosses with only a
  `0.001644L` margin and a terminal yaw rate of `1.887 rad/T`, so this is a
  narrow dynamic capture rather than a settled hold.
- No current solver sample supplies a failed or distinct visual trajectory.
  The informative failure contrast is therefore inherited.  The assigned
  parent's v42 headroom redistribution crosses one integration row earlier but
  worsens final/mean distance to `0.749001/2.348455L`, score to `-0.448986`,
  and raw acceleration exposure to `74.124%`, without a better rate or load
  class.  The sampled optimizer's v43 coupled anti-windup changes the route
  only at `22.044T/2.052L`, then delays capture to `24.656513T`, consumes the
  crossing margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516`, again without a new load or command class.  These
  opposite coupling directions jointly falsify treating a posterior safety
  rejection as an instantaneous command for the anterior phase anchor.
- The inherited step-32 logs also select byte-identical v41 after observing
  that direct-uniform, no-cylinder evidence contains no external wake event
  from which to calibrate the sign or scale of force, moment, or crossflow
  feedback.  Replaying the same nominal trace again cannot make such a
  disturbance mechanism evidence-backed.

## Candidate hypothesis

Keep exactly one candidate: the existing v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to all four sampled successful
solvers.  Preserve the observed-state anterior phase anchor, lagged posterior
traveling bend, normalized body-frame projected-miss corridor, bounded
phase-compatible terminal residual, posterior stopping-stroke reserve, and
posterior rate coast.  Do not adopt v42's inverse headroom transfer, v43's
coupled anti-windup, another terminal allocator, or an uncalibrated wake-load
residual.

This is an evidence-selected negative result after a semantic stall, not
scalar tuning and not a claim about the unevaluated child.  Post-exit
evaluation should reproduce the captured route, coherent three-dimensional
wake, zero hard-stop occupancy, and low-load class.  Reject the selection if
nominal capture fails.  Before adding a new disturbance mechanism, require a
distinct reflected, perturbed-release, or wake-interaction rollout that
identifies the normalized body-frame signal's sign and scale; reject it if it
changes the established far route or consumes capture margin without a new
termination, robustness, or load class.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish control, asymmetric fish turning, and wake-adaptive swimming
source_mechanism: preserve an anterior-to-posterior traveling bend and place bounded sensory steering on a compatible observed half-cycle without confusing constrained joints with interchangeable authority
transferable_invariant: infer propulsion phase from joint state, keep the phase anchor independent of posterior safety filtering, and add a disturbance response only after measured evidence identifies a persistent control error
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant body-frame projected-miss residual and lagged-wave half-cycle gate; keep posterior stroke and rate safety joint-local; do not add an unsupported scalar tune or force, moment, or crossflow residual
falsification: reject if nominal capture, far-route locality, coherent wake, zero hard-stop occupancy, or the low-load class fails to repeat; also reject the retained phase allocation if reflected or perturbed evidence shows that it removes necessary route correction

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The current candidate's
outcome is not evidence available to this worker.

## Pre-evaluation validation

- The selected candidate has LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  matching all four sampled v41 policies.  This workspace contains one
  materializable candidate and no sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account.  Its three declared no-CFD commands were run
  directly and separately after removing the duplicate assigned-parent marker
  from the rendered workspace README.  Reusable-guidance semantics, the Julia
  public contract, and the solver editable-boundary audit all pass; the
  contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
