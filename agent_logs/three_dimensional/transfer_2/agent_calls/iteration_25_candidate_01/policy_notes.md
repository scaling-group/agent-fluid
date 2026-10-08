# Evidence-selected predicted-miss corridor candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evaluation contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the
  L64 inertial moving window.  Three v40 samples have byte-identical policies,
  `4484`-row trajectories, and top-down, oblique, and combined keyframe hashes;
  each captures at `24.662014T` and `0.748606L`, with mean scored distance
  `2.348173L` and score `-0.448570730`.  The distinct v39 sample captures at
  `24.678516T` and `0.748602L`, with mean distance `2.348208L` and score
  `-0.448571249`.
- The combined top-down vorticity and oblique Lambda2 sheets for v40 and v39
  were inspected from release through capture.  Both begin wake-free, show
  self-propelled diagonal progress with a coherent alternating mid-plane wake,
  retain compact three-dimensional structures through the redirect, and end
  in the same bounded transverse hook into the target.  The fish is not
  passively advected, unstable, or escaping out of plane, and v40 is not a new
  visible wake or route class.
- No failed keyframe is present in the current sample.  The informative route
  failure is therefore used only through inherited audited metrics: synthesized
  posterior reference-velocity feedforward changed the far trajectory by `8T`,
  missed at `0.993183L`, and exited left at `37.1470T` and `6.9973L` despite a
  coherent wake.  No visual behavior is attributed to an unavailable sheet.
- V40 smoothly releases the existing post-passage course paths when the
  body-frame constant-velocity projection is already inside a miss corridor.
  Relative to v39 it captures `0.016502T` earlier, lowers mean distance by
  `0.00003436L`, and improves score by `0.000000519`.  It preserves zero
  posterior hard-stop occupancy and the inherited low-load and roughly `13.9%`
  exact-rate classes.  Its final projected miss is slightly larger, so the
  result supports safe noninterference and task-relevant release, not improved
  alignment or a reason to tune corridor scalars.

## Policy hypothesis

Replace the v39 prefill with the completed v40 predicted-miss corridor policy
as this workspace's single candidate.  Preserve the anterior state-feedback
phase anchor, lagged posterior traveling wave, far route, course-preview
intercept, steering-priority envelope, posterior braking reserve, and coast
guard.  Add only the evaluated mirror-even corridor gate: signed body-frame
course steering continues while velocity projection predicts a material miss
and releases after the projected intercept becomes safe.  This selects a
replicated feedback mechanism; it does not add a scalar tune or claim a new
trajectory class.

Expected post-exit evidence is deterministic v40-family capture near
`24.662T`, the same coherent three-dimensional route and low planar-load class,
zero posterior hard-stop occupancy, and no command change outside the
normalized terminal window.  Falsify the selection if capture or its small
arrival/score advantage fails to replicate, the far route changes, the wake
loses coherence, hard-stop contact returns, or rate, raw-command, force, or
moment behavior leaves the sampled class.  A reflected or perturbed rollout
must separately reject the corridor if it releases steering while projected
miss is leaving the safe set.  The new CFD outcome occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and terminal interception control
source_mechanism: bounded sensory steering modulates an anterior-anchored traveling bend until the task-relevant intercept is safe, then releases without suppressing propulsion
transferable_invariant: preserve the phase anchor and traveling-wave direction while normalized body-frame velocity projection, rather than body-course alignment alone, determines when terminal steering may withdraw
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact corridor widths, capture geometry, prescribed paths, vortex phases, Strouhal targets, and task-specific routes
policy_translation: select the evaluated v40 gate that tapers only the existing post-passage posterior and coupled course paths inside a predicted-miss corridor while leaving carrier and safety layers unchanged
falsification: reject if replication loses capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class, or if held-out reflection or perturbation exposes unsafe steering release

## Pre-evaluation validation

- The single candidate is byte-identical to all three completed v40 samples
  (LF SHA-256
  `8122d88611c32f23241b9fe8c1f8f9e6f6e9430f3f014598a8f2f179d09efbeb`).
  This selects completed sampled CFD evidence; it does not claim a new
  same-worker rollout.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were then
  run directly and separately.  After removing the duplicate assigned-parent
  entry from the rendered README, the reusable-guidance check passes; the
  exact Julia public-contract probe returns two finite accelerations
  (`-14.3858335`, `0.0005062`); and the solver editable-boundary check passes.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.  No
  formal CFD was run.
