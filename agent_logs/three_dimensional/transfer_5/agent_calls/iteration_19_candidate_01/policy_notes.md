# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before candidate selection

- The assigned-parent guidance, all four sampled solver results, and inherited
  optimizer notes/results were read before selecting the candidate. Every
  compared rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, without cylinders or prewarm, remained finite, and
  terminated in capture. The four sampled solver artifacts are byte-identical
  copies of evaluated v33, so they provide repeat evidence for one mechanism,
  not four independent controller comparisons.
- The combined v33 and assigned-parent v35 keyframe sheets were inspected from
  release to capture in both the top-down mid-plane and oblique 3D Lambda2
  views. Both initially empty fields develop coherent alternating vortex
  streets and compact paired 3D structures behind fish that visibly
  self-propel along the same broad target-directed arc. Neither run shows
  advection-only motion, wake breakup, a distinct route, or instability; the
  controller difference is below the visual sheets' resolution.
- Sampled v33 captures at `23.8425T` with score `-0.535091`, scoring mean/final
  distance `2.433543/0.746165L`, and inside-`3L` mean/peak absolute yaw
  `1.6800/3.1848 rad/T`. Its mean/peak absolute yaw moment is
  `0.006382/0.013730`, mean body-lateral speed is `0.2522U`, and its coherent
  posterior traveling wave has no joint-angle-limit exposure.
- Assigned-parent v35 added a `0.30` share of full-tail tangent rate to v33's
  instantaneous carrier observer. It did improve inside-`3L` mean/peak yaw to
  `1.6103/3.0497 rad/T`, mean body-lateral speed to `0.2391U`, and mean moment
  to `0.006106`. However, peak moment rose slightly to `0.013912`; score,
  arrival, mean distance, and final distance regressed to `-0.535811`,
  `23.8975T`, `2.434232L`, and `0.746866L`. Joint-angle, joint-speed, and
  projected-command envelopes were essentially unchanged. The trajectory is
  identical to v33 until the existing `3L` terminal gate, then loses closing
  progress despite the cleaner yaw history.
- Thus v35 is a measured regulation-for-progress trade rather than evidence
  for further two-joint observer-share tuning. Its prior replay reduction in
  residual RMS/correlation was real as signal processing, but did not predict
  better closed-loop capture. Across v34 and v35, two different ways of
  suppressing terminal motion reduce yaw/slip while worsening distance
  progress; v33 remains the strongest sampled balance.

## Candidate hypothesis recorded before policy disposition

Retain the exact evaluated v33 anterior-half-cycle controller already present
in `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`. This is a
single evidence-backed exploit candidate, not a claim that an unevaluated
mechanism improves CFD. It preserves the coherent state-feedback traveling
wave, response-released body-frame C-bend, continuous target-course feedback,
phase-selected anterior excess-yaw residual, unchanged posterior amplitude and
lag, and component-wise smooth command projection.

Do not inherit v35's distributed instantaneous rate observer, and do not add a
new scalar rate share or another cue-arbitration gate to rescue it. The
falsifiable expectation is reproduction of v33-scale capture, distance
progress, terminal yaw/load, and actuator exposure. A materially different
rollout from the byte-identical sampled artifact would instead indicate
evaluation nondeterminism or a materialization mismatch and should be audited
before attributing the difference to control.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive thrust, adaptive swimming, and terminal capture control
source_mechanism: preserve posterior traveling-wave authority and apply only the smallest target-relevant correction instead of cancelling every lateral motion
transferable_invariant: when stronger carrier rejection reduces yaw but also reduces target closure, preserve the validated propulsive wave and its bounded phase-selected anterior correction until a new observation distinguishes harmful motion without erasing useful impulse
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: no new shelf primitive is adopted; retain v33's normalized body-frame target feedback, state-derived tail-side phase, two-joint actuation, posterior lag, and bounded anterior residual exactly as evaluated
falsification: reject the retained artifact only if it fails to reproduce capture and v33-scale distance, yaw/load, wake-coherence, and actuator metrics under the same frozen evaluation contract
```

The shelf was used as a mechanism filter, not as support for scalar-only gain
tuning. No formal CFD was run in this worker; the retained candidate's new
evaluation becomes evidence for a later generation.

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and it failed before
  inspecting the workspace. Its prescribed deterministic commands were then
  run directly.
- The guidance/materiality check initially found the same assigned parent
  marked twice in the rendered `README.md`. Removing only the duplicate marker
  made parent resolution unambiguous; the rerun passes and confirms that these
  notes exist and `guidance/control_experience.md` has a material reusable
  update.
- The solver boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`; its SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  byte-identical to the evaluated sampled v33 artifact.
- The exact Julia contract smoke test cannot start because no `julia`
  executable is installed. A deterministic static schema audit finds all 68
  direct `params.FIELD` references declared by `target_policy_params()`, and
  the evaluated-artifact identity supplies prior execution evidence for the
  unchanged policy. No CFD was run.
