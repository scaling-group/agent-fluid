# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before candidate selection

- The assigned-parent experience, all four sampled solver results, and the
  available inherited optimizer notes/results were read before selecting a
  candidate. Every compared rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite, and
  terminated in capture. The four sampled solvers are byte-identical v33
  policies and share the same keyframe sheet and outcome, so they are repeat
  evidence for one mechanism rather than four independent designs.
- The combined sheets for sampled v33 (the strongest balanced finite result)
  and inherited v35 (the most informative failed intervention) were inspected
  from release through capture in both views. In each top-down row, an empty
  release field develops into a coherent alternating vortex street behind a
  fish that translates along the same broad target-directed arc. The oblique
  rows develop compact paired Lambda2 structures and retain them through the
  curved terminal approach. This is self-propulsion rather than advection;
  neither wake breaks up, and the small controller differences are below the
  keyframe sheet's visual resolution.
- The sampled v33 anterior half-cycle counter-curvature captures at
  `23.8425T` with score `-0.535091`, scoring mean/final distance
  `2.433543/0.746165L`, and inside-`3L` mean/peak absolute yaw
  `1.6800/3.1848 rad/T` plus mean/peak absolute yaw moment
  `0.006382/0.013730`. Relative to the sampled posterior counter-tangent
  comparison, it improves score, mean/final distance, peak yaw, lateral speed,
  and peak moment while preserving posterior amplitude and lag.
- The inherited v34 fixed transfer of continuous course curvature further
  reduced yaw/slip/load, but regressed score, mean/final distance, and arrival
  to `-0.535920`, `2.434212/0.747022L`, and `23.8480T`. The inherited v35
  two-joint carrier-rate observer improved an offline decorrelation measure but
  regressed farther to `-0.535811`, `2.434232/0.746866L`, and `23.8975T`.
  Together with v30-v32 posterior relief, load/course gates, and stroke
  redistribution, these completed runs reject another allocation share,
  posterior authorization gate, carrier-cancellation coefficient, or scalar
  gain edit as an evidence-backed next step.
- A replay of v33's existing state gate on its `602` inside-`3L` trace states
  reproduces `232` active anterior residual states, mean/max active shift
  `0.565/1.785 deg`. In `228` of those `232` states (`98.3%`), the observed
  full-tail tangent is already returning toward neutral. Thus a proposed
  tail-return phase gate would be redundant rather than a new useful
  mechanism; this replay is a selection diagnostic, not CFD evidence.

## Candidate selection and falsifiable hypothesis

Retain the exact evaluated v33 policy already materialized in `solver/` as the
single exploit candidate. It preserves the state-feedback traveling-wave
carrier, response-released body-frame C-bend, continuous terminal course bend,
posterior amplitude and lag, phase-selected anterior excess-yaw residual, and
component-wise smooth acceleration projection. No unevaluated gain or
mechanism is layered onto the strongest completed result.

The hypothesis is reproducibility: the candidate should retain the coherent
alternating wake and reproduce v33-scale capture, arrival, distance integral,
terminal yaw/load behavior, and lack of new joint or projected-command
exposure. Falsify materialization if capture or wake coherence is lost, arrival
or scoring mean/final distance moves toward the v34/v35 regressions, terminal
yaw/moment worsens materially, or any actuator-limit exposure grows. The
candidate policy is byte-identical to prior completed evidence; no same-worker
CFD result is claimed.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and sensor-modulated robotic-fish CPG turning
source_mechanism: preserve posterior traveling-wave authority for propulsion while applying only a bounded state-phase steering residual anteriorly
transferable_invariant: separate the posterior propulsive carrier from the smallest target-derived corrective curvature, and retain an observed-joint phase gate when posterior waveform edits cost progress
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: retain v33's normalized body-frame target geometry and carrier-rejected yaw; observed q1+q2 selects the supporting half-cycle and only the anterior oscillator center receives bounded counter-curvature while posterior amplitude and lag remain unchanged
falsification: reject if capture or coherent alternating propulsion regresses, v33-scale distance progress is not reproduced, terminal yaw or moment worsens materially, or joint and projected-command exposure grows
```

The shelf supplied only the actuator-role and state-phase invariant. All gains,
sign conventions, and gates in this exploit candidate come from the completed
v33 rollout rather than from a source-domain value.

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported for this account and failed before it
  could inspect the workspace. Its three prescribed checks were therefore run
  directly and separately.
- The material-guidance check initially found two rendered markers for the
  same assigned parent. Removing only the duplicate marker from `README.md`
  made parent resolution unambiguous; the rerun passes and confirms that these
  notes exist and `control_experience.md` has a material reusable update.
- The solver-boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`, with SHA-256
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  byte-identical to all four sampled v33 artifacts.
- The exact Julia contract smoke command cannot start because no `julia`
  executable is installed. A deterministic static audit finds all `68` direct
  `params.FIELD` references among the `70` fields returned by
  `target_policy_params()`, with no missing field. It also confirms both public
  entrypoints and finds no executable clock, step, randomness, file I/O,
  mutable global state, cylinder identity, or memorized route. No CFD was run.
