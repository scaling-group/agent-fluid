# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- Every sampled rollout reports direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Motion and wake
  structures are therefore self-generated rather than imposed advection.
- The strongest finite sample, `solver_19f251537923`, develops a sustained
  alternating street in the top-down vorticity row and compact alternating
  structures in the oblique Lambda2 row. Its imported `28 deg`, `0.55T`
  carrier reduces range from `12.328L` to `6.138L` at `16.51T`, but heading
  then continues toward `1.383 rad`; range regresses to `10.460L` before a
  lower-boundary exit at `26.147T`. Raw anterior and posterior accelerations
  exceed `1800 deg/T^2` in `3346/4754` and `3655/4754` samples, respectively,
  so its useful thrust is inseparable from routine actuator clipping.
- The assigned parent, `solver_a8731015fd6e`, retains a visible alternating
  wake and uses the calibrated correct sign, but a static posterior mean bend
  capped at `4 deg` suppresses useful travel while accumulating excessive
  turn: heading falls from `0.506` to `-0.412 rad` by `8T`, minimum range is
  only `11.878L`, and the fish exits the upper boundary at `9.108T`.
- `solver_97bc3c03d55b` increases static-curvature authority through a raw
  recent-yaw-rate loop and reaches `9.175L`, but crosses zero heading by `8T`
  and exits the same upper boundary. `solver_d94c4664e94e` adds bounded
  bearing-trend lead to the parent's static bend, yet does worse: its minimum
  is `12.030L`, heading crosses zero by `6T`, and it exits upward at `8.717T`.
  Thus polarity, more static authority, and sub-beat response lead have all
  preserved the boundary-exit topology rather than supplying controlled
  target pursuit.
- The short failures show a tight turn with a short wake, whereas the imported
  carrier translates along a long coherent street. Local flow is only about
  `0.02--0.03U` at informative closest approaches, and no rollout enters the
  `0.75L` capture regime. The supported next test is therefore a different
  steering actuator that remains subordinate to propulsion, not wake
  rejection or terminal scheduling.

## Policy hypothesis

Replace the persistent posterior equilibrium offset with one bounded
target-gated half-cycle asymmetry. A joint-state oscillator and posterior lag
retain a directed traveling wave. Normalized body-frame line-of-sight error
sets the sign of a small posterior half-cycle imbalance: for a positive
body-y target, strengthen the positive posterior-wave side and weaken the
negative side, matching the established positive-mean-bend-to-negative-yaw
calibration. As alignment returns, the imbalance continuously vanishes; after
crossing, it reverses without a clock, raw yaw-rate loop, or mutable phase.

Use a `20 deg`, `0.70T` carrier whose nominal anterior harmonic acceleration
is about `1610 deg/T^2` and rate about `180 deg/T`, with a smooth returned-
acceleration envelope at `1750 deg/T^2`. This is an envelope-aware mechanism
test, not an assertion that these scalar settings are transferable.

Expected result: a materially longer, stronger wake than the parent's tight
turn, initial negative yaw without crossing far below the target direction,
and minimum range better than `11.878L` without routine returned-command
clipping. Falsify the mechanism if initial positive line-of-sight error does
not produce negative mean yaw, wake strength remains parent-like, the upper
exit repeats without better progress, the closest approach does not challenge
`9.175L`, or either returned command persists at the smooth envelope. The new
candidate's CFD result is unavailable to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG direction tracking
source_mechanism: sensor-gated half-cycle amplitude asymmetry superposed on a posterior-lagged propulsive rhythm
transferable_invariant: persistent body-frame target error may imbalance the two sides of an observed beat, but steering must vanish continuously with alignment while the directed traveling wave remains the propulsion carrier
nontransferable_details: published gains, dimensional frequencies, linkage geometry, clock-driven CPG phase, species kinematics, exact vortex phase, and task-specific routes
policy_translation: normalize `target_body_L` by `distance_L`, map its signed line-of-sight angle to a bounded scale imbalance inferred from posterior target-wave side, and return only two joint accelerations under a smooth physical envelope
falsification: reject if the calibrated initial yaw sign is wrong, the coherent wake collapses, the upper-boundary topology recurs without better progress, or commands persist at the smooth bound
