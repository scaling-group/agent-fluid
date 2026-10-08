# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before candidate selection

- I read the assigned-parent guidance, all four sampled solver results, and the
  inherited optimizer notes and evaluated rollouts before selecting a policy.
  Every sampled result is a finite capture from direct uniform still water at
  `U_infinity=(0,0,0)`, without cylinders or prewarm. The four sampled policy
  files, combined keyframe sheets, and scored outcomes are byte-identical v33
  repeats, so they support reproducibility of one mechanism rather than four
  independent comparisons.
- I inspected the sampled v33 and inherited v35 combined sheets from release
  to capture, including both the top-down mid-plane vorticity row and the
  oblique 3D body/Lambda2 row. Each empty initial field develops a coherent
  alternating wake behind a visibly self-propelled fish. Compact paired 3D
  structures follow the body along the same broad target-directed arc, with no
  wake breakup, passive advection, boundary approach, or instability. The v35
  regulation change is below the visual sheets' resolution, so its value must
  be decided from the trajectories rather than vortex prominence.
- Sampled v33 captures at `23.8425T` with score `-0.535091`, scoring
  mean/final distance `2.433543/0.746165L`, and inside-`3L` mean/peak absolute
  yaw `1.6800/3.1848 rad/T`. Its inside-`3L` mean/peak absolute moment is
  `0.006382/0.013730`, mean body-lateral speed is `0.2522U`, and it has no
  joint-angle-limit exposure. The current artifact is byte-identical to that
  evaluated policy (`76326f8c...48a0d`).
- Inherited v35 is the informative performance failure. It added a `0.30`
  full-tail-rate share to v33's terminal carrier observer and reduced
  inside-`3L` mean/peak yaw to `1.6103/3.0497 rad/T`, mean body-lateral speed
  to `0.2391U`, and mean moment to `0.006106`. Nevertheless, score, arrival,
  mean distance, and final distance regressed to
  `-0.535811/23.8975T/2.434232L/0.746866L`; peak moment rose to `0.013912`,
  while actuator envelopes were essentially unchanged. The paths agree until
  the existing `3L` gate, after which v35's mean closure is lower despite its
  cleaner yaw history.
- A trajectory replay of v33 adds a useful boundary to that comparison. Its
  phase-selected anterior correction is concentrated on the observed
  tail-returning portion of the carrier; inside `3L`, samples with material
  support (`support > 0.1`) have mean radial closure `0.700L/T`, versus
  `0.672L/T` outside that support. This correlation is not proof that more
  correction is better, but it makes suppressing the validated correction to
  improve a residual trace especially weak: v35 provides the required
  closed-loop falsification.

## Candidate hypothesis recorded before policy disposition

Retain the exact evaluated v33 anterior-half-cycle controller already present
in `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`. This is
one evidence-backed exploit candidate. It preserves the coherent
state-feedback traveling wave, response-released body-frame C-bend,
continuous target-course correction, phase-selected anterior excess-yaw
residual, posterior amplitude and lag, and component-wise smooth command
projection.

Do not inherit v35's distributed instantaneous-rate observer, and do not use
its lower offline residual correlation or lower yaw trace as a surrogate for
target progress. The falsifiable expectation is reproduction of v33-scale
capture, distance progress, terminal dynamics, and actuator exposure. A
materially different rollout under the same frozen contract should be audited
for nondeterminism or materialization mismatch before it is attributed to a
new controller effect.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive thrust, state-feedback rhythmic swimming, and terminal capture control
source_mechanism: preserve the posterior traveling-wave carrier and apply only bounded target-relevant correction rather than cancelling all lateral motion
transferable_invariant: regulation is useful only when it retains target closure; a coherent tail-driven traveling wave and its measured phase-selected correction should not be weakened merely to clean an instantaneous yaw residual
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: no new shelf primitive is adopted; retain v33's normalized body-frame geometry, state-derived tail-side phase, posterior lag, two-joint actuation, and bounded anterior residual exactly as evaluated
falsification: reject if the retained artifact fails to reproduce capture, v33-scale distance progress, coherent alternating wake structure, terminal yaw/load, or actuator-envelope behavior under the same frozen evaluation
```

The shelf was used to reject scalar-only tuning and to preserve the evidenced
propulsion/regulation balance, not to import a gain or route. The retained
candidate has no same-worker CFD evidence; its formal evaluation after this
worker exits becomes evidence for a later generation.

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before
  inspecting the workspace. Its three prescribed checks were then run
  directly and separately.
- The guidance/materiality check initially found the assigned parent marked
  twice in the rendered root `README.md`. Removing only the duplicate listing
  made the parent unambiguous; the rerun passes and confirms that these notes
  exist and `guidance/control_experience.md` has a semantic reusable update.
- The solver boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`, with SHA-256
  `76326f8c...48a0d`, byte-identical to evaluated v33.
- The exact Julia contract smoke test cannot start because no `julia`
  executable is installed. The deterministic static schema audit finds all
  `68` directly referenced parameter fields among `70` declared fields, with
  no missing references; only metadata fields `version` and `control_period`
  are unreferenced. Static guards find no clock/step input, randomness, file
  I/O, cylinder state, fixed route, or mutable global state. No CFD was run.
