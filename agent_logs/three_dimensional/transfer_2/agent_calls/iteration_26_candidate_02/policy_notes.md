# Evidence-selected terminal phase-allocation candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the
  L64 inertial moving window. Three byte-identical v40 predicted-miss samples
  capture at `24.662014T`, minimum/final distance `0.748606L`, mean distance
  `2.348173L`, and score `-0.448570730`. The distinct v41 terminal
  phase-allocation sample captures at `24.640015T`, `0.748356L`,
  `2.347937L`, and `-0.448328283`, making it the strongest finite sampled
  candidate.
- The top-down vorticity and oblique Lambda2 rows of the distinct v40 and v41
  combined sheets were inspected from release through capture. Both begin
  wake-free, then show self-propelled diagonal progress, a coherent alternating
  mid-plane vortex street, compact three-dimensional wake structures, and the
  same bounded transverse terminal hook into the capture disk. Neither is
  passively advected, unstable, prewarmed, or escaping out of plane. The sheets
  are visually indistinguishable, so v41 is not a new wake or trajectory class.
- No failed rollout is present in the current sampled keyframes. The available
  inherited logs provide the informative failure boundary: posterior
  reference-velocity feedforward retained a coherent wake but altered the far
  route by `8T`, missed at `0.993183L`, and exited left at `37.1470T` and
  `6.9973L`; broad dual-joint rate barriers likewise lost capture. This rules
  against replacing the established carrier or spreading terminal correction
  into both joints merely to improve a saturation statistic.
- V41 makes one mechanism change to v40: it removes the collision-corridor
  course residual from continuous mean curvature and spends a bounded portion
  only on the observed lagged-tail-wave half-cycle aligned with the requested
  turn. Relative to v40, it advances capture by `0.021999T`, reduces mean
  distance by `0.000236L`, improves terminal course angle from `58.415` to
  `57.610 deg`, and lowers projected perpendicular miss from `0.63771` to
  `0.63193L`. It preserves zero sampled posterior hard-stop occupancy,
  essentially unchanged raw acceleration exposure (`73.595%` in both), a
  slightly lower exact-rate class, and the same peak body-force/yaw-moment
  class (about `0.0254/0.0319/0.0156`). The improvement is consistent but
  remains nonsemantic because termination, visible route, and wake class do not
  change.

## Candidate hypothesis

Select the completed v41 terminal phase-allocation policy as this workspace's
exactly one candidate. Preserve its anterior state-feedback phase anchor,
lagged posterior traveling bend, body-frame target and velocity-course
feedback, predicted-miss release, steering-priority envelope, posterior stroke
braking, and posterior rate coast. Its distinguishing mechanism keeps the
extra collision-course residual separate from route-scale mean curvature and
admits it only on the observed tail-wave half-cycle aligned with the signed
target request. This is evidence selection, not a new scalar gain tune and not
a claim that the nominal result generalizes.

Expected post-exit evidence is another v41-family capture near `24.640T`, the
same coherent three-dimensional route, zero posterior hard-stop occupancy, and
no regression from the established raw-command, exact-rate, force, or moment
classes. Falsify the selection if replication loses capture or its v40-relative
arrival/distance advantage, alters the far path, breaks wake coherence, or
raises peak command/load class. A future reflected or perturbed rollout must
also reject the mechanism if the phase gate applies the residual on the wrong
physical half-cycle. The new CFD result is unavailable to this worker and is
not claimed here.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: bounded half-cycle asymmetry allocates target correction within a stable anterior-to-posterior traveling bend instead of replacing that rhythm with static curvature
transferable_invariant: preserve the anterior phase anchor and posterior lag, infer phase from observed joint state, and spend a bounded target-derived steering residual only on the half-cycle aligned with the requested turn
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: select the evaluated v41 controller that gates the normalized body-frame predicted-miss residual with the mirror-equivariant lagged-tail-wave phase while retaining the inherited carrier and safety layers
falsification: reject if capture, far-route noninterference, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if reflected or perturbed evidence exposes wrong-half-cycle allocation

## Pre-evaluation validation

- The single candidate is byte-identical to the completed v41 sample (LF
  SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  This selects existing sampled evidence and does not claim a same-worker CFD
  result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three declared no-CFD checks were then
  run directly and separately: the reusable-guidance check passes, the Julia
  public-contract probe returns exactly two finite accelerations, and the
  solver editable-boundary audit passes.
- The deterministic schema guard resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`. No
  formal CFD was run.
