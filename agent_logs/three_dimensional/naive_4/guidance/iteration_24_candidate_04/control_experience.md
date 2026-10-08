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
- Near-target drive relief must remain subordinate to measured steering need,
  but that ordering is a terminal-shape result rather than an arrival-speed
  result. The inherited approach law that applied damping and wave attenuation
  while either redirect selector was large still captured at `16.044T`, but
  finished at `0.748557L` and scored `-0.059985`. Reversing those roles on the
  same carrier—settling only after both raw and carrier-residual redirect duty
  released—created a distinct terminal velocity/heading state, improved final
  distance to `0.745461L` and score to `-0.056774`, while leaving the earlier
  milestones unchanged and delaying capture slightly to `16.049T` versus the
  `16.044T`, `-0.058311` unconditioned phase-residual baseline. Preserve the
  rule that unresolved course demand retains rhythmic authority, but do not
  stack further approach-relief gates and claim faster capture from the scalar
  score alone. The assigned-parent closed-loop test sharpens the geometric
  boundary: using a closing predicted-miss corridor to attenuate high-authority
  mean steering preserved the coherent wake, all `8/6/4/2L` milestones, and
  `16.049T` capture, but changed only six posterior commands and worsened final
  distance from `0.745461L` to `0.745652L` and score from `-0.056774` to
  `-0.056973`. A locally safe projected course is therefore not sufficient
  evidence that mean steering is redundant. Preserve the evaluated steering
  law when reusing this corridor signal; test a distinct terminal role such as
  releasing residual carrier braking, and require the gate to restore settling
  as soon as predicted miss worsens. Falsify this boundary only if a future
  steering-release policy improves target progress or limiting without losing
  wake coherence or altering the pre-approach route. The current three-way
  closed-loop comparison resolves that terminal role: using the corridor to
  release only anterior damping preserved the same coherent two-view wake and
  `16.0545T` capture while achieving `0.744345L`, `-0.055617`, and `24.0%`
  approach posterior acceleration-limit residence. Extending the same gate to
  release posterior wave settling left milestones through `1.25L` and arrival
  time unchanged but worsened the crossing to `0.745354L`, `-0.056672`, and
  raised posterior limit residence to `29.2%`; releasing high-authority mean
  steering was also worse at `0.745652L`, `-0.056973`. Therefore a locally safe
  intercept may release residual anterior braking, but it is not permission to
  release posterior wave shaping or target-directed curvature. Reopen anterior
  damping continuously if closing, course reliability, or the intercept
  corridor is lost; falsify this role boundary if a posterior release improves
  distance integral or limiting without changing the proven route or wake.
- When the episode's hard joint-speed clamp is active, a same-sign outward
  acceleration is redundant actuator demand: it cannot change the next
  velocity or angle. Across the sampled captures, `2.8%` of anterior and
  `4.9-5.5%` of posterior commands have this signature. Closed-loop evaluation
  of the exact-boundary projection matched the unprojected best's `16.044T`
  capture, `-0.058311` score, all `8/6/4/2L` milestones, distance integral,
  joint extrema, and force/moment peaks, while lowering mean absolute commanded
  acceleration from `23.452/25.514` to `23.294/24.871 rad/T^2`. This supports a
  reflection-equivariant anti-windup projection only at the exact observed
  boundary, not a softer near-limit gait change. The present four-solver sample
  sharpens the negative boundary: three distinct policy source hashes,
  spanning the unprojected phase-residual carrier and exact-boundary projected
  variants, produced byte-identical wake sheets and the same `16.0435T`,
  `0.746962L`, `-0.058311` capture also repeated in inherited step-9 through
  step-11 logs. Therefore rejected-command cleanup is useful but is not new
  physical trajectory diversity; later workers seeking a hydrodynamic change
  should alter feasible action under an evidence-conditioned gate instead of
  stacking another clamp-equivalent wrapper. Falsify or revise the equivalence
  for actuator models where rejected demand affects work, compliance, or fluid
  coupling, and do not extrapolate it away from the exact clamp.
- Pre-limit posterior speed-headroom guarding is a replicated negative result
  on this carrier, even when it attenuates only outward wave acceleration and
  passes a pointwise same-sign/no-larger-command test. The inherited factorial
  rollout on the response-conditioned approach reduced posterior speed- and
  acceleration-limit residence (`6.066%` to `5.850%` and `22.892%` to
  `22.751%`) plus peak force/moment, but delayed every `8/6/4/2L` milestone,
  moved capture from `16.049T` to `16.077T`, and regressed score from
  `-0.056774` to `-0.058139`. The assigned-parent combination with the older
  unconditional approach likewise retained capture but required `236` rather
  than `229` window shifts and reached the target at `16.071T`, `-0.057037`,
  versus the sampled anterior-only corridor result at `16.0545T`, `-0.055617`.
  A pointwise actuator-relief predicate therefore does not establish
  closed-loop route neutrality: the wake can remain visually coherent while
  small phase-local changes accumulate into a longer path. Do not tune another
  near-speed onset on this scaffold; revisit pre-limit guarding only with a
  distinct response observable and require milestone/distance-integral benefit,
  not lower saturation or loads alone.
