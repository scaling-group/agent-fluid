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
- In the sampled direct-still-water seed rollout, the lagged carrier formed a
  coherent 3D wake and reached `0.636U`, but target bearing swept from roughly
  `+0.19` through zero to `-1.44 rad`; best progress was only `0.250L` before
  an upper-boundary exit at `8.547T`. Raw joint-acceleration commands also
  exceeded the actuator envelope in about one third of samples. Treat this
  topology as missing target-relative steering, not evidence for more drive:
  preserve the useful traveling bend and test bounded body-frame curvature
  before increasing carrier gains. Falsify that implication if curvature
  feedback destroys wake coherence, materially increases saturation, or does
  not improve bearing containment, progress, or termination class.
- The first four direct-uniform still-water target-feedback rollouts sharpen
  that seed lesson. Three posterior mean-curvature variants preserved coherent
  propulsion and improved closest distance to `9.141L`, `11.642L`, and
  `11.824L`, yet all crossed into diverging negative bearing and exited the
  upper boundary by `13.129T`; changing curvature cap, bearing scale, trend
  lead, or instantaneous yaw-rate feedback did not improve termination class.
  A fourth variant moved both joint centers, limited the anterior oscillation
  to about `8 deg`, and worsened final distance to `13.403L`, despite avoiding
  raw acceleration clipping. For this carrier, do not treat static-offset gain
  tuning as course recovery and do not shift the anterior oscillator center
  without separate evidence that thrust survives. When a posterior offset
  retains progress but cannot reverse the post-crossing yaw, test a different
  phase-aware actuator primitive such as bounded half-cycle asymmetry or mild
  lag modulation. Reconsider this boundary only if such a controller loses
  wake coherence or a static offset later demonstrates bearing recovery and a
  better termination class without increased limit occupancy.
- Two completed phase-aware posterior variants now falsify tail-only
  half-cycle asymmetry as the next recovery mechanism for this carrier. An
  opposition-relief variant retained the static mean bend and reduced mean
  absolute yaw rate from about `1.31` to `1.13 rad/T` and posterior speed-limit
  contact from `5.8%` to `2.6%`, but it still exited the upper boundary with
  bearing near `-1.28 rad` and worsened closest approach from `9.141L` to
  `9.855L`. A stronger two-sided half-cycle scaling variant without the mean
  bend exited by `9.09T` after reaching only `11.655L`. Do not spend another
  iteration tuning tail half-cycle magnitude alone: lower rate occupancy is
  not course recovery when bearing and lateral drift still diverge. Test a
  distinct preemptive state channel, such as bounded body-frame lateral-slip
  feedback or response-gated lag relief, and retain it only if bearing
  containment or termination class improves without erasing the coherent wake
  and leftward surge.
- The sampled body-frame lateral-slip residual produced the first large
  trajectory improvement over that static/half-cycle family: it preserved the
  alternating 3D wake, extended survival from at most `13.129T` to `26.637T`,
  and improved closest approach from `9.141L` to `2.960L`. However, three
  completed distance/alignment envelope variants around that residual reached
  only `3.032--3.592L`, and all four slip-family rollouts still exited through
  the upper boundary. Their paths were effectively coincident at `12T`, with
  the head near `y=12.78L` and distance near `6.68L`, already `3.28L` above
  the target before the `4--5L` approach gates had meaningful authority. One
  hold variant reduced raw acceleration clipping to about `31%/41%` from the
  unscheduled residual's `56%/65%`, but better reserve alone did not change the
  failure topology. Preserve target-relative slip as useful far/mid-course
  feedback, but do not spend another iteration on near-distance carrier
  scaling until a preemptive turn-response mechanism changes target-line
  alignment or bearing containment outside `6L`. Reconsider this boundary if
  an earlier continuous scheduler demonstrably changes the pre-`6L` route
  without erasing surge/wake coherence, or if a response-gated mechanism fails
  while a distance scheduler improves termination class.
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
