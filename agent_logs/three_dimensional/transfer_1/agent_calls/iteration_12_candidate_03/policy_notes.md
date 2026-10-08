# Posterior residual-recovery candidate

## Evidence and visual diagnosis before editing

- All four sampled solver evaluations satisfy the frozen Phase-2 contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and semantic `capture`.  The assigned
  parent's v28 centered gait-frame projection is the strongest sample at
  `20.5315 T`, score `-0.29558`, and distance integral `2.18697 L`, versus the
  reproduced v27 capture at `23.6390 T`, `-0.54451`, and `2.44217 L`.  It leads
  v27 by `0.364/1.424/1.771/2.134 L` at `8/12/16/20 T`.
- I inspected both the top-down vorticity and oblique Lambda2 rows from release
  through termination for v28 and v27.  Both fish are visibly self-propelled
  from quiescent water: compact startup structures develop into coherent
  alternating three-dimensional posterior packets.  V28 preserves one smooth
  target-signed arc but advances farther along it at every late keyframe; the
  more separated packets agree with its higher mean/max speed rather than
  passive advection.  The mean/max speed rises from `0.553/0.810` to
  `0.628/0.894 L/T`, peak normalized planar force/yaw moment rises slightly
  from `0.02974/0.01484` to `0.03056/0.01525`, and head/tail/any-joint
  acceleration-limit residence changes from `32.50/15.70/48.21%` to
  `35.92/10.37/46.29%`.  Thus the route improvement is large, but target
  authority has shifted toward the already constrained anterior joint.
- The inherited uncentered target-frame sibling is the informative failure.
  Its top-down row retains an alternating wake but visibly passes the target,
  curls away, and exits left; the oblique row confirms continued self-propulsion
  rather than instability.  It misses capture by only `0.0506 L`, then exits
  at `30.9388 T` with final distance `12.1995 L`.  Unlike the successful v28,
  it projected the large-error redirect through raw head-joint displacement.
  This comparison protects raw redirect selection and subtraction of the
  redirect-commanded joint mean before gait-frame route projection.
- An offline replay of the completed v28 trajectory reconstructs its logged
  joint commands with maximum/mean error `0.00109/0.000006 rad/T^2`.  The
  componentwise carrier-first projection loses some same-sign target residual
  on `36.0%` of head steps but only `10.39%` of tail steps; mean lost residual
  on affected steps is `2.03` versus `0.74 rad/T^2`.  On those fixed recorded
  states, routing the unmet head residual into posterior headroom recovers all
  of it without increasing tail-limit residence.  This diagnostic supports a
  cross-joint allocation change, not a carrier or steering gain change.

## One-candidate policy hypothesis

Preserve v28's state-feedback traveling wave, centered gait-frame target
projection, raw completion-gated redirect, progress-gated posterior lag,
half-cycle steering, and physical acceleration bound.  Replace independent
componentwise residual projection with one coupled allocator: project each
carrier component first, apply the head steering residual, measure only the
bounded residual that the head could not realize, and add that unmet amount to
the posterior steering residual before its final projection.  When the head
has authority, behavior is identical; when it saturates outward, the posterior
joint supplies the route request without cancelling the carrier.

The expected outcome is to retain capture and v28's early/late route lead while
reducing loss of target steering at head-saturated half-cycles, ideally lowering
capture time or distance integral without materially increasing tail saturation,
speed, force, or yaw moment.  Falsify the mechanism if capture is lost or later
than `20.5315 T`, integral exceeds `2.18697 L`, the continuous target-signed arc
or coherent alternating wake degrades, tail/any-joint limit residence grows
materially, or max speed and normalized force/moment exceed the v28 envelope.

bookshelf_consulted: true
source_domain: residual CPG control and posterior-emphasized robotic-fish turning
source_mechanism: preserve the rhythmic propulsive oscillator while a target-derived residual uses available posterior actuation to maintain turn authority
transferable_invariant: route-scale steering should remain separate from the carrier and move only its unrealized bounded component to an actuator with available authority
nontransferable_details: published gains, clocked CPG phase, robot or species geometry, dimensional cadence, exact vortex phase, prescribed route, and any claimed equivalence between anterior and posterior torque
policy_translation: use normalized body-frame v28 guidance unchanged, project both state-feedback carrier accelerations first, measure the clipped head steering residual, and add that signed unmet residual to the posterior joint before the shared physical bound
falsification: reject if the allocator loses or delays capture, worsens the route integral, destroys the target-signed wake, or materially raises posterior saturation, speed, normalized load, or the inherited left-exit risk

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD and
inherited optimizer logs.  The residual allocator is an unevaluated candidate;
formal CFD after worker exit must decide whether the frozen-state headroom
diagnostic transfers to the closed-loop trajectory.
