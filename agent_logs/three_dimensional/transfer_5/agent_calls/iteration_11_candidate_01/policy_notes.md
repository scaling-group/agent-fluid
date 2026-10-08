# Anterior reaction-yaw residual candidate

## Visual and quantitative diagnosis before editing

- All four sampled rollouts and both inherited parent rollouts satisfy the
  direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, stable dynamics, and capture. In both rows of the combined
  sheets, the fish is visibly self-propelled. The top-down views show the same
  broad target-directed arc behind a strong alternating vortex street, while
  the oblique Lambda2 views show compact paired three-dimensional shedding
  through capture. The terminal variants are visually indistinguishable at
  keyframe resolution. There is no current failure sheet; the inherited
  mechanism-level failure boundary remains the weak-wake upper exit caused by
  replacing this carrier with opposite-sign static posture.
- V24 remains the sampled progress baseline: capture at `23.8315T`, scoring
  mean distance `2.434073L`, final distance `0.746924L`, and peak yaw
  `3.208 rad/T`. Inside `3L`, its mean absolute yaw, body-lateral speed,
  lateral-force coefficient, and yaw-moment coefficient are `1.684 rad/T`,
  `0.254U`, `0.011795`, and `0.006402`. Hard direction consensus in the
  assigned v25 prefill arrives later (`23.8590T`) and changes those terminal
  measures by less than two percent, so its binary cue gate is not retained.
- The inherited half-cycle candidate materially lowers inside-`3L` yaw to
  `1.616 rad/T`, but also lowers mean swimmer speed from `0.736U` to `0.718U`
  and delays capture to `23.9085T`. The latest inherited v28 posterior-lag
  damper captures at `23.8425T`, but worsens mean/final distance to
  `2.435327L`/`0.748560L`; inside-`3L` yaw (`1.678 rad/T`), body-lateral speed
  (`0.252U`), lateral force (`0.011749`), and yaw moment (`0.006374`) improve
  by less than one percent from v24. Posterior phase/lag coupling therefore
  did not deliver the predicted cleanup, and another lag-gain variant is not
  supported.
- A different response signature is consistent across v24, v25, and v28.
  Inside `3L`, the previous anterior command has Pearson correlation
  `-0.916/-0.913/-0.915` with next-step yaw acceleration, whereas the previous
  posterior command has only `-0.075/-0.073/-0.073`; previous yaw moment has
  correlation `0.966/0.965/0.966`. This is observational, not causal proof,
  but it identifies the anterior command as the sharper untested actuation
  channel for a small yaw-reaction residual.

## Policy hypothesis

Restore evaluated v24 as the sole base, including its traveling-wave carrier,
same-sign redirect, response release, continuous target-course terminal bend,
and smooth component-wise acceleration projection. Add only a bounded
near-target anterior acceleration residual whose sign follows carrier-rejected
excess yaw. Under the sampled joint/yaw convention, positive anterior
acceleration is associated with negative yaw acceleration, so a positive
residual for positive excess yaw is dissipative. Proximity and swimmer-speed
gates already used by v24 keep the residual out of far-field propulsion; the
`2.0 rad/T^2` cap is `6.4%` of the physical acceleration envelope and does not
gate either propulsive half-cycle or alter posterior lag.

Expected result: preserve v24 capture, approach speed, C-bend polarity, and
coherent alternating wake while reducing terminal yaw, lateral motion, and
yaw-moment exposure more materially than v28. Falsify if capture or wake
coherence is lost; if arrival exceeds `23.9T` or scoring mean distance exceeds
`2.435L` without material terminal cleanup; if peak/inside-`3L` yaw, lateral
speed, force, or moment worsen; or if joint-speed or high-command exposure
increases. The new CFD result is unavailable to this worker and is not claimed
as evidence.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: preserve a rhythmic propulsive carrier and layer a small bounded feedback residual on a response-relevant actuator instead of replacing the gait
transferable_invariant: separate slow target-course curvature from fast excess-yaw rejection, and make the rejection residual smaller than the carrier while retaining every propulsive stroke
nontransferable_details: published gains, dimensional cadence, robot linkage kinematics, species-specific wave envelopes, exact vortex phase, and task-specific routes
policy_translation: normalized body-frame target geometry retains v24 course steering; carrier-rejected normalized yaw and distance/speed gates add a bounded anterior joint-acceleration residual under the evidenced joint/yaw sign convention
falsification: reject if capture or coherent alternating-wake topology is lost, or if arrival, distance integral, terminal yaw/lateral motion, loads, joint-speed exposure, and command exposure do not jointly improve on v24 and v28
```

## Non-CFD contract checks

- The material-guidance check and solver boundary check pass. The rendered
  workspace duplicated its copied-parent marker; removing only that duplicate
  allowed the guidance checker to identify the assigned parent and verify the
  semantic experience update.
- The configured `julia` executable is absent, so the exact lightweight policy
  contract probe was rerun through the inherited `julia-vanda` wrapper and
  passed with finite two-joint output.
- All `68` direct `params.FIELD` references are fields returned by
  `target_policy_params()`.
- A static grid of `1,620` near/far states spanning joint angles, joint speeds,
  yaw rates, and distance produced finite commands within `31.416 rad/T^2`.
  Candidate output exactly matched v24 outside the `3L` gate, and explicit
  positive/negative-yaw probes changed anterior output with the intended
  dissipative sign. No CFD rollout was run.
