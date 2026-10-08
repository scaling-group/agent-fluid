# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver artifacts, and the
  inherited optimizer notes/results were read before choosing a mechanism. All
  sampled runs are finite captures from direct uniform still water at
  `U_infinity=(0,0,0)`, without cylinders or prewarm. Three artifacts are the
  same evaluated v33 policy and outcome; v30 is the distinct comparison.
- The combined sheets for sampled v33 and v30 were inspected from release to
  capture in both views. Each empty initial field develops a coherent
  alternating top-down vortex street and compact paired oblique Lambda2
  structures behind a fish that follows the same broad target-directed arc.
  The motion is self-propelled rather than advected, neither wake breaks up,
  and the controller differences are below the sheet's visual resolution.
- Sampled v30 captures at `23.8315T` with score `-0.535298`, scoring mean/final
  distance `2.433642/0.746599L`, and inside-`3L` mean/peak absolute yaw
  `1.6816/3.2645 rad/T` plus mean/peak absolute moment
  `0.006393/0.014385`. Prefilled v33 preserves the posterior traveling-wave
  amplitude and lag while moving its phase-selected excess-yaw residual to the
  anterior oscillator. It captures at `23.8425T` and improves score,
  mean/final distance, terminal mean/peak yaw, and terminal mean/peak moment to
  `-0.535091`, `2.433543/0.746165L`, `1.6800/3.1848 rad/T`, and
  `0.006382/0.013730`, respectively. This is a narrow positive result, not a
  solved terminal-regulation problem.
- The inherited v34 fixed transfer of continuous course curvature from the
  posterior tangent to the anterior center further reduced terminal yaw/load,
  but regressed score to `-0.535920`, mean/final distance to
  `2.434212/0.747022L`, and arrival to `23.8480T`. Together with earlier
  posterior relief, moment-gating, redistribution, and phase-lag failures,
  this rules out another allocation share, load gate, or scalar steering-gain
  edit.
- The remaining actionable defect is in v33's observation decomposition.
  Inside `3L`, its nominal carrier-rejected rate
  `heading_rate + 0.50*phi_dot[1]` still has correlation `-0.954` with the
  normalized full-tail tangent velocity `phi_dot[1]+phi_dot[2]`; its RMS is
  `0.635 rad/T`, versus a slow signed mean of only `0.111 rad/T`. Thus the
  terminal residual can still mistake the propulsive beat for route-scale
  excess yaw. A bounded replay adding `0.30` of full-tail rate inside the
  existing `0.50` carrier conversion reduces the residual RMS to
  `0.230 rad/T` and the correlation magnitude to `0.388`, while preserving the
  mean at `0.107 rad/T`. These are observer-replay diagnostics, not a claim of
  CFD improvement.

## Candidate hypothesis recorded before policy edit

Preserve v33's evaluated state-feedback carrier, response-released body-frame
C-bend, continuous terminal course correction, anterior half-cycle residual,
posterior amplitude/lag, cadence, and smooth component-wise command projection.
Change only the terminal carrier observer: form its joint-rate coordinate from
the anterior rate plus a bounded share of the observed full-tail tangent rate.
Use that distributed two-joint coordinate wherever v33 currently removes the
fast carrier from heading rate. Do not change the route request, steering
authority, phase gate, or actuator distribution.

The hypothesis is that a cleaner separation of fast periodic carrier yaw from
slow route-scale yaw will avoid unnecessary anterior correction without
discarding the slow signed residual. Falsify it if capture or coherent wake
formation is lost; score, arrival, or mean/final distance regresses from v33;
inside-`3L` yaw, target-transverse speed, or moment returns toward or beyond
v30; or joint/command-limit exposure grows. Replay decorrelation alone is not
success—the post-worker CFD result must retain progress and improve or preserve
terminal dynamics.

```text
bookshelf_consulted: true
source_domain: fish-swimming carrier dynamics and closed-loop wake-disturbance separation
source_mechanism: separate slow persistent course error from fast alternating propulsive motion before applying a bounded residual correction
transferable_invariant: a route controller should reject the observed two-joint traveling-wave carrier rather than treat periodic body yaw as persistent target error
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: augment the normalized body-frame terminal yaw observer with a bounded share of observed full-tail tangent velocity while preserving v33's target geometry, state-derived phase gate, posterior wave, and two-joint actuation
falsification: reject if capture or wake coherence regresses, v33-scale progress is lost, terminal yaw/lateral/load metrics worsen, or actuator-limit exposure increases despite improved offline carrier decorrelation
```

The candidate has no same-worker CFD evidence. Its formal rollout is evidence
for a later worker.

## Non-CFD validation

- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account and failed before inspecting the
  workspace. Its three listed checks were therefore executed directly and
  separately.
- The guidance-materiality check initially exposed a duplicate rendered marker
  for the same assigned parent in `README.md`. Removing only the duplicate
  listing made the parent unambiguous; the rerun passes and confirms these
  notes plus a semantic, evidence-backed `control_experience.md` update.
- The solver-boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`, and its diff from
  evaluated v33 is limited to the two-joint carrier-rate observation path,
  returned diagnostics, metadata, and its owned parameter.
- The deterministic schema audit finds all `69` direct `params.FIELD`
  references among `71` fields returned by `target_policy_params()`, with no
  undeclared reference; only metadata fields are unreferenced. Static guards
  find no time/step input, randomness, file I/O, cylinder state, fixed route,
  or mutable global state.
- The prescribed Julia contract smoke test cannot run because no `julia`
  executable is installed. The candidate edit preserves the already evaluated
  v33 expressions except for the bounded carrier observer described above.
  No formal CFD was run.
