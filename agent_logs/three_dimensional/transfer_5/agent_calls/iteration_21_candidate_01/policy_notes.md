# Candidate diagnosis and hypothesis

## Evidence read before candidate selection

- The assigned-parent guidance, all four sampled solver results, and the
  inherited optimizer notes/results were read before selecting the candidate.
  Every rollout used direct uniform still water at `U_infinity=(0,0,0)`, no
  cylinders or prewarm, remained finite, and terminated in capture.
- The four sampled solvers are byte-identical evaluations of v33, with the
  same combined keyframe hash and outcome. They are repeat evidence for one
  strong finite mechanism rather than four independent controller designs.
- The sampled v33 and inherited v36 combined sheets were inspected from
  release through capture in both views. Their top-down rows begin with an
  empty field and develop a coherent alternating vortex street behind a fish
  following the same broad target-directed arc. Their oblique rows develop
  compact paired Lambda2 structures that persist through the bent terminal
  approach. The fish is self-propelled rather than advected; the v36 policy
  difference is below the visual sheet's resolution and does not disrupt the
  wake topology.
- Sampled v33 captures at `23.8425T` with score `-0.535091`, scoring mean/final
  distance `2.433543/0.746165L`, and inside-`3L` mean/peak absolute yaw
  `1.6800/3.1848 rad/T`. Its coherent carrier remains inside the joint-angle
  envelope, although anterior/posterior velocity-cap exposure is
  `14.3%/5.7%`; that symptom is not evidence that extra terminal damping will
  improve target progress.
- Inherited v35 and v36 are the informative failed interventions. The v35
  two-joint carrier observer lowers inside-`3L` mean yaw to `1.6103 rad/T` and
  target-transverse speed to `0.2224U`, but delays capture to `23.8975T` and
  worsens score and mean/final distance to `-0.535811` and
  `2.434232/0.746866L`. V36's posterior tracking-spring relief likewise lowers
  mean yaw to `1.6316 rad/T` while delaying capture to `23.8865T` and
  worsening score and mean/final distance to `-0.535956` and
  `2.434335/0.746970L`. Both retain the visible wake, so their failure is a
  regulation-for-progress trade rather than loss of propulsion or stability.
- These results extend the assigned-parent warning about posterior
  counter-tangents: observer cancellation and posterior half-cycle relief can
  make terminal histories look quieter while reducing useful approach
  impulse. No completed evidence supports another posterior edit, allocation
  gate, carrier-cancellation coefficient, or scalar yaw gain.

## Candidate selection and falsifiable hypothesis

Retain the exact evaluated v33 policy already materialized in `solver/` as the
single exploit candidate. It keeps the successful target-aware C-bend,
state-feedback traveling-wave carrier, posterior amplitude and lag, continuous
body-frame terminal course bend, phase-selected anterior counter-curvature,
and component-wise smooth acceleration projection. No unevaluated terminal
regulator or scalar-only gain change is layered onto the strongest completed
result.

The hypothesis is reproducibility: the candidate should retain capture, the
coherent alternating wake, v33-scale arrival and distance integral, and its
balanced yaw/load behavior. Falsify materialization if capture or wake
coherence is lost, arrival or mean/final distance moves toward the v35/v36
regressions, terminal yaw/moment worsens materially, or joint/command-limit
exposure grows. The candidate is byte-identical to completed evidence; no
same-worker CFD result is claimed.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and sensor-modulated robotic-fish asymmetric turning
source_mechanism: preserve posterior traveling-wave authority for thrust while placing the smallest observed-phase corrective curvature at an anterior coordinate
transferable_invariant: do not suppress the posterior power stroke merely to quiet carrier-scale yaw; separate propulsion from bounded target-derived correction
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: retain v33's normalized body-frame target feedback and observed-tail-side anterior half-cycle correction while leaving posterior amplitude, lag, and cadence unchanged
falsification: reject if v33-scale capture and distance progress are not reproduced, wake coherence is lost, terminal yaw or moment worsens materially, or actuator-limit exposure grows
```

The shelf was consulted after the completed v34-v36 sequence produced no new
success or better termination class. Its actuator-role invariant supports
retaining v33, but the rollout evidence rejects adopting another posterior
amplitude, lag, or disturbance-rejection primitive in this candidate.

## Validation boundary

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported for this account and failed before it
  could inspect the workspace. Its prescribed checks were therefore executed
  directly and separately.
- The guidance-materiality check passes after removing one duplicate rendered
  marker for the same assigned parent from the workspace `README.md`. The
  solver boundary check passes and reports no change outside the permitted
  candidate file.
- The Julia smoke command cannot start because no `julia` executable is
  installed. A deterministic static audit finds all `68` direct
  `params.FIELD` references among the `70` fields returned by
  `target_policy_params()`, with no missing field. It also finds no executable
  clock, randomness, file I/O, mutable global, cylinder-coordinate, or
  memorized-route access.
- Exactly one nonempty `candidate_target_policy.jl` exists under `solver/`.
  Its SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  matching every sampled evaluated v33 artifact. No formal CFD was run.

## Validation boundary

- The material-guidance check initially found that the rendered workspace
  README marked the same assigned parent twice. Removing only the duplicate
  marker made parent selection unambiguous; the rerun passes.
- The solver boundary check passes and exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`. Its SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  matching all four sampled evaluated v33 artifacts.
- The deterministic schema audit finds all `68` direct `params.FIELD`
  references among the `70` fields returned by `target_policy_params()`, with
  no undeclared field; only metadata fields are unreferenced. Static guards
  find no executable clock, randomness, file I/O, mutable global state,
  cylinder-coordinate access, or memorized route.
- The prescribed Julia smoke check could not start because no `julia`
  executable is installed. No formal CFD was run; the candidate's existing
  completed rollout is the evidence for this exploit selection.
