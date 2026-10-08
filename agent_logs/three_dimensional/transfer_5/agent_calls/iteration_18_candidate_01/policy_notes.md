# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver evaluations, and the
  inherited optimizer notes were read before selecting the candidate. Every
  sampled rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite, and
  terminated in capture. Three solver artifacts independently reproduce the
  same v33 policy and outcome; they are repeat evidence, not three mechanisms.
- The combined keyframe sheets for the strongest sampled v33 run and the
  weaker assigned v30 parent were inspected from release through capture in
  both views. Their initially empty fields develop coherent alternating
  top-down vorticity streets and compact paired oblique Lambda2 structures.
  Both fish visibly self-propel along the same broad target-directed arc and
  retain the wake through capture. The controller difference is below the
  sheets' visual resolution, so terminal trajectory, load, joint, and score
  histories decide the intervention.
- The prefilled v30 load-selective posterior counter-tangent captures at
  `23.8315T` with score `-0.535298`, scoring mean/final distance
  `2.433642/0.746599L`, and no prewarm or instability. Inside `3L`, inherited
  trace analysis reports mean/peak absolute filtered yaw
  `1.6816/3.2645 rad/T`, mean body-lateral speed `0.2544U`, and mean/peak
  absolute yaw moment `0.006393/0.014385`.
- The sampled v33 phase-selected anterior counter-curvature is the strongest
  balanced result. It preserves posterior traveling-wave amplitude and lag,
  captures at `23.8425T`, and improves score, mean distance, and final distance
  to `-0.535091`, `2.433543L`, and `0.746165L`. It also lowers terminal
  mean/peak yaw to `1.6800/3.1848 rad/T`, body-lateral speed to `0.2522U`, and
  mean/peak moment to `0.006382/0.013730`, without new joint or projected-
  command exposure. The yaw cleanup is modest, but unlike posterior relief it
  does not trade away distance progress.
- The inherited v34 child moved a fixed `25%` share of continuous terminal
  course curvature anteriorly. It retained capture and further reduced
  terminal yaw/slip/load, but regressed score and mean/final distance from v33
  to `-0.535920` and `2.434212/0.747022L`, arriving later at `23.8480T`.
  Fixed mean-course redistribution is therefore a measured regulation/progress
  tradeoff, not a reason for another transfer-share retune.

## Policy hypothesis recorded before policy edit

Replace the prefilled v30 posterior load-gated counter-tangent with the exact
evaluated v33 anterior half-cycle counter-curvature controller. Preserve its
state-feedback traveling-wave carrier, response-released body-frame C-bend,
continuous terminal course distribution, posterior amplitude and lag, and
smooth component-wise command projection. Carrier-rejected excess yaw sets a
bounded counter direction; observed two-joint tail tangent admits it only on
the yaw-supporting half-cycle; only the anterior oscillator center receives
the residual.

This exploit candidate uses prior completed CFD evidence rather than claiming
a same-worker result. It rejects v34's fixed route-scale allocation: anterior
authority remains phase-selected and corrective while the evidenced
continuous course bend and posterior traveling wave stay unchanged. Falsify
materialization if capture or coherent wake formation regresses, v33-scale
arrival/distance is not reproduced, terminal yaw or load worsens materially,
or actuator-limit exposure appears.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive-thrust theory and robotic-fish asymmetric CPG turning
source_mechanism: preserve posterior traveling-wave authority for thrust while allocating a bounded beat-side steering residual to an anterior actuator
transferable_invariant: when posterior waveform edits trade regulation for progress, retain posterior amplitude and lag and apply the smallest correction at an anterior coordinate only on an observed supporting half-cycle
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target geometry retains the evaluated continuous course bend; carrier-rejected yaw sets correction sign, observed q1+q2 supplies a state-derived half-cycle coordinate, and only the anterior oscillator center receives bounded counter-curvature
falsification: reject if capture or coherent alternating propulsion regresses, v33-scale distance progress is not retained, terminal yaw or moment worsens materially, or joint and projected-command exposure grows
```

The shelf supplied only the actuator-role and state-phase invariant. All gains,
sign conventions, and gating are retained from the completed sampled v33
rollout rather than copied from a source domain. No CFD is run in this worker.

## Non-CFD validation

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account and failed before
  inspecting the workspace. Its prescribed commands were run directly.
- The transient-notes and material-guidance check passes. The solver-boundary
  check also passes, confirming that only the permitted candidate file differs
  from the frozen solver baseline.
- The exact Julia smoke command cannot start because Julia is not installed.
  A deterministic static audit resolves all 68 direct `params.FIELD`
  references among the 70 fields returned by `target_policy_params()`; only
  metadata fields are unreferenced. No executable clock, step, random, file-I/O,
  mutable-global, cylinder, or memorized-route dependency was found.
- Exactly one nonempty `candidate_target_policy.jl` exists under `solver/`.
  Its SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  byte-identical to the independently evaluated sampled v33 artifact.
