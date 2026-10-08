# Target-aligned tail-tangent saturation candidate

## Evidence and visual diagnosis before editing

- All four sampled solver examples satisfy the frozen Phase-2 contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  dynamics, and capture. Their trajectory and combined-keyframe hashes are
  identical. Three policies are byte-identical `v40`; the fourth is `v41`,
  whose nominal course/yaw selector remains hidden beneath the existing
  terminal allocation floor. The samples therefore reproduce one physical
  rollout, not four independent mechanisms: capture at `19.684490 T`, score
  `-0.261384287`, mean/final distance `2.151092787 L`/`0.748302400 L`, path
  length `12.951133 L`, and only `0.006661 L` of range backtracking.
- I inspected the sampled combined sheet from release through capture. The
  top-down row shows self-propelled compact target progress from quiescent
  water and a coherent alternating posterior wake; it is not passive
  advection. The oblique row shows finite localized Lambda2 structures
  following the body rather than a volume-filling instability. The fish
  enters the capture circle in the established quiet curved posture, with no
  collision, boundary exit, joint-stop dwell, or wake collapse. The metrics
  agree: `12/10/8/6/4/2/1 L` are first crossed at
  `3.806/7.838/10.543/13.057/15.444/17.809/19.162 T`.
- The assigned parent's evaluated `v45` action-preview allocator is the most
  informative active failure. Its one-step two-joint prediction slightly
  advances the first `10/8/6/4 L` crossings, but the top-down row then bends
  into long paired vorticity bands and a large loop around the target; the
  oblique row remains finite but follows that widened route. Capture is
  delayed to `44.863487 T`, score/mean distance regress to
  `-0.920008223`/`2.860142691 L`, path length grows to `30.566383 L`, and
  range backtracking grows to `4.456396 L`. Thus finite wake structure and a
  joint-kinematic one-step improvement do not predict useful hydrodynamic
  trajectory response.
- Complementary inherited results close nearby loci. Instantaneous
  posterior error-velocity credit forms a similar `45.848015 T` loop; a
  mature overload-gated `3%` cadence reduction delays capture to
  `20.322491 T`; and response-aligned posterior damping relief captures
  slightly earlier at `19.623991 T` but worsens mean distance to
  `2.152556228 L` and delays the middle approach from `4 L` inward. These
  results reject another scalar cadence/damping adjustment or a selector
  based on predicted posterior error.

## Policy hypothesis

Preserve `v40`'s state-feedback oscillator, posterior lag target, geometric
steering, existing response/course allocator, acceleration ceiling,
intercept-supported posture, and complete terminal law. Add one compact
actuator-coordinate mechanism after the existing outer allocator: when the
fish is already translating toward the target on a well-aligned body-frame
course, large-angle redirect is quiet, and independent clipping materially
removes the raw carrier's combined tail-tangent acceleration, form the
box-bounded two-joint command nearest the existing allocation that restores
that signed `q̈1 + q̈2` request. Transfer only a small continuous share toward
that projection.

This is not tail-only priority and does not add energy, cadence, amplitude,
phase lag, mean curvature, turn authority, or a new command. It protects one
coupled kinematic coordinate across both joints using the already requested
carrier acceleration, and is exactly silent at and below `4 L`, at low
target-course speed, during course misalignment or large redirect, and when
clipping does not remove a material tail-tangent request. The CFD hypothesis
is faster mature straight-course progress without changing the compact path,
alternating wake, or quiet terminal capture. It is falsified by dormancy,
terminal leakage, slower `10/4/2 L` crossings or capture, worse distance
integral, a widened path or loop, increased saturation or loads, joint-stop
dwell, instability, or degradation of either wake view.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and closed-loop robotic-fish CPG control
source_mechanism: preserve posterior/trailing-edge kinematics of a directed traveling bend while sensory feedback allocates bounded two-joint actuation
transferable_invariant: under actuator saturation, protect the signed coupled coordinate that drives tail-tangent acceleration without rewriting the traveling-wave target or assigning the posterior joint an isolated role
nontransferable_details: published gains, dimensional frequencies, Strouhal targets, species amplitude envelopes, exact phase lags, vortex timing, full-body waveforms, robot geometry, and task-specific routes
policy_translation: use normalized body-frame target-course speed and miss, redirect state, outer distance, clipping direction loss, and the raw two-joint carrier sum to gate a small convex transfer toward a box-bounded command that restores q1_ddot plus q2_ddot across both joints
falsification: reject if the branch is dormant or active at or below 4 L, delays or loses capture, worsens distance progress or loads, changes the compact path, causes joint-stop dwell or instability, or degrades the alternating top-down or localized oblique wake

## Candidate boundary

Only a target-aligned outer saturation projection may change. No formal CFD
result is claimed here because evaluation occurs after this worker exits.

## Deterministic pre-CFD activity check

Reconstructing the sampled `v40` observations and replaying both policies
changes `460/3579` two-joint outputs; `359` changes exceed
`1e-4 rad/T^2`. Activity spans the mature outer approach from
`5.967505 T`, `11.121426 L` through `15.345013 T`, `4.077243 L`, with
exactly zero changes among states at or below `4 L`. The maximum per-joint
same-state change is `0.092822 rad/T^2`, the mean active change is
`0.021384 rad/T^2`, and every output remains within the existing
`30.543262 rad/T^2` software ceiling. This establishes bounded independent
activity and exact terminal isolation, not hydrodynamic improvement.

## Static contract verification

- The semantic guidance check passes with a material evidence-backed update.
- The manifest's lightweight Julia check returns a finite two-joint action,
  and the solver editable-boundary check passes.
- A deterministic schema audit resolves all `97` direct
  `params.FIELD` references against the `98` fields returned by
  `target_policy_params()`; only metadata `version` is unreferenced.
- A deterministic grid of `6561` finite states remains finite and within the
  declared acceleration ceiling.
- The prescribed pinned `check-runner` was invoked after the edits, but its
  `gpt-5.4-mini` model is unavailable for this account and failed before
  executing a command. The manifest's three exact checks were therefore run
  separately as above. No formal CFD rollout was run.
