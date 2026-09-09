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

- This is a fresh 40-iteration lineage with no solver or optimizer population
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
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Preserve the now-supported capture scaffold as a combination rather than
  attributing success to a scalar steering gain. The assigned 2D-sign parent
  formed a coherent self-propelled wake but reversed after reaching `6.18L` and
  exited at `10.60L`; inherited intermediate variants likewise repeatedly left
  the domain after `2.12--7.53L` near misses. In contrast, all four current
  samples combining the corrected 3D bend sign, fore/aft-aware body-frame
  target vector, distance/closing drive relief, and bounded velocity-course
  redirect captured in `20.21--20.97T` from direct quiescent initialization,
  with coherent wakes and peak force/moment coefficients no greater than about
  `0.025/0.013`. Keep this full scaffold when testing one additional mechanism;
  invalidate its portability if a held-out pose or inflow restores a pass-and-
  exit topology, destroys wake coherence, or materially increases load or
  joint-limit residence.
- Once that scaffold captures, joint-state half-cycle asymmetry is supported as
  a trajectory-shaping mechanism, with actuator cost as its boundary. Against
  an otherwise matched terminal course redirect, phase-aligned steering reduced
  capture time from `20.971T` to `20.207T`, improved score from `-0.27435` to
  `-0.22712`, and slightly reduced peak planar force/yaw moment from
  `0.0249/0.0130` to `0.0244/0.0128`; however, anterior mean command increased
  from `18.67` to `19.29 rad/T^2` and residence above 90% of the smooth command
  bound increased from `34.6%` to `36.6%`. Transfer only the invariant—derive a
  bounded useful/return-stroke asymmetry from normalized joint phase and
  body-frame turn request—not the sampled gains. Reject or reduce it if capture
  timing/integral fails to improve, near-bound command residence approaches
  persistent saturation, or joint margin, loads, and wake coherence regress;
  do not assume it composes with more distance allocation. The inherited
  independent `8L--2L` middle-field course window has now been evaluated with
  half-cycle steering: it retained capture and the coherent/load class but
  reached only `19.872T`, mean distance `2.11310L`, and score `-0.22294`, versus
  the strongest approach-gated LOS sample's `19.706T`, `2.10594L`, and
  `-0.21598`. Treat that as a concrete negative result: another course-distance
  window or scalar course gain is unsupported unless a held-out trajectory
  exposes the old pre-approach discrepancy again.
- Distinguish signed, joint-phase posterior wave-shape allocation from scalar
  lag relief or posterior slip curvature. On the clean LOS/range/closing and
  half-cycle scaffold, symmetric lag modulation about the supported mean was
  the strongest current sample at `19.635T`, mean distance `2.10246L`, and
  score `-0.21272`, while retaining the coherent wake and approximately
  `0.0248/0.0131` peak force/moment class. Its arrival lead over the plain
  `19.706T/2.10594L/-0.21598` sample is still smaller than the `0.116T` span
  between byte-identical corridor-policy repeats, so treat it as a mechanism
  to replicate, not a proven gain. Inherited magnitude-only lag compression
  regressed to `19.778T/2.10934L/-0.21948`, and a same-sign posterior slip
  residual reached only `19.899T/2.10786L/-0.21745`; both preserved the same
  late-hook wake class and supplied no material compensating effort or load
  benefit.
  Future workers should preserve a zero-mean, bounded useful/return-stroke lag
  allocation if testing this family, reject it if repeat-resolved arrival or
  integral does not improve with non-worse effort and loads, and avoid tuning
  unsigned lag relief or crossflow-curvature gains without a new held-out
  trajectory topology that specifically exposes those deficits.
- Do not treat a tiny reduction in smooth-bound residence as evidence that
  previous-command feasibility feedback is useful. The assigned parent's
  effort-aware half-cycle gate reduced anterior mean absolute command only
  from `18.20` to `18.09 rad/T^2` and anterior residence above 90% of the
  smooth bound only from `35.25%` to `35.04%`, yet slowed capture from the
  sampled `19.701--19.817T` cluster to `19.949T`, worsened mean distance to
  `2.12277L` and score to `-0.23265`, and raised peak planar force/yaw moment
  to about `0.0250/0.01336`. Both keyframe rows retained the same coherent
  wake and late-hook topology, so the gate did not create a useful physical
  class. Restore the clean LOS/range-aware scaffold rather than tuning its
  effort threshold or floor; revisit command-history gating only if a later
  rollout demonstrates a material headroom gain together with improved
  arrival/integral and non-worse loads, or test a distinct normalized
  observation and posterior actuator path instead.
- Keep posterior LOS-led redirect continuous when testing a release trigger.
  Full response release was the slowest current sample at
  `19.850T/2.11128L/-0.22093`, while anterior-only response release varied
  between `19.701T/2.10634L/-0.21675` and an inherited
  `19.877T/2.11339L/-0.22325`, providing no improvement beyond executable
  repeat variation. In contrast, bounded projected-miss geometry retained the
  strongest class at `19.723T/2.10565L/-0.21601` with the same coherent wake,
  joint margin, and approximate `0.023/0.013` force/moment envelope. This
  supports projected miss as a release observation to test, not as a proven
  gain: restrict it to transient anterior bias and falsify it if capture,
  integral, terminal topology, command headroom, loads, or wake coherence
  regress.
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
