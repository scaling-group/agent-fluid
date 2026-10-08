# De-gaited terminal course-shape candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Two byte-identical v50 evaluations reproduce the strongest
  result at `17.41299 T`, score `-0.0595203`, final distance `0.745094 L`, and
  total/observed distance integrals `1.945327/1.329976 L`.
- The prefilled shared-route course controller is the strongest negative
  comparison.  It captures at the same logged step but regresses to score
  `-0.0599362`, final distance `0.745498 L`, and total/observed integrals
  `1.945663/1.329978 L`.  The sampled posterior-only raw-course comparator is
  less harmful but still fails to beat v50: score `-0.0595473`, final distance
  `0.745115 L`, and integrals `1.945350/1.329982 L`.  Thus neither sending the
  instantaneous cue through the yaw-rate loop nor merely moving it to the tail
  establishes useful course authority.
- I inspected the combined sheets for reproduced v50 and both raw-course
  comparators from release through capture.  Their top-down rows show active
  self-propulsion on the same smooth target-signed arc behind a coherent
  alternating street; there is no passive advection, reversal, collision,
  boundary exit, or visible wake collapse.  The v50 oblique row has an
  unreadable middle keyframe, while both course comparators show readable
  paired caudal Lambda2 structures at that stage and capture.  The added
  readability reveals no beneficial three-dimensional topology and does not
  overturn the distance regression.
- A frozen-state reconstruction of the reproduced v50 trace identifies why the
  instantaneous course cue is noisy.  In the controller's gait frame, a linear
  combination of the already mean-preserving carrier tail tangent and observed
  tail-tangent rate explains about `95.6%` of lateral-velocity variance from
  `4-14 T`.  Raw course-slip standard deviation remains about `0.29-0.31` over
  `12-17.5 T`; subtracting the fitted odd carrier component reduces the
  reconstructed course-slip standard deviation to about `0.03` and leaves a
  consistent target-signed mean near `-0.25`.  This is offline signal evidence,
  not a closed-loop improvement claim.

## One-candidate policy hypothesis

Restore the completed v50 policy and add exactly one mechanism: de-gait terminal
course feedback before it reaches the small posterior wave-shape residual.
Rotate body velocity into the same carrier-rejected frame as the target vector,
subtract the reflection-odd lateral recoil predicted by the existing
mean-preserving carrier tail tangent and its observed rate, and form a normalized
target/velocity cross product from the residual.  Gate that cue by normalized
terminal approach, positive closing response, observed carrier motion, and the
existing redirect release.  Do not alter anterior steering, route curvature,
redirect logic, cadence, launch response, carrier-first spillover, or actuator
projection.

The next CFD evaluation should retain v50 capture and the coherent two-view wake
while improving final radial crossing or either distance integral without
raising the sampled speed, saturation, force, or moment envelope.  Reject the
mechanism if it repeats either raw-course regression, merely shifts gait phase,
delays or shallows capture, increases posterior clipping, or degrades the
organized wake.  Formal CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: separate persistent direction error from rhythmic self-induced lateral motion before applying a bounded residual to the propulsive oscillator
transferable_invariant: a productive traveling wave should remain intact while feedback rejects its observable carrier-synchronous component and acts only on the slower response-coherent course residual
nontransferable_details: published gains, dimensional cadence, robot morphology, species-specific kinematics, clocked oscillator phase, exact vortex phases, and task-specific routes
policy_translation: rotate normalized body-frame target and velocity into the existing carrier-rejected gait frame, subtract lateral recoil estimated from mean-preserving tail tangent and rate, and gate the remaining odd course cue into only the terminal posterior wave-shape residual
falsification: reject if v50 capture or either distance integral regresses, the cue remains carrier-correlated, posterior limit residence grows without closure benefit, the target-signed route changes, or complete two-view evidence loses wake coherence
```

## Evidence boundary

Outcome claims come only from the assigned-parent guidance, sampled completed
solver results, inherited optimizer notes, and frozen-state reconstruction of
their recorded traces.  The candidate below has no same-worker CFD evidence.

## No-CFD implementation audit

- The sole materialized policy is
  `dogfish_target_control_v54_degaited_posterior_course_shape`, SHA-256
  `3d64b50a4370ac526abcfe2c6375d4dd3fcabacbefa6f594f4809caa02996eb2`.
  Its terminal residual is posterior-only, remains within final componentwise
  projection, and a synthetic far-state comparison is exactly action-identical
  to reproduced v50.
- All `72` distinct direct `params.FIELD` references resolve among the `74`
  fields returned by `target_policy_params()`.  Synthetic terminal and mirrored
  states produce finite bounded actions, leave the anterior action unchanged
  relative to v50, and reverse the added posterior residual's direction.
- The material-guidance check, lightweight Julia policy contract, and solver
  editable-boundary check pass.  The required check-runner was invoked, but its
  pinned `gpt-5.4-mini` model is unavailable for this ChatGPT account; its three
  exact no-CFD commands were then run locally and separately.  The guidance
  check first exposed a duplicated assigned-parent marker in the rendered
  workspace `README.md`; removing only that duplicate repaired provenance.
  No formal CFD was run.
