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
- This lineage starts from the transferred 2D clean-B iteration-20 champion.
  It contains target-aware feedback; evaluate its actual 3D performance rather
  than assuming either successful transfer or a missing steering mechanism.
  No 3D solver or optimizer population is imported.
- The transferred champion's direct-uniform still-water rollout establishes a
  useful carrier but a failed steering topology: its coherent alternating 3D
  wake and roughly `0.8 L/T` speed persist as distance improves from
  `12.3277 L` to `4.7800 L` at `17.853 T`, then the path continues downward,
  distance rebounds to `9.7089 L`, and it exits the lower boundary at
  `27.495 T`.  For this approach-then-diverge pattern, preserve the posterior-
  lag gait and test body-frame motion anticipation or response-gated curvature
  before increasing carrier amplitude/frequency.  Falsify that implication if
  earlier redirection weakens closing or wake coherence, creates persistent
  saturation, or leaves the same closest approach and `left_domain` topology.
- A controlled redirect-release comparison converts the coherent near-miss
  into capture without changing the carrier or curvature magnitude.  The
  response-gated parent reaches `2.4625 L` at `24.228 T`, passes above-left of
  the target, and exits left; multiplying its observed-yaw release by
  geometric completion instead sustains target-signed curvature at large
  body-frame angle and captures at `0.7496 L` and `26.411 T`.  The captured
  rollout retains the alternating 3D wake while reducing mean/max speed from
  `0.733/1.265` to `0.501/0.667 L/T` and peak raw joint accelerations from
  about `109.4/175.1` to `74.2/85.6 rad/T^2`.  By contrast, terminal carrier
  amplitude/cadence relief reaches `1.2329 L` but still misses and accelerates
  to `1.432 L/T` before a lower-boundary exit; inherited velocity lead, shared
  whole-wave curvature, and global drive relief also regress useful closure.
  When an oscillatory yaw signal can falsely announce completion of a large
  redirect, require contraction of normalized body-frame target angle before
  releasing the burst and preserve the posterior-lag carrier.  Apply this to
  coherent large-angle near-misses; falsify it if another pose or wake loses
  capture/early closing, reverses the target-signed arc, degrades wake
  coherence, or materially exceeds the captured speed/action envelope.
- Do not add a policy-side outward-speed guard merely to reduce clipping in a
  stable captured gait when the evaluator already enforces the same actuator
  envelope.  Relative to three reproduced completion-gated captures at
  `26.411 T`, score `-0.71050`, and distance integral `2.6134 L`, the sampled
  guard reduced speed-limit contact from about `11.4%` to `2.9%` and clamped
  policy output, but delayed capture to `26.813 T`, increased the integral to
  `2.6382 L`, worsened score to `-0.73429`, and did not reduce peak force or
  moment.  Treat envelope projection as a safety mechanism, not free
  performance: test it only when overspeed, instability, load, or an explicit
  effort objective is the failure mode, and otherwise preserve productive
  outward acceleration in an already stable route.
- Carrier/residual allocation and gait-phase rejection are compatible but
  improve different parts of the route and actuator envelope.  Three sampled
  evaluations of their combination reproduce capture at `23.9305 T`, score
  `-0.55178`, and distance integral `2.4500 L`, improving both carrier-first
  allocation alone (`25.9545 T`, `-0.64779`, `2.5501 L`) and phase-rejected
  guidance alone (`25.0745 T`, `-0.65392`, `2.5541 L`) while retaining the
  coherent target-directed wake and the same `0.0297/0.0148` peak normalized
  force/moment scale.  Applying its joint-state common mode consistently to
  yaw and bearing-trend derivatives then improves late closure again, capturing
  at `23.6390 T`, score `-0.54451`, and integral `2.4422 L`; it trails by only
  `0.020 L` at `12 T`, leads by `0.030/0.129 L` at `16/20 T`, and preserves
  the alternating 3D wake.  That derivative-only extension falsifies actuator
  relief as the explanation: any-joint acceleration-limit residence rises from
  `45.62%` to `48.21%` and peak speed from `0.784` to `0.810 L/T`, with the
  peak force/moment scale unchanged.  Its proportional body-frame target angle
  still has `0.167 rad` within-beat variation and `-0.927` correlation with
  head-joint angle; subtracting the redirect-commanded joint mean before the
  same phase projection reduces the reconstructed variation to `0.072 rad`
  while changing the route-scale mean by less than `0.012 rad`.  For a coherent
  gait with joint-correlated body rotation, retain carrier-first target
  authority and distinguish both derivative and pose common modes from
  deliberate mean curvature before adding steering or propulsion.  Treat
  derivative rejection as an evidenced late-route improvement, not an effort
  reduction; falsify pose projection if another pose lacks the correlation or
  if it loses capture, route closure, wake coherence, or the established
  speed/action/load envelope.
