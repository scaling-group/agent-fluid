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
- Raw short-window yaw is not a clean directional-response observable for this
  carrier. Across the four sampled rollouts and four inherited descendants,
  regressions inside `6L` attribute `93.3--99.7%` of yaw-rate variance to the
  anterior beat state, with stable fitted signs (`q1` coefficient
  `+1.118--+1.473`, `q1_dot` coefficient `-0.489---0.638`). At the strongest
  `2.169L` miss, for example, raw yaw is `-2.281 rad/T` while
  `q1=-0.166 rad` and `q1_dot=+4.467 rad/T`; interpreting that sample as slow
  yaw deficit confounds carrier phase with route response. Before yaw tracking
  gates mean or half-cycle steering, remove an evidence-calibrated joint-phase
  component or use a genuinely whole-beat response estimate. The completed
  controlled comparison further shows that the reconstructed phase component
  should use the mean-removed oscillator coordinate rather than raw joint
  angle: three exact raw-`q1` rollouts captured at `16.6375T` with score
  `-0.119674`, whereas replacing only `q1` by
  `q1_carrier = q1 - head_course_center` retained the same connected 3D wake
  and capture arc, arrived at `16.6320T`, improved score to `-0.118307`, and
  slightly reduced distance integral, joint excursions, near-limit action
  residence, force, and moment. Thus carrier demodulation must preserve slow
  steering offsets in the measured directional response; do not subtract the
  controller's own bounded course center as if it were beat phase. The gain is
  narrow and applies while oscillator family, scaling, and course-center
  semantics remain comparable; falsify it if a repeat or held-out pose/flow
  loses capture, retains carrier correlation, or worsens trajectory, wake,
  joint contact, saturation, force, or moment.
- Completed lateral-phase demodulation provides a narrow extension of the yaw
  lesson, not a license to cancel body sway generally. The inherited optimizer
  logs preserve the preceding `-0.118307` and `-0.115560` capture stages, and
  three exact sampled speed-guarded controls captured at `16.609995T` with
  score `-0.115560` and `1.999656L` distance integral; subtracting the fitted
  anterior carrier sway only from posterior course and relative-crossflow
  cues preserved the same visible target-crossing arc and tail-connected
  alternating 3D wake, captured at `16.604496T`, and improved score and
  distance integral to `-0.113729` and
  `1.998146L`. Peak planar force/moment increased slightly from
  `0.035828/0.017759` to `0.037165/0.018356`, so retain the raw-course
  anterior center and treat the residualized posterior cues as a route result,
  not an effort or robustness result. Completed descendants delimit what may
  follow that observer. Two line-of-sight-rate feedforwards retained capture
  but worsened score to `-0.118996` and `-0.118543`; bearing demodulation and
  moment-residual rejection likewise preserved finite connected wakes while
  worsening target cost. Three distinct terminal gates then failed against
  four exact `-0.113729`, `1.998146L`, `16.604496T` parent captures. Releasing
  up to 35% of posterior yaw response under high alignment arrived one step
  earlier but regressed to `-0.114037/1.998380L`; adding posterior half-cycle
  relief under closure deficit arrived at `16.609995T` and regressed to
  `-0.114215/1.998537L`. Most decisively, qualifying yaw-response release by a
  forward projected `0.5L` capture corridor retained the same arrival and the
  visually connected alternating two-view wake, yet regressed to
  `-0.114625/1.998871L` and crossed at `0.744813L` instead of `0.743958L`.
  Wake coherence, normalized alignment, closure deficit, and projected
  interception therefore do not validate terminal intervention on this
  already-capturing carrier. Preserve its full wave, raw target geometry, and
  response channels; do not gain-tune or recombine these terminal holds. A
  later worker should test a new mechanism only for a demonstrated semantic or
  held-out response deficit, and must reject it if pre-approach actions change
  or capture, distance cost, crossing depth, arrival, joint feasibility, force,
  or moment worsens. Exact nominal repeats do not establish held-out pose or
  flow robustness.
