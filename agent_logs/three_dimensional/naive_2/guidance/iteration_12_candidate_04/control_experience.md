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
- Completed descendants now falsify gate retuning as the missing fix for
  posterior half-cycle attenuation. Proximity-gated asymmetry nearly preserved
  the full-wave parent's approach (`3.259L` versus `3.135L`) but receded to
  `7.016L`; moving the same lever earlier with bearing/course agreement reached
  `3.580L` and receded to `6.629L`, while a stricter signed-agreement variant
  degraded to `4.743L`. All retained an organized alternating 3D wake and the
  later variants reduced near-limit action residence to about `61.6--62.6%`,
  so wake coherence and lower saturation do not rescue the repeated upper-exit
  topology. A separate algebraic velocity-to-target sign flip with desired-
  minus-measured yaw feedback was worse still: it exited at `15.681T` with
  minimum and final distance both `6.850L`, despite only `52.4%` near-limit
  residence. For a carrier already approaching within about `3.1L`, do not
  infer posterior steering polarity from angle convention or spend another
  iteration tuning half-cycle activation; preserve the empirically useful
  course-brake polarity and full traveling wave, and test a response observable
  as a release on the slow route bias instead. Reject that alternative if it
  loses the `3.135--3.259L` approach, weakens the wake, or fails to reduce
  bearing overshoot and post-minimum upper recession.
- Completed response branches separate a useful actuator calibration from an
  ineffective release schedule. Releasing posterior route bias during
  centerward short-window bearing motion still exited high with a `4.867L`
  minimum and `6.013L` final distance, so that observable is too beat-local to
  repair the route by attenuation alone. In contrast, mapping posterior
  curvature request to opposite-sign physical yaw and tracking the resulting
  desired yaw response improved its matched course-gated precursor from a
  `5.000L` minimum to `2.299L`, while retaining the alternating two-view wake
  and reducing near-soft-limit acceleration residence from about `62.1%` to
  `55.0%`. Its later recession to `8.092L` shows that calibrated yaw response
  is an approach mechanism, not a terminal solution: the target moved into the
  aft body half-plane as target-projected translation became non-closing, a
  topology hidden by the absolute-forward bearing definition. Preserve the
  calibrated response law and treat aft-target plus closure deficit as a
  distinct, bounded missed-pass redirect condition; do not deepen bearing-rate
  release or rank this useful trajectory by scalar score alone. Falsify the
  redirect if it activates during the `2.299L` forward approach, repeats the
  known persistent-anterior-curvature speed collapse, disrupts wake coherence
  or loads, or cannot reduce post-pass recession and the upper exit.