- Saturation-aware cross-joint allocation is now a closed-loop result rather
  than only a frozen-state headroom argument.  Two independently written
  variants that move only the target-derived anterior steering residual lost
  after carrier-first projection into posterior headroom reproduce capture at
  `19.3105 T`, score `-0.21058`, and distance integral `2.09959 L`, improving
  the centered gait-frame parent at `20.5315 T`, `-0.29558`, and `2.18697 L`.
  The allocated controller leads by `0.050/0.195/0.517/0.994 L` at
  `4/8/12/16 T`, preserves the coherent alternating wake and
  `0.03056/0.01541` peak normalized force/moment scale, and lowers any-joint
  acceleration-limit residence from `46.29%` to `42.35%` even as mean/max
  speed rises from `0.628/0.894` to `0.665/0.931 L/T`.  When target steering
  is clipped by an anterior carrier and posterior headroom is observed,
  transfer only that signed rejected residual; do not transfer carrier demand
  or claim generic effort relief.  Falsify this rule when the posterior joint
  lacks same-sign headroom, the route or wake loses coherence, capture or
  integral regresses, or speed/load growth outweighs closure.
- Mean-preserving whole-wave pose rejection survives closed-loop CFD and
  improves the spillover route.  The completed controller subtracts its
  bounded route and redirect means from the observed two-joint tail tangent
  before adding posterior carrier pose to the body-frame target projection;
  relative to three reproduced head-only v29 captures at `19.3105 T`, score
  `-0.21058`, and integral `2.09959 L`, it captures at `18.9970 T`, score
  `-0.18597`, and integral `2.07455 L`.  It leads by
  `0.024/0.154/0.149/0.174 L` at `4/8/12/16 T`, preserves the coherent
  alternating top-down and oblique wake, and keeps max speed and peak
  normalized force/moment within `0.927/0.03068/0.01541`, although any-joint
  acceleration-limit residence rises from `42.35%` to `43.43%`.  For a
  coherent two-joint gait whose target observation contains joint-correlated
  carrier recoil, reject the complete traveling-wave pose while retaining the
  controller's deliberate mean bend and keeping large-error redirect selection
  on raw geometry.  This is a route-sensing improvement, not effort relief;
  falsify it under another pose or wake if capture or middle/late closure
  regresses, mean curvature changes sign, the wake decoheres, or the established
  speed/action/load envelope is materially exceeded.
- Phase-common-mode rejection does not transfer indiscriminately from route
  pose sensing to actuator phase or route-rate feedback.  Relative to the v30
  whole-wave-pose capture at `18.9970 T`, score `-0.18597`, and integral
  `2.07455 L`, subtracting commanded mean curvature from the half-cycle
  detector retains capture but regresses to `19.0355 T`, `-0.20185`, and
  `2.08993 L`; it is `0.118/0.124 L` farther away at `8/12 T`, raises maximum
  speed from `0.927` to `0.948 L/T`, and raises acceleration-limit residence
  from `43.43%` to `44.21%`.  More critically, extending offline-correlated
  rejection to `qdot1+qdot2` changes the same useful carrier into an upward
  wrong-sign turn and `left_domain` at `8.4755 T`, with only `12.2107 L`
  minimum distance and peak normalized force/moment of `0.3025/0.1347` versus
  `0.0307/0.0154`.  For this two-joint gait, retain raw mean-informed
  half-cycle steering and the validated head-only route-rate correction;
  treat frozen-trajectory phase correlation as diagnostic, not causal proof.
  Revisit either projection only if a closed-loop sign/authority analysis
  predicts target-signed curvature and bounds loads before CFD.
