# Intercept-unsupported terminal carrier recovery

## Evidence and visual diagnosis before the policy edit

- All four root samples satisfy the frozen Phase-2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture. The two `v37` samples
  are exact reproductions at `19.612991 T`, score `-0.282941223`, mean
  distance `2.172435105 L`, and final distance `0.748660505 L`. The `v38`
  course-supported sample captures at `19.998001 T`, score `-0.271582682`,
  mean distance `2.162124221 L`, and final distance `0.747272313 L`.
- The assigned `v39_geometry_agreed_course_allocation` parent is the strongest
  scalar and distance-integral result: it captures at `19.783508 T`, improves
  score to `-0.262179959` and mean distance to `2.151933490 L`, and crosses
  `4/3/2/1 L` at `15.444014/16.620995/17.803501/19.189503 T`, earlier than
  both `v37` and `v38`. Geometry sign agreement therefore survives its first
  CFD test as a useful allocation mechanism, even though it is not uniformly
  best on every terminal measure.
- The parent's final approach exposes a distinct weakness. Its time from the
  `1 L` crossing to capture is about `0.594 T`, versus `0.380 T` for `v38`
  and `0.297 T` for `v37`; final distance is only `0.000933 L` inside the
  capture boundary. At capture its normalized center-course error is about
  `1.109 rad`, predicted cross-track miss is about `0.671 L`, target angle is
  about `1.307 rad`, and joint rates and commands have settled to roughly
  `-0.215/-0.026 rad/T` and `0.166/0.951 rad/T^2`. This is a quiet,
  intercept-unsupported coast after a fast approach, not a demand for more
  outer steering.
- I inspected the parent's combined and view-specific sheets from release to
  capture. The top-down view shows self-propulsion, a compact target-directed
  path, and coherent alternating vortex shedding; the oblique view shows
  finite localized Lambda2 structures. There is no passive advection, wake
  collapse, boundary precursor, or out-of-plane instability. Below `4 L` the
  parent has `318/373` commands above `30 rad/T^2` and finite force/moment
  maxima about `0.03017/0.01564`, so a terminal change must remain small and
  must not disturb the proven outer wake.
- The inherited `v39_closure_released_course_allocation` log is the informative
  failure. Releasing course priority when short-window closure approached
  center speed produced a large visible loop, `30.58 L` path length, capture
  only at `44.885483 T`, score `-0.936939307`, and mean distance
  `2.877117766 L`. Its top-down and oblique sheets remain finite and coherent,
  so the regression is specifically route-control failure rather than lost
  propulsion or solver instability. The roughly `0.04 T` observation window
  is much shorter than the `0.55 T` beat; instantaneous closure efficiency is
  not a safe achieved-response release cue for the outer allocator.

## Policy hypothesis

Preserve the evaluated `v39` oscillator, geometry-agreed outer allocator,
target residual, mean bend, closure preview, and center-intercept predictor.
Add one disjoint terminal mechanism: after the two-joint redirect equilibrium
has settled and proximity is below the existing `1.6 L` relief onset, use the
complement of the existing center-intercept support to recover at most six
percent of the carrier that terminal redirection removed. The gate is zero in
the validated intercept-supported glide and outside the near band; it adds no
new turn sign, cadence, route memory, or acceleration limit.

The expected effect is to retain `v39`'s early crossings and coherent wake
while preventing the high-miss terminal state from becoming a nearly passive
held-bend coast. The mechanism is supported only if it is independently
active on the parent trajectory, leaves states outside `1.6 L` and all
intercept-supported states unchanged, preserves capture, improves the last
`1 L` crossing or distance integral, and does not materially raise terminal
loads or actuator contact. Falsify it on dormancy, pre-terminal command
changes, renewed carrier in the validated intercept corridor, slower or lost
capture, worse mean/final distance, a loop, joint-stop dwell, load growth,
instability, or degradation of either wake view. The new CFD evaluation occurs
after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal capture scheduling
source_mechanism: continuously retain bounded rhythmic propulsion when a settled steering posture has not produced an acceptable target-relative intercept
transferable_invariant: a near-target equilibrium redirect may reduce rhythm only while measured translation remains inside the capture corridor; an independently observed miss should smoothly restore a small coordinated carrier component
nontransferable_details: published gains, dimensional cadence, full-body waveforms, species-specific kinematics, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: below the normalized near band, combine settled two-joint tracking with the complement of the existing body-frame center-intercept support to reduce terminal carrier removal by a bounded fraction; preserve the outer allocator and shared mean bend
falsification: reject on dormancy, any change outside the near band or inside the supported intercept corridor, slower or lost capture, worse distance integral, a loop, renewed joint-stop dwell or saturation, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the assigned parent's stored trajectory as reconstructed
  body-frame states changes `80` of `3597` commands, all in the intended near,
  intercept-unsupported regime. The maximum same-state command difference is
  about `0.0730 rad/T^2`; all states at or beyond `1.6 L` and every state with
  full center-intercept support are exactly parent-identical. The realized
  recovery gate reaches about `0.0430` of its bounded `0.060` ceiling, so the
  mechanism is active but retains response and proximity modulation.
- A deterministic `306180`-state grid spanning range, target/course angle,
  speed, both joint positions and rates, and closure finds `1206` active
  differences. Every output is finite and within the declared acceleration
  limit, and every state at or beyond `1.6 L` is exactly parent-identical.
  These are same-state activity and noninterference checks, not CFD evidence.
- The lightweight two-output policy contract, the deterministic parameter
  schema (`88` direct references resolved by `89` returned fields), guidance
  materiality, and solver edit-boundary checks pass. The prescribed
  check-runner was invoked, but its pinned `gpt-5.4-mini` model is unsupported
  on this ChatGPT account; its three non-CFD checks were therefore run directly
  and separately. No formal CFD was run in this workspace.