- Carrier-phase subtraction can expose a useful yaw-response residual as well
  as a route-error residual, provided the residual changes feasible steering
  rather than merely wrapping a clamp. Three independent assigned-parent
  samples were byte-identical at `16.0545T`, `1.938857L` distance integral,
  and `-0.055617`; adding posterior mean curvature only when normalized
  measured yaw minus joint-phase-predicted yaw opposed a reliable raw redirect
  preserved the coherent alternating top-down and oblique 3D wake and capture
  time, advanced every `8/6/4/2/1.25L` milestone by `0.072-0.127T`, lowered
  the distance integral to `1.931257L`, and improved score to `-0.048654`.
  This was not broad authority escalation: mean absolute posterior command and
  acceleration-limit residence fell from `24.888` to `24.616 rad/T^2` and
  `22.47%` to `21.86%`, while peak yaw moment also fell. Apply the mechanism
  only on a coherent carrier with an evidenced joint-phase yaw model, reliable
  target-directed redirect sign, and a bounded opposition-only addition;
  aiding yaw must receive no extra action. Preserve the caveats that posterior
  excursion grew from `31.7` to `36.4 deg`, peak lateral force rose from
  `0.03193` to `0.03320`, and the final crossing geometry changed even though
  capture time did not. The current sample and inherited step-18/19 logs now
  establish a narrow terminal role boundary. Relative to the yaw-opposition
  carrier's `0.747530L`, `1.931257L` distance integral, and `-0.048654`, two
  independent copies that release only supplemental curvature when a closing
  capture corridor and measured target-signed yaw agree retain the same
  `16.0545T` capture and coherent two-view wake while improving to `0.746955L`,
  `1.930773L`, and `-0.048055`. Adding an instantaneous bearing-rate escape
  trigger changes those quantities by only `0.000002L`, `0.000001L`, and
  `0.000002`, respectively; treat that extension as trajectory-equivalent and
  do not tune another release threshold. Trace reconstruction sharpens what a
  genuinely different terminal response must address: over the last `0.0715T`
  of the released rollout, projected miss improves from `0.503L` to `0.373L`
  and closing speed from `0.926U` to `1.029U`, yet bearing reopens from `0.021`
  to `0.178 rad`, its seven-sample rate grows from `0.568` to `2.716 rad/T`,
  and target-signed yaw rises from `0.53` to `2.02 rad/T`. Preserve the
  route-improving residual correction outside the safe corridor, and retain
  the evidenced base redirect, wave shaping, and anterior release inside it;
  if testing further, change feasible action with bounded terminal yaw damping
  rather than stacking another release predicate. Falsify this implication if
  terminal damping changes pre-corridor milestones, delays or loses capture,
  disrupts wake coherence, or regresses distance integral/final crossing; also
  revise it if a held-out route needs course response rather than target-signed
  yaw to retain supplemental terminal authority.
- Translational target-line rate is a distinct terminal observation, but it
  must be judged jointly with body yaw rather than by distance score alone.
  Against three repeatable redirect-handoff/yaw-damper captures at
  `16.0544T`, `0.745943L`, `1.929921L` distance integral, and `-0.047001`, a
  bounded posterior correction from normalized body-frame target/velocity
  cross product preserved every `8/6/4/2/1.25/0.9L` milestone, the coherent
  top-down and oblique wake, joint extrema, limit residence, and force/moment
  peaks while improving to `0.745869L`, `1.929859L`, and `-0.046924`. The
  moment-led yaw predictor was nearly trajectory-equivalent at `0.745938L`,
  `1.929917L`, and `-0.046995`, so load lead alone is not the reusable result.
  The slip correction also reveals an allocation boundary: at capture it
  lowers translational line rate by `0.00243 rad/T` versus the parent but raises
  target-signed yaw by `0.01705 rad/T` and body-frame bearing from `0.183324`
  to `0.183914 rad`. Thus separate translational slip from rotational yaw on a
  proven closing corridor, but do not tune another slip gain or claim that a
  lower distance integral damps total line-of-sight reopening. A follow-up
  should hand response authority between the two measured components or alter
  their actuation allocation, requiring retained capture/route/wake plus an
  improvement in both distance geometry and late yaw/bearing response.
  Falsify the positive transfer if the distance benefit does not replicate,
  pre-corridor milestones move, capture is delayed or lost, loads rise, or a
  held-out approach needs simultaneous slip and yaw authority.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
