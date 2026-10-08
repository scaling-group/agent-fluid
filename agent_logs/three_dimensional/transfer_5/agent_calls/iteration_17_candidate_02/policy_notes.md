# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver evaluations, and the
  available inherited optimizer notes were read before selecting a mechanism.
  Every sampled rollout used direct uniform still-water initialization at
  `U_infinity=(0,0,0)`, with no cylinders or prewarm, remained finite, and
  terminated in capture. The motion is therefore self-propulsion rather than
  background advection or a stale-flow artifact.
- The combined keyframe sheets for the best sampled v33 anterior half-cycle
  controller and the informative v24 baseline were inspected from release to
  capture in both views. The initially empty field develops a coherent
  alternating top-down vorticity street and compact paired oblique Lambda2
  structures behind a fish following the same broad target-directed arc.
  Neither wake breaks up before capture. The terminal differences are below
  the sheet's visual resolution, so the trajectory, load, joint, and score
  histories determine the intervention.
- Sampled v33 is the strongest finite result: it captures at `23.8425T` with
  score `-0.535091`, scoring mean distance `2.433543L`, and final distance
  `0.746165L`. Inside `3L`, its mean/peak absolute yaw is
  `1.6800/3.1848 rad/T`, mean body-lateral speed is `0.2522U`, and mean absolute
  lateral force/yaw moment is `0.011756/0.006382`. No joint-angle or projected-
  command exposure is introduced. Relative to v24, the phase-selected
  anterior residual improves the distance integral and trims peak yaw/moment
  while preserving posterior amplitude and lag, although it does not solve
  terminal yaw.
- The inherited v34 continuous anterior transfer is a useful negative/positive
  boundary. Moving `25%` of the active posterior course bend to the anterior
  oscillator improves v33's terminal mean/peak yaw to
  `1.6440/3.1207 rad/T`, body-lateral speed to `0.2463U`, lateral force to
  `0.011561`, and mean/peak moment to `0.006271/0.013582`, but worsens score to
  `-0.535920`, capture to `23.8480T`, scoring mean distance to `2.434212L`, and
  final distance to `0.747022L`. Thus anterior course allocation is a real
  stabilizing coordinate, but applying it continuously discards useful
  posterior course authority. Earlier moment gates, target-course gates,
  posterior relief/boost redistribution, and scalar relief changes likewise
  failed to recover posterior-relief progress.

## Policy hypothesis recorded before policy edit

Use evaluated v33 as the sole behavioral base. Preserve its state-feedback
traveling-wave carrier, posterior oscillatory amplitude and lag, response-
released body-frame C-bend, continuous terminal course bend, phase-selected
anterior excess-yaw residual, and component-wise smooth acceleration
projection. Add one bounded actuator-allocation mechanism: transfer the
inherited v34 share of the signed posterior course bend to the anterior
oscillator only on the already observed tail-tangent half-cycle that reinforces
carrier-rejected excess yaw. The instantaneous algebraic sum of anterior and
posterior course targets remains unchanged; outside that phase the evaluated
v33 allocation is recovered continuously.

This is phase-conditioned actuator allocation rather than a gain retune. The
expected result is to retain part of v34's yaw/lateral/load cleanup while
recovering v33-scale capture time and distance integral by leaving posterior
course authority in place on the non-reinforcing half-cycle. Falsify it if
capture or coherent wake formation is lost; if score, capture time, or scoring
mean distance regresses to or beyond v34; if terminal yaw/lateral/load does not
improve over v33; or if joint-angle, joint-speed, or projected-command exposure
grows materially.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and robotic-fish half-cycle turning control
source_mechanism: preserve posterior traveling-wave thrust while phase-selecting a bounded anterior steering allocation
transferable_invariant: separate the propulsive traveling bend from corrective curvature and reallocate steering only during the observed stroke phase that reinforces unwanted route-scale yaw
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: normalized body-frame course feedback supplies the signed course bend; carrier-rejected excess yaw and observed q1+q2 form a continuous supporting-half-cycle gate that transfers a bounded share from posterior mean tangent to anterior oscillator center without clock or memory
falsification: reject if capture or wake coherence regresses, v33-scale progress is not recovered, v34-scale terminal cleanup disappears, or actuator-limit exposure worsens
```

The new candidate has no same-worker CFD evidence. Its formal result will be
evaluated after this worker exits and belongs to a later generation's evidence.

## Non-CFD validation

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before running
  checks. Its material-guidance check was then run directly; it exposed a
  duplicate rendered marker for the same assigned parent in `README.md`.
  Removing only that duplicate made parent resolution unambiguous, and the
  rerun passes. The prescribed solver boundary check also passes.
- The Julia contract command cannot start because no Julia executable is
  installed. A deterministic schema audit found all 69 direct
  `params.FIELD` references among the 71 fields returned by
  `target_policy_params()`; only metadata fields `version` and
  `control_period` are intentionally unreferenced. Static guards found no
  clock, step counter, randomness, file I/O, cylinder identity, fixed route,
  or mutable global state. Exactly one nonempty `candidate_target_policy.jl`
  exists under `solver/`.
- A `68,921`-state algebraic grid over signed excess-yaw response, observed
  tail side, and signed course target bounds the transferred share to `25%`,
  makes it identically zero on non-supporting phases, and preserves the
  instantaneous head-plus-tail course target to `1.11e-16`. The posterior
  oscillatory amplitude and lag expressions remain byte-equivalent to the
  evaluated v33 base. No CFD was run.
