# Evidence-selected v41 candidate at the fixed-case identifiability boundary

## Visual diagnosis before candidate selection

- All four sampled solvers are exact nominal v41 replications.  Their policy,
  `4480`-row trajectory, and combined two-view keyframe hashes match.  Each
  uses direct uniform still water (`U_infinity=[0,0,0]`) with no cylinders and
  no prewarm snapshot, and each captures at `24.640015T` and `0.748356L` with
  score `-0.448328283`, distance integral `2.347937L`, and 284 moving-window
  shifts.  This is one deterministic fixed-case result repeated four times,
  not four mechanisms or held-out robustness evidence.
- I inspected the combined sheet from release through capture in both views.
  The top-down row begins wake-free, then shows self-propelled diagonal
  progress, an orderly alternating mid-plane vortex street, and a compact
  transverse hook through the target disk.  The oblique row retains compact
  paired three-dimensional Lambda2 structures through the hook.  With zero
  background flow the motion is not passive advection; no wake breakup,
  out-of-plane escape, collision, or numerical instability is visible.
- The trajectory and diagnostics agree with the images.  Peak absolute planar
  body-frame force and yaw-moment coefficients are
  `0.02539/0.03193/0.01559`; neither joint reaches its `45 deg` position hard
  stop, although raw acceleration-envelope exposure remains `73.594%`.  The
  terminal head crossing has only `0.001644L` margin and measured yaw rate
  `1.887 rad/T`, so this is a narrow dynamic capture rather than a settled
  hold.
- No sampled solver supplies a distinct failure sheet, so a visual
  success/failure comparison cannot be manufactured.  The informative
  negative controls are inherited trace-level results.  V42 transfers a
  safety-filtered posterior terminal share to the anterior phase anchor; it
  crosses one row earlier but worsens final/mean distance to
  `0.749001/2.348455L`, score to `-0.448986`, and raw acceleration exposure to
  `74.124%`.  V43 makes the complementary coupled anti-windup choice and first
  diverges only at `22.044T/2.052L`, but captures later at `24.656513T`,
  consumes crossing margin to `0.000397L`, and worsens mean distance/score to
  `2.348909L/-0.449516`.  Neither creates a better load or rate class.
- The earlier course-consistency veto is an equally important null control:
  its complete trajectory is byte-identical to its captured parent.  It proves
  nominal noninterference but cannot evidence usefulness away from the sole
  route.  Broader dual-joint rate barriers and posterior reference-velocity
  feedforward do activate, lower selected saturation statistics, change the
  far route, and lose capture.  The available evidence therefore identifies
  neither a safe active robustness trigger nor a useful dormant one.

## Candidate hypothesis

Keep exactly one candidate: the existing v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to all four sampled successful
solvers.  Preserve the observed-state anterior phase anchor, lagged posterior
traveling bend, normalized body-frame projected-miss corridor, bounded
phase-compatible terminal residual, posterior stopping-stroke reserve, and
posterior rate coast.  Do not adopt another terminal allocator, cross-joint
authority transfer, nominally dormant veto, or force/moment/crossflow residual
from this fixed-case sample.

This is a concrete negative selection after a semantic stall, not scalar-only
gain tuning and not a claim about the unevaluated child.  Post-exit evaluation
should reproduce the captured route, coherent two-view wake, zero position
hard-stop occupancy, and low-load class.  Reject the selection if nominal
capture fails.  Reopen mechanism search only when a reflected,
perturbed-release, or actual wake-interaction rollout exposes a reproducible
normalized body-frame divergence; reject a future branch if it activates
before that trigger, changes the established far route, or consumes capture
margin without a new termination, robustness, or load class.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated coupled-oscillator robotic-fish control, asymmetric fish turning, and wake-adaptive swimming
source_mechanism: retain an anterior-to-posterior traveling bend and allocate bounded sensory steering on a compatible observed half-cycle; introduce disturbance feedback only for a measured persistent error
transferable_invariant: infer phase from joint state, preserve the anterior phase anchor and posterior lag, and require a normalized body-frame trigger with evidenced sign and scale before adding a robustness response
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, fixed capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual and lagged-wave half-cycle gate with posterior stroke and rate safety kept joint-local; add no scalar tune, cross-joint recovery, or uncalibrated wake residual
falsification: reject if nominal capture, far-route locality, coherent wake, zero position hard-stop occupancy, or the low-load class fails to repeat; reject the retained phase allocation on held-out poses if it removes necessary route correction

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The current candidate's
future rollout is not evidence available to this worker.

## Pre-evaluation validation

- The single materializable candidate has LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  matching all four sampled v41 policies.  No sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account.  Its three declared no-CFD commands
  were then run directly and separately: reusable-guidance semantics, the
  Julia public policy contract, and the solver editable-boundary audit all
  pass.  The contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
