# Candidate diagnosis and policy hypothesis

## Evidence read before the candidate decision

- All four sampled rollouts satisfy the frozen-flow contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and active moving-window shifts. Their translation and wake
  formation are released-swimmer behavior rather than ambient advection.
- Three sampled policies have the exact
  `dogfish3d_intercept_guarded_speed_reserve_v1` bytes (SHA-256
  `567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`).
  They capture at `0.7466--0.7494L` after `18.3205--18.6010T`; the best
  sampled finite score is `-0.15140`. The fourth sample uses the posterior
  wave-shape residual and captures at `0.7480L`, but inherited exact-replay
  evidence already rejects that residual as less reliable than the baseline.
- I inspected both rows of the combined sheets for the highest-scoring
  speed-reserve capture and the distinct posterior-wave capture. From release
  through termination, both visibly self-propel, lay down an organized
  alternating mid-plane vortex street, and retain compact bilateral oblique
  Lambda2 structures. Neither shows carrier collapse, passive advection, or
  numerical instability. Their summary metrics confirm capture with active
  translation rather than a visually dramatic but unproductive wake.
- The current sample set contains no failed keyframe sheet. The inherited
  optimizer notes preserve prior two-view diagnoses of the informative lower-
  exit failures: the posterior pulse, exact baseline miss, yaw brake, and mean-
  curvature servo all retained active alternating wakes. The assigned
  parent's newest phase-compensated achieved-course observer has only scalar
  evaluation artifacts here; it missed at `1.5445L`, exited with final
  distance `10.4040L`, and scored `-11.2867`. Therefore no new visual claim is
  made for that rollout, but its semantic result falsifies the predicted
  capture improvement.
- The parent justified subtracting `0.42U` of anterior-joint-speed-correlated
  sway because an offline replay reduced terminal route-error total variation
  from `10.30--13.60` to `5.45--6.82`. The subsequent lower exit shows that
  trace smoothness is not a proxy for interception and provides no basis for
  scalar tuning of that compensation. Existing inherited evidence also
  rejects route-gain/cadence tuning, carrier suppression, total-command
  governors, half-cycle allocation, projected-miss replacement, posterior
  phase shaping, yaw braking, and mean-curvature tracking in this topology.

## One candidate hypothesis

Retain the exact sampled
`dogfish3d_intercept_guarded_speed_reserve_v1` candidate already materialized
in `solver/`, with no gain, schema, or byte changes. This is an evidence
rollback from the assigned parent's failed phase-compensated course observer:
it restores the repeat-supported raw achieved-course observation while
preserving the joint-state traveling bend, normalized body-frame target
feedback, intercept release veto, additive steering, and sparse outward-
carrier reserve. An unchanged exact replay is more informative here than a
new scalar variant of the falsified observer.

Expected test: recover capture while retaining the coherent top-down and
oblique wakes and the evaluated actuator/load envelope. The new CFD result is
not claimed here because evaluation occurs only after this worker exits.

Falsification: if this exact baseline replay misses again, treat the baseline
as phase-sensitive rather than robust and require complete trajectory, load,
and wake artifacts before selecting a distinct phase-invariant observation or
response mechanism. Do not answer either outcome by tuning the `0.42U`
observer coefficient or stacking any previously failed terminal residual.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a posteriorly lagged propulsive bend while target feedback remains a separate subordinate loop
transferable_invariant: an active directional body wave should be preserved when observation-side terminal variants fail without evidence of propulsion loss
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, world-frame routes, and task coordinates
policy_translation: remove the falsified joint-speed course compensation and retain the exact normalized body-frame achieved-course/intercept controller with its two-joint traveling bend and sparse actuator-state reserve
falsification: reject robust-baseline status if exact replay loses capture, weakens either wake view, changes far-field closure, or leaves the repeat-supported actuator and load envelope
