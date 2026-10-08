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
- Partial joint-phase residualization of target-versus-course error is now
  positive closed-loop evidence, but it must not be forced to act as a veto
  only. Across the precursor captures, normalized anterior angle and velocity
  explain `94.3-99.1%` of that error's within-regime variance and `97.3%` of
  body-frame lateral-velocity variance from `4T` to the `2L` crossing. Letting
  a quarter of that component select the high-authority gate while raw error
  retained bend direction advanced the `8/6/4/2L` crossings and capture to
  `9.202/11.154/13.013/14.905/16.044T`, scoring `-0.058311` versus the
  closing-redirect baseline's `16.225T` and `-0.063208`. Clamping the residual
  gate below the raw gate instead captured at `16.115T` and regressed to
  `-0.064714`: some phase-residual-created authority was useful course
  correction. Thus separate beat-correlated response from route error, but
  preserve the residual's ability to raise or lower gate duty unless new
  evidence isolates a safer role; short-window yaw-rate feedback remains
  contradicted. Falsify on a carrier where this bidirectional gate loses
  capture, early progress, coherent propulsion, or acceptable loads.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model, and
  exact-boundary anti-windup is an effort cleanup rather than a navigation
  mechanism under the present clamped integrator. In four sampled captures,
  the two base/comment-only policies and two outward-acceleration projections
  had byte-identical non-action traces, wake sheets, `16.044T` captures, and
  `-0.058311` scores. Projection lowered mean absolute anterior/posterior
  commands from `23.452/25.514` to `23.294/24.871 rad/T^2`, but could not alter
  realized motion because the integrator already discarded those increments.
  Pre-boundary wave relief can alter the route, but less saturation is not
  necessarily better: the inherited broad `0.95` speed guard removed posterior
  exact-speed residence (`5.8%` to `0%`) and lowered acceleration-limit
  residence (`22.7%` to `20.8%`), yet delayed all `8/6/4/2L` crossings and
  capture from `16.044T` to `16.456T`, regressing score to `-0.073426` despite
  a coherent wake and slightly lower loads. The assigned parent's narrow
  `0.96` guard, accepted only when the recomposed command retained sign and did
  not grow, preserved capture at `16.071T`, modestly lowered speed/acceleration
  residence to `5.6/22.4%`, and improved score to `-0.057037`, though it
  delayed the final three milestones. Apply pre-limit relief only to a
  separable wave component on an already captured carrier, keep it sparse and
  dominance checked, and preserve mean redirect; judge it by crossings and
  score rather than saturation reduction. Falsify this boundary if a broader
  guard with the same allocation semantics preserves milestones and improves
  score, or if the narrow guard loses capture or wake coherence on a new case.
- Near-target drive relief should be conditioned on steering response, not
  proximity and closing alone, when a captured carrier still reports a large
  course mismatch. Releasing anterior damping and posterior-wave reduction
  while either raw or joint-phase-residual redirect duty remained high left
  the sampled `8/6/4/2L` crossings unchanged, retained the coherent top-down
  and oblique wake, and improved distance integral/score from
  `1.941006L/-0.058311` to `1.939780L/-0.056774`; capture moved only one step,
  from `16.0435T` to `16.0490T`. Apply this settle-versus-correct separation
  only inside an evidenced closing-conditioned approach with reliable mean
  steering. Falsify if pre-approach motion changes, capture is materially
  delayed or lost, loads rise without better distance history, or the benefit
  disappears when combined with independently gated actuator headroom.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
