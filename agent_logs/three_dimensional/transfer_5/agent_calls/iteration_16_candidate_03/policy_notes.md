# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver evaluations, and the
  inherited optimizer notes were read before selecting a mechanism. Every
  sampled run used direct uniform still water at `U_infinity=(0,0,0)`, no
  cylinders or prewarm, remained finite, and terminated in capture.
- The combined sheets for the strongest sampled run (v33 anterior half-cycle
  counter-curvature) and the most informative tradeoff (v30 posterior
  half-cycle amplitude relief) were inspected from release through capture.
  In both, an initially empty field develops into a coherent alternating
  top-down vorticity street and compact paired oblique Lambda2 structures.
  The fish self-propels along the same broad target-directed arc; neither wake
  breaks up, and the small terminal differences are below the sheet's visual
  resolution.
- The inherited v24 continuous-course baseline captures at `23.8315T` with
  scoring mean distance `2.434073L`. Inside `3L` its mean/peak absolute yaw is
  `1.6839/3.2076 rad/T`, mean body-lateral speed is `0.2535U`, and mean/peak
  absolute moment is approximately `0.006402/0.01406`.
- Posterior amplitude relief is the clearest yaw/load intervention but costs
  useful impulse: it lowers inside-`3L` mean/peak yaw to
  `1.6060/3.0632 rad/T`, body-lateral speed to `0.2414U`, and mean moment to
  `0.006137`, while delaying capture to `23.8755T`. Inherited moment gating,
  route gating, and equal relief/boost redistribution did not recover that
  arrival cost. The sampled load-selective counter-tangent instead preserves
  v24 arrival but raises peak yaw/moment to `3.2645 rad/T`/`0.014385`.
- The newly sampled v33 anterior half-cycle residual is the best finite result:
  score `-0.535091`, scoring mean distance `2.433543L`, final distance
  `0.746165L`, and capture at `23.8425T`. With posterior amplitude and lag
  unchanged, it also reduces inside-`3L` peak yaw/moment to
  `3.1848 rad/T`/`0.013730` and slightly lowers mean yaw, body-lateral speed,
  and mean moment to `1.6800 rad/T`, `0.2522U`, and `0.006382`. The yaw cleanup
  is too small to claim a terminal-regulation solution, but this is positive
  evidence that anterior phase-selected curvature can preserve progress while
  avoiding the posterior intervention tradeoff.

## Candidate hypothesis recorded before policy edit

Use evaluated v33 as the behavioral base. Preserve its state-feedback
traveling-wave carrier, response-released C-bend, continuous normalized
body-frame course feedback, phase-selected anterior excess-yaw residual, and
component-wise smooth command projection. Add one bounded allocation layer:
inside the existing terminal course gate, transfer a fixed fraction of the
signed continuous course bend from posterior mean tail tangent to the anterior
oscillator center. The algebraic sum of the two course-curvature targets is
preserved; posterior oscillatory amplitude, lag, and cadence are untouched.

This tests whether route-scale curvature can be supplied more anteriorly while
the posterior joint retains reactive-thrust duty. Falsify it if capture or the
coherent alternating wake is lost; capture time or scoring mean distance
regresses beyond the posterior-relief result; terminal yaw, lateral speed, or
moment worsens materially from v33; or joint-angle, joint-speed, or projected-
command exposure grows.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and robotic-fish CPG turning
source_mechanism: allocate route-scale steering curvature anteriorly while preserving posterior traveling-wave kinematics for reactive thrust
transferable_invariant: separate slower mean-course curvature from the propulsive carrier, and prefer anterior steering allocation when posterior waveform changes trade yaw cleanup for progress
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: the normalized body-frame terminal course brake supplies one bounded signed curvature target; transfer a parameterized share from posterior mean tangent to anterior oscillator center while retaining v33 phase feedback and unchanged posterior amplitude and lag
falsification: reject if capture or wake coherence regresses, v33-scale progress is lost, terminal yaw/lateral/load metrics worsen, or actuator-limit exposure grows
```

The new candidate has no same-worker CFD evidence; its formal result is for a
later generation to evaluate and distill.

## Non-CFD validation

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its prescribed
  material-guidance and solver-boundary checks were run directly and pass.
  The guidance check initially exposed the inherited duplicate marker for the
  same assigned parent in the rendered `README.md`; removing only that
  duplicate made parent resolution unambiguous.
- The exact Julia smoke command cannot start because no Julia executable is
  installed. The deterministic schema audit found all 69 direct
  `params.FIELD` references among the 71 fields returned by
  `target_policy_params()`; only metadata fields `version` and
  `control_period` are intentionally unreferenced. Static guards found no
  clock, step counter, randomness, file I/O, fixed route, or cylinder state.
- Replaying the new allocation algebra on all 602 inside-`3L` states of the
  sampled v33 trace activates a nonzero transfer in 507 states. Its mean active
  magnitude is `0.358 deg` and maximum is `1.392 deg`; the maximum numerical
  error in preserving the signed `14 deg` nominal head-plus-tail course target
  is `2.78e-17 rad`. The transfer is identically zero when the inherited
  terminal course brake is inactive, and posterior oscillatory amplitude and
  lag expressions are unchanged from evaluated v33. No CFD was run.
