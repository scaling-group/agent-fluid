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
  redirect captured in `19.71--20.21T` from direct quiescent initialization,
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
  persistent saturation, or joint margin, loads, and wake coherence regress.
- Its composition with earlier middle-field course correction is now sampled
  rather than untested: an `8L` gate with half-cycle steering captured at
  `20.124T` and scored `-0.22811`, essentially matching the terminal-gate
  half-cycle sample at `20.207T` and `-0.22712`; do not infer a useful mechanism
  from widening this gate alone. Closing-gated LOS lead is also capture-safe in
  two semantically identical samples (`19.706T`, `-0.21598`; `20.036T`,
  `-0.23090`) with coherent wakes, peak planar force/yaw-moment coefficients
  below `0.0247/0.0132`, and similar near-bound command residence
  (`32.8--35.3%` per joint). That repeat spread is larger than the scalar
  separation among these variants: preserve LOS lead only as a bounded
  companion, and require a repeatable trajectory, arrival/integral, or
  actuator/load change before treating another scalar adjustment as progress.
- Do not extend the route-steering half-cycle factor indiscriminately to the
  LOS/course redirect. That composition remained capture-safe but regressed to
  `20.168T`, distance integral `2.13279L`, and score `-0.24199` versus the base
  LOS sample's `19.706T`, `2.10594L`, and `-0.21598`. Keep asymmetry on the
  evidenced route term unless a later candidate shows a repeatable trajectory
  or effort benefit; reject another redirect-phase variant if it merely keeps
  the same hook while raising approach integral or near-bound action.
- Response-release on the added redirect is capture-safe, but is not yet an
  established improvement: it captured at `19.850T`, between the two
  semantically identical LOS-led samples at `19.706T` and `20.036T`, with the
  same load and command class. Preserve it only as a bounded body-frame
  hypothesis that tapers the additive redirect when measured yaw responds;
  require replication outside that spread before calling the terminal hook
  improved, and never turn it into a global cut of the capture-critical base
  course lead.
- A scheduled amplitude floor does not guarantee a live approach gait when an
  unconditional velocity damper overwhelms oscillator self-excitation. In the
  strongest LOS capture, joint state and commands were already nearly static
  at `3.615L`/`16T` and remained so near `1.28L`/`19T`, even though earlier
  vortices made the compact sheet look wake-active; the controller captured by
  coasting at about `0.77U`. When terminal propulsion is the test target,
  inspect joint cadence together with fresh shedding and gate damping by
  normalized orbit excess rather than assuming the configured floor is
  realized. Falsify orbit-selective damping if it does not restore a bounded
  reduced-amplitude beat, loses capture, or increases pass-through, loads,
  joint excursion, or near-command-bound residence.
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
