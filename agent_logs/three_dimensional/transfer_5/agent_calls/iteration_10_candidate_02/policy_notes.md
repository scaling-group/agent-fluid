# Posterior phase-lag terminal-yaw damper candidate

## Visual and quantitative diagnosis before editing

- All four sampled solver rollouts and the two inherited step-9 evaluations
  satisfy the experiment contract: direct uniform `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, stable dynamics, and capture. In the combined
  sheets, the top-down rows show self-propelled broad target-directed arcs and
  coherent alternating vortex streets from release through capture. The
  oblique rows show compact paired three-dimensional Lambda2 structures rather
  than background advection or carrier collapse. The terminal controller
  differences are below keyframe resolution. The inherited informative failure
  boundary is still the weak-wake upper exit caused by replacing this carrier
  with opposite-sign static posture.
- The v24 phase-demodulated course brake is the progress baseline: capture at
  `23.8315T`, scoring mean distance `2.434073L`, peak yaw `3.208 rad/T`, and,
  inside `3L`, mean absolute yaw/cross-track speed/lateral force/yaw moment of
  `1.684 rad/T`, `0.229U`, `0.011795`, and `0.006402`. Hard course/yaw
  consensus v25 arrived at `23.8590T` with essentially unchanged terminal
  motion and loads; yaw-selected static damping v26 arrived at `23.8535T` and
  slightly increased inside-`3L` yaw to `1.687 rad/T`.
- Applying terminal mean curvature only on the nominally supporting half-cycle
  produced a real but costly change: inside-`3L` yaw/cross-track speed fell to
  `1.616 rad/T`/`0.213U`, but arrival slipped to `23.9085T` and mean distance
  to `2.434609L`. This shows that reducing phase-independent posture can clean
  up motion, but gating away most terminal authority also loses closing speed.
- The inherited step-9 logs close two other branches. Hydrodynamic-moment lead
  reached the capture boundary slightly sooner (`23.8260T`) but worsened mean
  and final distance to `2.435488L`/`0.748944L`, while near-field yaw and load
  remained near v24. Pressure-gated residual allocation arrived at `23.8535T`,
  worsened mean/final distance to `2.435590L`/`0.748793L`, and increased
  inside-`3L` yaw to `1.704 rad/T`. Thus neither another fast-response cue nor
  reserving acceleration headroom is the evidenced missing capability.

## Policy hypothesis

Use evaluated v24 as the sole base and preserve its traveling-wave carrier,
same-sign redirect, response release, target-course terminal curvature, and
smooth acceleration projection. Add one small, independent fast-response
residual: signed carrier-rejected excess yaw requests damping, anterior joint
velocity supplies observable beat phase, and their bounded product modulates
posterior lag. The modulation is rectified by the posterior tracking equation,
so it produces a speed-weighted mean tail reaction opposing excess yaw without
gating away either propulsive half-cycle or changing the target-course request.

This should preserve v24 capture, approach speed, and alternating wake while
moving terminal yaw/cross-track/load toward the half-cycle result. Falsify the
mechanism if capture or wake coherence is lost; if arrival exceeds `23.9T` or
mean distance exceeds `2.435L` without material terminal cleanup; if peak or
inside-`3L` yaw, cross-track speed, force, or moment worsen; or if joint-speed
or high-command exposure increases. This worker does not claim the unavailable
new CFD result.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG turning
source_mechanism: preserve a traveling propulsive carrier while a bounded feedback residual changes posterior wave lag to redirect tail reaction
transferable_invariant: separate slow target-course curvature from fast excess-yaw rejection, and apply the latter through observed joint-state phase at the posterior actuator instead of another route-cue gate or phase-independent posture
nontransferable_details: published gains, dimensional cadence, full-body envelopes, robot linkage kinematics, species-specific tail motion, exact vortex phase, and prescribed routes
policy_translation: normalized body-frame target and velocity observations retain the v24 terminal brake; carrier-rejected body yaw sets a bounded damping sign and normalized anterior joint velocity modulates posterior lag within the two-joint state-feedback contract
falsification: reject if capture or coherent alternating-wake topology is lost, or if arrival, distance integral, terminal yaw/course, loads, joint-speed exposure, and command exposure do not jointly improve on the v24 and half-cycle evidence
```

## Non-CFD contract checks

- The material-guidance check and solver boundary check pass.
- The configured `julia` executable is absent, so the identical lightweight
  contract probe was run through the workspace `julia-vanda` wrapper and
  passed with finite two-joint output.
- Direct `params.FIELD` references are a subset of the fields returned by
  `target_policy_params()`.
- Static probes confirm exact v24 output outside the `3L` terminal gate. Across
  a terminal grid spanning joint angles, joint speeds, target offsets, and yaw
  rates, commands remained within `31.416 rad/T^2`; the effective posterior lag
  remained positive (`0.178` to `0.879`). A non-finite-input probe also returned
  finite bounded commands. No CFD rollout was run.
