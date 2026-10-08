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
- The completed closing-aware hold falsifies anterior-carrier amplitude relief
  as the next terminal mechanism for this already propulsive controller, even
  when proximity and measured radial-closing deficit are required together.
  The full-carrier approach-redistribution parent reached `3.135L`; adding the
  closure gate worsened the minimum to `3.926L`, still carried `0.837U` speed,
  `-0.044U` closure, and saturated `-pi/2` course error at closest approach,
  and exited through the same upper boundary at `7.891L`. Although that final
  distance is smaller than the parent's `10.210L`, acceleration residence rose
  from `71.9%` to `75.0%`, so the gate traded away approach without producing
  a hold. Together with distance-only relief (`5.126L`) and
  distance-times-course damping (`6.397L`), this says to preserve the full
  anterior traveling-wave carrier and next redistribute steering within the
  posterior waveform or damp measured yaw/slip rather than shed oscillator
  energy. This boundary applies when a coherent carrier reaches the approach
  with a large, saturated course residual; revisit drive relief only if it
  demonstrably lowers speed or joint amplitude while retaining a roughly
  `3.135L` approach and reducing recession, saturation, or loads.
- Approach-gated posterior half-cycle attenuation is a bounded steering lever,
  but the assigned parent's completed rollout falsifies proximity alone as its
  trigger. Relative to the full-carrier parent, it nearly preserved closest
  approach (`3.259L` versus `3.135L`), reduced acceleration-limit residence
  (`65.8%` versus `71.9%`), and shortened final recession (`7.016L` versus
  `10.210L`), while maintaining the alternating top-down and tail-connected 3D
  wake. Yet at closest approach it still carried `0.758U` speed, `+0.406U`
  body-frame lateral slip, and saturated `-pi/2` target-versus-velocity course
  error before the same upper-boundary exit. Therefore do not deepen or retune
  terminal-only asymmetry as a capture fix; if this lever is retained, test a
  speed-qualified directional-response trigger early enough to alter course,
  and reject it if the full-carrier approach degrades or lateral slip and exit
  topology remain unchanged.
- The completed course-to-yaw response test falsifies direct use of textbook
  geometric signs in the posterior-curvature channel. Replacing the sampled
  `target x velocity` residual with `velocity x target` and feeding
  `desired_yaw - measured_yaw` to the posterior mean retained a coherent,
  finite alternating wake, but worsened closest approach to `6.850L` and
  reached the upper exit at `15.68T`; the four actuator-coordinate samples
  instead approached to `4.162--5.126L` and survived to `20.52--23.36T` before
  the same exit. Body-positive `x` is opposite the swimming direction, and a
  geometric yaw sign is not automatically a posterior-bend sign. Do not deepen
  the failed correction with gain tuning or claim either cross-product order
  universal: map requested curvature and measured yaw into one empirically
  checked convention, and change one sign relationship at a time. Reject a
  proposed calibration if it loses the coherent carrier, worsens the
  `4.162L` sampled approach, or accelerates the upper exit again.
- Signed agreement is not enough to rescue posterior half-cycle attenuation.
  Requiring bearing and course-response agreement improved closest approach
  only from `5.000L` to `4.743L`; final distance remained near `5.93L`, both
  controllers kept the same coherent wake, and both exited through the upper
  boundary. They also remain worse than the inherited proximity-gated
  half-cycle reference at `3.259L`. Treat this as a scheduling dead end rather
  than evidence for more agreement thresholds: revisit phase-selective relief
  only after a different response convention or actuator mechanism changes the
  route topology, and falsify that boundary with an earlier targetward turn or
  a new termination class without carrier or load degradation.
- Post-miss curvature recruitment in either joint is not supported once the
  convention-aware response controller already reaches about `2.2L`. Its
  response-deficit tail relief improved closest approach from `2.299L` to
  `2.169L` while retaining the coherent top-down and tail-connected 3D wake;
  adding a near-abreast anterior oscillator-center shift then regressed the
  approach to `2.931L`, made closure negative by the minimum, and still exited
  through the upper boundary at `24.79T`. A separate closure-loss posterior
  burst likewise reached only `3.254L` with the same termination. Preserve the
  calibrated carrier and do not deepen proximity/closure-gated anterior or
  posterior bends after the miss; test an earlier sign-selective response cue
  such as hydrodynamic yaw moment instead. Revisit this boundary only if the
  new cue reduces pre-miss lateral offset or creates a re-approach without
  increasing saturation, loads, or wake disruption.
- Joint-phase demodulation is the first completed feedback-semantic change in
  this lineage to convert the repeated upper-boundary failure into capture.
  Subtracting an anterior-angle/velocity reconstruction from short-window yaw
  before the calibrated response tracker captured at `0.7477L` and `16.637T`
  with mean distance `2.003L`; three matched distance/half-cycle variants
  reached only `4.530--5.126L` and exited high near `21T`, the assigned
  selective-moment parent still exited high after reaching `2.358L`, and the
  strongest inherited raw-yaw response reached `2.169L` without capture. Both
  visual rows show that the success retained the alternating top-down street
  and tail-connected 3D wake, so its benefit is directional signal separation
  rather than propulsion recovery. For a strong rhythmic carrier, treat raw
  short-window yaw—and any similarly carrier-correlated course observable—as
  a mixed phase/route signal: remove only the repeatable joint-state component
  before comparing response with the slow body-frame request. Coefficients are
  observation- and carrier-specific rather than transferable gains; refit or
  reject this implication if the residual remains phase-correlated, capture
  is lost, or the current high joint-speed/acceleration residence and peak
  loads worsen.
