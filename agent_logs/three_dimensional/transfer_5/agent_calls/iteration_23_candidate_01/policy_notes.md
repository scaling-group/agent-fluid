# Candidate diagnosis and policy hypothesis

## Evidence read before candidate selection

- I read the assigned-parent guidance, all four sampled solver artifacts, and
  the inherited optimizer notes and completed results before choosing the
  candidate. Every sampled evaluation used direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite, and ended
  in capture.
- The four sampled solvers are byte-identical evaluations of v33: both their
  policy SHA-256 and combined-keyframe SHA-256 match. Each captures at
  `23.8425T`, with score `-0.535091`, scoring mean/final distance
  `2.433543/0.746165L`, and `236` moving-window shifts. They are deterministic
  repeat evidence for one controller, not four independent mechanisms.
- I inspected the combined sheet and both view-specific sheets from release to
  capture. The top-down row starts from an empty still-water field, then shows
  the fish translating toward the target under its own actuation while leaving
  a spatially ordered alternating vortex street. The oblique 3D row develops
  compact paired Lambda2 structures behind the moving body and retains them
  through the curved terminal approach. The motion is self-propelled rather
  than background advection; neither view shows wake breakup, boundary exit,
  collision, or instability. The final frames do show a pronounced body bend
  and transverse motion as the head crosses the capture sphere.
- The diagnostics support that visual diagnosis. Inside `3L`, v33 has
  mean/peak absolute yaw `1.6800/3.1848 rad/T`, mean body-lateral speed
  `0.25221U`, and mean/peak absolute yaw moment `0.006382/0.013730`. Its
  anterior/posterior `99%` joint-speed-cap exposure is `14.28%/5.72%`, with a
  maximum joint angle of `0.6156 rad`, maximum recorded joint speed at the
  `4.5379 rad/T` cap, maximum projected command `31.3855 rad/T^2`, and final
  yaw still `1.3803 rad/T`. Propulsion and broad routing work; oscillatory
  terminal regulation remains imperfect.
- The assigned-parent lesson reports that the earlier posterior same-path
  counter-tangent improved arrival but worsened terminal yaw and load. The
  inherited completed v33 result supplies the positive actuator reallocation:
  moving the phase-selected residual to the anterior oscillator while keeping
  posterior amplitude and lag improved score/mean/final distance over v30 and
  reduced peak yaw and moment. Later mechanisms did not improve that balance.
  V34's fixed course-curvature transfer reduced yaw but regressed score to
  `-0.535920`; v35's distributed carrier observer reduced mean yaw to
  `1.6103 rad/T` but delayed capture to `23.8975T` and regressed score to
  `-0.535811`; v36's regulation-coupled cadence crossed one `0.0055T` control
  step earlier but worsened score to `-0.535652` and slightly worsened mean
  terminal yaw and moment. The inherited posterior-relief result also regressed
  score to `-0.535956`. No distinct failed keyframe sheet is present in this
  workspace, so those informative failures are used only through their
  completed trajectory and load evidence, not unsupported visual claims.

## Single candidate and falsifiable hypothesis

Retain the exact evaluated v33 policy already materialized at
`solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl` as this
workspace's one exploit candidate. It preserves the state-feedback
traveling-wave carrier, response-released body-frame C-bend, continuous
target-course correction, observed-tail-side anterior half-cycle residual,
posterior amplitude and lag, and component-wise smooth acceleration projection.
Do not inherit the failed observer, fixed allocation, posterior relief, cadence
reserve, or a smaller scalar variant of any of them.

The hypothesis is reproducibility of the strongest completed joint
progress/regulation result. Under the frozen evaluation, the candidate should
retain capture, the coherent alternating wake, v33-scale arrival and distance
integral, and its yaw/load and actuator-envelope behavior. Falsify
materialization if the byte-identical policy fails to reproduce those metrics;
audit nondeterminism or materialization mismatch before attributing a change to
a new controller mechanism. No same-worker CFD result is claimed.

The shelf was consulted again because the completed v34-v36 sequence produced
no new semantic success. It was used as a mechanism filter; adopting another
primitive is optional, and the completed negative evidence outweighs an
unevaluated scalar or actuator-share variant.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and sensor-modulated robotic-fish CPG control
source_mechanism: preserve posterior traveling-wave thrust while applying only the smallest observed-phase target-derived correction supported by closed-loop evidence
transferable_invariant: terminal regulation is useful only when it retains target closure, so a coherent posterior carrier should not be suppressed or overdriven merely to clean one yaw diagnostic
nontransferable_details: published gains, dimensional cadence, hardware duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: retain v33's normalized body-frame target feedback, state-derived tail-side phase gate, bounded anterior correction, posterior amplitude and lag, and two-joint state-feedback contract exactly as evaluated
falsification: reject if v33-scale capture and distance progress are not reproduced, wake coherence is lost, terminal yaw or moment worsens materially, or actuator-limit exposure grows
```

Formal CFD is intentionally deferred to the post-worker evaluator.

## Validation boundary

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before
  inspecting the workspace. I therefore ran its prescribed deterministic
  checks directly and separately.
- The guidance-materiality check initially found the same assigned parent
  marked twice in the rendered workspace `README.md`. Removing only that
  duplicate marker made the parent unambiguous; the rerun passes and confirms
  that these notes exist and `control_experience.md` has a semantic reusable
  update.
- The solver boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`, with SHA-256
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  byte-identical to every sampled evaluated v33 policy.
- The Julia contract command cannot start because no `julia` executable is
  installed. A deterministic schema audit finds all `68` direct
  `params.FIELD` references among the `70` fields returned by
  `target_policy_params()`, with no undeclared reference; only metadata fields
  `version` and `control_period` are intentionally unused. Static guards find
  no executable time/step input, randomness, file I/O, mutable global state,
  cylinder identity, or memorized route. The byte-identical sampled rollout
  supplies prior runtime evidence; no formal CFD was run.
