# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before candidate disposition

- The assigned-parent guidance, its three inherited completed results and
  optimization notes, and all four sampled solver artifacts were read before
  selecting a candidate. Every completed rollout used direct-uniform still
  water at `U_infinity=(0,0,0)`, with no cylinders or prewarm, remained finite,
  and terminated in capture.
- The four sampled solvers are byte-identical copies of the evaluated v33
  anterior half-cycle policy and share the same rollout, so they are repeat
  evidence for one mechanism rather than four independent controller tests.
  Their combined sheet was inspected from release through capture in both the
  top-down mid-plane and oblique 3D Lambda2 views. An initially empty field
  develops a coherent alternating vorticity street and compact paired 3D wake
  structures behind a fish that visibly translates along a broad
  target-directed arc. The wake remains organized during the terminal turn;
  this is self-propulsion rather than advection, with no breakup, domain exit,
  or instability.
- No distinct sampled failure image exists in this rendered workspace. The
  assigned-parent phase-advance result is therefore the informative failed
  intervention, but only its completed score and optimizer notes are available;
  no unsupported visual comparison is inferred for it.
- Sampled v33 captures at `23.8425T` with score `-0.535091`, scoring mean/final
  distance `2.433543/0.746165L`, progress `0.939473`, and `4335` steps. The
  inherited diagnostics report inside-`3L` mean/peak absolute yaw
  `1.6800/3.1848 rad/T`, mean/peak absolute moment
  `0.006382/0.013730`, mean body-lateral speed `0.2522U`, no angle-limit
  exposure, and finite peak joint speed/projected acceleration of approximately
  `4.538 rad/T` and `31.39 rad/T^2`.
- The assigned-parent phase-advance child replaced v33's observed
  tail-tangent-only half-cycle selector with a bounded tangent-plus-velocity
  phase coordinate while retaining the same anterior residual and posterior
  carrier. It still captured in `4334` steps, but worsened score to
  `-0.536780`, final distance to `0.747967L`, and progress to `0.939326`.
  This joins the earlier fixed anterior course-transfer regression
  (`-0.535920`, `0.747022L`) as evidence that a cleaner or earlier corrective
  coordinate is not itself a target-progress improvement.

## Single candidate and falsifiable hypothesis

Retain the exact evaluated v33 policy already materialized at
`solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl` as the one
candidate. It preserves the state-feedback traveling-wave carrier,
response-released body-frame C-bend, continuous terminal course bend,
posterior amplitude and lag, tangent-selected anterior excess-yaw residual,
and component-wise smooth command projection. Relative to the assigned parent,
this deliberately removes the failed velocity phase advance and returns to the
strongest completed distance-progress result; it is not an unevaluated scalar
gain change.

The expected result is reproduction of v33-scale capture, distance integral,
terminal yaw/load behavior, coherent wake formation, and actuator exposure.
Falsify the selected artifact if it loses capture or wake coherence, moves
score or mean/final distance toward the inherited phase-advance regression,
materially worsens terminal yaw or moment, or adds joint/command-limit
exposure. A materially different rollout under the frozen contract should also
trigger a materialization/nondeterminism audit before a control attribution.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG turning
source_mechanism: preserve posterior traveling-wave propulsion while localizing a bounded steering residual to an observed beat side
transferable_invariant: separate posterior reactive-thrust duty from the smallest target-relevant anterior correction, and retain an observed-state phase gate only when closed-loop progress validates it
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame target feedback and carrier-rejected excess yaw; bounded q1+q2 selects the supporting half-cycle, only the anterior oscillator center receives corrective curvature, and posterior amplitude and lag remain unchanged
falsification: reject if capture or alternating wake coherence regresses, v33-scale score and distance progress are not reproduced, terminal yaw/load worsens materially, or actuator-limit exposure grows
```

The bookshelf supplied only the actuator-role and state-phase invariants. The
candidate's gains, signs, and gate come from completed v33 evidence, while the
assigned-parent result rejects adding tail-tangent velocity merely to improve
phase estimation. No formal CFD was run in this worker; the post-worker result
becomes evidence for a later generation.

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported for this account and failed before it
  could inspect the workspace. Its prescribed checks were therefore run
  directly and separately.
- The material-guidance check passes: these transient notes exist and
  `guidance/control_experience.md` differs semantically from the assigned
  parent with an evidence-backed reusable negative boundary. The solver
  boundary check also passes and confirms no out-of-scope solver change.
- The exact Julia contract smoke command cannot start because no `julia`
  executable is installed. A deterministic static audit finds all `68` direct
  `params.FIELD` references among the `70` fields returned by
  `target_policy_params()`, with only metadata fields `version` and
  `control_period` unreferenced. Public entrypoints, one nonempty candidate,
  and forbidden clock/randomness/file-I/O/global-state scans pass.
- The candidate SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  byte-identical to all four sampled executed v33 artifacts. No CFD was run.
