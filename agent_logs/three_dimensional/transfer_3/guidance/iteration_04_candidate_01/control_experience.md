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
- In direct-uniform still water, damped actuator reallocation—not more
  curvature superposed on the carrier—resolved the fast terminal miss. The
  transferred controller's coherent wake reduced distance from `12.328L` to
  `4.780L` before lower-boundary exit; a geometry-gated redirect reached
  `1.135L` but consumed posterior excursion and produced large terminal loads.
  Continuously replacing most of the carrier inside `4L` with tracking of a
  shared two-joint curvature equilibrium preserved the approach and captured
  at `25.26T`; inside `2.1L` it had zero acceleration-cap incidence and low
  force/yaw-moment maxima of about `0.0029/0.0009`. For a fast misaligned
  approach after propulsion is established, reserve joint excursion by
  blending into damped mean curvature with a small carrier floor. This result
  is not established under imposed wakes or altered poses and is falsified if
  capture, low terminal saturation, or the coherent far wake does not survive.
- Three nearby refinements bound that terminal mechanism. Closing-supported
  release was exactly behaviorally neutral on the continuously closing capture
  (same `-0.53064634` score and `2.431797L` mean distance), while two bounded,
  speed-gated body-frame velocity-course residuals retained capture but
  worsened mean distance to `2.4319998L` and `2.4327134L`; all four sampled
  paths were identical outside `4L`. Do not add another terminal course
  residual or recession gate to this topology without evidence of an actual
  near-target recession or miss. Preserve the captured curvature allocation
  and move the next test upstream: outside `4L`, the common carrier still put
  about `50.5%/40.3%` of joint commands at the acceleration cap and both joint
  rates reached their limit. This boundary does not rule out velocity-course
  feedback under altered initial poses, externally advected flow, or a genuine
  recession, but such use must be speed-qualified and must outperform geometry
  feedback in a coupled rollout rather than an offline replay.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
