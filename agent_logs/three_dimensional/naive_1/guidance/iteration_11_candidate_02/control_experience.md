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
  authority. The subsequently sampled phase-selective tests sharpen that
  boundary. An anterior redirect plus symmetric relief reaches `4.018L`, while
  adding posterior half-cycle redistribution produces the best approach,
  `3.691L`, with a coherent three-dimensional wake and about `13.7/5.5%`
  anterior/posterior rate-cap occupancy; both still pass below the target and
  exit low. In the latter trace the target passes abeam at `21.19T` and
  `3.722L`, but the folded-bearing gate starts releasing by `24.71T` at
  `4.697L` even though the full head-relative error is `2.243 rad`. A
  full-angle posterior-only descendant independently reaches `3.909L` and
  keeps its gait modulation active behind the head, yet still exits low with
  full error `2.721 rad` near `32T`; fixing target geometry is therefore not
  yaw authority by itself. The completed assigned-parent test now falsifies
  the proposed combination with the whole-body half-cycle mechanism as well.
  Full-angle activation preserves its coherent wake and `3.691L` pre-abeam
  approach exactly and lowers rate-cap occupancy slightly, but still scores
  `-10.410`, exits low at `33.65T`, and lets rear-target error rise from
  `1.60` to `2.54 rad`. During `28--32T`, its anterior/posterior means remain
  opposite-signed at about `+0.207/-0.081 rad` while mean heading rate is only
  `0.018 rad/T`: preventing false gate release leaves an S-shaped carrier with
  negligible sustained yaw. Preserve full normalized body-frame geometry for
  recovery decisions, but do not spend another test on its gate, relief, or
  phase-asymmetry gains. The next sampled generation supplies the first
  semantic break from that repeated lower exit. Replacing the late same-sign
  C-bend with an opposite-sign posterior reactive rudder, recruited smoothly
  by both proximity and full body-frame target error, captures at `24.34T`
  and `0.7496L` with mean distance `2.224L`. Its top-down path closes
  continuously instead of passing below the target, and the oblique view
  retains the alternating three-dimensional wake through arrival; anterior
  and posterior rate-cap occupancy (`14.0/6.9%`) and peak planar force/yaw
  moment (`0.03165/0.01638`) remain close to the prior useful envelope. This
  is strong evidence for preserving propulsion while changing the posterior
  mean load path before the miss. It is not a clean rudder-sign ablation: the
  capture also replaces folded-bearing turn magnitude with a continuous
  lateral-target sign in the redirect and half-cycle carrier. Reuse that
  combined normalized feedback structure, not a bare posterior-sign rule;
  reject descendants that disturb the far carrier, lose capture, or exceed
  the sampled saturation/load envelope. Further terminal scheduling is
  applicable only when it responds to an evidenced approach defect while
  leaving healthy closure unchanged; the capture trace isolates such a defect
  only in its final slowdown from roughly `0.47L/T` median closure toward
  `0.11--0.13L/T` at the crossing.
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
