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
- The sampled target-steering comparison separates useful posterior steering
  from three failed corrections. Re-centering both joints on a `10 deg` bias
  reduced anterior excursion from `0.459` to `0.175 rad`, reduced mean force
  magnitude from `0.0077` to `0.0003`, left both visual views nearly wake-free
  through `8T`, and worsened final distance to `13.411L`; do not move the
  anterior oscillator equilibrium when this carrier is working. With that
  equilibrium preserved, bearing-lookahead posterior mean curvature remains
  the strongest result (`11.413/11.421L`, upper exit at `9.740T`). A
  yaw-rate-damped static bias reached only `12.091L`; posterior half-cycle
  asymmetry reached `11.778L` and exited earlier at `8.800T`; and the inherited
  desired-turn-rate residual reached `11.858L` while raising raw posterior
  acceleration-envelope exceedance from `54.9%` to `69.8%`. The last failure
  also shows that the adapter's seven-entry `turn_rate_recent` window (about
  `0.033T`) is not a slow-yaw observable and should not be treated as one. At
  `4T` all four evaluated policies still have a small positive bearing
  (`+0.06` to `+0.16 rad`) while normalized body-frame lateral velocity is
  already `+0.21` to `+0.26 U`; bearing reverses by `5T` after the upward
  course is established. For this coherent-wake, inertial-sideslip topology,
  preserve posterior-only mean curvature but test target-versus-course error
  from bounded body-frame velocity instead of more curvature, phase
  asymmetry, or beat-scale yaw-rate feedback. Falsify this implication if
  course compensation cannot beat `11.413L` or improve the upper-exit class
  without persistent limiting; it does not apply to a weak-thrust gait or to
  genuinely slow yaw estimates.
- On the preserved course-compensated carrier, an observed-response gate is
  the first sampled steering change to alter termination class. The fixed
  `12 deg` posterior-curvature controller retained a coherent wake but passed
  its `5.144L` closest point and exited the upper boundary at `18.975T`; adding
  bearing-gated scalar carrier shrink produced the same topology (`5.086L`,
  `19.201T`) and essentially unchanged posterior limit residence (`35.9%`
  versus `36.2%`). In contrast, gating `24 deg` mean curvature and stronger
  attenuation-only opposing-lobe relief by normalized target-versus-course
  mismatch captured at `0.746L` and `16.291T` with a coherent wake. Preserve
  this response-gated redirect rather than revisiting scalar carrier shrink,
  but treat its `60.4%` posterior acceleration-limit residence and higher
  mean/max force magnitude (`0.0156/0.0372`) as the next constraint target.
  Test constraint-aware or reliably-closing near-field relief without moving
  the anterior equilibrium or weakening rescue authority; falsify the lesson
  if capture does not survive held-out poses or if lower limit residence loses
  the direct target trajectory.
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
