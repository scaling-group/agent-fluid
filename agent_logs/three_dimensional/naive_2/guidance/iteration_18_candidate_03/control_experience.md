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
- Closing-aware wave relief is now falsified in two propulsive lineages, even
  when proximity and measured closure deficit are required together. An
  anterior-relief child worsened its full-carrier parent's minimum from
  `3.135L` to `3.926L` and raised acceleration residence from `71.9%` to
  `75.0%`. More decisively, the sampled posterior-relief child regressed from
  the inherited actuator-calibrated yaw-response route's `2.299L` minimum and
  `28.41T` upper exit to `4.530L` and `21.72T`; it retained an alternating 3D
  wake and lowered near-limit acceleration residence to `59.3%`, with bounded
  force/moment peaks of `0.0306/0.0157`, but still had `0.725U` speed, about
  `-0.217U` target--velocity radial closure, and saturated course error at its
  minimum. Together with distance-only relief (`5.126L`) and other sampled
  half-cycle relief (`4.743L`), lower effort does not validate a terminal gate
  that damages approach or preserves the upper-exit topology. Preserve the
  full traveling-wave carrier; if terminal control is tested, derive closure
  from a speed-qualified body-frame target--velocity projection and gate a
  separate bounded steering/redirect channel rather than shedding wave energy.
  Falsify this boundary only if relief retains the parent approach while
  producing capture, re-approach, or a better termination without worse loads.
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
- A completed direct sign test falsifies treating geometric vector order as
  posterior steering polarity. Replacing `target x velocity` with
  `velocity x target` and using `desired_yaw - measured_yaw` retained a finite,
  alternating wake but reached only `6.850L` and left the upper boundary at
  `15.68T`; the four assigned actuator-coordinate variants reached
  `4.162--5.126L` and survived to `20.52--23.36T`. Body-positive `x`, bearing,
  posterior curvature, and physical yaw conventions must be mapped through a
  completed response test, not inferred independently from textbook angle
  signs. Do not repeat or gain-tune the failed combined sign flip; change one
  sign relationship at a time and reject it if the coherent carrier remains
  but approach or exit timing worsens.
- Actuator-calibrated yaw-response feedback is the first inherited mechanism
  here to produce a materially different useful route. Retaining the empirical
  `target x velocity` residual, requesting physical yaw opposite the bounded
  posterior route command, and feeding back actual-minus-requested yaw reduced
  closest approach from the assigned parent's `4.162L` to `2.299L`, extended
  the upper exit from `23.36T` to `28.41T`, and kept tail-connected 3D wake
  structures while reconstructed near-limit action residence fell to about
  `55%`. It did not solve capture: at the `18.41T` minimum the fish still moved
  near `0.78U`, had already lost instantaneous closure by about `0.33U`, then
  receded to `8.092L`. Preserve this route-response convention as a provisional
  carrier-specific mechanism and test terminal action only after closure loss,
  leaving the demonstrated approach untouched. Falsify that boundary if the
  response mechanism fails under another pose or flow, or if terminal gating
  perturbs the `2.299L` approach, destroys the wake, raises loads, or cannot
  create a re-approach, capture, or better termination class.
- Completed descendants now falsify recruiting additional terminal mean
  curvature as the response fix. Response-gated posterior half-cycle relief
  was the strongest inherited variant (`2.169L` minimum, `28.04T` upper exit,
  peak force/moment about `0.0335/0.0170`), modestly improving the full-wave
  yaw-response carrier's `2.299L` miss. Adding a bounded `5 deg` anterior
  response center regressed to `2.931L` and an earlier `24.79T` exit; the
  assigned parent's closure-loss `8 deg` posterior burst regressed further to
  `3.254L` at `25.05T`, drove joint 2 to its `45 deg` hard limit, and raised
  peak force/moment to about `0.0450/0.0206`. Preserve the full carrier and the
  limited phase-selective response channel; do not deepen near-target anterior
  centering or posterior mean bursts. Reopen this boundary only if a distinct
  response observable localizes curvature without worsening the inherited
  approach, joint contact, loads, or upper-exit topology.
