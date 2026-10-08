# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before candidate selection

- I read the assigned-parent guidance, all four sampled solver artifacts, and
  the inherited optimizer notes and completed v36 rollout before selecting the
  candidate. Every compared evaluation used direct uniform still water at
  `U_infinity=(0,0,0)`, without cylinders or prewarm, remained finite, and
  terminated in capture.
- The four sampled solvers are byte-identical evaluations of v33: their
  combined keyframe SHA-256 is the same, and each reports capture at
  `23.8425T`, score `-0.535091`, scoring mean/final distance
  `2.433543/0.746165L`, and `236` moving-window shifts. They are repeat
  evidence for one strong finite controller, not four independent designs.
- I inspected the sampled v33 and inherited v36 combined sheets from release
  through capture, including both the top-down mid-plane vorticity row and the
  oblique 3D body/Lambda2 row. In each initially quiescent field, a visibly
  self-propelled fish develops a spatially ordered alternating wake and compact
  paired three-dimensional structures while following the same broad curved
  route toward the target. Neither rollout shows passive advection, wake
  breakup, a boundary encounter, or instability. The v36 change is below the
  visual sheets' resolution, and the aligned head paths differ by at most
  `0.00384L`; vortex prominence therefore cannot decide between them.
- The trajectory and load histories distinguish the candidates. V33 captures
  at `23.8425T` with score/mean/final distance
  `-0.535091/2.433543/0.746165L`. Inside `3L`, its mean/peak absolute yaw is
  `1.6800/3.1848 rad/T`, mean body-lateral speed is `0.25221U`, and mean/peak
  absolute yaw moment is `0.006382/0.013730`. Its anterior/posterior
  `99%`-velocity-cap exposure is `14.28%/5.72%`, with no joint-angle-limit
  contact.
- Assigned-parent v36 restored a bounded share of approach-suppressed cadence
  whenever v33's terminal regulation was active. It crossed one control step
  earlier at `23.8370T`, but worsened score/mean/final distance to
  `-0.535652/2.433974/0.746760L`. Inside `3L`, mean/peak yaw changed to
  `1.6831/3.2070 rad/T`, body-lateral speed to `0.25247U`, and mean/peak
  moment to `0.006409/0.013694`; joint-speed exposure and projected-command
  envelopes were essentially unchanged. Thus the tiny arrival change did not
  supply the claimed distance-progress or regulation benefit. This is a
  concrete negative result for coupling terminal-regulation magnitude to a
  scalar cadence reserve, not evidence that more reserve should be tried.
- Together with completed v34-v36 allocation, observer-cancellation, and
  cadence interventions, this leaves v33 as the strongest measured balance of
  target closure, coherent propulsion, and bounded terminal correction. No
  positive rollout evidence supports another scalar share, gain, or terminal
  cue gate in this iteration.

## Candidate selection and falsifiable hypothesis

Retain the exact evaluated v33 policy already materialized at
`solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl` as the single
exploit candidate. It preserves the state-feedback traveling-wave carrier,
response-released body-frame C-bend, continuous target-course correction,
phase-selected anterior excess-yaw residual, posterior amplitude and lag, and
component-wise smooth command projection. Do not inherit v36's
regulation-to-cadence coupling, and do not replace it with a smaller scalar
share unsupported by a completed rollout.

The hypothesis is reproducibility: under the frozen contract, the candidate
should retain the coherent alternating wake and reproduce v33-scale capture,
arrival, distance integral, terminal yaw/load behavior, and actuator exposure.
Falsify materialization if capture or wake coherence is lost; arrival or
mean/final distance moves toward the v34-v36 regressions; terminal yaw, lateral
speed, or moment worsens materially; or joint/command-limit exposure grows. A
materially different evaluation of the byte-identical policy should be audited
for nondeterminism or materialization mismatch before attributing it to a new
control mechanism. No same-worker CFD result is claimed.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive thrust and sensor-modulated robotic-fish terminal control
source_mechanism: preserve a posterior traveling-wave propulsive carrier while applying only the smallest observed-phase target correction supported by closed-loop evidence
transferable_invariant: terminal regulation must retain target closure, and a coherent tail-driven traveling wave should not be retuned merely to clean yaw or marginally advance the crossing sample
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, hardware duty ratios, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: no new shelf primitive is adopted; retain v33's normalized body-frame geometry, state-derived tail-side phase gate, bounded anterior correction, posterior lag, and two-joint actuation exactly as evaluated
falsification: reject if the retained artifact fails to reproduce capture, v33-scale distance progress, coherent alternating propulsion, terminal yaw/load, or actuator-envelope behavior under the same frozen evaluation
```

The shelf was used as a mechanism filter after consecutive completed
iterations lacked a semantic improvement. It does not justify a gain change or
override the v36 closed-loop negative result.

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and it failed before
  inspecting the workspace. Its prescribed deterministic checks were run
  directly and separately.
- The guidance-materiality check passes after removing one duplicate rendered
  marker for the same assigned parent from the workspace `README.md`.
  `control_experience.md` now contains a semantic, evidence-backed v36 lesson.
- The solver-boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`; its SHA-256 is
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`,
  byte-identical to all four sampled evaluated v33 policies.
- The Julia contract smoke command cannot start because no `julia` executable
  is installed. A deterministic static audit finds all `68` direct
  `params.FIELD` references declared among the `70` fields returned by
  `target_policy_params()`; only metadata fields `version` and
  `control_period` are unreferenced. Static guards find no executable clock,
  step, randomness, file I/O, mutable global state, cylinder identity, or
  memorized route. The byte-identical evaluated artifact supplies prior runtime
  evidence. No formal CFD was run.
