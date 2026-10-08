# Reproduced intercept-supported terminal posture candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite free-surge/sway/yaw moving-window dynamics, and
  capture. There is no failure termination, so the weakest capture is the
  informative regression rather than a distinct failure class.
- The sampled `v40_intercept_supported_terminal_posture` is strongest: it
  captures at `19.684490 T`, scores `-0.261384287`, and has mean/final
  distance `2.151092787 L`/`0.748302400 L`. Its small actual-distance,
  closure-, and center-intercept-supported handoff also retains no joint-stop
  dwell. The nominally different course-worsening response policy produces a
  byte-identical trajectory and combined keyframe sheet, independently
  reproducing that behavior while establishing that its extra yaw/course
  branch is dormant on the realized rollout.
- The assigned prefill adds terminal command-ratio coordination to `v40`.
  It retains the same `4 L` crossing (`15.444014 T`) but delays capture to
  `19.728489 T`, regresses score/mean/final distance to `-0.261932556`,
  `2.151649804 L`, and `0.748698652 L`, and changes the final head position
  and heading from `(9.67723,9.18170)L`/`0.76678 rad` to
  `(9.66390,9.15389)L`/`0.78062 rad`. Its slightly lower high-command counts
  and similar finite load envelope therefore do not establish useful terminal
  coordination.
- The response-opposed posture increment is also active but worse: it captures
  at `19.722988 T`, scores `-0.261856310`, and reaches `0.748641372 L`.
  Together with the assigned-parent result, the sampled evidence rejects both
  more posture allocation and terminal carrier-ratio repair as improvements
  to the already supported handoff.
- I inspected the complete combined sheets for the strongest `v40` rollout and
  weakest assigned-parent rollout, including every top-down mid-plane
  vorticity and oblique body/Lambda2 keyframe from release through capture.
  Both fish visibly self-propel from direct-uniform quiescent water along the
  same compact target-directed arc, shed a coherent alternating posterior
  wake, and retain finite localized three-dimensional structures. Neither
  shows passive advection, a loop, collision, boundary-exit precursor, wake
  collapse, numerical instability, or out-of-plane motion. The visual
  difference is too small to justify a new propulsion or disturbance-rejection
  mode; trajectory and load diagnostics locate the regression in terminal
  command shaping.
- Inherited optimizer logs show that `v40` was itself a semantic improvement
  over `v39`: it preserved the outer `4 L` crossing, advanced capture by about
  `0.099 T`, improved score and distance integral, and reduced terminal
  high-command incidence through a compact, independently active posture
  handoff. Current evidence now adds an exact behavioral reproduction plus two
  concrete same-regime regressions.

## Policy hypothesis

Use the evaluated `v40_intercept_supported_terminal_posture` controller
exactly as the single candidate. Relative to the assigned prefill, remove only
the unevidenced terminal command-ratio coordination and retain the reproduced
state-feedback oscillator, geometry-agreed outer allocator, center-course
intercept, closure preview, bounded mean-curvature equilibrium, carrier floor,
and actuator limit. This is winner adoption from completed CFD evidence, not a
new scalar variant: no cadence, gain, authority, observation, target geometry,
world coordinate, clock, route, case identity, or beat/vortex phase is added.

The expected result is reproduction of the compact `v40` trajectory, coherent
two-view wake, capture near `19.6845 T`, score near `-0.2613843`, and absence
of joint-stop dwell. Falsify this selection if an exact policy reproduction
does not reproduce materially, loses or delays capture, worsens the distance
integral, raises terminal saturation or loads, becomes unstable, or degrades
either wake view. The new CFD evaluation occurs only after this worker exits
and is not claimed here.

bookshelf_consulted: true
source_domain: continuous terminal approach-hold control and closed-loop CPG robotic-fish direction tracking
source_mechanism: hand off continuously from rhythmic propulsion to a bounded posture only when observed range, closure, and target-relative intercept geometry support the approach
transferable_invariant: a terminal posture correction that shares rhythmic actuators should remain a small state-gated allocation, and added response or clipping logic should be removed when completed rollouts show dormancy or worse capture
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: adopt the reproduced normalized body-frame `v40` controller and remove the prefill's regressive terminal common-ratio blend while retaining the existing two-joint intercept-supported posture target
falsification: reject on non-reproduction, slower or lost capture, worse distance integral, renewed joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The candidate is byte-identical to the strongest evaluated `v40` solver
  sample (shared SHA-256
  `624f4cec48f1a4c8d2eada4f72269efd16c22d4785955a09cd208447208cd659`),
  while `solver/` retains only the designated editable candidate surface.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this ChatGPT account and failed before executing a
  command. I therefore ran its three configured non-CFD checks directly. The
  guidance check first exposed the inherited duplicate assigned-parent marker
  in the rendered root `README.md`; removing only that duplicate marker made
  the material-guidance check pass. The lightweight Julia contract returns two
  finite accelerations, and the repository boundary check passes.
- The supplemental deterministic schema audit resolves all `88` direct
  `params.FIELD` references against the `89` fields returned by
  `target_policy_params()`; only the version label is intentionally unused.
  No formal CFD was run in this workspace.
