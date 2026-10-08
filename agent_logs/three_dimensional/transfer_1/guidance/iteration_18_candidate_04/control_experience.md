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
- Once whole-wave pose projection has established a coherent captured route,
  recover separately evidenced carrier and steering authority without
  reinterpreting the gait as route motion.  Against the same v30 capture at
  `18.9970 T`, score `-0.18597`, and distance integral `2.07455 L`, releasing
  only turn-induced cadence relief when normalized closing speed is positive
  captures at `18.7550 T`, `-0.17114`, and `2.05886 L`, while returning only
  posterior-rejected target steering to anterior headroom captures at
  `18.8705 T`, `-0.18102`, and `2.06891 L`; both retain the target-directed
  alternating 3D wake and about `0.0307` peak normalized force.  Their stack is
  now a concrete negative boundary rather than an untested additive hypothesis:
  three comment/version-distinct but code-equivalent v33 samples produce
  byte-identical trajectories, capture at `18.7660 T`, score `-0.17027`, and
  integral `2.05835 L`, versus the cadence-release v32 parent at `18.7550 T`,
  `-0.17114`, and `2.05886 L`.  The stack trails by `0.003/0.018 L` at
  `12/16 T`; its small score gain comes with a deeper discrete capture crossing,
  not a new route or wake, while mean/max speed and any-joint limit residence
  change only from `0.686/0.949 L/T` and `41.96%` to `0.686/0.940 L/T` and
  `41.35%` at the same `0.0307/0.0157` peak force/moment scale.  On this stable
  route, posterior target residual rarely benefits from being sent back to the
  already carrier-limited anterior joint: do not proliferate nominally distinct
  bidirectional-allocation variants without first demonstrating complementary
  headroom and a material route change.  Keep rhythmic carrier demand local and
  withhold cadence release when closure is nonpositive.  Two other nearby
  transformations remain negative boundaries:
  subtracting commanded mean curvature from the raw half-cycle detector slows
  capture to `19.0355 T` and raises any-joint limit residence from `43.43%` to
  `44.21%`, while adding a fitted posterior `qdot1+qdot2` common mode to route
  rates reverses the arc and exits at `8.4755 T` with `12.7296 L` final
  distance.  Apply the recovery pair only to stable captures with measured
  positive closure and complementary actuator headroom; reject it if the
  combination fails to beat the closing-response parent, changes the route
  sign or wake coherence, or materially worsens speed, saturation, force, or
  moment.
- After allocation variants repeatedly preserve one captured trajectory, a
  response-gated geometry mechanism can improve the route without strengthening
  the carrier.  Relative to the assigned response-arbitrated capture at
  `18.7550 T`, score `-0.16976`, and distance integral `2.05747 L`, adding
  bounded target-signed curvature only while de-gaited body-frame bearing is
  outside its centerline band and diverging captures at `18.4030 T`,
  `-0.14045`, and `2.02781 L`.  It leads by
  `0.061/0.148/0.230/0.225/0.201 L` at `4/8/12/16/18 T` while retaining the
  same smooth target-directed arc and coherent alternating 3D wake.  Mean
  speed changes from `0.685` to `0.696 L/T`, maximum speed remains
  `0.946/0.948 L/T`, any-joint acceleration-limit residence changes from
  `42.35%` to `42.14%`, peak normalized force stays `0.03067`, and peak moment
  changes only from `0.01564` to `0.01587`; the improvement is therefore not
  explained by extra propulsion or envelope expansion.  For a coherent route
  with measured out-of-band target-angle divergence, preserve the posterior-
  lag carrier and gate a compact curvature residual by worsening normalized
  body-frame geometry, releasing it when geometry responds.  Falsify this
  lesson if held-out poses lose capture or early closure, the residual follows
  within-beat recoil, bearing excursions or route sign worsen, wake coherence
  changes, or the established speed/action/load envelope materially expands.
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
