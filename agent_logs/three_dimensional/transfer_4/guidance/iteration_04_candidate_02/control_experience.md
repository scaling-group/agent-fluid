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
- Establish the measured 3D curvature polarity before adding steering reserves
  or redirect modes. Across four direct-uniform still-water descendants of the
  same transferred carrier, the only controller with a bounded odd mapping
  from signed body-frame turn request to same-sign posterior mean curvature
  captured at `23.35T` (`0.7497L` final, `2.4147L` mean distance). The reserve
  allocator exited the upper boundary at `17.58T` (`6.2764L` minimum), the
  velocity-course redirect reached `4.0215L` but later exited the upper
  boundary, and the large-error geometry redirect exited the lower boundary
  with `13.0563L` final distance. All four retained coherent propulsive wakes,
  so for this course-failure topology, remove direction-specific inverse-
  polarity curvature before layering extra authority or recovery branches.
  Raw clipping incidence alone is not proof that allocation is the missing
  mechanism: the capturing policy also requested beyond the acceleration
  envelope frequently, while the explicit allocator failed. Apply this lesson
  when propulsion remains coherent and signed target error grows; falsify it
  if reflected or held-out target geometries do not produce reflected course
  response, or if a same-sign odd map loses capture or destroys the wake.
- Once the target course and propulsive wake are already successful, distinguish
  envelope-aware state feedback from redundant output clipping. On the captured
  alignment-cadence controller, a smooth per-joint governor that withdrew only
  speed-increasing acceleration above `0.96` of the observed rate envelope
  reduced `99.9%`-limit residence from about `9.09%/1.62%` to zero, bounded
  policy requests, preserved capture and the coherent wake, left peak planar
  force/moment coefficients unchanged (`0.03672/0.01832`), and improved score
  and mean distance from `-0.51528/2.41260L` to `-0.51275/2.40949L`. Arrival
  was `0.0055T` later and peak speed fell from `0.7515` to `0.7428 L/T`, so
  treat this as a feasibility and integrated-route improvement, not a speed
  gain. In contrast, adding the episode's identical symmetric acceleration
  clamp at policy output produced the same trajectory and score. Apply
  same-direction withdrawal only when measured rate-envelope residence is
  material and preserve opposing acceleration for reversal; falsify the lesson
  if repeated or held-out rollouts lose capture, worsen distance/arrival beyond
  the stated tradeoff, restore saturation, increase loads, or disrupt the
  alternating wake.
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