- A response-gated posterior-lag residual is a reproducible later-route
  improvement over the completion-gated carrier, but should not be described
  as startup recovery.  Three direct-uniform evaluations reproduce capture at
  `26.0425 T`, score `-0.69472`, and distance integral `2.5975 L`, versus
  `26.4110 T`, `-0.71050`, and `2.6134 L` without the residual; at `24 T` the
  residual leads by `0.1811 L`, while distance near `2 T` is slightly worse.
  It raises mean/max speed from `0.501/0.667` to `0.508/0.717 L/T` without
  raising the sampled `0.0297/0.0148` peak force/moment scale.  An inherited
  aligned low-speed cadence residual is a weaker substitute: it captures at
  `26.5430 T`, remains `2.304 L` away at `24 T`, and raises peaks to about
  `0.0319/0.0159`.  For a coherent, already captured gait, gate added thrust
  through normalized closing response and put it in posterior wave shape,
  yielding to approach and turn load; falsify this lesson if the later-route
  lead fails to reproduce under another pose or wake, capture regresses, or
  speed, limit residence, force, or moment materially worsens.
- Independently positive steering and propulsion recoveries are not
  necessarily additive; compare trajectory semantics before trusting their
  combined scalar score.  Reverse recovery of posterior-rejected steering
  improves the slower whole-wave base from `18.9970 T`, score `-0.18597`, and
  integral `2.07455 L` to `18.8705 T`, `-0.18102`, and `2.06891 L`, but after
  positive-closing response releases turn-relieved cadence, three combined
  evaluations reproduce a later `18.7660 T` capture than cadence release
  alone at `18.7550 T`.  The combination is farther away by
  `0.0031/0.0178 L` at `12/16 T` and has a worse observed distance integral
  (`1.45130` versus `1.45037 L`); its nominally better score
  (`-0.17027` versus `-0.17114`) comes from a deeper discrete terminal sample,
  not better approach.  It does lower maximum speed from `0.949` to
  `0.940 L/T` and acceleration-limit residence from `41.96%` to `41.35%`, so
  treat it as a mild regularizer rather than closure authority.  Frozen-state
  reconstruction places every reverse-allocation event in strong positive
  closure, identifying an arbitration test: let extra recovered steering
  yield as measured closure restores propulsion.  Apply this boundary when
  both mechanisms compete during an already coherent target-directed arc;
  falsify response arbitration if another pose needs simultaneous authority,
  loses capture or wake coherence, or worsens middle/late closure or the
  established speed/action/load envelope.
- Geometry-gated bearing-divergence recovery is a reproducible route
  improvement, and stacking an unrelated success gate on it is mildly harmful.
  Three direct-uniform v34 evaluations reproduce capture at `18.4030 T`, score
  `-0.14045`, total/observed distance integrals `2.02781/1.41810 L`, and a
  coherent alternating two-view wake.  Adding a yaw-and-positive-closing
  release to the same correction captures at `18.4140 T`, is already
  `0.0008 L` farther away near `16 T`, and worsens the integrals to
  `2.02872/1.41827 L` without changing the `0.9476 L/T`, `0.03068`, and
  `0.01587` maximum speed/normalized-force/moment envelope.  When bounded
  target-signed curvature is already active only for out-of-band de-gaited
  bearing moving away from centerline, release it when that geometric error
  contracts; do not also suppress it merely because closing and correct-sign
  yaw coexist.  Falsify this rule if a different pose or wake needs the second
  response signal to preserve capture, improve middle/late closure, reduce
  loads, or prevent oscillatory oversteer.
