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
- In direct-uniform still water, target feedback should leave the anterior
  carrier equilibrium unchanged until contrary evidence appears. Among the
  sampled first-generation policies, posterior-only bearing-plus-trend bias
  retained the coherent alternating 3D wake and improved the seed's
  minimum/final distance from `12.078/12.380L` to `11.413/11.421L`. Centering
  the same kind of bias on both joints instead held joint excursions near
  `10 deg`, delayed visible wake growth, made a broad U-turn, and ended at
  `13.411L`. Apply this lesson to a working traveling-bend carrier; falsify it
  if a future shared-bias design preserves comparable joint/wake amplitude and
  improves target progress rather than merely surviving longer.
- On a working target-versus-course posterior-curvature carrier, phase
  conditioning is useful specifically as attenuation-only wave relief. The
  sampled one-sided policy never amplified the aiding lobe, retained the
  coherent alternating top-down and oblique 3D wake, cut posterior
  acceleration-limit residence from `60.8%` to `35.9%` versus the otherwise
  matching continuous-bias policy, improved closest approach from `6.218L` to
  `5.144L`, and delayed upper exit from `16.879T` to `18.975T`. Do not generalize
  this to arbitrary half-cycle scaling: the inherited two-sided
  strengthen/weaken policy regressed to `11.778L` and `8.800T`, and one-sided
  acceleration-lobe gating reached only `11.448L` at `9.053T`. Preserve the
  successful relief scaffold when testing a response-gated redirect, but do
  not claim steering is solved: its best rollout still passed its closest
  point and exited at center y=`15.203L` with `0.632 U` positive-y velocity.
  Falsify the reusable implication if attenuation loses wake/x progress on a
  different carrier, or if a simpler continuous bias achieves a better
  termination class with comparably low limit residence.
- A speed-reliable, response-gated increase from cruise curvature to a strong
  posterior redirect is now positive evidence, not merely a proposed rescue.
  Applied on the one-sided-relief scaffold above, it preserved the coherent
  alternating top-down and oblique wake and changed the sampled outcome from a
  `5.144L` closest approach plus upper exit at `18.975T` to capture at `0.746L`
  in `16.291T`. The reusable mechanism is to open extra posterior curvature
  only for a large target-versus-course mismatch after forward translation is
  reliable, then release it continuously as measured course realigns. Its cost
  is also material: posterior acceleration-limit residence rose from `35.9%`
  to `60.4%`, despite posterior angle staying within `30.4 deg`. Thus limit
  residence alone must not veto a better termination class, but follow-up
  designs should preserve the evidenced mean redirect while testing whether
  the joint-state wave can yield acceleration headroom. Falsify this transfer
  on carriers without coherent cruise propulsion, or if the stronger redirect
  loses capture/early x progress, fails to release with course response, or
  creates instability rather than a finite target-directed path.
- Closing-conditioned redirect persistence is also positive evidence when it
  is confined to an already reliable final approach. On the allocated,
  closing-relief carrier, lowering the strong-redirect onset only through the
  existing proximity-plus-target-closing gate left the trajectory unchanged
  through the `2L` crossing, advanced capture from `16.258T` to `16.225T`,
  improved score from `-0.066284` to `-0.063208`, and retained low posterior
  hard-limit residence (`21.3%` versus `22.5%`). This supports keeping mean
  curvature engaged through a measured terminal course mismatch rather than
  releasing it at the cruise dead zone. Apply only after capture-directed
  translation and a closing-conditioned approach exist; falsify if the
  pre-approach route changes, capture is delayed or lost, or limit residence
  returns toward the unallocated `58-59%` samples.
