# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned parent guidance, all four sampled solver results, the parent's
  optimization notes, and its completed score were read before choosing the
  candidate. Every sampled rollout and the assigned-parent result used direct
  uniform still water at `U_infinity=(0,0,0)`, no cylinders or prewarm,
  remained finite, and terminated in capture.
- The combined keyframe sheets for the strongest sampled result
  (`solver_2546ece173ab`, duplicated independently as
  `solver_dbb24e880a8c`) and the weakest sampled result
  (`solver_8ce1bc88a53c`) were inspected from release through capture in both
  views. Each starts in an empty flow field, visibly self-propels along the
  same broad target-directed arc, develops a coherent alternating top-down
  vorticity street and compact paired oblique Lambda2 structures, and retains
  that wake through capture. The terminal controller differences are below
  the keyframe resolution, so trajectory, load, joint, and score histories
  decide the intervention.
- The prefilled v24 course-brake policy captures at `23.8315T` with score
  `-0.535794`, scoring mean distance `2.434073L`, and final distance
  `0.746924L`. Inside `3L`, its mean/peak absolute yaw is
  `1.6839/3.2076 rad/T`, target-transverse speed is `0.23935U`, and mean/peak
  absolute moment is `0.006402/0.014062`.
- The sampled v30 posterior load-selective counter-tangent preserves the
  `23.8315T` arrival and improves score to `-0.535298`, but worsens terminal
  target-transverse speed to `0.24493U`, peak yaw to `3.2645 rad/T`, and peak
  moment to `0.014385`. This agrees with the inherited negative result that
  another posterior tangent or load gate is not a clean yaw/load mechanism.
- The sampled v33 anterior half-cycle counter-curvature is the strongest
  finite result: it preserves posterior amplitude and lag, captures at
  `23.8425T`, and improves score/mean/final distance to
  `-0.535091`/`2.433543L`/`0.746165L`. Inside `3L`, mean/peak absolute yaw is
  `1.6800/3.1848 rad/T`, target-transverse speed is `0.23924U`, and mean/peak
  absolute moment is `0.006382/0.013730`. Peak joint angle, joint speed, and
  projected acceleration remain finite at `0.616 rad`, `4.538 rad/T`, and
  `31.386 rad/T^2`; the yaw improvement is small but does not incur the
  posterior-relief progress trade.
- The assigned parent then transferred a fixed share of the continuous
  route-scale course bend from posterior mean tangent to the anterior
  oscillator while retaining v33's phase residual. That completed rollout
  still captured, but regressed to score `-0.535920`, final distance
  `0.747022L`, and `4336` steps versus v33's `-0.535091`, `0.746165L`, and
  `4335` steps. No detailed terminal load trace was inherited, so this result
  specifically falsifies fixed mean-course reallocation as a progress
  improvement; it does not establish whether that child changed yaw or load.

## Policy hypothesis recorded before policy edit

Replace the prefilled v24 policy with the evaluated v33 anterior half-cycle
counter-curvature candidate. Preserve its state-feedback traveling-wave
carrier, posterior amplitude and lag, response-released body-frame C-bend,
continuous terminal course distribution, and smooth component-wise command
projection. Carrier-rejected excess yaw sets a bounded counter direction, and
the observed two-joint tail tangent admits that correction only on the
yaw-supporting half-cycle; only the anterior oscillator center receives the
residual.

This choice uses prior evaluated evidence rather than claiming same-worker CFD
improvement. It deliberately rejects the assigned parent's fixed route-scale
transfer: anterior authority remains phase-selected and corrective, while the
evidenced continuous course bend and posterior traveling wave stay unchanged.
Falsify the candidate if the post-worker rollout loses capture or coherent
wake formation, fails to reproduce v33-scale distance progress, materially
worsens terminal yaw/lateral load, or increases joint/command-limit exposure.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and robotic-fish asymmetric turning control
source_mechanism: preserve posterior traveling-wave authority while applying bounded beat-side steering through an anterior actuator
transferable_invariant: separate route-scale mean curvature from phase-selected correction, and preserve the posterior kinematics that supply reactive thrust when posterior edits trade stability for progress
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target geometry retains the evaluated continuous course bend; carrier-rejected yaw sets correction sign, observed q1+q2 selects the supporting half-cycle, and only the anterior oscillator center receives bounded counter-curvature without clock or memory
falsification: reject if capture or coherent wake formation regresses, v33-scale arrival and distance integral are not retained, terminal yaw or lateral load worsens materially, or actuator-limit exposure grows
```

The bookshelf supplied only the role-separation invariant. Candidate gains and
sign conventions are retained from the completed sampled v33 rollout rather
than copied from a source domain.

## Non-CFD validation

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Its first prescribed
  check initially exposed two inherited markers for the same assigned parent
  in the rendered workspace `README.md`; removing only the duplicate made the
  parent unambiguous. The material-guidance check then passed.
- The solver boundary check passed and confirms that
  `candidate_target_policy.jl` is the only solver difference from the frozen
  baseline. Exactly one nonempty file with that candidate filename exists in
  `solver/`.
- The prescribed Julia smoke command could not start because no Julia
  executable is installed. A deterministic static audit found all `68` direct
  `params.FIELD` references among the `70` fields returned by
  `target_policy_params()`, with no missing field; the two unreferenced fields
  are metadata. Static guards found no clock/step source, randomness, file I/O,
  or mutable global state.
- The candidate is byte-identical to the independently evaluated sampled v33
  policy (SHA-256
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`).
  No formal CFD was run in this worker; the post-worker evaluation remains the
  materialization test for this artifact.