- Carrier-coherent crossflow is useful as bounded pose confidence, not as
  monotone wake cancellation or a route schedule.  Relative to three
  reproduced v34 captures at `18.4030 T`, score `-0.14045`, and
  total/observed distance integrals `2.02781/1.41810 L`, weighting de-meaned
  anterior joint phase by a smooth moderate-crossflow confidence captures at
  `18.2325 T`, score `-0.12650`, and integrals `2.01298/1.39980 L`.  It is
  closer at every `2 T` checkpoint through `18 T`, with a `0.1060-0.1437 L`
  lead from `8-16 T`, while maximum speed rises only from `0.9476` to
  `0.9519 L/T`, acceleration-limit residence falls from `42.14%` to `41.54%`,
  and peak normalized force/moment remains `0.03068/0.01579`.  By contrast,
  monotone crossflow authority captures at `18.3260 T` but trails during the
  high-crossflow middle route and raises speed/residence to `0.9631 L/T` and
  `43.55%`; a late distance gate captures only at `18.3865 T`.  For a coherent
  target-directed gait, pass absolute normalized body-frame crossflow through
  confidence that yields at both zero and disturbance-like magnitudes,
  multiply it by observed carrier phase to preserve odd symmetry, and confine
  it to proportional whole-wave pose rejection.  Do not rectify flow sign
  into steering, schedule the cue by a learned route segment, or extend it to
  rate feedback/direct actuation.  Four byte-identical sampled v38 captures now
  reproduce the `18.2325 T` result from direct-uniform still water, and a
  readable combined sheet shows the same coherent target-signed wake in both
  the top-down and oblique rows, satisfying the earlier visual boundary.
  Lateral-load magnitude does not improve this confidence law: the inherited
  full-route soft union captures slightly earlier at `18.1995 T` but worsens
  total/observed integrals to `2.01591/1.40257 L`; response-gating that union
  and bridging only raw-crossflow dropout regress further to
  `18.3095/18.2545 T` and `2.01911/2.01679 L`, despite similar force, moment,
  and saturation envelopes.  Their organized top-down rows show no new wake
  benefit and both oblique rows are black.  Thus response and primary-sensor
  dropout gates are not sufficient evidence that a route-wide high-magnitude
  load cue is complementary.  Retain the selective crossflow-only pose cue and
  test a different actuator/response mechanism; revisit load only if a
  sign/coherence discriminator remains selective on completed traces and a
  readable two-view rollout improves middle-route closure as well as capture.
  Falsify the crossflow rule under another pose or flow scale if the
  checkpoint-wide lead, capture, or low-load envelope regresses, or if complete
  visuals show wake degradation.
- Posterior launch response must distinguish axial propulsion from sway without
  pretending that all lateral motion is irrelevant.  The completed
  axis-selective controller keeps total planar speed as the release signal for
  its base posterior-wave envelope and uses positive forward body-axis speed
  only for the smaller phase-even joint-energy deficit residual; it captures
  at `17.7540 T`, score `-0.07917`, and total/observed distance integrals
  `1.96508/1.34990 L`.  Three separately written comparators that release the
  entire envelope from axial speed reproduce capture at `17.8970 T`,
  `-0.08687`, and `1.97313/1.35927 L`.  The full-axial form is closer by
  `0.0050/0.0195 L` at `2/4 T`, but loses that lead by `6 T` and trails by
  `0.0378/0.0720/0.0929/0.0909 L` at `8/10/12/16 T`; readable combined
  sheets show the same coherent target-directed alternating wake rather than
  a beneficial new topology.  For a sway-dominated but coherent launch,
  preserve phase-insensitive whole-body motion as the broad envelope governor
  and localize axial selectivity to a bounded posterior energy residual.  Do
  not infer from weak initial axial speed that the whole tail wave needs more
  amplitude.  Falsify this allocation under another pose or flow if its
  middle/late lead, capture, or organized two-view wake fails to reproduce, or
  if speed, saturation, force, or moment materially exceed the completed
  envelope.
