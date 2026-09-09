# Wake-policy candidate notes

## Evidence diagnosis before edit

- The five inspected shared-prewarm sheets are byte-identical. They show the
  fish held near the upper-right boundary while four developed, interacting
  vortex streets fill the target corridor, so this is common initial-condition
  evidence rather than candidate-specific wake-phase or route evidence.
- Every available released sheet is a finite capture; no failed rollout sheet
  exists in this workspace. The strongest sampled policy actively swims
  down-left through the merged wakes with a zero-centered traveling bend and
  enters capture without approaching a cylinder. Its mean body x velocity is
  `-0.2470`, stronger upstream than its `-0.1848` mean local flow, and the head
  moves `-10.910/-4.263L`; this route is self-propelled, not passive advection.
- The prefilled near-target course damper is a matched positive result over the
  time-to-go-only baseline. It improves arrival/mean distance from
  `45.221/1.71458L` to `44.121/1.70618L` and lowers force/moment RMS from
  `439/4345` to `389/3909`, while mean command energy rises modestly from
  `1030.39` to `1036.49`. The released sheets retain the same diagonal topology
  and the stronger policy makes a shallower final crossing, so its route and
  propulsive scaffold should be preserved.
- The inherited shared-angular-budget variant is a concrete negative boundary.
  Clamping the already bounded heading response and course response together
  still reaches the target, but delays arrival to `45.727`, worsens mean
  distance to `1.72692L`, and raises force/moment RMS to `449/4408`; its lower
  `1025.91` mean command energy does not compensate. Its sheet makes a deeper
  terminal excursion, so this candidate does not recombine or retune those
  route-angle terms. The inherited actual failure boundary is broader optional
  propulsion, which passed below capture and collided after a `1.872L` closest
  approach; that evidence also rules out increasing the tail residual.
- The current best nevertheless touches the `4.538` joint-rate cap on both
  joints and reaches `28.79/28.39` acceleration. In inherited sign-resolved
  approach samples, body-course-minus-bearing remains about `0.59`, `0.30`,
  `-0.40`, and `0.33` rad between `2.05L` and capture. Positive closure and
  small position bearing can therefore coexist with terminal cross-course
  motion, while the current allocator can still add roughly `10--17%` optional
  posterior wave scale depending on closure and course trend.

## Policy hypothesis

Add exactly one terminal approach-hold mechanism to the successful prefill:
use the already measured body-frame course mismatch to smoothly withdraw only
the optional posterior propulsion residual as normalized distance shrinks. The
gate is even in mismatch sign, so it expresses excess cross-course motion, not
a memorized turn direction. It cannot remove the base traveling wave and is
inactive far from the target or when velocity course agrees with the target
line of sight. Preserve the oscillator, posterior lag, target steering,
heading response, course damper, yaw-magnitude steering gate, positive-closure
and course-consistency evidence, and soft acceleration limiter.

Expected evidence is the same diagonal first-crossing capture with a shallower
terminal crossing and either less joint-rate cap contact, lower load, or better
arrival/mean distance. Reject the mechanism if capture or the established wake
entry topology is lost, arrival or mean distance regresses without material
load/effort relief, or the inherited below-target pass returns. A fixed-wake
success would not establish changed-wake robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG approach control and wake-interaction swimming
source_mechanism: preserve the low-dimensional propulsive rhythm while sensor feedback continuously relieves excess drive during terminal slip
transferable_invariant: near capture, retain the base traveling wave but withhold optional propulsion when normalized body-frame velocity crosses the target line of sight
nontransferable_details: published gains, dimensional approach ranges, robot or species kinematics, exact vortex phases, cylinder or target coordinates, capture radius, and task-specific routes
policy_translation: multiply only the route-conditioned posterior wave increment by a bounded distance-and-course-mismatch gate while leaving the base two-joint wave and steering feedback unchanged
falsification: reject if diagonal capture or wake-entry topology is lost, terminal crossing persists, arrival or mean distance worsens without load relief, or the below-target collision topology returns