- Joint-phase demodulation converts the previously promising raw-yaw response
  mechanism into the first completed capture in this lineage. Across four
  sampled rollouts and four inherited descendants inside `6L`, anterior joint
  angle and velocity explain `93.3--99.7%` of raw short-window yaw variance,
  with stable fitted signs (`q1` coefficient `+1.118--+1.473`, `q1_dot`
  coefficient `-0.489---0.638`). Subtracting the fixed state-derived carrier
  estimate before response tracking changed the inherited phase-selective
  parent's `2.169L` miss and `28.04T` upper exit into capture at `0.7477L` and
  `16.637T`. Both visual rows retain an alternating, tail-connected 3D wake;
  maximum joint angles remain about `0.550/0.560 rad`, while peak planar
  force/moment rise modestly from the parent's approximate `0.0335/0.0170` to
  `0.0369/0.0186`. Preserve the full carrier and compensated response semantics
  as the incumbent mechanism; do not revert to raw-yaw deficit gating or
  whole-wave terminal relief merely to lower effort. This implication applies
  while the oscillator family and observation scaling remain comparable and
  must be falsified on changed pose or flow if compensation remains
  phase-correlated, capture fails to repeat, joint contact appears, or the
  route, connected wake, saturation, or load envelope degrades materially.
- Mean-preserving joint-phase demodulation is a safe semantic refinement of
  the captured carrier: reconstruct fast yaw from the anterior oscillator
  coordinate after subtracting its bounded slow course center, rather than
  from the raw joint angle. Against the assigned raw-mean capture, the matched
  completed variant retained the same alternating, tail-connected wake and
  capture while improving arrival from `16.637493T` to `16.631994T` and
  observed distance integral from `1.380093L` to `1.378485L`. Peak planar
  force/moment decreased from `0.036873/0.018564` to `0.036777/0.018272`,
  maximum joint magnitudes from `0.550013/0.560251` to
  `0.547719/0.555689 rad`, and near-limit speed/acceleration residence from
  `27.504%/74.050%` to `27.282%/73.942%`. These improvements are modest and
  establish semantic preservation, not changed-pose robustness. In contrast,
  adding state-triggered negative damping to recruit the carrier missed at
  `3.490652L`, receded to `10.765473L`, exited at `28.231514T`, and drove the
  posterior joint to `0.739916 rad` despite a coherent wake. Preserve the
  demonstrated carrier amplitude and mean-free response decomposition; do not
  pursue faster startup by injecting oscillator energy. Reopen that negative
  boundary only if an intervention releases before altering route response
  and repeats capture without worse joint contact, saturation, loads, or wake
  topology; falsify the positive boundary if the mean-preserving residual is
  still carrier-correlated or capture fails under changed pose or flow.
- Relative body-frame crossflow is not automatically a directional slip cue
  when the sensor moves with an undulatory carrier. Across the two distinct
  completed captures, mean-free anterior angle and joint rate explain
  `91.1--91.2%` of raw crossflow variance over the episode and `99.84%` inside
  `6L`, with repeatable full-episode coefficients near `+0.50/+0.12`. Removing
  that fixed state-derived component in replay reduces crossflow standard
  deviation from about `0.400U` to `0.119U`, while preserving the recruitment
  failure's slow offset (`+0.084U` raw versus `+0.083U` residual). Therefore
  distinguish fast self-motion from persistent body-frame slip before using
  crossflow as steering feedback; coherent wake images alone cannot establish
  that raw relative flow is an exogenous disturbance. This is an observation
  separation result, not evidence that the unevaluated compensated controller
  improves CFD. Retain raw or softly blended feedback if changed-flow tests
  show that subtraction erases persistent slip, and reject the mechanism if
  carrier correlation remains or capture, route topology, wake connection,
  saturation, joint contact, force, or moment worsens.
