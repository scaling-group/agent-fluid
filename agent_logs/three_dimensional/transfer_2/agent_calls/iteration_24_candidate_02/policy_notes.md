# Evidence-selected predicted-miss corridor candidate

## Visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the
  L64 inertial moving window.  Three v39 samples have byte-identical policies,
  `4487`-row trajectories, and combined keyframe sheets; all capture at
  `24.6785T` and `0.748602L`, with mean distance `2.348208L` and score
  `-0.448571249`.
- The combined top-down and oblique sheets for replicated v39 and distinct v40
  were inspected from release through capture.  Both top-down rows begin
  wake-free, show self-propelled diagonal motion with a coherent alternating
  mid-plane vortex street, and finish with the same compact hook into the
  capture disk.  Both oblique rows retain compact three-dimensional Lambda2
  structures through the redirect.  Neither trajectory is passive advection,
  wake breakup, instability, or a moving-window artifact.  The sheets are
  visually indistinguishable, so v40 is not a new wake or route class.
- No termination failure is present in the current four-example sample.  The
  informative negative comparator is therefore a mechanism failure rather
  than a failed episode: v39's terminal course residual still crosses with
  `0.85009` absolute normalized course error and `0.636379L` projected miss.
  The inherited audited route failure remains the broader safety boundary:
  reference-velocity follower feedforward changed the far route by `8T`,
  missed at `0.993183L`, and exited left despite a coherent wake.
- V40 applies a smooth predicted-miss corridor to the existing posterior and
  coupled course paths.  Relative to the three deterministic v39 replications,
  it retains capture, advances arrival by one sampled simulation interval from
  `24.6785T` to `24.6620T`, lowers mean distance by `0.0000344L`, and improves
  score by only `0.000000519`.  Peak absolute body-frame planar force changes
  from `0.02335/0.03202` to `0.02292/0.03176`, peak yaw moment changes only
  from `0.01559` to `0.01569`, and posterior hard-stop occupancy remains zero.
  Its final projected miss actually rises slightly to `0.637713L`, so the tiny
  numerical advantage is evidence for safe release/noninterference, not for
  better terminal alignment or for another corridor-gain tune.

## Policy hypothesis

Use the completed v40 predicted-miss corridor policy as this workspace's one
candidate.  Relative to the v39 prefill, it preserves the evaluated anterior
state oscillator, lagged posterior wave, far route, course-preview intercept,
steering-priority envelope, posterior braking reserve, and coast guard.  It
adds only the previously evaluated mirror-even corridor gate: the gate retains
signed body-frame course steering when constant-velocity projection predicts a
material miss and releases its post-passage support when the projected miss is
already inside the corridor.  No new gain, clock, route, world-frame direction,
target identity, or scalar-only gait tuning is introduced.

Expected post-exit evidence is deterministic capture near `24.662T`, the same
coherent three-dimensional route and low planar-load class, zero posterior
hard-stop occupancy, and no command change outside the normalized terminal
window.  Treat the current improvement as negligible unless it replicates.
Falsify the candidate if capture is lost, the far trajectory changes, the wake
loses coherence, posterior hard-stop contact returns, or loads leave the
sampled low class.  Do not infer held-out robustness from this fixed pose; a
reflected or perturbed rollout must reject the corridor if it releases steering
while projected miss is growing outside the capture set.  The new CFD result
is not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and terminal interception control
source_mechanism: bounded sensory direction feedback modulates a stable anterior-anchored traveling bend and releases when the task-relevant interception error is already safe
transferable_invariant: preserve wave direction and the anterior phase anchor while allocating signed target steering according to normalized body-frame collision prediction rather than forcing terminal alignment
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact corridor widths, capture geometry, prescribed paths, vortex phases, Strouhal targets, and task-specific routes
policy_translation: select the evaluated v40 corridor gate around the existing posterior and coupled course paths while leaving carrier, far-route, steering-bound, stroke-reserve, and coast mechanisms unchanged
falsification: reject if capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, or low-load behavior is lost, or if held-out reflection or perturbation shows unsafe steering release

## Pre-evaluation validation

- The single candidate is byte-identical to the completed v40 sample (LF
  SHA-256 `8122d88611c32f23241b9fe8c1f8f9e6f6e9430f3f014598a8f2f179d09efbeb`).
  This selects completed sampled CFD evidence; it does not claim a new
  same-worker rollout.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were then
  run directly and separately: the reusable-guidance check passes after
  removing the duplicate assigned-parent marker from the rendered workspace
  README, the exact Julia public-contract probe returns two finite
  accelerations, and the solver editable-boundary audit passes.
- The deterministic schema audit finds all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.  No
  formal CFD was run.
