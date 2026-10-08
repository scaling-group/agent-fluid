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
- In direct-uniform still water, that drive-only seed generated a visible
  three-dimensional posterior wake and briefly reduced distance from
  `12.328L` to `12.078L`, but both joints reached the `260 deg/T` rate cap,
  yaw swept about `103 deg`, progress reversed, and the fish exited the upper
  boundary at `8.55T`. Visible self-propulsion therefore does not establish
  directed control: retain posterior lag, but test bounded body-frame
  target-to-mean-curvature feedback with yaw-response unloading before using
  drive-scalar tuning as a steering surrogate. Revisit this implication if a
  later candidate loses its posterior wake (a propulsion deficit) or the
  closed-loop curvature preserves the same early-exit topology (wrong sign,
  insufficient authority, or a drive/steering interaction).
- Across the assigned-parent progression and the current four samples,
  preserving an always-available anterior-only mean-curvature center while
  keeping the posterior lag zero-mean is the first change to escape the common
  upper exit: it retained a coherent 3D wake through `28.59T` and reached
  `5.033L`, whereas rectifier-only and rectifier-to-center handoffs exited high
  near `10.64--11.20T` with minima of `9.402--10.062L`. The positive result is
  still incomplete: the anterior center saturated near `8 deg` as cycle-mean
  bearing grew to roughly `66--80 deg`, distance reversed, and the fish left
  low at `9.084L`, with both joint rates still touching their caps. When this
  topology recurs, retain the useful mean center and test a bounded,
  large-error phase-selective redirect rather than gating the center off at
  modest bearing or merely increasing its static limit. Falsify that transfer
  if it destroys the alternating posterior wake, materially worsens rate/load
  saturation, fails to beat the `5.033L` minimum, or preserves the large-bearing
  lower-exit arc.
- Later descendants sharpen the large-bearing failure: target-signed slip
  unloading, yaw-response unloading, a phase-speed anterior residual, and 65%
  posterior-carrier relief all retained the coherent wake and improved closest
  approach from the anterior-center baseline's `5.033L` to
  `4.233--4.859L`, but every policy still passed below the target and exited
  low. Carrier relief was the useful edge case: it reached `4.233L`, survived
  to `31.87T`, reduced late acceleration-cap occupancy from roughly
  `0.22--0.25` to `0.09--0.11`, and briefly moved two-second mean heading in
  the corrective direction from `0.663` to `0.625 rad`; nevertheless mean
  bearing rose to about `1.42 rad` before heading turned away again. Thus
  yielding posterior thrust at large error is helpful but not sufficient, and
  another relief fraction, slip algebra change, or phase-speed residual should
  not be treated as a new redirect. When this combination of coherent thrust,
  temporary corrective yaw, and a large-bearing fly-by recurs, test a bounded
  geometry-triggered gait transition that couples carrier suppression to
  additional curvature and restores the carrier as bearing falls. Falsify that
  implication if the transition loses the early wake or fails to improve on
  `4.233L`, or if bearing falls yet target distance still reverses, which would
  point to approach timing rather than insufficient yaw authority.
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
