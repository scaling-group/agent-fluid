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
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Direct-uniform still-water evidence separates propulsion progress from route
  control. The drive-only seed formed a coherent 3D posterior wake but reached
  only `12.078L` before upper exit. Four inherited shared/partial
  mean-curvature variants then retained `left_domain` and regressed final
  distance to `13.258--15.361L`; do not retry common, shared, or tail-biased
  moving equilibria by scalar gain changes. Anterior useful-half-cycle steering
  instead improved minimum/final distance to `11.782/11.797L`, while posterior
  half-cycle scaling and a shared residual were weaker (`12.006/12.205L` and
  `12.140/12.686L`). A later slip-aware, both-stroke anterior residual retained
  the alternating wake and improved monotonically to `10.062L`, yet all sampled
  variants still hit the `260 deg/T` rate cap and exited the upper boundary. In
  that strongest trace, bearing reversal was followed by opposite joint means
  of about `-0.081/+0.122 rad` near exit because the full biased anterior angle
  entered the `-q1` tail target. Reuse the narrow positive result—body-frame
  slip feedback and anterior steering can preserve thrust and substantially
  improve progress—but do not treat an opposite-mean posterior response or
  more drive gain as directed turning. The subsequent anterior-only curvature
  center with a zero-mean posterior lag is a real semantic improvement: all
  four sampled descendants replace the early upper hook with a long
  lower-going trajectory, preserve self-propelled 3D wake evidence, and reach
  `4.233--5.033L`. It is not yet route control. The plain center passes below
  the target with bearing near `1.13 rad` at its `5.033L` minimum and exits at
  `28.59T`. Bearing-gated posterior relief gives the narrow best result:
  minimum/mean distance improve to `4.233/8.611L`, survival extends to
  `31.87T`, and tail rate-cap occupancy falls from about `13.4%` to `5.2%`;
  nevertheless bearing is still `1.405 rad` at closest approach and the same
  lower exit remains. Target-signed slip rectification independently reaches
  `4.252L` but retains that topology, so it is not a reliable missing
  mechanism. Recent-yaw unloading reaches `4.376L` but lets joint motion,
  command effort, and the visible wake decay nearly to zero after about `18T`,
  leaving an inertial coast to the boundary. Reuse anterior/tail mean
  separation and modest posterior relief, but avoid direct recent-yaw
  unloading and further slip or relief scalar tuning as substitutes for yaw
  authority. The subsequent phase-selective tests now close that branch more
  firmly. An anterior redirect plus symmetric relief reached `4.018L`,
  posterior half-stroke redistribution reached `3.909L`, and their whole-body
  combination reached the lineage-best `3.691L`; all preserved coherent
  top-down and oblique 3D wakes but still passed below the target and exited
  low. Two inherited continuations then kept that combined mechanism active
  with full head-relative target geometry. Both reproduced the `3.691L`
  minimum exactly yet still exited low, with slightly worse final distance
  (`9.328--9.329L` versus `9.294L`) and full error still about
  `2.39--2.42 rad` near `32T`. Thus correcting folded-bearing release is
  semantically valid but neither it nor more half-cycle, relief, or
  redirect-gain tuning supplies the missing yaw authority. Later workers
  should preserve the narrow best-distance result only as a baseline, avoid
  further variants of that same gate/asymmetry family, and test a different
  bounded allocation of the anterior angle/rate envelope—such as trading
  carrier amplitude for target-signed turn posture while keeping the
  posterior mean separated. Falsify such an allocation if it loses the
  coherent carrier, increases angle/rate-limit occupancy, fails to reduce
  target error before the miss, or retains the lower-exit topology.
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
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
