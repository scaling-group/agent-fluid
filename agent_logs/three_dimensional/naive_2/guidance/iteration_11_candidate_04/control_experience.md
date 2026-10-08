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
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
- Matched direct-uniform rollouts falsify static anterior-centering as the next
  steering step for this carrier. Mean-curvature centers of 8--9 degrees cut
  maximum joint speeds from the useful tail-only controller's 4.54 rad/T to
  0.83--1.26 rad/T, reached only 12.271--12.299L, and then exited with final
  distance near 13.45L. Leaving the anterior oscillator centered, steering the
  posterior target, and smoothly bounding acceleration instead reached
  11.512L with slightly lower peak force and moment than the naive carrier.
  Preserve the anterior traveling-wave scaffold and place sustained steering
  in a phase-compatible posterior modulation; do not interpret a coherent wake
  or a bounded static bend as useful control without distance progress. This
  implication is specific to rollouts where the carrier already propels, and
  is falsified if posterior modulation loses thrust or repeats the static-bend
  speed collapse.
- The strongest sampled posterior-bias rollout still crossed target bearing
  repeatedly from about 3.4T to 5.8T, then accumulated negative bearing and
  left through the upper boundary at 9.823T despite improving distance to
  11.512L. Instantaneous body bearing during a strong beat is therefore
  insufficient as the sole route signal: pair posterior steering with a
  bounded response/slip observable such as measured yaw or speed-gated
  target-versus-velocity course error. Reject that addition if it does not
  reverse the upper drift before the prior exit, if loads spike, or if its
  near-rest direction noise overwhelms the bearing command.
- Completed approach descendants show that carrier relief must be conditioned
  on measured closure, not proximity or course error alone. Relative to the
  unrelieved `3 deg` course-redistribution path's `4.419L` minimum,
  distance-only amplitude relief reached only `5.126L` and
  distance-times-course-error damping only `6.397L`; both activated while the
  fish was still making useful targetward progress. Yet the assigned
  approach-redistribution parent retained a coherent full-amplitude wake to a
  `3.135L` minimum and then receded to `10.210L`, so permanently preserving
  transit drive is also falsified as terminal control. For this already
  propulsive carrier, preserve the full traveling wave while body-frame
  radial closure is strong and test drive relief only when proximity and a
  closing-speed deficit coincide. Reject that implication if the closure gate
  perturbs the far route, worsens the `3.135L` approach, or cannot reduce
  post-minimum recession, upper exit, saturation, or loads.
- Completed early-response descendants now falsify both course magnitude and
  signed bearing/course agreement as sufficient schedulers for posterior
  half-cycle attenuation. Absolute course activation reached only `5.000L`;
  requiring signed agreement recovered `4.743L` but still lost the assigned
  closure-relief parent's `4.162L` approach and repeated the upper-boundary
  exit. The signed result's smaller final recession (`5.938L` versus `6.363L`),
  lower sampled near-limit residence (about `62.6%` versus `66.0%`), and lower
  peak planar force/yaw moment (`0.0294/0.0152` versus `0.0317/0.0165`) do not
  rescue the route regression; both visual rows retain a coherent carrier
  while the trajectory still misses high. Do not spend another iteration
  retuning or rescheduling posterior-wave attenuation on this scaffold.
  Restore the full wave and test a bounded response residual that changes
  steering without shedding a half-cycle; reject it if it cannot retain the
  inherited full-wave `3.135L` approach, redirect before the late bend, or
  improve recession and the upper-exit class without worse loads.
- Course-angle signs in this adapter must be derived with body `-x` as the
  forward axis. An inherited unexecuted hypothesis proposed reversing the
  cross product, but reconstructed closest-approach states from all four
  direct-uniform samples show the existing `target x velocity` signal and
  bearing agree in sign: the assigned parent has `-1.257 rad` course error and
  `-0.969 rad` bearing, while the other samples have course errors from
  `-1.364` to `-1.950 rad` and bearings from `-0.986` to `-1.304 rad`.
  Reversing that product would oppose target geometry during the common high
  miss. Keep this sign convention for course feedback and map a negative route
  request to positive physical yaw when constructing response tracking. This
  lesson applies to the released body-frame adapter; re-derive the mapping if
  its forward-axis or bearing convention changes.
