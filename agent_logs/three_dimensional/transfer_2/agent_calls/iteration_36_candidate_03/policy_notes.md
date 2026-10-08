# Evidence-selected v41 candidate at the nominal multi-wake identifiability boundary

## Visual diagnosis before candidate selection

- The four sampled solver policies, `4480`-row trajectories, and combined
  two-view keyframe sheets are byte-identical.  Each is the v41 terminal
  phase-allocation controller, initialized directly in uniform still water
  (`U_infinity=[0,0,0]`) with no cylinders and no prewarm snapshot.  Each
  captures at `24.640015T` and `0.748356L`, with score `-0.448328283`, score
  mean distance `2.347937L`, and 284 moving-window shifts.  These are repeated
  measurements of one fixed condition, not four distinct wake encounters.
- I inspected the shared combined sheet from release to capture.  The
  top-down row starts wake-free, develops an orderly alternating mid-plane
  vortex street during sustained diagonal self-propulsion, and ends in a
  compact transverse hook through the capture disk.  The oblique row retains
  compact paired Lambda2 structures through the hook.  With zero background
  flow, the translation is self-propelled rather than passive advection; no
  wake breakup, out-of-plane escape, collision, or numerical instability is
  visible.
- The trajectory and diagnostics support the image reading.  Peak absolute
  planar body-force/yaw-moment coefficients are
  `0.02303/0.03169/0.01559`; neither joint occupies its `45 deg` hard stop.
  Exact-rate exposure remains `9.196/4.643%` on the anterior/posterior joints
  (`13.839%` on either joint), and at least one raw command exceeds the
  acceleration envelope in `73.594%` of sampled rows.  The fish crosses with
  only `0.001644L` margin and yaw rate `1.887 rad/T`, so the success is a
  narrow dynamic capture, not a settled hold.
- No distinct failure keyframe sheet exists in the sampled solvers or
  inherited optimizer rollout artifacts; all inherited sheets repeat the same
  v41 capture.  A visual success/failure contrast therefore cannot be made
  honestly in this workspace.  The informative negative controls survive at
  trace level in the assigned parent guidance: v42's rejected-pulse transfer
  to the anterior anchor worsened final/mean distance and raw acceleration
  exposure, while v43's opposite coupled veto delayed capture and consumed
  crossing margin.  Older broad joint-rate barriers and posterior
  reference-velocity feedforward lowered selected saturation counts but
  changed the far route and lost capture.

## Candidate hypothesis

Keep exactly one materializable candidate: the existing v41 terminal
phase-allocation policy, byte-identical in dynamics and parameter schema to
all sampled successful solvers.  It preserves the observed-state anterior
phase anchor, lagged posterior traveling bend, normalized body-frame
projected-miss corridor, phase-compatible bounded terminal residual,
posterior stopping-stroke reserve, and posterior rate coast.

Do not add a force, moment, local-flow, or relative-crossflow residual merely
because the evaluator schema and task-family labels contain `multiwake`.  The
physical evidence has no cylinders or imposed disturbance and provides no
separable external-wake event from which to calibrate the response sign,
scale, or onset.  Repeated selection after the semantic stall is a concrete
negative transfer result, not scalar gain tuning and not evidence for
held-out robustness.  Post-exit evaluation should reproduce nominal capture,
the coherent two-view wake, zero position hard-stop occupancy, and the low
load class.  Reopen an active wake mechanism only after a reflected,
perturbed-release, or actual wake-interaction rollout exposes a reproducible
normalized body-frame divergence.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated coupled-oscillator robotic-fish control, asymmetric turning, and wake-adaptive swimming
source_mechanism: retain the anterior-to-posterior traveling bend and phase-compatible sensory steering; add disturbance feedback only after a measured external wake event is distinguishable from persistent route error
transferable_invariant: infer phase from joint state, preserve the anterior phase anchor and posterior lag, and require a normalized body-frame disturbance trigger with evidenced sign and scale before adding wake rejection
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, evaluator labels, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave half-cycle gate, joint-local posterior stroke reserve, and posterior coast; add no scalar tune, cross-joint recovery, or uncalibrated wake residual
falsification: reject if nominal capture, far-route locality, coherent wake, zero position hard-stop occupancy, or the low-load class fails to repeat; on a later disturbed rollout reject any residual that activates before the diagnosed divergence or removes useful wake-assisted motion

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The retained candidate
is evidence-selected for the fixed case but is not evidence of robustness to
reflection, release-pose perturbation, imposed inflow, or an external wake.

## Pre-evaluation validation

- The single `solver/**/candidate_target_policy.jl` is non-empty LF text with
  SHA-256 `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  byte-identical to all four sampled v41 policies.  No sibling candidate was
  created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account.  Its three declared no-CFD commands
  were run directly and separately: reusable-guidance semantics, the finite
  Julia two-joint contract, and the solver editable-boundary audit all pass.
- All `87` direct `params.FIELD` references resolve among the `89` fields
  returned by `target_policy_params()`.  Formal CFD remains reserved for the
  post-worker evaluator.
