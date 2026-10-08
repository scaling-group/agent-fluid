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
- In direct-uniform still water, a coherent alternating wake does not establish
  useful target control. The target-blind `0.55T`, `28 deg` naive carrier was
  visibly self-propelled, yet it swept past the initially small body-frame
  bearing, reached only `12.078L` from `12.328L`, and left the upper boundary at
  `8.547T` with joint velocity at its limit. For this failure topology, test a
  bounded target-geometry-to-mean-curvature loop with bearing-trend or yaw-rate
  release before adding drive; falsify the lesson if a target-blind replicate
  holds bearing, or if the added loop destroys thrust/coherence instead of
  improving closest approach and termination. This implication does not rank
  already target-directed candidates or establish wake-rejection behavior in
  cylinder cases.
- For the coherent-propulsion/upper-exit topology, inertial course is a more
  useful steering-response signal than bearing trend or local crossflow alone.
  The sampled posterior target-versus-course mean-curvature policy preserved a
  coherent 3D wake, survived `16.879T`, and reached `6.218L`, versus
  `10.883L` for bearing plus relative crossflow, `11.448L` for one-sided
  acceleration-lobe steering, and `11.778L` for two-sided half-cycle scaling.
  It is still only a partial mechanism: at exit its body-frame course remained
  about `0.70 rad` above a bearing of about `-1.29 rad`, while posterior action
  occupied the hard limit in roughly 61 percent of samples. Preserve the
  course residual, but do not answer this mismatch by increasing continuous
  curvature or amplifying a half-cycle; test a bounded way to free posterior
  headroom while retaining the anterior carrier. Falsify this implication if
  a course-free controller beats `6.218L` with comparable wake coherence and a
  better termination class, or if posterior headroom improves without an
  earlier lateral-course correction.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
