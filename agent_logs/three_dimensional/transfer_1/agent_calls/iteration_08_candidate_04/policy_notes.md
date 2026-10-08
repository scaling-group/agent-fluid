# Speed-released posterior energy-envelope candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and semantic
  `capture`.  Three samples are the same effective v24 progress-gated
  posterior-lag controller and reproduce `26.0425 T` capture, mean distance
  `2.59751 L`, and score `-0.69471683`.  Their repeated outcome and inherited
  optimizer logs show that policy promotion and command-projection variants
  are exhausted; the informative weaker control is the v20 completion-gated
  capture at `26.4110 T`, mean distance `2.61340 L`, and score `-0.71050181`.
- The inspected v24 and v20 combined sheets show the same useful physical
  family.  In both top-down rows, the fish moves under its own power through a
  continuous targetward arc while an alternating red/blue wake grows behind
  the posterior body.  Both oblique rows confirm compact alternating Lambda2
  structures at `8`, `16`, `24 T`, and capture, with no visible wake collapse,
  collision, advection, or numerical instability.  The v24 route closes the
  final gap sooner without changing this topology.
- Trajectory metrics agree with the visual reading.  Relative to v20, v24
  improves capture by `0.3685 T`, mean distance by `0.01589 L`, and mean/max
  speed from `0.5013/0.6669` to `0.5081/0.7170 L/T`, while the sampled planar
  force/yaw-moment extrema remain about `0.0297/0.0148`.  This validates the
  closure- and steering-gated posterior lag as a whole-route mechanism.
  It does not validate the original launch claim: at `2 T` and `8 T`, v24 is
  slightly farther from the target (`12.2663/10.7306 L`) than v20
  (`12.2625/10.6878 L`), and its useful lead appears only after about `12 T`.
  The inherited aligned low-speed cadence residual is also a negative control:
  it captures later at `26.5430 T` and raises force/moment extrema to roughly
  `0.0319/0.0159` without improving the first two periods.
- The remaining weakness is therefore specifically low-speed response, not
  missing route curvature or a weak eventual carrier.  In v24, mean speed is
  only `0.117 L/T` through `2 T` and `0.180 L/T` through `4 T`; speed first
  stays above `0.28 L/T` after about `4.12 T`.  During the first `4 T`, the
  observed tail tangent has mean absolute excursion `0.205 rad`, maximum
  `0.534 rad`, and tail-velocity RMS `2.45 rad/T`.  Commands are already
  frequently projected (about `69.5%` of head rows and `38.2%` of tail rows
  over the whole route), so a global amplitude/frequency increase or another
  actuator-boundary edit is not an isolated test.

## Policy hypothesis

Retain v24's completion-gated redirect, target guidance, half-cycle steering,
closure-gated posterior lag, and parameter-owned acceleration projection.  Add
one posterior-only state-feedback mechanism: while normalized body speed is
below the observed established-swimming threshold, apply a bounded tail
acceleration in the direction of the observed tail-tangent velocity.  Taper
this energy residual continuously as body speed establishes, tail excursion
approaches its observed launch envelope, the target approaches, or steering
load grows.  This is a speed-released posterior amplitude envelope, not a
global carrier gain or clocked startup stage.

The mechanism uses only normalized body-frame velocity, joint angle/velocity,
target-relative distance, and existing turn demand.  It adds no elapsed time,
step counter, route coordinate, target identity, wake phase, or mutable
oscillator.  The direct test is whether it improves the previously unresolved
`2--8 T` distance while retaining v24's later lead and capture.  Reject it if
early distance is not better, capture is lost or delayed, mean distance
regresses, tail angle/speed or command-limit residence grows materially, the
alternating wake loses coherence, or force/moment extrema rise without a
compensating route improvement.

bookshelf_consulted: true
source_domain: Lighthill-style reactive propulsion and sensor-modulated robotic-fish oscillator control
source_mechanism: tail-end kinematic emphasis with a bounded state-feedback amplitude envelope
transferable_invariant: when normalized locomotor response is weak, add phase-aligned energy posteriorly and withdraw it as response, excursion, or steering demand establishes so the traveling bend remains the carrier
nontransferable_details: published gains, dimensional frequencies, species-specific tail envelopes, clocked CPG phase, exact vortex phase, and prescribed task routes
policy_translation: use normalized body-speed deficit to gate a bounded tail-velocity-aligned acceleration, taper it with observed tail-tangent excursion, target approach, and body-frame turn load, and retain the two-joint state-feedback contract
falsification: reject if distance at 2--8 T, capture time, or mean distance does not improve, or if steering, wake coherence, joint-limit residence, force, or moment materially regresses

## Scope

The numerical comparisons are completed sampled CFD evidence.  No same-worker
CFD result is claimed; formal evaluation after worker exit must decide whether
the new posterior energy envelope survives its stated boundaries.
