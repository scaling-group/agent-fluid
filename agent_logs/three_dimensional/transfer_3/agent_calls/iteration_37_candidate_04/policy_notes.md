# Low-speed propulsive-recruitment candidate

## Evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite moving-window dynamics, and `capture` termination. Their trajectory
  CSVs and combined sheets are byte-identical. Each captures at
  `19.684490 T`, scores `-0.261384287`, has mean/final distance
  `2.151092787 L`/`0.748302400 L`, follows a `12.951133 L` path, and triggers
  `243` moving-window shifts. Three samples are byte-identical `v40`; the
  fourth is source-different but behaviorally dormant.
- I inspected the complete combined sheet for a reproduced `v40` rollout and
  the inherited independently active signed course/yaw regression, including
  the top-down mid-plane-vorticity and oblique body/Lambda2 rows from release
  through capture. The release frame is quiescent. The fish self-propels on a
  compact target-directed arc while forming an alternating posterior wake;
  oblique structures remain finite and localized. There is no passive
  advection, collision precursor, boundary exit, out-of-plane motion, wake
  collapse, or numerical instability. The signed-yaw contrast is visually
  indistinguishable at sheet resolution and preserves the capture step but is
  numerically worse (`-0.261390567`, mean/final distance
  `2.151097816 L`/`0.748308659 L`), so it is a terminal allocation regression,
  not a new useful trajectory.
- Metrics isolate a slow momentum-acquisition interval without diagnosing a
  steering failure. While distance remains above `12 L`, the reproduced
  winner takes `3.801 T`, averages only about `0.179 L/T` center speed and
  `0.085 L/T` windowed closure, and already has `205/326` anterior/posterior
  commands above `30 rad/T^2`. It subsequently averages about `0.650 L/T`
  center speed from `12 L` to `8 L`, about `0.88 L/T` from `6 L` to `4 L`,
  and crosses `4 L` at `15.444014 T`. Thus simply demanding more static bend
  or shortening lag is not supported; any startup test must respect clipping
  and release once translation develops.
- Inherited completed tests establish that boundary. An outer mean-curvature
  addition changes only startup commands yet delays capture to `23.375013 T`
  through stable late mis-steering. Reducing the derivative-defined posterior
  lag creates a large loop, `31.012702 L` path, `607` moving-window shifts,
  and capture only at `46.145020 T`. Terminal joint-response, posture-energy,
  course/yaw, cadence-recovery, force-veto, and head-rate-predictor refinements
  also regress or remain dormant. The fixed lag, target-owned mean bend,
  response-conditioned outer allocator, and validated sub-`4 L` handoff are
  therefore protected.

## Candidate hypothesis

Add one independently active closed-loop mechanism: a small low-speed
frequency recruitment of the existing state-feedback oscillator. Support is
high only while normalized center speed is low, distance is outside the
protected `4 L` band, and the geometry-only large-angle redirect is quiet. It
vanishes smoothly as translation develops or a redirect is requested. The
mechanism does not alter oscillator amplitude, posterior lag, mean curvature,
turn residuals, saturation allocation, terminal posture, or command limit.

This tests whether faster wake establishment can shorten the evidenced
`3.8 T` momentum-acquisition interval without confusing startup propulsion
with steering. Same-state replay must show bounded activity in the low-speed
outer interval and exact inactivity at and below `4 L`; it cannot establish a
CFD improvement. The later rollout should be rejected if speed and distance
crossings do not advance, the compact route or terminal commands change
materially, the alternating/oblique wake loses coherence, high-command or load
incidence grows materially, capture is delayed or lost, joint-stop dwell
appears, or dynamics become unstable. The new CFD evaluation occurs only
after this worker exits and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and burst-to-cruise swimming control
source_mechanism: recruit an established rhythmic propulsor when sensed translation is weak, then release the recruitment continuously as locomotor response develops or steering takes priority
transferable_invariant: propulsion demand may depend on normalized measured locomotor response, but it should preserve the evidenced traveling-wave relation and yield to target-relative redirection
nontransferable_details: published oscillator gains and frequencies, dimensional speed thresholds, species-specific startup kinematics, prescribed burst durations, exact vortex phases, target coordinates, capture radius, and task-specific routes
policy_translation: retain the v40 body-frame oscillator and posterior target unchanged; add a bounded speed-supported frequency fraction gated by outer normalized range and the existing geometry-only redirect, with no clock or mutable phase
falsification: reject if replay activity is dormant or reaches the protected terminal band, or if CFD fails to advance momentum acquisition and capture without a changed route, increased clipping or loads, joint stops, instability, or degraded top-down or oblique wake coherence

## Deterministic pre-CFD replay

- Replaying the sampled parent states through both policies makes the new
  support independently active on `835/3579` states, from release through
  `4.818000 T` (`12.327689 L` to `11.662454 L`). Its maximum support is `1.0`;
  no command changes at or below `4 L`.
- The largest same-state command change is `3.093287 rad/T^2`, RMS vector
  change over active states is `1.029333 rad/T^2`, and all candidate outputs
  remain within the existing `30.543262 rad/T^2` software limit. Mean/max
  sine of the parent-to-candidate command-direction change is only
  `0.01330/0.07340`, consistent with cadence recruitment rather than a new
  steering vector.
- On the fixed parent states, global `|action|>30 rad/T^2` counts change from
  `1369/1973` to `1384/1970` anterior/posterior. This small same-state shift is
  not a claim about closed-loop loads and remains an explicit CFD
  falsification boundary. Replay proves activity, boundedness, and terminal
  noninterference only.

## Non-CFD validation

- The prescribed check-runner was invoked after the material edits, but its
  pinned `gpt-5.4-mini` model is unavailable on this account and failed before
  executing a check. Its three configured commands were then run directly and
  separately: the material guidance/notes check, exact finite two-output Julia
  contract, and solver edit-boundary check all pass. The duplicate rendering
  of the same assigned-parent marker in `README.md` was removed so the first
  check could resolve the unchanged assigned parent uniquely.
- A separate deterministic schema audit resolves all `91` direct
  `params.FIELD` references against the `92` fields returned by
  `target_policy_params()`; only the version label is intentionally unused.
  No formal CFD was run in this workspace.
