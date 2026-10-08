# Candidate diagnosis and policy hypothesis

## Evidence read before candidate selection

- I read the assigned-parent guidance, all four sampled solver artifacts, and
  the inherited optimizer notes and completed results before selecting the
  candidate. Every sampled rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, with no cylinders or prewarm, remained finite, and
  ended in capture.
- The four sampled policies and combined keyframe sheets are byte-identical
  v33 repeats. Each captures at `23.8425T`, with score `-0.535091`, scoring
  mean/final distance `2.433543/0.746165L`, and `236` moving-window shifts.
  They establish deterministic evidence for one controller rather than four
  independent mechanisms.
- I inspected the sampled combined sheet from release through capture in both
  rows. The top-down row begins in an empty quiescent field and develops an
  orderly alternating vortex street behind a fish translating toward the
  target. The oblique row develops compact paired Lambda2 structures along
  the same curved path. This is self-propulsion, not background advection;
  neither row shows wake breakup, boundary contact, or numerical instability.
  The terminal frames retain the coherent carrier but show a pronounced bend
  and transverse motion at the capture sphere.
- I also inspected the distinct inherited v37 distributed-observer sheet as
  the informative failure. Its top-down and oblique wake topology is visibly
  as coherent as v33, so vortex prominence does not identify the regression.
  The trajectory does: adding `0.17*(phi_dot[1]+phi_dot[2])` to the
  carrier-rejected yaw estimate delayed capture by `0.0275T` to `23.8700T`
  and worsened score/mean/final distance to
  `-0.536789/2.434939/0.747952L`.
- The v37 observer did clean the instantaneous terminal trace: inside `3L`,
  mean/peak absolute yaw fell from v33's `1.6800/3.1848 rad/T` to
  `1.5977/3.0499 rad/T`. But mean radial closure fell from `0.6814` to
  `0.6752L/T`, mean absolute tail-tangent angle/rate fell from
  `0.3545 rad`/`3.1792 rad/T` to `0.3347 rad`/`3.0305 rad/T`, and peak
  absolute moment rose slightly from `0.013730` to `0.013876`. Thus the
  offline decorrelation that motivated v37 removed motion that was useful to
  target progress; a cleaner observer or yaw history is not itself a better
  closed-loop controller.
- This joins the inherited v34-v36 regressions from fixed allocation,
  distributed carrier cancellation, and regulation-driven cadence. The
  evidence supports preserving v33's carrier, continuous course bend, and
  anterior phase-selected correction. It does not support another scalar
  gain, posterior relief, cadence reserve, observer-share, or load gate.

## Single candidate and falsifiable hypothesis

Retain the exact evaluated v33 controller already materialized at
`solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl` as this
workspace's one exploit candidate. It preserves the state-feedback traveling
wave, response-released body-frame C-bend, continuous target-course feedback,
posterior amplitude and lag, phase-selected anterior excess-yaw correction,
and component-wise smooth acceleration projection.

The falsifiable hypothesis is reproducibility of the strongest completed
progress/regulation balance. Under the frozen evaluation, the policy should
retain capture, its coherent alternating wake, v33-scale arrival and distance
integral, and its established yaw/load and actuator-envelope behavior. If the
byte-identical candidate does not reproduce that result, audit evaluation or
materialization nondeterminism before attributing the change to a controller
mechanism. No same-worker CFD result is claimed.

The fish-control bookshelf was consulted because three consecutive completed
follow-ups lacked a semantic improvement. Its carrier/correction separation
was used as a decision boundary; no new primitive or shelf-derived scalar is
adopted because the closed-loop evidence favors the existing mechanism.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior traveling-wave power stroke and separate it from bounded target-derived correction
transferable_invariant: terminal regulation is useful only when it preserves target closure, so periodic body motion should not be cancelled merely to clean an instantaneous yaw residual
nontransferable_details: published gains, dimensional cadence, hardware duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: retain v33's normalized body-frame target feedback, state-derived tail-side phase gate, bounded anterior correction, posterior amplitude and lag, and two-joint state-feedback contract exactly as evaluated
falsification: reject if v33-scale capture and distance progress are not reproduced, wake coherence is lost, terminal yaw or moment worsens materially, or actuator-limit exposure grows
```

Formal CFD is intentionally deferred to the post-worker evaluator.

## Validation boundary

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before it
  could inspect the workspace. I therefore executed its three prescribed
  checks separately.
- The guidance-materiality check passes: these notes exist and
  `guidance/control_experience.md` contains a semantic reusable update from
  the assigned parent. The solver boundary check also passes.
- Exactly one nonempty `candidate_target_policy.jl` exists under `solver/`.
  Its SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  byte-identical to every sampled evaluated v33 policy.
- The prescribed Julia contract smoke test cannot start because no `julia`
  executable is installed. A deterministic schema audit finds all `68`
  direct `params.FIELD` references among the `70` fields returned by
  `target_policy_params()`, with no undeclared reference; only metadata fields
  `version` and `control_period` are intentionally unused. Static guards find
  no executable clock/step input, randomness, file I/O, mutable global state,
  cylinder identity, or memorized route. No formal CFD was run.
