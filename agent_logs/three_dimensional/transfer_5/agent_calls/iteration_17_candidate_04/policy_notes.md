# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver results, and the
  inherited optimizer rollouts were read before selecting the candidate. Every
  compared evaluation used direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite, and
  terminated in capture.
- The combined sheets for the strongest sampled v33 run, the assigned v30
  parent, the informative v31 load-gated regression, and the inherited v34
  fixed-allocation result were inspected from release through capture. Their
  top-down rows start with an empty flow field, then show the fish translating
  toward the target while forming a coherent alternating vortex street. Their
  oblique rows develop compact paired Lambda2 structures behind the fish and
  retain them through the curved terminal approach. Motion is self-propelled,
  not background advection. Policy differences are below the sheets' visual
  resolution, so the trajectory and load histories decide the intervention.
- The prefilled v30 load-selective posterior counter-tangent captures at
  `23.8315T` with score `-0.535298`, scoring mean/final distance
  `2.433642/0.746599L`, and no angle-limit exposure. Inside `3L`, its
  mean/peak absolute filtered yaw is `1.6816/3.2645 rad/T`, mean body-lateral
  speed is `0.2544U`, and mean/peak absolute yaw moment is
  `0.006393/0.014385`.
- The sampled v33 phase-selected anterior counter-curvature is the strongest
  balanced result. It preserves posterior traveling-wave amplitude and lag,
  captures at `23.8425T`, and improves score, mean distance, and final distance
  to `-0.535091`, `2.433543L`, and `0.746165L`. It also lowers terminal
  mean/peak yaw to `1.6800/3.1848 rad/T`, body-lateral speed to `0.2522U`,
  and mean/peak moment to `0.006382/0.013730`. Peak joint angle, speed, and
  smoothly projected commands remain at the established envelope; two sampled
  solver artifacts contain the same evaluated policy and outcome.
- The inherited v34 test moved a fixed `25%` share of continuous terminal
  course curvature from posterior to anterior. It further lowered terminal
  mean/peak yaw to `1.6440/3.1207 rad/T`, body-lateral speed to `0.2463U`,
  and mean/peak moment to `0.006271/0.013582`, while keeping the coherent wake
  and capture. However, it regressed score and mean/final distance from v33 to
  `-0.535920` and `2.434212/0.747022L`, and arrived later at `23.8480T`.
  Fixed route-curvature transfer is therefore a real regulation/progress
  tradeoff, not evidence for another transfer-share retune.

## Policy hypothesis recorded before policy edit

Replace the prefilled v30 posterior load-gated counter-tangent with the exact
evaluated v33 anterior half-cycle counter-curvature policy. Preserve its
state-feedback traveling-wave carrier, response-released body-frame C-bend,
continuous terminal course correction, posterior amplitude and lag, and smooth
component-wise command projection. Carrier-rejected excess yaw determines the
correction sign, while observed two-joint tail tangent selects only the
yaw-supporting half-cycle; the bounded residual shifts the anterior oscillator
center rather than modifying posterior propulsion.

This is an evidence-backed actuator reallocation, not scalar gain tuning. The
expected result is the already sampled capture topology with better distance
and peak yaw/load behavior than the assigned parent, without inheriting v34's
fixed-transfer distance regression. The source rollout is prior evidence; no
same-worker CFD result is claimed. Falsify materialization if capture or wake
coherence is lost, v33-scale arrival/distance is not reproduced, terminal
yaw/load grows materially, or actuator-limit exposure appears.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and robotic-fish asymmetric CPG turning
source_mechanism: preserve posterior traveling-wave kinematics for thrust while allocating a bounded phase-selected steering residual to an anterior actuator
transferable_invariant: when posterior waveform edits trade regulation for progress, retain posterior amplitude and lag and apply the smallest corrective curvature at an anterior coordinate only on the observed yaw-supporting half-cycle
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target geometry retains the continuous course bend; carrier-rejected yaw sets correction sign, observed q1+q2 supplies a state-derived half-cycle coordinate, and only the anterior oscillator center receives bounded counter-curvature
falsification: reject if capture or coherent alternating propulsion regresses, v33-scale distance progress is not retained, terminal yaw or moment worsens materially, or joint and projected-command exposure grows
```

## Validation boundary

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account and failed before inspecting the
  workspace. Its three prescribed checks were therefore run directly.
- The guidance-materiality check initially found two identical rendered
  markers for the same assigned parent in `README.md`. Removing the duplicate
  made parent selection unambiguous; the rerun passes. The solver boundary
  check passes and confirms that only the permitted candidate file differs
  from the frozen solver baseline.
- The exact lightweight Julia contract command cannot start because no Julia
  executable is installed. A deterministic static audit found all `68` direct
  `params.FIELD` references among the `70` fields returned by
  `target_policy_params()`; only metadata fields `version` and
  `control_period` are intentionally unreferenced. The candidate has no clock,
  step, random, file-I/O, mutable-global, cylinder, or memorized-route access.
- Exactly one nonempty `candidate_target_policy.jl` exists under `solver/`.
  Its SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  byte-identical to the evaluated sampled v33 artifact. Formal CFD remains the
  post-worker evaluation and was not run here.
