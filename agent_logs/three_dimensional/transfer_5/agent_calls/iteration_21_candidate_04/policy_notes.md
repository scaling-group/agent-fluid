# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- I read the assigned-parent guidance, the four sampled solver artifacts, and
  the inherited optimizer notes and completed results before selecting a
  mechanism. All sampled runs are finite captures from direct uniform still
  water at `U_infinity=(0,0,0)`, with no cylinders or prewarm. Their policy
  files and combined keyframe sheets are byte-identical v33 artifacts, and all
  report capture at `23.8425T`, score `-0.535091`, scoring mean/final distance
  `2.433543/0.746165L`, and `236` moving-window shifts. They are reproducible
  evidence for one controller, not four independent comparisons.
- I inspected the sampled v33 combined sheet and the inherited v35 failure
  sheet from release through termination, including the top-down mid-plane
  vorticity and oblique 3D body/Lambda2 rows. Both initially empty fields form
  coherent alternating wakes and compact paired three-dimensional structures
  behind fish that visibly self-propel along the same broad target-directed
  arc. Neither shows passive advection, wake breakup, a boundary encounter, or
  instability. Both remain strongly bent and laterally active near capture;
  the regulation difference is below the sheets' visual resolution.
- The trajectory diagnostics distinguish them. Sampled v33 has inside-`3L`
  mean/peak absolute yaw `1.6800/3.1848 rad/T`, mean body-lateral speed
  `0.2522U`, and mean/peak absolute yaw moment `0.006382/0.013730`, with no
  joint-angle-limit exposure. Inherited v35 added a `0.30` full-tail-rate share
  to the instantaneous carrier observer. It reduced mean/peak yaw to
  `1.6103/3.0497 rad/T`, mean lateral speed to `0.2391U`, and mean moment to
  `0.006106`, but worsened score/arrival/mean/final distance to
  `-0.535811/23.8975T/2.434232L/0.746866L`; peak moment rose to `0.013912`
  with essentially unchanged actuator envelopes. Thus offline decorrelation
  and lower yaw/slip are not progress surrogates: suppressing periodic motion
  can remove useful closing impulse.
- This negative result joins the inherited failures of fixed course-curvature
  reallocation, posterior relief, moment/cue gates, and phase-lag damping. It
  rules out another observer-share, steering-allocation, posterior-wave, or
  scalar correction-gain edit. The evaluated v33 anterior phase-selected
  correction and posterior traveling wave are the strongest sampled
  progress/regulation balance and should remain intact.
- A read-only replay was used only to bound the proposed pathway. Inside `3L`,
  v33's existing terminal regulation load is at least `0.1` on `389/602`
  states. Those states average about `0.689L/T` radial closure versus about
  `0.668L/T` outside them; load at least `0.5` averages `0.706L/T`. This
  correlation does not prove a new CFD benefit, but it argues against damping
  the correction and supports preserving propulsion while that correction is
  active.

## Policy hypothesis recorded before the policy edit

Preserve v33's target-course feedback, state-feedback traveling-wave carrier,
response-released C-bend, posterior amplitude and lag, phase-selected anterior
counter-curvature, and smooth component-wise command projection. Add one new
closed-loop coupling: when either existing terminal course curvature or
anterior half-cycle regulation is active, restore a bounded fraction of the
cadence removed by the approach schedule. Compute a nonnegative regulation
load from those already bounded commands and blend the drive-distance gate
toward (never beyond) its far-field value. With zero regulation load, or
outside the approach schedule, the evaluated v33 cadence is exactly retained.

This is a regulation-aware propulsive reserve, not a gain sweep: it connects a
validated steering layer to the CPG cadence while analytically keeping the
effective cadence gate in `[approach, 1]`. The hypothesis is that v33's useful
terminal correction can retain closing impulse instead of trading propulsion
for a cleaner yaw trace. Falsify it if capture or alternating wake coherence is
lost; arrival, score, or mean/final distance regresses from v33; inside-`3L`
yaw, lateral speed, or moment worsens materially; joint/command-limit exposure
grows; or the result merely raises cadence without improving target progress.
The new candidate has no same-worker CFD evidence.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture control
source_mechanism: retain a state-feedback propulsive rhythm while a bounded feedback load modulates a low-dimensional CPG parameter during corrective maneuvering
transferable_invariant: terminal regulation should preserve enough traveling-wave propulsion to maintain target closure rather than optimize yaw or slip in isolation
nontransferable_details: published gains, dimensional frequencies, clock phases, species-specific envelopes, hardware duty ratios, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: use the magnitudes of v33's normalized body-frame terminal course and phase-selected yaw corrections as a bounded load, and restore only part of the approach-suppressed two-joint cadence while preserving the posterior lag and all steering commands
falsification: reject if v33-scale capture, distance progress, terminal yaw/load, wake coherence, or actuator envelopes regress, or if cadence rises without a target-progress benefit
```

## Non-CFD validation

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before it
  could inspect the workspace. Its three prescribed checks were therefore run
  directly and separately.
- The guidance/materiality check initially exposed two rendered markers for
  the same assigned parent in `README.md`. Removing only the duplicate marker
  made the parent unambiguous; the rerun passes and confirms these notes plus a
  semantic, evidence-backed `control_experience.md` update.
- The solver boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`; its SHA-256 is
  `db53a98d64c66e58beec1358a486db33f3b9882cecc3068a8cf5c80b35e3295a`,
  distinct from evaluated v33 only through candidate metadata and the bounded
  terminal regulation-to-cadence pathway.
- The exact Julia contract smoke test cannot start because no `julia`
  executable is installed. A deterministic static audit finds all `69` direct
  `params.FIELD` references declared among `71` fields returned by
  `target_policy_params()`. Only metadata fields `version` and
  `control_period` are unreferenced. Both public entrypoints are present, and
  static guards find no executable clock/step, randomness, file I/O, cylinder
  state, fixed route, or mutable global state. No CFD was run.
