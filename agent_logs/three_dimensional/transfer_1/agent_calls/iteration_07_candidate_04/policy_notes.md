# Motion-established posterior-thrust candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and `capture`.  Two samples are the assigned
  completion-gated prefill, one adds aligned low-speed cadence recovery, and
  the best adds a progress-gated posterior-lag residual plus the already
  validated acceleration projection.  The inherited optimizer log proposed
  that posterior mechanism before its CFD result; the sampled result now
  supplies the missing evaluation evidence.
- The completion-gated baseline captures at `26.4110 T`, mean distance
  `2.61340 L`, and score `-0.71050`.  The aligned cadence variant remains a
  coherent capture but reaches at `26.5430 T`, raises peak lateral force and
  yaw moment from about `0.02974/0.01484` to `0.03193/0.01593`, and scores
  `-0.70419`; it improves the score integral but does not improve termination
  time.  It is the most informative current mechanism-level failure, since no
  sampled rollout has a failed termination.
- In both the baseline and best combined sheets, the fish is self-propelled
  along a continuous closing arc.  The top-down row shows an alternating
  red/blue wake established by `8 T`, a long coherent posterior street, and a
  final target-directed turn rather than a standing lateral wiggle.  The
  oblique row shows compact alternating Lambda2 structures behind the body at
  `8`, `16`, and `24 T`, with no visible collapse or unstable load event before
  capture.  The best sheet differs subtly in route and reaches the capture
  disk earlier; its motion cannot be ambient advection because maximum sampled
  local-flow magnitude is only `0.02958` while mean fish speed is `0.50808`.
- The progress-gated posterior-lag rollout is the strongest finite sample: it
  captures at `26.0425 T`, reduces score-model mean distance to `2.59751 L`,
  and improves score to `-0.69472`.  It is slightly worse during launch
  (`12.2668 L` versus `12.2631 L` near `2 T`) and still trails at `8 T`
  (`10.7306 L` versus `10.6878 L`), but leads by `16 T` (`6.8035 L` versus
  `6.8736 L`) and `24 T` (`2.0645 L` versus `2.2456 L`).  Mean/max speed rises
  from `0.5013/0.6669` to `0.5081/0.7170`, while peak lateral force and moment
  stay at the baseline values; peak axial force rises modestly from `0.01365`
  to `0.01590`.  Thus the posterior mechanism survives, but its low-motion
  activation does not.
- Both compared controllers reach the `4.53786 rad/T` joint-speed limit.  The
  best projected commands reach `31.41593 rad/T^2` in about `69.5%/38.2%` of
  head/tail rows, so a global amplitude or cadence increase is unsupported.
  The next edit should shape when the successful residual is available, not
  increase its scalar strength.

## Policy hypothesis

Promote the evaluated progress-gated posterior-lag policy and add one bounded
state-feedback gate: the extra posterior lag turns on only after measured
body-forward speed indicates that the carrier has established forward motion.
The gate is continuous, uses `-velocity_body_U[1]` in the body convention
already evidenced by the rollout, and multiplies only the auxiliary residual;
the proven base traveling bend, completion-gated redirect, half-cycle
steering, cadence schedule, approach logic, and acceleration projection remain
unchanged.  This is a motion-state transition rather than a clocked launch
stage or scalar-only gain tune.

Expected result: recover the baseline launch through the low-speed interval,
then recover the sampled posterior-lag benefit as body-forward speed enters the
established `0.45--0.63` range, improving the distance integral without
reopening the captured redirect.  Falsify it if the `2--8 T` distance deficit
remains, capture is lost or later than `26.0425 T`, mean distance exceeds
`2.59751 L`, the coherent two-view wake changes adversely, joint-limit
residence grows, or force/moment extrema increase without compensating
closure.

bookshelf_consulted: true
source_domain: Lighthill-style reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: posterior traveling-wave emphasis released by observed locomotor response rather than by an elapsed-time stage
transferable_invariant: add posterior thrust only when measured body motion shows that the anterior carrier has established a propulsive traveling bend, and remove the auxiliary command when task closure or steering load makes it unnecessary
nontransferable_details: published gains, dimensional speed thresholds, species-specific envelopes, clocked CPG phase, exact vortex phase, and prescribed routes
policy_translation: retain the sampled closure-gated posterior-lag residual but multiply it by a smooth gate from normalized body-forward velocity; preserve normalized target geometry, two-joint state feedback, and the parameter-owned acceleration boundary
falsification: reject if early distance is not recovered, the sampled late closure and capture-time benefit disappears, or wake coherence, loads, or actuator-limit residence materially regress

## Scope

No same-worker CFD result is claimed.  Formal evaluation occurs after worker
exit; current evidence supports the mechanism selection and falsification
boundary, not this candidate's eventual outcome.
