# Split course/phase carrier-observer exploit

## Evidence diagnosis before editing

- I read the assigned-parent guidance, all four sampled solver results, and the
  inherited optimizer notes before selecting a controller. Every sampled CFD
  run used direct uniform still water at `U_infinity=(0,0,0)`, no cylinders and
  no prewarm, stayed finite, and terminated in capture. The four artifacts are
  two duplicate pairs: two exact v33 evaluations and two independently written
  implementations of the same split course/phase observer. The latter have
  different policy hashes and diagnostic names but bit-identical trajectories
  and keyframe sheets, so they supply replicated physical evidence for one
  mechanism rather than two separate gains.
- Before editing, I inspected the best split-observer and weaker v33 combined
  sheets from release through capture, including each top-down mid-plane
  vorticity row and oblique 3D body/Lambda2 row. Both initially empty fields
  develop a strong, spatially ordered alternating vortex street and compact
  three-dimensional structures behind a translating fish. They follow the
  same broad target-directed arc and retain the wake through the terminal bend;
  neither shows passive advection, wake breakup, a boundary encounter,
  collision, or instability. Their difference is below the sheets' visual
  resolution, so the trajectory and load histories decide the comparison.
- The split observer preserves capture while improving score from
  `-0.53509095` to `-0.53501328`, crossing one control step earlier at
  `23.8370T` instead of `23.8425T`, and improving scoring mean/final distance
  from `2.433543/0.746165L` to `2.433468/0.746096L`. Inside `3L`, mean absolute
  yaw and target-cross-track speed improve slightly from `1.67999 rad/T` and
  `0.23924U` to `1.67938 rad/T` and `0.23868U`; peak cross-track speed improves
  from `0.57194U` to `0.56914U`, and peak absolute moment from `0.013730` to
  `0.013581`. The boundary is mixed: peak yaw rises from `3.18484` to
  `3.19386 rad/T` and mean absolute moment from `0.0063824` to `0.0063875`.
  Both joint-speed exposures and the smoothly projected acceleration envelope
  remain essentially unchanged, with no joint-angle-limit contact.
- This result resolves the inherited whole-path observer regression. Applying
  the distributed joint-rate estimate to both the continuous course brake and
  the phase residual had reduced yaw but delayed capture and worsened distance.
  The sampled positive design keeps the established anterior-only course
  response and uses `0.17*(phi_dot[1]+phi_dot[2])` only to classify the small
  beat-side anterior correction. Thus it preserves route closure while
  suppressing some carrier-synchronous residual action. The gain was inherited
  from the tested hypothesis; this worker does not retune it.
- The final failure-boundary audit also inspected the inherited whole-path
  observer-regression sheet in both views. It retains the same coherent,
  self-propelled wake topology, confirming that its mechanism failure is the
  measured regulation-for-progress trade rather than wake collapse.

## Single candidate hypothesis

Materialize the evaluated split course/phase observer exactly as the one
candidate. Preserve v33's normalized body-frame target geometry,
response-released C-bend, continuous anterior-only course brake, posterior
traveling-wave amplitude and lag, cadence, actuator allocation, and smooth
component-wise command projection. Add the distributed full-tail tangent rate
only to the existing phase observer that selects the bounded anterior
half-cycle counter-curvature.

This is an evidence-backed exploit candidate, not a claim of same-worker CFD
improvement. Under the frozen evaluation it should reproduce the sampled split
observer's coherent wake, capture, progress, mixed terminal-load profile, and
actuator exposure. Treat a materially different rollout as a reproducibility
or materialization failure before inferring a new control effect. On a held-out
pose or flow, falsify the mechanism if it loses capture or coherent propulsion,
regresses v33-scale distance progress, materially worsens yaw/cross-track/load,
or increases joint/command-limit exposure.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive wake-disturbance rejection
source_mechanism: separate slow persistent route feedback from fast periodic locomotor-carrier feedback before applying a bounded residual correction
transferable_invariant: preserve target-derived mean curvature and the posterior traveling-wave carrier while a distinct body-intrinsic joint-rate observation governs only the smallest beat-synchronous correction
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, hardware duty ratios, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: keep normalized body-frame target geometry and the anterior-only yaw response for continuous course curvature; use the observed two-joint tangent rate only in the phase channel driving bounded anterior half-cycle counter-curvature
falsification: reject if the frozen rollout does not reproduce the sampled split observer or if held-out CFD loses capture, coherent wake, v33-scale progress, terminal yaw/cross-track/load behavior, or actuator-envelope feasibility
```

The bookshelf supplied the slow-route/fast-carrier separation invariant and was
not used to justify scalar-only tuning. No formal CFD is run in this worker.

## Non-CFD validation

- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before
  inspecting the workspace. Its three prescribed checks were then run directly
  and separately.
- The guidance-materiality check initially found the same assigned optimizer
  parent marked twice in the rendered workspace `README.md`. Removing only the
  duplicate listing made the parent unambiguous; the rerun passes and confirms
  these notes plus the semantic `control_experience.md` revision.
- The solver-boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists in `solver/`, and its SHA-256 is
  `e8dd4f34950bd011ceb6edb01df5d936d40aed672c0dc8e8b22d328238fb5b35`,
  byte-identical to the evaluated sampled split-observer artifact.
- The Julia contract command cannot start because no Julia executable is
  installed. The deterministic static audit finds all `69` direct
  `params.FIELD` references among `71` returned fields, with no undeclared
  reference; only metadata fields are unused. Static guards find no explicit
  time/step input, randomness, file I/O, cylinder state, mutable global state,
  or memorized route. The byte-identical evaluated artifact supplies prior
  runtime evidence. No formal CFD was run.
