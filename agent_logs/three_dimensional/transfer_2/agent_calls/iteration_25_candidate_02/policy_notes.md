# Evidence-selected replicated predicted-miss candidate

## Visual diagnosis before candidate selection

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the
  L64 inertial moving window.  The three v40 samples have byte-identical
  policies, `4484`-row trajectories, and combined keyframe sheets; each
  captures at `24.662014T` and `0.748606L`, with mean distance `2.348173L`
  and score `-0.448570730`.  The distinct v39 sample captures at
  `24.678516T` and `0.748602L`, with mean distance `2.348208L` and score
  `-0.448571249`.
- The combined top-down vorticity and oblique Lambda2 sheets for v39 and v40
  were inspected from uniform release through capture.  Both show
  self-propelled diagonal progress, a coherent alternating mid-plane vortex
  street, compact three-dimensional wake structures, and the same bounded
  transverse hook into the capture disk.  The body moves through still water;
  this is not passive advection, a prewarm artifact, wake breakup, numerical
  instability, or an out-of-plane escape.  The sheets are visually
  indistinguishable, so v40 is not a new wake or route class.
- No termination failure is present among the current sampled keyframes.  The
  informative negative comparison is therefore mechanistic: relative to v39,
  v40 advances capture by `0.016502T`, lowers mean distance by only
  `0.00003436L`, and improves score by only `0.000000519`.  It preserves zero
  sampled posterior hard-stop occupancy, nearly the same anterior/posterior
  exact-rate exposure (`9.233/4.862%` versus `9.294/4.858%`), and the same
  low peak body-force/yaw-moment class (`0.0229/0.0318/0.0157` versus
  `0.0233/0.0320/0.0156`).  Yet terminal course angle worsens from `58.221`
  to `58.415 deg`, and constant-velocity projected miss rises from `0.63638`
  to `0.63771L`.  Thus v40 demonstrates safe terminal release and nominal
  noninterference, not better alignment or a reason to tune corridor scalars.
- The inherited logs supply the broader failure boundary unavailable as a
  current failed keyframe: reference-velocity follower feedforward changed the
  established far route by `8T`, missed at `0.993183L`, and exited left at
  `37.1470T` despite a coherent wake and lower rate-limit occupancy.  Broad
  dual-joint velocity barriers likewise lost capture.  A speculative new
  phase or rate intervention is therefore weaker evidence than the replicated
  v40 controller selected here.

## Candidate hypothesis

Use the completed v40 predicted-miss-corridor controller already present in
`solver/` as this workspace's exactly one candidate.  It preserves the
anterior state oscillator, lagged posterior traveling bend, course-preview
intercept, steering-priority bound, posterior braking reserve, and
steering-residual coast.  Its only distinction from v39 is a smooth,
mirror-equivariant gate that retains existing signed course steering while a
body-frame constant-velocity projection predicts a material lateral miss and
withdraws post-passage support once that projection lies in the safe corridor.
No clock, route, world-frame direction, target identity, or scalar-only gait
tune is added.

Expected post-exit evidence is another deterministic v40-family capture near
`24.662T`, the same coherent three-dimensional route, zero posterior hard-stop
occupancy, and the established exact-rate and low-load classes.  Falsify the
selection if replication loses capture or the tiny arrival/score advantage,
changes the far path, breaks wake coherence, or regresses hard-stop, rate, raw
command, force, or moment behavior.  The fixed nominal pose does not test
generalization: a future reflected or perturbed rollout must reject the gate
if projected miss grows after steering release.  The new CFD result is not
available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and terminal interception control
source_mechanism: bounded sensory steering modulates a stable traveling-bend rhythm until the task-relevant intercept is safe, then withdraws without suppressing propulsion
transferable_invariant: preserve the anterior phase anchor and posterior traveling wave while normalized body-frame collision prediction, rather than body-course alignment alone, determines terminal steering release
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact corridor widths, capture geometry, prescribed paths, vortex phases, Strouhal targets, and task-specific routes
policy_translation: select the triply replicated v40 controller whose smooth predicted-miss gate tapers only the existing post-passage posterior and coupled course paths while leaving carrier and safety layers unchanged
falsification: reject if replication loses capture, established far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class, or if reflected or perturbed evidence shows unsafe steering release

## Pre-evaluation validation

- The single candidate is byte-identical to all three completed v40 samples
  (LF SHA-256
  `8122d88611c32f23241b9fe8c1f8f9e6f6e9430f3f014598a8f2f179d09efbeb`).
  This selects completed sampled evidence and does not claim a same-worker CFD
  result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were then
  executed directly and separately: the reusable-guidance comparison passes
  after removing the duplicated assigned-parent marker from the rendered
  workspace README, the Julia public-contract probe returns exactly two finite
  accelerations, and the solver editable-boundary audit passes.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.  No
  formal CFD was run.
