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
  capture time did not. The assigned-parent evidence and inherited step-18/19
  logs establish a narrow terminal role boundary. Two independent copies that
  release only supplemental curvature when a closing capture corridor and
  measured target-signed yaw agree reproduce `16.0545T` capture, `0.746953L`
  final distance, `1.930772L` distance integral, and the same two-view sheet.
  An instantaneous bearing-rate escape extension remains trajectory-equivalent
  at `0.746955L`, `1.930773L`, and `-0.048055`; do not tune another such
  threshold. In contrast, moving reopening response into a smooth
  small-bearing closing-approach cone preserves the coherent alternating wake,
  all `239` shifts, and effectively the same arrival time, while improving the
  crossing to `0.746212L`, distance integral to `1.930147L`, and score to
  `-0.047281`. Thus release geometry can affect the last fraction of a beat,
  but this is still terminal shaping rather than a new route or held-out
  robustness result. Trace reconstruction specifies the remaining terminal
  response: over the last `0.0715T`, projected miss improves from `0.503L` to
  `0.373L` and closing speed from `0.926U` to `1.029U`, yet bearing reopens
  from `0.021` to `0.178 rad`, its seven-sample rate grows from `0.568` to
  `2.716 rad/T`, and target-signed yaw rises from `0.53` to `2.02 rad/T`.
  The sampled four-solver combination now confirms that the two previously
  positive response-local reductions are compatible. Three independently
  sourced copies of redirect-increment handoff plus bounded safe-corridor yaw
  damping produce byte-identical two-view sheets and the same `16.0544T`,
  `0.745943L`, `1.929921L`, `-0.047001` capture; yaw damping without the
  handoff retains the same arrival step and coherent wake but regresses to
  `0.746051L`, `1.930012L`, and `-0.047113`, while the inherited handoff-only
  result was `0.746070L`, `1.930028L`, and `-0.047133`. Complementary terminal
  gates can therefore improve crossing geometry when their response support
  differs, but three identical outcomes also establish that rewriting or
  retuning this combination is not trajectory diversity. Preserve the proven
  carrier, redirect, wave shaping, anterior release, and both terminal roles;
  a distinct follow-up may separate body yaw from body-frame translational
  line-of-sight slip, which remains present while bearing reopens, but must
  alter feasible posterior action only in the reliable closing corridor.
  Falsify that transfer if it changes pre-corridor milestones, delays or loses
  capture, disrupts wake coherence, regresses distance integral/final
  crossing, or merely duplicates the existing yaw damper.
- Carrier demodulation transfers from route-error and yaw-response selection
  to line-of-sight response, but it remains a trace-scale mean-curvature tool
  on this carrier. The assigned-parent net bearing-rate damper was duplicated
  at `16.0544T`, `0.745854L`, distance integral `1.929846L`, and score
  `-0.046908`; two independently sampled copies that subtract the normalized
  anterior-joint carrier-yaw prediction before middle-approach damping retain
  the same arrival step, all 239 shifts, and the coherent top-down/oblique wake
  while improving the crossing to `0.745846L`, the integral to `1.929840L`,
  and score to `-0.046900`. Mean posterior demand and exact acceleration-limit
  residence fall slightly from about `24.5858` to `24.5845 rad/T^2` and
  `21.86%` to `21.79%`, at the cost of a small peak lateral-force increase
  from about `0.03223` to `0.03239`. The reusable structure is to subtract a
  joint-state prediction of repeatable carrier motion before applying bounded
  sensory mean correction in the reliable middle corridor, then fade into the
  measured net target-line response near capture; do not use the residual to
  redefine direction or propulsion. The inherited phase-action comparison is
  a negative boundary: slip-conditioned half-cycle relief changed only four
  terminal samples and reached `-0.046923`, while broader raw-bearing-rate
  posterior-lobe relief regressed to `-0.046998`. Do not stack another terminal
  phase gate or tune another onset/curvature scalar expecting route diversity.
  Revisit phase shaping only if a distinct residual acts over measurable
  response support and improves target progress, not command effort alone.
  Falsify the mean-residual transfer if capture, earlier milestones, wake
  coherence, distance integral, limiting, or force envelope regresses, or if
  held-out conditions show that the fitted carrier prediction aliases useful
  route response.
