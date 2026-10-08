# Candidate diagnosis and hypothesis

## Evidence read before editing

- The four sampled solver evaluations and the assigned parent's latest
  inherited evaluation all satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture
  at `16.0544T` after 2,919 steps and 239 moving-window shifts. There is no
  termination-class failure in this allocation, so "failure" below means a
  controlled terminal regression relative to the repeated capture baseline.
- I inspected the combined sheets for the best sampled line-of-sight-slip
  controller, the repeated assigned-parent controller, and the inherited
  phase-selective regression, including their top-down vorticity and oblique
  body/Lambda2 rows. All show self-propelled translation on the same smooth
  target-directed arc, a coherent alternating wake, and compact 3D caudal
  structures through capture. There is no passive advection, reciprocal
  standing wiggle, wake breakup, collision, exit, or out-of-plane instability.
  The carrier, cruise route, redirect sign, posterior wave, approach scaffold,
  and exact-boundary projection should remain unchanged.
- Two source-distinct copies of the assigned-parent handoff plus yaw damper are
  trajectory-equivalent at final distance `0.745943L`, distance integral
  `1.929921L`, and score `-0.047001`. Adding a yaw-moment lead changes only the
  last 17 commands but remains effectively equivalent at `0.745938L`,
  `1.929917L`, and `-0.046995`. The assigned parent's inherited phase-selective
  yaw-relief attempt also changes only the terminal lobe and slightly regresses
  to `0.745945L`, `1.929923L`, and `-0.047003`. These results do not support
  another moment predictor, phase allocation, or scalar release-threshold edit.
- The informative positive sample instead exposes target-relative
  translational line rate separately from body yaw and subtracts at most one
  degree of posterior mean curvature when that slip reopens the body-frame
  bearing. It preserves the same arrival and wake while improving final
  distance to `0.745869L`, distance integral to `1.929859L`, and score to
  `-0.046924`. Trace comparison localizes its effect to the final 17 rows
  (`15.9664-16.0544T`, `0.842-0.746L`), with a maximum posterior-action change
  of `1.228 rad/T^2`. This is positive but terminal-scale evidence, not a new
  route or robustness result.
- At the assigned-parent crossing, normalized body-frame reconstruction gives
  bearing `0.1833 rad`, target-line translation rate `0.7895 rad/T`, and
  target-signed yaw `2.0919 rad/T`; both kinematic components therefore drive
  the same observed bearing reopening. The policy currently estimates and
  brakes the components separately even though `state.bearing_rate` directly
  measures their net target-relative consequence.

## One candidate

Replace the component-specific terminal yaw brake with one bounded posterior
line-of-sight-rate damper. It reads normalized body-frame bearing and measured
`bearing_rate`, and it acts only when proximity, target closing, a safe
straight-course intercept, and reopening alignment all agree. Its three-degree
curvature envelope combines—but does not stack beyond—the sampled two-degree
yaw and one-degree slip envelopes. The command remains reflection-odd, releases
immediately when bearing stops reopening, and is identically inactive on the
proven cruise route. This is a feedback-structure test, not scalar-only tuning.

Expected test: preserve the same capture class, arrival step, milestones,
239 shifts, coherent two-view wake, and pre-terminal actions while matching or
improving the sampled slip controller's crossing geometry and distance
integral. Reject the mechanism if the total-rate signal produces beat-noise
chatter, changes the route before `0.90L`, delays or loses capture, worsens
`0.745869L`/`1.929859L`, or materially increases limiting or load peaks.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish sensor modulation and terminal capture control
source_mechanism: preserve rhythmic propulsion while a bounded target-relative yaw/slip correction damps endpoint line-of-sight reopening
transferable_invariant: separate the productive traveling-wave carrier and route curvature from a continuously gated terminal response, and correct only the measured net target-relative angular drift without coasting early
nontransferable_details: published gains, clock-driven CPG phase, species-specific kinematics, dimensional frequencies, exact vortex phases, morphology envelopes, and source-task routes
policy_translation: retain the evaluated two-joint carrier, redirect handoff, wave shaping, and anterior release; inside the normalized body-frame closing capture corridor, subtract a bounded posterior mean bend signed by measured bearing rate only while bearing magnitude is reopening
falsification: reject if cruise milestones or coherent top-down/oblique wake change, capture is delayed or lost, the damper acts while alignment is closing or the intercept is unsafe, or crossing, distance integral, limiting, and load evidence do not match or beat the sampled separate yaw-plus-slip response

## Pre-evaluation verification

- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  commands were then run directly and separately: the material guidance/notes
  check, lightweight Julia policy contract, and solver editable-boundary check
  all pass. No CFD was run.
- The deterministic schema guard finds all 48 direct `params.FIELD` references
  in the 48-field object returned by `target_policy_params()`.
- Counterfactual evaluation on the assigned-parent trajectory leaves every
  anterior command and every action before `0.848L` unchanged. It changes 18
  posterior commands from `15.9609T` through capture, by at most
  `2.160 rad/T^2` versus the parent. Compared on those same recorded states with
  the sampled separate yaw-plus-slip controller, the new total-rate feedback
  differs by at most `0.496 rad/T^2`. This verifies bounded terminal support,
  not an unevaluated closed-loop outcome.
- A deterministic sweep of 306,180 paired body-frame states returns finite
  commands within the `31.416 rad/T^2` envelope, equal-and-opposite commands
  under lateral reflection to numerical tolerance, no outward command at the
  exact joint-speed boundary, and a finite non-finite-observation fallback.
