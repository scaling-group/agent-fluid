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
- Treat phase-fitted recorded-state replay as an observation audit, not causal
  controller validation. On the transferred carrier, a joint-state correction
  `0.50*phi1 + 0.14*phi2` explained beat-scale heading with `0.997`
  correlation and reduced replayed bearing switching, but the evaluated
  phase-demodulated controller coupled it to a reversed mean-tail curvature
  sign and degraded the seed's `4.780L` closest approach to `12.120L`, then
  exited the upper boundary after only `8.48T`. Do not reuse that combined
  phase correction/sign reversal or infer steering sign from one correlated
  drift segment. If phase demodulation is revisited, isolate it from actuator
  remapping and require preserved far propulsion plus a better coupled-CFD
  trajectory, not merely lower replay clipping.
- Geometry-gated allocation to whole-body mean curvature is the first sampled
  3D steering mechanism to survive coupled CFD usefully: relative to the
  transferred seed it improved closest approach from `4.780L` to `1.135L`,
  extended the finite trajectory from `27.49T` to `41.84T`, retained a
  coherent alternating wake in both views, and kept raw commands at its
  explicit guard. Preserve this large-error redirect when testing terminal
  capture. Its applicability ends at the observed near miss: the fish crossed
  the target x-coordinate about `1L` low at roughly `0.64L/T`, then made a
  large departure loop. Later workers should test normalized proximity plus
  radial/tangential velocity as a continuous thrust-to-curvature allocation
  signal; reject schedules that disturb the approach before about `2.6L`, fail
  to beat `1.135L`, or replace the loop with persistent joint-limit dwell.
- For this near-miss topology, terminal *replacement* of carrier authority is
  better supported than scalar drive relief or curvature boosting. A convex
  blend from the oscillatory carrier to bounded damped tracking of the same
  body-frame mean-curvature request, gated by distance below `4L` and the
  existing redirect angle, preserved the organized far wake and captured at
  `25.26T` (`0.7469L`, mean distance `2.4318L`). A closing-gated cadence hold
  also captured but only after a large loop at `51.65T`, while proximity plus
  tangential/closure-gated amplitude relief and curvature boost still missed
  at `1.108L` and exited. Preserve the far carrier, but when proximity and
  large geometry error coincide, give the mean bend actual joint-excursion
  authority instead of layering a stronger scalar request onto the rhythm.
  This lesson is bounded to the sampled still-water near-miss: the fast capture
  still touched acceleration/rate limits, so require coupled capture and low
  angle dwell under changed initial/target conditions before claiming robust
  actuator margin.
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