- Separating repeatable carrier motion from persistent navigation error is now
  positive closed-loop evidence on this carrier. Normalized anterior joint
  phase explained `94.3-99.1%` of within-regime target-versus-course-error
  variance in the parent traces; subtracting only one quarter of that fitted
  phase component from the high-authority redirect gate, while retaining raw
  error for direction and a pointwise relief guard, preserved the coherent 3D
  wake and advanced every `8/6/4/2L` milestone. Capture improved from
  `16.225T`, score `-0.063208`, to `16.044T`, score `-0.058311`, with slightly
  lower mean posterior acceleration but exact acceleration-limit residence
  increasing from `21.3%` to `22.7%`. Prefer this bounded phase residual to
  short-window prediction: the sampled bearing-phase-lead alternative retained
  the baseline `16.225T` arrival and regressed to `-0.065510`. Do not force the
  residual to be attenuation-only: capping its redirect gate by the raw gate
  preserved the coherent wake and capture but delayed every distance milestone,
  moving arrival from `16.044T` to `16.115T` and score from `-0.058311` to
  `-0.064714`. Residual-created authority can therefore contain useful
  persistent route evidence even when its pointwise interpretation is
  uncertain. Apply only as a selector for high steering authority on a
  coherent state-feedback carrier, retain raw error for redirect direction and
  pointwise acceleration relief, and falsify if capture or wake coherence is
  lost, the upper-exit topology returns, or limiting/load growth outweighs the
  route improvement.
- Near-target drive relief should remain subordinate to measured route demand,
  while a predicted-miss corridor should be treated as a safety gate rather
  than evidence that steering itself is wrong. The sampled
  response-conditioned approach preserved all `8/6/4/2L` milestones and
  captured at `16.049T` with score `-0.056774` and total distance integral
  `1.939780L`. Releasing high-authority mean curvature inside a closing
  predicted-miss corridor left those milestones, arrival, and the observed
  distance integral unchanged, lowered mean posterior command only from
  `24.923` to `24.901 rad/T^2`, and slightly regressed score to `-0.056973`.
  Thus pointwise-relief-only corridor steering is safe but too weak to count as
  a useful trajectory mechanism; later designs should use the corridor to gate
  an independently measured response such as terminal yaw or slip, and must
  reopen the original redirect as soon as closing or predicted miss worsens.
  Falsify this boundary if a corridor release advances a distance milestone,
  improves termination, or materially reduces limiting/load without changing
  the coherent carrier.
- Do not soften the posterior wave merely because joint speed approaches its
  clamp on this carrier. A wave-only headroom guard beginning at `0.96` of the
  speed limit retained capture and the visible coherent 3D wake, but the two
  sampled variants arrived later (`16.071T` and `16.077T` versus `16.049T`),
  worsened total distance integral from `1.939780L` to `1.940194L` and
  `1.941101L`, and left posterior acceleration-limit residence at `22.38%` and
  `22.75%` versus `22.89%`. Prefer the evidenced exact-boundary anti-windup for
  rejected demand; test any softer guard only if it is conditioned on a
  distinct measured loss of phase, load, or route quality. Revisit this result
  for compliant or power-limited actuators where near-boundary effort has a
  physical cost absent from the present hard-clamp model.
- When the episode's hard joint-speed clamp is active, a same-sign outward
  acceleration is redundant actuator demand: it cannot change the next
  velocity or angle. Across the sampled captures, `2.8%` of anterior and
  `4.9-5.5%` of posterior commands have this signature. Closed-loop evaluation
  of the exact-boundary projection matched the unprojected best's `16.044T`
  capture, `-0.058311` score, all `8/6/4/2L` milestones, distance integral,
  joint extrema, and force/moment peaks, while lowering mean absolute commanded
  acceleration from `23.452/25.514` to `23.294/24.871 rad/T^2`. This supports a
  reflection-equivariant anti-windup projection only at the exact observed
  boundary, not a softer near-limit gait change. Falsify or revise the lesson
  for actuator models where the rejected command affects work, compliance, or
  fluid coupling despite unchanged joint kinematics; do not infer same-state
  equivalence away from the exact clamp.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
