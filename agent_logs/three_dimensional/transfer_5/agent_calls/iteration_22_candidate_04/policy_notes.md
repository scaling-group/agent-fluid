# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- I read the assigned-parent guidance, all four sampled solver results, and the
  inherited parent rollout and optimizer notes before selecting a mechanism.
  The sampled files are byte-identical v33 policies and reproducible copies of
  one finite direct-uniform still-water capture: score `-0.535091`, arrival
  `23.8425T`, mean/final distance `2.433543/0.746165L`, no cylinders or
  prewarm, and `236` moving-window shifts.
- I inspected both rows of the sampled v33 combined keyframe sheet and the
  inherited v36 cadence-reserve sheet from release through termination. In
  both, the fish visibly self-propels along the same broad target-directed arc,
  the top-down row retains a coherent alternating wake, and the oblique row
  retains compact paired three-dimensional structures. Neither run shows
  passive advection, wake breakup, boundary contact, or instability; the
  intervention is below the sheet's visual resolution.
- Telemetry makes v36 an informative regression despite its retained capture.
  Restoring cadence in proportion to terminal-regulation load starts changing
  commands inside about `2.1L` and reaches capture one step earlier
  (`23.8370T`), but it worsens score, mean distance, and final distance to
  `-0.535652`, `2.433974L`, and `0.746760L`. The `3L`, `2L`, and `1L`
  threshold times remain identical to v33. Inside `3L`, mean/peak absolute yaw
  rise from `1.6800/3.1848` to `1.6831/3.2070 rad/T`, mean absolute moment
  rises from `0.006382` to `0.006409`, mean absolute lateral force coefficient
  rises from `0.011756` to `0.011809`, and joint/action envelopes remain
  essentially unchanged. Thus a regulation-magnitude-to-cadence reserve adds
  propulsive disturbance without improving the target path.
- The sampled v33 replay exposes a narrower route-estimation issue. Inside
  `3L`, its anterior-rate carrier subtraction makes the inferred course
  residual oppose the directly measured target-line cross-track velocity on
  `173/602` states (`28.7%`) and makes its magnitude larger on `151/602`
  states (`25.1%`). Those subsets still average `0.615L/T` and `0.693L/T`
  radial closure, respectively. Carrier rejection is useful when it removes
  beat motion, but its estimate should not create a course-correction sign or
  magnitude unsupported by target-relative translation.

## Policy hypothesis recorded before the policy edit

Preserve v33's target steering, state-feedback traveling-wave carrier,
response-released C-bend, posterior amplitude and lag, anterior phase-selected
yaw correction, cadence schedule, and smooth command projection. Change only
the terminal course residual: project the carrier-rejected estimate onto the
closed interval between zero and the measured target-line cross-track speed.
The observer may therefore cancel part of a measured course error, but may not
reverse it or amplify it. This is a structural target-consistency projection,
not a carrier-observer gain retune or a new cue gate.

The hypothesis is that retaining only target-supported course rejection will
avoid spending steering authority against useful periodic closing motion while
leaving the validated carrier and yaw correction intact. Falsify it if capture
or alternating wake coherence is lost; score, arrival, mean/final distance, or
`3L/2L/1L` threshold progress regresses from v33; inside-`3L` yaw, cross-track
speed, force, or moment worsens materially; or actuator-limit exposure grows.
The new candidate has no same-worker CFD evidence.

```text
bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: separate target-route feedback from fast lateral beat or wake motion, and reject only the bounded disturbance component supported by observed target error
transferable_invariant: a carrier or disturbance estimate must remain subordinate to normalized target-relative motion and must not invent an opposite-sign or larger route correction
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, hardware duty ratios, full-body kinematics, exact vortex phases, organized-wake phase locking, and task-specific routes
policy_translation: keep v33's two-joint state-feedback carrier and steering, but project its anterior-rate-rejected terminal course residual between zero and the measured body-frame target-line cross-track speed
falsification: reject if v33-scale capture, distance progress, terminal yaw/load, coherent alternating wake, or actuator envelopes regress, even if the inferred residual is algebraically cleaner
```

## Non-CFD validation

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before it
  could inspect the workspace. Its three prescribed checks were therefore run
  directly and separately.
- The guidance/materiality check initially exposed two rendered markers for
  the same assigned parent in `README.md`. Removing only one duplicate marker
  made the parent unambiguous; the rerun passes and confirms these notes plus a
  semantic, evidence-backed `control_experience.md` update.
- The solver boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`; its SHA-256 is
  `12ed1f1c3ebac3d701eb61cfdce515deefbce8ef890a58c9942f94956c9b39ce`,
  distinct from evaluated v33 only through candidate metadata and the bounded
  target-consistency projection.
- The exact Julia contract smoke test cannot start because no `julia`
  executable is installed. A deterministic static audit finds all `68` direct
  `params.FIELD` references declared among `70` fields returned by
  `target_policy_params()`. Only metadata fields `version` and
  `control_period` are unreferenced. Both public entrypoints are present, and
  static guards find no executable clock/step, randomness, file I/O, or
  mutable global state. No CFD was run.
