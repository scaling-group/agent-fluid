# Evidence-selected v41 candidate after the allocation plateau

## Visual diagnosis before candidate selection

- All four sampled solver policies, `4480`-row trajectories, combined
  keyframe sheets, and view-specific sheets are byte-identical.  Each rollout
  uses direct uniform still water (`U_infinity=[0,0,0]`) with zero cylinders
  and no prewarm snapshot, captures at `24.640015T` and `0.748356L`, has mean
  distance `2.347937L` and score `-0.448328283`, and performs 284 moving-window
  shifts.  This is deterministic nominal replication, not four mechanisms or
  held-out robustness evidence.
- I inspected the combined sheet and both view-specific sheets from release to
  capture.  The top-down sequence begins wake-free, then shows self-propelled
  diagonal advance, an orderly alternating mid-plane street, and a compact
  transverse hook through the target disk.  The oblique Lambda2 sequence
  retains compact three-dimensional structures through the hook.  With zero
  background velocity this is propulsion rather than passive advection; no
  wake breakup, out-of-plane escape, collision, or instability is visible.
- The histories agree with the visual diagnosis.  Peak absolute body-frame
  planar force and yaw-moment coefficients are
  `0.02303/0.03169/0.01559`; neither joint occupies a position hard stop.  The
  crossing margin is only `0.001644L`, terminal yaw rate is `1.887 rad/T`, and
  raw acceleration-envelope exposure remains `73.594%`, so this is a narrow
  dynamic capture rather than a settled or unsaturated hold.
- The raw-command statistic is not localized to the terminal hook.  Against
  the owned `1800 deg/T^2` envelope, any-joint exceedance is `95.73%` while
  farther than `6.5L`, `65.23%` from `3.5--6.5L`, `24.89%` from
  `2.1--3.5L`, and `26.45%` at or below `2.1L`.  Posterior exceedance is
  `76.38%`, `21.33%`, `0%`, and `0%` in those bins; all near-target
  exceedance is therefore the independent anterior phase anchor.  A terminal
  allocator cannot repair this far-carrier property.
- No sampled solver supplies a distinct failed visual sheet, so a visual
  success/failure contrast cannot be manufactured.  The informative negative
  controls are inherited trace-level results.  V42 moves safety-rejected
  posterior terminal effort to the anterior phase anchor and crosses one row
  earlier, but worsens final/mean distance to `0.749001/2.348455L`, raises raw
  acceleration exposure to `74.124%`, and worsens score to `-0.448986`.  V43
  makes the complementary coupling choice and delays capture to `24.656513T`,
  consumes crossing margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516` without improving the command or load class.  Earlier
  broad rate barriers and posterior reference-velocity feedforward reduce
  selected saturation counts but alter the established route and lose
  capture.

## Candidate hypothesis

Keep exactly one candidate: the existing v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to all four sampled successful
solvers.  Preserve its observed-state anterior phase anchor, lagged posterior
traveling bend, normalized body-frame projected-miss corridor, bounded
phase-compatible terminal residual, posterior stopping-stroke reserve, and
posterior rate coast.  Keep posterior safety joint-local.  Do not adopt v42's
headroom transfer, v43's coupled veto, another terminal allocator, a scalar
carrier tune, or an uncalibrated force/moment/crossflow residual.

This is completed-evidence selection and a concrete negative result after a
semantic plateau, not a same-worker CFD claim.  Post-exit evaluation should
reproduce the captured route, coherent two-view wake, zero position-hard-stop
occupancy, and low-load class.  Reject the selection on nominal
non-replication.  A later active mechanism requires reflected,
perturbed-release, or genuinely disturbed evidence that supplies a distinct
normalized body-frame trigger and calibrated sign.  A future carrier-envelope
mechanism must preserve the captured route and traveling-wave phase while
changing the far-range command distribution; a terminal-only change cannot
falsify that hypothesis.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated coupled-oscillator robotic-fish control, and asymmetric fish turning
source_mechanism: retain an anterior-to-posterior traveling bend with an independent phase anchor, and place bounded sensory steering only on a compatible observed half-cycle
transferable_invariant: infer phase from joint state, preserve anterior-to-posterior lag, and localize correction to the actuator and body-frame error actually implicated by evidence
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual and lagged-wave half-cycle gate with posterior stroke and rate safety kept joint-local; do not use a terminal allocator to alter the independent far-carrier envelope
falsification: reject if nominal capture, far-route locality, coherent wake, zero position-hard-stop occupancy, or the low-load class fails to repeat; reject a future carrier mechanism if it changes the route before reducing far-range command exposure, and reject a future disturbance residual if it activates without a divergent measured event

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The retained candidate
does not establish reflection, perturbed-pose, imposed-inflow, or external-wake
robustness.

## Pre-evaluation validation

- The workspace retains exactly one downstream candidate, with LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  matching all four sampled v41 policies.  No sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account.  Its three declared no-CFD commands
  were run directly and separately after removing the duplicated assigned-parent
  marker from the rendered workspace README.  Reusable-guidance semantics, the
  Julia public contract, and the solver editable-boundary audit pass; the
  contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
