# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the frozen initialization contract:
  direct uniform still water at `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and capture. The best finite sampled score is the
  load-selective posterior counter-tangent (`solver_28bce98206ce`), while the
  assigned parent (`solver_3b8f345c391b`) is the most informative stabilizing
  tradeoff.
- Both combined keyframe sheets were inspected from release to capture. Their
  top-down rows begin with an empty field and develop a coherent alternating
  vortex street; their oblique rows develop compact paired Lambda2 structures
  behind a fish translating along the same broad target-directed arc. The fish
  is self-propelled rather than advected, neither wake breaks up before capture,
  and the policy differences are below the visual sheet's resolution.
- The trajectory histories confirm that all four sampled policies are
  effectively identical until the terminal `3L` gate. The evaluated v24
  continuous-course baseline (`solver_8ce1bc88a53c`) captures at `23.8315T`
  with scoring mean distance `2.434073L`; inside `3L` its mean/peak absolute
  yaw is `1.6839/3.2076 rad/T`, mean body-lateral speed is `0.2535U`, and mean
  absolute moment is `0.006402`.
- The assigned parent's unconditional posterior half-cycle relief retains
  capture and the coherent wake while lowering inside-`3L` mean/peak yaw to
  `1.6060/3.0632 rad/T`, mean body-lateral speed to `0.2414U`, and mean moment
  to `0.006137`. Peak joint angle, joint speed, and projected acceleration stay
  at `0.616 rad`, `4.538 rad/T`, and `31.379 rad/T^2`, respectively. Its cost is
  later capture at `23.8755T` and scoring mean distance `2.433993L`. This is a
  selective loss of useful posterior impulse, not wake or command failure.
- The best-score counter-tangent reaches capture at the v24 time and improves
  scoring mean distance to `2.433642L`, but increases target-transverse speed
  to `0.2449U`, peak yaw to `3.2645 rad/T`, and peak moment to `0.014385`.
  Another tangent offset is therefore not an evidenced yaw/load remedy.
- Inherited v31 evidence also rejects instantaneous reinforcing yaw moment as a
  multiplicative relief gate: it did not recover the parent's arrival time and
  weakened its yaw cleanup while worsening score/final distance. The next
  candidate should neither add another load gate nor merely retune the relief
  fraction.

## Candidate hypothesis recorded before policy edit

Preserve the assigned parent's target-aware state-feedback oscillator,
posterior lag, response-released C-bend, continuous body-frame terminal course
bend, and smooth component-wise acceleration projection. Replace amplitude
removal with one compact posterior stroke-redistribution mechanism: the
carrier-rejected excess-yaw sign and observed `phi1+phi2` tail side keep the
evaluated half-cycle selection, but the bounded amount removed from the
yaw-supporting oscillatory tail target is added to the yaw-opposing half-cycle.
The normalized body-frame proximity and speed gates remain unchanged.

This preserves the cycle-scale posterior wave envelope while retaining the
parent's useful waveform asymmetry. It should recover some or all of the
parent's `0.044T` arrival loss without returning yaw, lateral motion, or load to
the v24/counter-tangent range. Falsify the mechanism if capture or coherent
wake formation is lost; arrival and scoring mean distance do not improve over
the parent; terminal yaw/lateral/load cleanup is materially lost; or joint
angle, joint speed, or projected-command exposure worsens.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric CPG turning and elongated-body posterior reactive thrust
source_mechanism: redistribute posterior half-cycle amplitude while a slower target-derived bend preserves route curvature and the traveling carrier
transferable_invariant: preserve the propulsive traveling bend and cycle-scale posterior authority while shifting a bounded amount of stroke authority from the half-cycle reinforcing unwanted yaw to the opposing half-cycle
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target feedback keeps the continuous course bend; carrier-rejected yaw selects correction sign, observed two-joint tail tangent selects the half-cycle, and the existing proximity/speed gate transfers equal bounded posterior wave authority without a clock or memory
falsification: reject if capture or wake coherence regresses, if approach time and distance integral fail to recover over amplitude removal, if yaw/lateral/load cleanup is lost, or if joint and projected-command exposure worsens
```

The new candidate has no same-worker CFD evidence; its formal result is for a
later generation to evaluate and distill.

## Non-CFD validation

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before inspecting the workspace.
  Its prescribed checks were therefore run directly.
- The material-guidance check passes after removing a duplicate rendered
  marker for the same assigned optimizer parent from `README.md`. The solver
  boundary check passes and confirms that `candidate_target_policy.jl` is the
  only solver difference from the frozen baseline.
- The deterministic schema audit found 68 direct `params.FIELD` references
  among 70 returned fields, with no missing field; only metadata fields
  `version` and `control_period` are intentionally unreferenced. The solver
  contains exactly one nonempty `candidate_target_policy.jl`, and static guards
  found no time/step state, randomness, file I/O, cylinder coordinates, or
  mutable global state.
- A `40,401`-pair algebraic grid over signed yaw demand and observed tail side
  bounds the posterior wave gain to `[0.82, 1.18]`; matched sign-reflected pairs
  sum exactly to `2.0`, confirming equal relief/boost before the inherited
  smooth command projection. The edited expression is algebraically equivalent
  to the inherited, previously smoke-tested redistribution proposal.
- The exact Julia smoke command could not execute: the available Juliaup
  launcher has no installed Julia channel, and its attempted channel bootstrap
  is blocked by the environment network. No formal CFD was run.