- Release rules for supplementary steering can have a route-stage crossover;
  compare checkpoint semantics before selecting one by scalar score or stacking
  both everywhere.  Against the inherited axis-selective launch capture at
  `17.7540 T`, score `-0.07917`, and total/observed distance integrals
  `1.96508/1.34990 L`, two sampled phase-even posterior-turn-shape evaluations
  reproduce capture at `17.6440 T`, `-0.07419`, and
  `1.95985/1.34371 L`.  Releasing only that supplementary curvature on
  correct-sign de-gaited yaw improves again to `17.5065 T`, `-0.06667`, and
  `1.95193/1.33422 L`; releasing it on in-window bearing contraction captures
  slightly later at `17.5340 T` but has the better score and integrals at
  `-0.06405` and `1.94972/1.33372 L`.  The geometric rule is closer by
  `0.0172/0.0333/0.0257 L` at `8/10/12 T`, while the yaw-response rule is
  closer by `0.0180/0.0279 L` at `14/16 T` and arrives `0.0275 T` sooner.
  Both release variants retain readable coherent target-signed wakes in the
  top-down and oblique rows.  Their peak normalized force remains `0.03225`;
  response release changes max speed/moment/any-joint limit residence from the
  geometric rule's `0.9731/0.01609/43.22%` to
  `0.9815/0.01625/42.70%`, so neither result is generic load or effort relief.
  The assigned-parent optimizer logs also show that four earlier changes to
  carrier cadence, approach steering, or approach thrust all worsened total
  integral and changed observed integral by less than `0.000062 L`; the
  crossover is therefore evidence for release arbitration, not permission to
  reopen the carrier or base route authority.  The completed follow-ups now
  falsify normalized distance as the missing arbitration variable.  Blending
  from contraction release to yaw release inside `4.0 L` is identical to the
  contraction parent through the `2-14 T` checkpoints, leads by only
  `0.00133 L` at `16 T`, and captures one solver step earlier at `17.5285 T`,
  while total integral/score regress from `1.949721/-0.06405` to
  `1.950718/-0.06531`.  Geometry partition is more informative: using
  contraction inside the centerline window and correct-sign yaw outside it
  improves observed integral from `1.333721` to `1.331907 L`, capture from
  `17.5340` to `17.4790 T`, maximum speed from `0.9731` to `0.9602 L/T`, and
  acceleration-limit residence from `42.75%` to `40.15%`, with the same
  `0.03225/0.01609` peak normalized force/moment scale and coherent readable
  two-view wake.  Its scalar still regresses to `-0.06581` because a shallower
  `0.749953 L` crossing raises terminal hold to `0.618869 L`, overwhelming
  the route-integral gain.  The completed approach-priority follow-up then
  multiplies only the out-of-band yaw-release branch by the existing normalized
  approach gate.  It is identical to the geometry partition outside `2.1 L`
  and changes observed integral by only `+0.000042 L`, but deepens the terminal
  crossing from `0.749953` to `0.745909 L`, reducing total integral from
  `1.950776` to `1.947439 L` and improving score from `-0.06581` to `-0.06165`.
  Against the contraction parent it captures `0.0495 T` earlier at
  `17.4845 T`, improves observed integral from `1.333721` to `1.331949 L`,
  lowers maximum speed from `0.9731` to `0.9602 L/T` and acceleration-limit
  residence from `42.75%` to `40.17%`, and retains the same
  `0.03225/0.01609` peak normalized force/moment scale.  Its top-down wake
  remains organized, but its oblique sheet is black after frame 000, so 3D
  wake preservation is not established for that rollout.  For an independently
  useful supplementary residual, first partition release by normalized
  body-frame response geometry; use distance only to return target-signed
  authority continuously in the immediate capture region, not to switch
  release observations at a learned route stage.  Preserve the carrier and
  base route, and do not reopen their gains to fix the remaining `10-14 T`
  checkpoint regression.  Falsify this rule if the route and terminal gains,
  capture, or speed/action/load envelope fail under another pose or flow, or
  if complete two-view evidence shows wake degradation.
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
