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
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- The far-field response-release hypothesis has a concrete negative result in
  direct-uniform still water.  Relative to the transferred seed, gating only
  geometric steering when measured yaw had the requested sign changed minimum
  and final distance from `4.780/9.709L` to `4.660/9.604L`, but preserved the
  lower-boundary exit, roughly `98%` exposure to at least one raw acceleration
  command above the actuator envelope, and essentially the same thresholded
  yaw-reversal count (82 versus 84).  The evaluator's seven-sample
  `turn_rate_recent` window spans only about `0.0385T`, so it is dominated by
  within-beat rotation and must not be treated as a route-scale response signal
  or repaired by another release-gain tweak.  Preserve the coherent carrier
  and deep early approach, but test steering authority upstream of clipping.
  Do not replace the carrier wholesale: a corrected-sign `12 deg` static mean
  curvature reached only `12.206L` before an upper exit, while the assigned
  parent's globally slower, soft-limited progress redirect removed raw
  acceleration exceedance but degraded closest approach to `8.752L` and also
  exited above.  The inherited course-response experiment closes an important
  loophole: even an initial negative tail-tangent bias below `0.5 deg`, released
  and reversed using measured swimming direction, reached only `12.083L` and
  exited above at `8.618T`.  Thus correct actuator polarity or course alignment
  alone does not make an always-on mean bend safe at the release pose.  In this
  direct-uniform, fixed-initial-joint regime, keep the demonstrated carrier and
  leave mean curvature dormant near the initial centerline.  The completed
  materially off-axis wrong-polarity veto now closes the release-only branch:
  relative to the response-release child it improved minimum distance from
  `4.660L` to `4.141L` and delayed the lower exit from `28.369T` to `32.197T`,
  but still finished at `9.570L` through the same lower boundary with a
  coherent unrecovered diagonal wake.  Thus geometric withdrawal can preserve
  and modestly extend the useful approach, but another veto threshold or
  release gain is unlikely to supply route-scale turning.  Its completed
  phase-selective successor validates a distinct useful mechanism: attenuating
  only the contradicted posterior half-cycle improved closest approach again
  from `4.141L` to `3.033L`, reduced raw acceleration-envelope exposure from
  `98.09%` to `93.63%` and joint-rate-limit exposure from `19.41%` to
  `12.68%`, preserved the coherent wake, and changed the lower exit into a
  later left-boundary exit at `40.331T`.  Preserve that allocation rather than
  retuning it as a scalar.  The completed descendants close the posterior-only
  recapture branch: carrier-unloaded and persistent-route pivots reach only
  `3.024L` and `2.996L` and execute nearly the same broad upper loop, while a
  pre-passage sector pulse improves the pass to `2.579L` but still exits above.
  Giving that sector steering first claim on the acceleration envelope is the
  first large allocation improvement, reaching `1.076L` and lowering mean
  distance from `6.913L` to `6.178L`, but it overshoots to an upper exit at
  `37.823T`.  Its posterior joint is held at the `-45 deg` hard limit during
  the redirect and its peak normalized lateral force/yaw moment jumps to
  `0.441/0.211`, versus at most about `0.028/0.015` for the three sampled
  comparators.  Thus preserve bounded steering priority but do not add another
  late recapture gain or more sector magnitude.  The reusable next test is a
  mirror-equivariant velocity-course error that begins correcting a predicted
  lateral miss before the hard-limit turn and releases on course alignment;
  keep it dormant on the established far approach.  Reject that implication
  if it cannot beat the `1.076L` pass, changes the far trajectory, or retains
  the exceptional joint-limit load class.  That test now has replicated
  positive evidence: three byte-identical course-preview samples capture at
  `24.5795T` and `0.74697L` with mean distance `2.36044L`, replacing the upper
  exit while retaining a coherent three-dimensional wake.  A subsequent
  position-and-command-aware posterior stroke guard also preserves capture
  (`24.6180T`, `0.74872L`) and cuts tail hard-limit occupancy from `23.38%` to
  `12.60%`; peak absolute body-frame force and yaw-moment coefficients fall
  from `0.269/0.178/0.143` to `0.165/0.118/0.089`.  Its raw acceleration and
  joint-rate exposure remain essentially unchanged (`72.84/15.15%` versus
  `72.65/15.10%`), so preserve stroke-aware allocation as load relief, not as
  a saturation cure.  Two completed conditional handoffs are concrete
  negatives: returning relief only with measured inward stroke captures at
  `0.749001L` and score `-0.462859`, while a course-alignment handoff captures
  at `0.749838L` and `-0.464278`; both consume more of the narrow margin than
  the evaluated guard without a new trajectory benefit.  Do not spend another
  candidate on a recovery-phase, carrier-direction, or alignment handoff.  A
  final command projection is a separate negative control: it produces the
  exact evaluated-guard score and distance (`-0.462756`, `0.748724L`) because
  it duplicates downstream actuator clipping.  Treat zero reported raw
  exceedance from such output clipping as representational consistency, not
  improved dynamics or saturation relief.  The completed outward-rate
  prediction is useful load shaping but not a constraint cure: it retains
  capture at `24.5960T`, lowers peak absolute planar force/yaw-moment
  coefficients from `0.165/0.118/0.089` to
  `0.149/0.097/0.0667`, yet leaves posterior hard-stop and any-joint
  rate-limit occupancy at `12.634/15.139%`.  Preserve its prediction, but
  do not tune another onset threshold or priority floor.  Its completed
  braking-reserve successor establishes the stronger reusable mechanism:
  replace an insufficient near-boundary command with bounded inward
  deceleration derived from posterior position, outward rate, and the owned
  acceleration envelope.  It retains the same coherent route and captures at
  `24.6290T` and `0.748702L`, eliminates sampled posterior hard-stop
  occupancy, and reduces peak planar force/yaw-moment coefficients again to
  `0.0241/0.0303/0.0149`.  Preserve this filter rather than returning to
  handoff or output-clipping variants.  Its remaining `15.163%` rate-limit
  occupancy is a separate carrier-envelope defect: `9.357%` anterior and
  `5.806%` posterior, and every rate-limited sample still commands
  acceleration aligned with measured joint velocity.  Two completed
  sign-symmetric velocity barriers now falsify the broad dual-joint version of
  that test.  A barrier that drives conflicted commands toward full inward
  braking reduces exact-rate occupancy to `0/0.236%` anterior/posterior but
  misses at `0.933L` and exits left at `37.273T`; a softer barrier eliminates
  sampled exact-rate occupancy on both joints but misses at `0.848L` and exits
  left at `36.751T`.  Both preserve zero posterior hard-stop occupancy and low
  peak loads, and both retain coherent wakes, yet both shift the long approach
  and convert capture into the same pass-and-turn failure topology.  Therefore
  do not treat a lower saturation statistic as improvement, inject
  rate-triggered inward braking into both joints, or tune another shared rate
  band.  Preserve the anterior oscillator as the phase anchor.  The completed
  posterior-only coast guard validates the narrower alternative: tapering only
  velocity-increasing posterior acceleration to zero at the rate boundary
  retains capture and the coherent route, preserves zero posterior hard-stop
  occupancy, and reduces posterior/any-joint exact-rate exposure from the v32
  `5.806/15.163%` to `4.586/13.869%`.  Its peak absolute planar
  force/yaw-moment coefficients remain in the same low class
  (`0.0244/0.0337/0.0162`), and its `-0.452083` score is better than the three
  byte-identical sampled v27 captures at `-0.460673`.  Treat this as evidence
  for preserving direction and phase while removing redundant follower
  command, not for aggressive rate regulation: capture is delayed from the
  inherited v32 `24.6290T` to `25.0635T`, raw acceleration-envelope exposure
  rises from `73.05%` to `73.93%`, and the untouched anterior phase anchor
  still accounts for `9.282%` exact-rate exposure.  Preserve the posterior
  coasting layer, but do not tune its band as another scalar, extend it to the
  anterior oscillator, or turn zero-command coasting into inward braking.
  Reopen rate feasibility only with a new phase-preserving follower mechanism,
  and reject it if capture, the established path, zero posterior hard-stop
  occupancy, or this low-load class is lost.
- The replicated v34 trace sharpens what a phase-preserving follower must
  address.  Its 243 near-boundary posterior-rate rows occur during
  centerline transits (`2.090--14.383T`, mean/max absolute posterior angle
  `0.062/0.172 rad`), not near the protected stroke stop; in 221 of those rows
  the derivative of the existing anterior-derived tail target, estimated with
  the bounded anterior command at the high end of the sampled cadence range,
  already points opposite posterior velocity.  Together with the inherited
  v32 capture and the two failed dual-joint barriers, this supports an
  upstream, posterior-only reference-velocity follower at phase reversal—not
  another position brake, shared rate barrier, or coast-threshold retune.
  Apply it only to a fast follower moving against its observed carrier
  reference, and falsify it if the v34 capture path, coherent wake, zero
  posterior hard-stop occupancy, low-load class, or rate exposure regresses.
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
