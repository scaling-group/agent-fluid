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
- Put route steering upstream of final acceleration clipping and keep its slow
  body-frame geometry channel separate from subcycle yaw feedback, but treat
  target passage as a distinct control regime. Opposing-only half-cycle relief
  first changed the lower exit into a left exit and reached `3.033L`; making
  that relief persist with route error then produced the sampled best
  `2.999L` pass, reduced raw acceleration-envelope exposure from `93.63%` to
  `89.62%`, and modestly improved final distance from `9.314L` to `8.965L`.
  This assigned-parent result still left the target behind and `2.805L`
  lateral at closest approach, followed by the same westward runout, so
  persistent phase allocation is useful target-ahead authority but is not a
  recapture maneuver. A separately completed target-behind posterior-curvature
  branch supplies the missing semantic capability: it preserves the common
  approach through `22T`, produces the only sampled late hairpin, extends
  survival to `49.319T`, improves mean distance to `7.107L`, and raises score
  to `-8.514`. It remains incomplete because it still exits with the target
  behind and `7.016L` lateral. Do not arm mean curvature merely in the abeam
  sector: the sampled early abeam burst retained the left exit and slightly
  worsened closest approach from `3.033L` to `3.035L`. The reusable structure
  is therefore route-persistent half-cycle allocation while the target is
  ahead plus a separate mirror-equivariant, body-frame target-behind recapture
  mode that releases on reacquisition; their combined closed-loop effect is
  not yet evaluated. This applies while the seven-state history remains
  subcycle and passage is observable from normalized forward target position;
  falsify it if the combined controller perturbs the deep approach, increases
  limit exposure materially, turns before definite passage, or completes
  another non-capturing hairpin with the target still behind.
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
