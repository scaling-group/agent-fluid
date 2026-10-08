# Evidence-selected terminal phase-allocation candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the
  L64 inertial moving window.  Three byte-identical v40 predicted-miss-corridor
  samples capture at `24.662014T`, minimum/final distance `0.748606L`, mean
  distance `2.348173L`, and score `-0.448570730`.  The distinct v41
  terminal-phase sample captures at `24.640015T`, `0.748356L`, `2.347937L`,
  and `-0.448328283`.
- Both rows of the assigned-parent v40 and distinct v41 combined keyframe
  sheets were inspected from release through capture.  Their top-down rows
  begin wake-free and show self-propelled diagonal progress, a coherent
  alternating mid-plane vortex street, and the same bounded transverse hook
  into the capture disk.  Their oblique rows retain compact three-dimensional
  Lambda2 structures through capture.  Neither rollout is passively advected,
  unstable, or escaping out of plane, and no wake-class or route-class change
  is visible.
- No termination failure is present among the four current sampled keyframes.
  The informative failure boundary therefore comes from inherited audited
  logs rather than an invented visual claim: posterior reference-velocity
  feedforward changed the established far route by `8T`, missed at
  `0.993183L`, and exited left at `37.1470T` despite a coherent wake and lower
  rate-limit occupancy.  Broad dual-joint velocity barriers likewise lost
  capture.  These negatives rule out another widespread phase or rate
  correction.
- V41 is a small but consistent improvement over the replicated v40 parent:
  arrival advances by `0.021999T`, mean distance falls by `0.000236L`, score
  improves by `0.000242448`, and terminal constant-velocity projected miss
  falls from `0.637713L` to `0.631928L`.  Raw acceleration-envelope exposure
  remains `73.59%`, sampled exact-rate exposure remains in the same roughly
  `13%` class, posterior hard-stop occupancy remains zero, and peak absolute
  body-force/yaw-moment coefficients remain near `0.023/0.032/0.0156`.

## Candidate hypothesis

Use the completed v41 terminal phase-allocation policy as this workspace's
exactly one candidate.  It preserves v40's anterior state-feedback oscillator,
lagged posterior traveling wave, body-frame predicted-miss corridor,
course-preview capture path, steering-priority envelope, posterior stroke
braking, and steering-residual coast.  Its one actuator-level distinction is
to remove the extra terminal collision-course residual from continuous mean
curvature and spend only a bounded share on the observed lagged tail-wave
half-cycle aligned with the signed target-derived turn request.  Phase comes
only from joint position and rate; no clock, route, world-frame direction, or
case identity enters the policy.

The post-exit evaluation should reproduce v41's slightly earlier capture and
smaller projected miss without changing the established far route, coherent
three-dimensional wake, zero posterior hard-stop occupancy, or low-load/rate
classes.  Reject the selection if replication loses capture or the small
arrival/distance advantage, changes any pre-terminal behavior, increases peak
command or load class, or shows that the terminal pulse is merely noisy and
nonrepeatable.  The fixed nominal pose still does not establish reflected or
perturbed-route generalization, and no same-worker CFD result is claimed.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: bounded half-cycle asymmetry allocates steering within a stable traveling bend instead of imposing continuous static curvature
transferable_invariant: preserve the anterior phase anchor and posterior lag, infer phase from observed joint state, and spend a bounded target-derived residual only on the half-cycle aligned with the requested turn
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, robot or species kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: select the completed v41 controller that keeps v40's normalized body-frame collision-course signal and safety layers but applies its terminal residual through a mirror-equivariant gate derived from the observed lagged tail-wave side
falsification: reject if replication loses capture, the far-route locality, coherent wake, zero posterior hard-stop occupancy, or low-load class, or if the small arrival and projected-miss improvements do not repeat

## Pre-evaluation validation

- The solver candidate is byte-identical to the completed v41 sample (LF
  SHA-256 `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  This selects completed evidence and does not claim a same-worker CFD result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account.  Its three declared no-CFD checks
  were then run separately: reusable-guidance semantics passes after removing
  the duplicated assigned-parent marker from the rendered workspace README,
  the exact Julia public contract returns two finite accelerations, and the
  solver editable-boundary audit passes.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  A static forbidden-state scan finds only explanatory comments stating that
  route/world-frame signals are excluded.  No formal CFD was run.
