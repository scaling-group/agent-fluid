# Gait-synchronous yaw-residual candidate

## Visual and quantitative diagnosis before the policy edit

- All sampled evaluations use direct uniform still water with
  `U_infinity=(0,0,0)` and terminate by capture. The three copies of the
  strongest rate-governed controller reproduce `23.3640T`, mean score-distance
  `2.409486L`, and score `-0.51274776`; the weaker ungoverned comparison reaches
  capture one step earlier but has a longer `13.4189L` center path, larger RMS
  yaw rate, and worse `-0.51527750` score.
- I inspected the combined top-down and oblique sheets for the strongest
  sample, the weaker capture, and the two inherited phase-energy variants. In
  every top-down row the fish moves under its own tail beat and sheds an
  alternating wake from startup through the broad closing turn. The oblique
  Lambda2 rows show the same compact posterior three-dimensional structures;
  there is no prewarm wake, passive advection, wake collapse, collision, or
  out-of-plane instability. Thus the inherited phase-energy rollouts are
  informative efficiency failures, not semantic misses or different wake
  topologies.
- Three upstream energy-withdrawal mechanisms failed the full control test.
  Rate-headroom cadence suppression scored `-0.52317589` and arrived at
  `23.7435T`; positive-power phase-load gating scored `-0.53312008` and arrived
  at `23.6555T`; shared velocity damping scored `-0.53004112` and arrived at
  `23.7215T`. The latter two modestly reduced high-rate or acceleration-limit
  residence, but all three increased mean score-distance relative to the
  rate-governed parent while preserving nearly indistinguishable wakes. The
  evidence therefore rejects further carrier-energy attenuation as the next
  mechanism in this still-water capture condition.
- A different defect is present in route feedback. On the strong rollout, the
  recent yaw-rate signal used by guidance has `1.59 rad/T` RMS and is almost a
  gait-phase measurement: its correlation with anterior normalized joint rate
  is `-0.976` over the established transit. A single evidence-scale linear
  projection onto `phi_dot[1]/joint_rate_limit` reduces that measured yaw
  residual to about `0.35 rad/T`. Meanwhile the existing rate correction is
  saturated near `+/-1.25` through most beats and changes steering sign 55
  times before capture. It is therefore reacting strongly to propulsive body
  recoil rather than only to persistent course rotation.

## One policy hypothesis

Preserve the demonstrated odd target-to-curvature map, traveling-wave carrier,
posterior lag, half-cycle steering, terminal cadence, and selective output rate
governor. Add one phase-projected yaw observer inside guidance: predict the
gait-synchronous part of recent body yaw from bounded anterior joint rate
normalized by the owned actuator-rate envelope, subtract that prediction, and
feed only the residual yaw into the existing turn-rate feedback and recovery
terms. This is an observation/feedback mechanism, not a change to carrier
frequency or a global route. It should stop the route loop from cancelling
normal beat recoil while retaining target-driven mean curvature and the proven
actuator safeguard.

Falsify the candidate if it loses capture, changes the broad closing topology,
increases mean distance/path/arrival or load scale materially, produces a
persistent turn bias in the matched or reflected condition, or changes either
visual row from a posteriorly lagged alternating wake into a standing or
disorganized motion. Also reject the phase projection if the evaluated yaw
residual is not less gait-synchronous even when scalar score happens to move.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and adaptive wake-interaction control
source_mechanism: separate fast gait-synchronous body motion from slow persistent route error before closing the steering loop
transferable_invariant: project measured yaw onto observed oscillator phase and steer from the bounded residual rather than cancelling normal propulsive recoil
nontransferable_details: published CPG gains, dimensional cadence, species kinematics, exact vortex phase, wake routes, and the evidence-fitted projection scale
policy_translation: subtract a bounded prediction from recent yaw using phi_dot[1] normalized by the policy-owned joint-rate limit, then reuse the existing body-frame target geometry and two-joint actuation
falsification: reject if capture, reflected polarity, distance integral, path, arrival, loads, or top-down and oblique wake coherence worsen, or if route feedback remains dominated by gait-phase yaw