- Carrier correlation is not enough to classify a measured fluid component as
  removable self-wake. Four direct-uniform controls replicated the
  response-demodulated carrier's `16.604496T`, `-0.113729` capture with
  `1.998146L` distance integral and `0.743958L` crossing. A completed child
  subtracted an approach-gated, joint-phase fit from local lateral flow before
  posterior relative-crossflow feedback; its two-view wake remained visibly
  alternating and tail-connected and it captured at the same time, but score
  regressed to `-0.115121`, distance integral rose to `1.999280L`, crossing
  became shallower at `0.745252L`, and the final head passed higher across the
  target (`y=9.822140L` versus `9.775620L`). Keep the demonstrated
  demodulation confined to body-response velocity and yaw; do not copy or
  gain-tune this fixed local-fluid phase subtraction merely because its fit
  explains variance. Reopen fluid residualization only with held-out imposed
  wake evidence or an independently observed causal disturbance signature,
  and reject it if nominal capture, route cost, crossing depth, connected wake,
  joint feasibility, effort, force, or moment worsens.
- Actuator-feasibility feedback must anticipate the released speed clamp, but
  only narrowly. An exact-boundary outward-acceleration projection reproduced
  the assigned `16.631994T`, score `-0.118307` capture without any metric
  change, whereas the completed smooth projection over the final 1% of the
  `260 deg/T` speed envelope retained the same target-crossing arc and
  tail-connected alternating 3D wake, arrived at `16.609995T`, and improved
  score to `-0.115560`. It reduced scored distance integral from `2.001992L`
  to `1.999656L`, peak joint magnitudes from `0.547719/0.555689 rad` to
  `0.541097/0.549208 rad`, mean absolute requested acceleration from
  `22.7698/25.4341` to `21.7384/22.6911 rad/T^2`, and peak planar force/moment
  from `0.036777/0.018272` to `0.035828/0.017759`; outward commands within
  that speed band fell from `9.66%/14.42%` to `1.85%/1.39%` while near-speed
  residence remained comparable. Preserve this one-sided final-band guard and
  all inward/reversal commands when the actuator and carrier match this lane;
  do not wait for exact speed equality or generalize the result into scalar
  carrier reduction. Falsify it if a changed actuator integration, pose, or
  flow loses capture or worsens reversal timing, distance cost, wake
  connection, joint contact, force, moment, or feasible effort, and widen the
  guard only through a controlled mechanism test.
- A nominal optimization plateau is not evidence of an unmodeled feedback
  deficit. Four current direct-still-water samples exactly reproduce the
  response-demodulated carrier's trajectory, two-view wake, `16.604496T`
  capture, `0.743958L` crossing, `1.998146L` distance integral, and
  `-0.113729` score; the three preceding completed selections likewise added
  no mechanism or semantic result. The nearest changed inherited control,
  releasing up to 35% of yaw response under qualified terminal closure,
  crossed one step earlier but regressed to `0.744276L`, `1.998380L`, and
  `-0.114037`, with effectively unchanged requested-action, joint-speed,
  force-component, and moment peaks. A stagnation-triggered mechanism review
  should therefore screen hypotheses, not force a new channel into a
  demonstrated carrier. When nominal terminal, target-rate, moment, and
  local-flow residuals have already failed, preserve the exact controller
  until a completed held-out pose, target, or flow exposes a specific response
  deficit; then test one bounded body-frame primitive against capture, route
  cost, crossing depth, wake connectivity, feasibility, and loads. Falsify
  this preservation boundary if such a distinct mechanism improves a semantic
  or held-out result without perturbing the demonstrated approach envelope.
- In a no-dwell first-crossing task, actual head-distance history outranks
  instantaneous speed, yaw, or a conflicting projected-closure proxy when
  diagnosing terminal control. Across four exact direct-still-water captures,
  all 1,001 logged intervals after entry inside `6.5L` reduced distance, with
  finite-difference closure between `0.704` and `1.331 L/T`; the fish crossed
  at `0.743958L` and `16.604496T` while still translating at `1.132762U` with
  recent yaw `2.238745 rad/T`. The two-view wake remained alternating and
  tail-connected and peak planar force/moment stayed about
  `0.037165/0.018356`. Yet the completed closure-qualified yaw-response
  release crossed only one `0.0055T` step earlier and worsened crossing depth,
  distance integral, and score to `0.744276L/1.998380L/-0.114037`, without a
  meaningful feasibility or load benefit. Do not trigger terminal damping or
  drive relief from endpoint motion or an alternative projection while
  measured distance closes monotonically. Require a completed miss, dwell
  failure, or carrier-scale interval of measured closure loss correlated with
  the proposed signal; reject the correction if nominal capture, route cost,
  crossing depth, wake connectivity, joint feasibility, force, or moment
  worsens.
