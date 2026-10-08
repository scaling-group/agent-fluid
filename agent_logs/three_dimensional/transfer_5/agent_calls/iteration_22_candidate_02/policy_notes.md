# Candidate diagnosis and policy hypothesis

## Evidence read before candidate selection

- The assigned-parent guidance, all four sampled solver artifacts, and the
  inherited optimizer notes and completed results were read first. Every
  compared rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite, and ended
  in capture.
- The four sampled solvers are byte-identical evaluations of v33. They have
  the same policy and combined-keyframe hashes and each captures at
  `23.8425T`, with score `-0.535091`, scoring mean/final distance
  `2.433543/0.746165L`, and `236` moving-window shifts. They are repeat
  evidence for one strong finite controller rather than four independent
  mechanisms.
- I inspected the sampled v33 combined sheet, the inherited v35 observer
  failure sheet, and the inherited v36 regulation-drive-reserve sheet from
  release to capture in both views. Their top-down rows begin in empty water
  and form spatially ordered alternating vortex streets behind fish following
  the same broad target-directed arc. Their oblique rows form compact paired
  Lambda2 structures that persist through the bent terminal approach. The
  fish are self-propelled rather than advected, and none shows wake breakup or
  instability; the controller differences are below the sheet resolution.
- Trajectory diagnostics expose the consequential trade. Sampled v33 has
  inside-`3L` mean/peak absolute yaw `1.6800/3.1848 rad/T`, mean body-lateral
  speed `0.2522U`, and mean/peak absolute moment `0.006382/0.013730`. V35's
  distributed two-joint carrier observer reduced mean/peak yaw to
  `1.6103/3.0497 rad/T`, lateral speed to `0.2391U`, and mean moment to
  `0.006106`, but delayed capture to `23.8975T` and worsened score and
  mean/final distance to `-0.535811` and `2.434232/0.746866L`; peak moment
  also rose to `0.013912`.
- The separately sampled v36 regulation-aware cadence reserve provides the
  complementary negative result. It arrived only `0.0055T` earlier than v33
  (`23.8370T`) while worsening score and mean/final distance to
  `-0.535652` and `2.433974/0.746760L`. My direct trajectory cross-check finds
  inside-`3L` mean/peak yaw `1.6831/3.2070 rad/T`, lateral speed `0.2525U`,
  and mean/peak moment `0.006409/0.013694`; extra terminal cadence therefore
  did not improve the progress/regulation balance even though the visible
  carrier remained coherent.
- These results join the inherited regressions from fixed course-curvature
  transfer, posterior half-cycle relief, moment/cue gates, and phase-lag
  damping. Lower yaw alone and slightly earlier capture alone are both
  insufficient objectives. No completed evidence supports another observer
  share, posterior-wave edit, terminal cadence reserve, scalar gain change, or
  added cue gate on top of v33.

## Single candidate and falsifiable hypothesis

Retain the exact evaluated v33 policy already materialized in `solver/` as
the one candidate. It preserves the target-aware, response-released C-bend;
state-feedback traveling-wave carrier; posterior amplitude and lag;
continuous normalized body-frame course correction; phase-selected anterior
counter-curvature; and component-wise smooth acceleration projection. No
unevaluated terminal regulator or scalar-only adjustment is added.

The hypothesis is reproducibility of the best completed progress/regulation
balance: the rollout should retain capture, the coherent alternating wake,
v33-scale arrival and distance integral, and its yaw/load behavior. Falsify
materialization if capture or wake coherence is lost, score or mean/final
distance moves toward the v35/v36 regressions, terminal yaw/moment worsens
materially, or joint/command-limit exposure grows. The candidate is
byte-identical to completed sampled evidence; no same-worker CFD result is
claimed.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior traveling-wave power stroke while separating it from bounded target-derived anterior correction
transferable_invariant: do not suppress or overdrive the posterior propulsive carrier merely to optimize one terminal diagnostic; retain a stable traveling wave and apply the smallest state-derived corrective layer that improves target progress and regulation together
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, hardware duty ratios, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: retain v33's normalized body-frame target feedback, observed-tail-side anterior half-cycle correction, posterior amplitude and lag, and existing approach cadence without adding the failed observer, relief, or regulation-reserve pathways
falsification: reject if v33-scale capture and distance progress are not reproduced, wake coherence is lost, yaw or moment worsens materially, or actuator-limit exposure grows
```

The shelf was consulted again because the completed v34-v36 sequence produced
neither a new success nor a better termination class. Its actuator-role
invariant supports retaining the v33 separation, while the rollout evidence
overrides adoption of another posterior modulation or terminal cadence
primitive.

## Validation boundary

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported for this account and failed before it could inspect the
  workspace. I therefore executed its three prescribed checks directly and
  separately.
- The guidance-materiality check initially exposed two rendered markers for
  the same assigned parent in `README.md`. Removing only the duplicate marker
  made parent selection unambiguous; the rerun passes and confirms that these
  notes exist and `control_experience.md` has a semantic reusable update.
- The solver-boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`; its SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  identical to all four sampled evaluated v33 artifacts.
- The exact Julia smoke command cannot start because no `julia` executable is
  installed. A deterministic static audit finds all `68` direct
  `params.FIELD` references among the `70` fields returned by
  `target_policy_params()`, with no undeclared reference; only metadata fields
  `version` and `control_period` are unreferenced. Static guards find no
  executable time/step input, randomness, file I/O, mutable global state,
  cylinder-coordinate access, or memorized route. No formal CFD was run.
