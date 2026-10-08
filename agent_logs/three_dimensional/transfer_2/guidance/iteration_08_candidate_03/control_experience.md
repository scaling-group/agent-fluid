# Dogfish L64 3D Moving-Window Still-Water Policy Experience

## Persistence contract

This file is mutable optimizer state, not a static task description. Every
successful worker must leave it with at least one material, evidence-backed
lesson added or revised from its assigned parent. Distill sampled solver results
and available inherited logs into a reusable control implication plus an
applicability or falsification boundary. When prior evidence shows no
improvement, record the concrete negative result and what later workers should
avoid or test; do not use a generic no-progress sentence or a cosmetic or
identifier-only change. The current worker's new CFD evaluation occurs after
it exits and therefore becomes evidence for a later sampled worker.

- This is a fresh 10-iteration lineage with no solver or optimizer population
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- This lineage starts from the transferred 2D clean-B iteration-20 champion.
  It contains target-aware feedback; evaluate its actual 3D performance rather
  than assuming either successful transfer or a missing steering mechanism.
  No 3D solver or optimizer population is imported.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Steering release is useful only as a partial correction in this lane, not a
  source of the missing counter-turn.  Yaw-response release changed the seed's
  `4.780/9.709L` minimum/final distance to `4.660/9.604L` but retained the
  lower exit and about `98%` raw acceleration-envelope exposure.  Geometry-
  gated wrong-polarity curvature release then improved minimum distance to
  `4.141L` and survival from `28.369T` to `32.197T`, yet still exited below at
  `9.570L`; late progress-gated cadence relief likewise retained the lower
  topology while worsening closest approach to `5.347L`.  Preserve the
  coherent `0.55T/28 deg` posterior-lagged carrier and the evidenced curvature
  release, but do not repeat another release threshold, yaw-window gain, or
  cadence gate as the sole mechanism.  This implication applies while the
  evaluator's seven-state history spans only about `0.0385T` and the carrier
  remains clipping-dominated; it would be falsified by a genuinely cycle-scale
  response signal or carrier-allocation mechanism that changes termination or
  produces a meaningfully different useful trajectory without losing the deep
  approach.
- Keep slow body-frame route geometry separate from subcycle yaw feedback, but
  do not infer that two individually useful branches will combine. The
  assigned persistent-route plus target-behind recapture controller has now
  been evaluated: against basic recapture it changes minimum distance only
  from `3.031L` to `2.996L`, and both trace the same broad upper loop to a
  left-domain exit near `49.4T` at about `7.52L` final range. Posterior carrier
  unloading cuts reconstructed raw acceleration-envelope exposure from
  `92.77%` to `82.97%` without changing that topology (`3.024L` minimum), so
  carrier relief is a load-allocation adjunct, not evidence of tighter
  recapture. A closing/abeam sector pulse followed by the same pivot is the
  strongest sampled approach (`2.579L` at `25.102T`, `82.76%` exposure), but
  it too makes a broad turn and exits left at `45.331T` with `7.435L` final
  range. Preserve its sector timing as the current useful base; avoid another
  gate, posterior relief factor, or curvature-gain-only variant. The next
  discriminating test is component-level actuator allocation during the
  observed sector: reserve bounded joint-acceleration authority for route and
  mean-curvature steering before admitting the oscillatory carrier, then
  restore the carrier on geometric release. This implication applies while
  raw carrier peaks (`74/113 rad/T^2`) exceed the `31.416 rad/T^2` envelope
  and the wake remains coherent; falsify it if explicit priority does not
  change in-sector actions, destroys the off-sector carrier, worsens the deep
  pass, or retains the same non-capturing upper loop.
- Prefer normalized body-frame feedback changes that are bounded and carry a
  falsifiable expectation. Let evidence choose the observation and mechanism;
  do not hard-code a global-direction command, coordinates, target identity,
  elapsed time, step count, iteration number, or a case-specific route.
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
- Inspect both top-down and oblique 3D keyframe rows before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination. A prewarm
  artifact is a contract failure in this direct-uniform experiment.
- Prefer normalized body-frame feedback. Inflow, target position, initial pose,
  and hydrodynamic conditions are intended held-out axes; coordinate
  memorization is not a valid solution.
- Treat every proposed observation as an empirical hypothesis: establish its
  scale, convention, and measurable effect from the current evidence before
  relying on it.
- Compare successful, near-miss, and failed trajectories without assuming a
  particular causal decomposition in advance.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