- Body-forward force can select useful posterior-wave authority more reliably
  than speed deficit alone on this carrier. The inherited speed-gated branch
  was first replicated at `15.977511T`, distance integral `1.928580797L`, 238
  shifts, and score `-0.045506315`; conditioning only its feasible posterior
  increment on normalized positive axial response then produced the same
  route-scale result across an assigned parent and three terminal variants:
  capture at `15.768509T`, distance integral about `1.92407L`, 232 shifts, and
  score about `-0.04168`, with the coherent alternating top-down and oblique
  wake intact. Relative to the speed-only branch, the response allocator
  advances the `6/4/2/1.25L` milestones by
  `0.0660/0.0935/0.1540/0.1650T` and lowers mean posterior demand from
  `25.473` to about `25.221 rad/T^2`; it also raises posterior
  acceleration-limit residence from `22.58%` to `23.58%`, so this is not
  evidence for a larger wave gain or a lower positive-force threshold.
  Preserve the zero-force base wave, anterior carrier, and navigation when
  transferring the mechanism, and require route or distance-integral benefit
  rather than effort relief alone. The current sample also closes two weaker
  branches: the original startup-thrust interpretation remains falsified by
  delayed `8L` progress, and three independently sourced exact
  translational-line-of-sight terminal dampers retain every milestone and the
  same capture step, improving distance integral by only about `4.2e-6L`.
  Another terminal slip decomposition or threshold is therefore not useful
  trajectory diversity. A distinct follow-up may test bounded adverse-load
  relief only inside the evidenced response envelope, but must retain the
  later milestone gain and coherent wake; falsify force-based allocation if
  capture, distance integral, load envelope, or held-out behavior regresses,
  or if lower pointwise demand repeats the inherited longer-path pre-limit-
  guard failure.
- A carrier-demodulated yaw-moment residual can improve route-scale steering
  on the axial-response-allocated carrier, rather than serving only as a load
  diagnostic. Three independently sourced translational-line-of-sight parent
  variants were trajectory-identical at `15.768509T`, `1.924067L` distance
  integral, `0.745720L` final distance, `232` shifts, and score `-0.041674`;
  the distinct opposition-only moment policy retained the coherent alternating
  top-down and oblique 3D wake while advancing every `8/6/4/2/1.25L` milestone,
  capturing at `15.735508T` with `1.919818L` integral, `0.744372L` final
  distance, `231` shifts, and score `-0.037222`. This route gain is not
  plausibly a terminal line-of-sight artifact: inherited comparisons changed
  that terminal decomposition with the same arrival step and only about
  `4.2e-6L` integral effect, whereas the moment branch acts before approach.
  Mean posterior demand fell from `25.221` to `25.012 rad/T^2` and limit
  residence stayed essentially fixed near `23.59%`, but posterior excursion,
  peak lateral force, and peak yaw moment rose slightly (`34.73` to `35.15 deg`,
  `0.03329` to `0.03380`, and `0.01895` to `0.01920`). Apply only after a
  coherent traveling-bend carrier exists, a joint-phase model explains most
  repeatable moment, and target-directed redirect sign is reliable; add
  bounded curvature only for opposing residual moment and fade it through the
  approach. Falsify if earlier milestones, capture, distance integral, wake
  coherence, limiting, or the force envelope regress, or if held-out traces
  show the fitted carrier moment aliases useful steering response. The current
  four-solver sample closes two proposed extensions. Combining moment
  rejection with exact translational line-of-sight terminal damping is
  trajectory-neutral: two distinct source hashes produce byte-identical
  two-view sheets and the same `15.735508T`, `1.919818L`,
  `0.744372L`, `-0.037222` capture. Adding a separately demodulated
  lateral-force consensus as another mean-curvature increment retains capture
  and the coherent wake but regresses to `15.746509T`, `1.921600L`,
  `0.744715L`, and `-0.039050`; its 229 rather than 231 window shifts do
  not outweigh worse arrival, integral, and crossing. Thus a second load
  observation is not permission to stack more mean bend, and another terminal
  line-of-sight rewrite is not trajectory diversity. A distinct follow-up may
  translate the proven moment request into attenuation-only posterior duty
  redistribution instead of extra curvature, but this remains a falsifiable
  actuator-coupling hypothesis until CFD shows route neutrality or benefit.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
