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
- Later completed feedback variants separate broad approach, actuator reserve,
  and corrective capture authority. Bearing-minus-body-slip posterior
  curvature preserved the coherent carrier, descended from `y=14.000L` to
  `12.324L`, and reached `2.960L` at `17.70T`, but bearing then approached
  `-1.50 rad`; the fish overshot at high surge and ended in the same
  `left_domain` class after an upper hook. A phase-referenced yaw-rate servo
  instead contained y but passed about `4.4L` high and reached only `4.361L`,
  so fitted beat-yaw cancellation is not the missing descent mechanism. More
  importantly, three subsequent distance-conditioned reallocations all
  retained coherent wakes and the same termination class but worsened closest
  distance to `3.032L`, `3.162L`, and `3.592L`. Tail-only relief reduced
  approach-phase posterior raw over-envelope demand from about `71.2%` to
  `6.0%`, and the strongest hold reduced mean absolute approach joint rates to
  only `0.58/0.40 rad/T`; the body nevertheless coasted near `0.7U` and missed
  farther from the target. Do not equate freed joint reserve with steering or
  repeat distance-only carrier attenuation: for this inertial swimmer it can
  remove the hydrodynamic action needed to turn without providing braking.
  After preserving the slip-guided far-field carrier, test an active,
  state-conditioned shape redirect or another mechanism that uses the freed
  authority while retaining a nonzero beat. Falsify this implication if active
  redirection destroys wake/progress, creates worse limits, or cannot improve
  the `2.960L` approach and repeated exit topology.
- The first sampled distributed C-bend supplies a concrete boundary on that
  active-redirection advice. A full-quadrant error gate plus anterior mean
  shift and added redirect damping reached `2.999L`, retained the same
  `left_domain` upper exit, and settled both joints into a static curved
  posture: after `18T`, mean absolute rates were about `0.001/0.001 rad/T`,
  with every sample below `0.05 rad/T`. The distance-conditioned joint hold
  exhibited the same failure more mildly (`0.023/0.016 rad/T` after `18T`,
  `3.592L` minimum), whereas continuously beating variants kept anterior mean
  rate near `2.62 rad/T` and approached to `3.032--3.162L`. Do not interpret a
  state gate, nonzero nominal carrier floor, or bounded mean bend as proof that
  propulsion remains active: added damping can stabilize the shifted
  equilibrium and leave the inertial body coasting. For the next redirect,
  preserve a zero-centered undamped anterior limit cycle and verify sustained
  joint-rate and alternating-wake evidence; phase-aware half-cycle allocation
  is preferable to another static C-posture. Reconsider this boundary only if
  an actively cycling distributed bend beats `2.960L` or improves termination
  without materially increasing actuator-limit occupancy.
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
