# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled policies and the assigned-parent child are finite captures
  from direct uniform still water with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. The sampled trajectories form
  two executable-equivalent pairs: the whole-carrier recovery pair reproduces
  `23.331013T`, `2.135772L` scored mean distance, and score `-0.239045`, while
  the posterior phase-lag pair reproduces `23.122009T`, `2.133413L`, and
  `-0.237071`. This is deterministic fixed-pose evidence, not robustness.
- The top-down sheets show both allocations self-propelling along the same
  captured S-route. Alternating red/blue mid-plane structures form behind the
  caudal region by `4T` and persist through capture; there is no visible
  collision, passive advection, or wake collapse. The phase-lag policy is
  farther from the target through `8T`, crosses ahead between `9T` and `12T`,
  and reaches `2.029L` rather than `2.158L` at `20T`, so its gain is a later
  traveling-bend/route allocation rather than stronger startup translation.
- The strongest phase-lag sheets have blank oblique rows and therefore provide
  no independent three-dimensional wake confirmation. The inspected matched
  whole-carrier sheet has a complete oblique row with discrete Lambda2
  structures behind the posterior body from `4T` through capture, establishing
  the inherited 3D-wake bound but not proving the phase-lag variant meets it.
- The assigned-parent course-qualified angle-quadrature addition is the
  informative negative control. Its complete top-down and oblique sheet retains
  the same visible route and discrete three-dimensional wake class, and it
  still captures, but arrival regresses to `23.265013T`, scored mean distance
  to `2.137810L`, and score to `-0.241061`. It lowers mean action from `60.062`
  to `58.970` and exact anterior/posterior rate-cap occupancy from about
  `11.92/7.06%` to `11.47/6.36%`, but raises peak normalized force from
  `0.030360` to `0.031321`. Reduced effort does not compensate for the lost
  distance and arrival performance.

## One candidate hypothesis

Materialize the strongest sampled posterior phase-lag policy as the sole
candidate. Relative to the prefilled whole-carrier controller, move its bounded
`0.12` through-water speed-deficit share out of whole posterior-carrier
amplitude and into only the anterior-velocity quadrature of the lagged tail
target. Do not retain the assigned parent's extra angle-quadrature amplitude.
This preserves the through-water course observation, anterior oscillator
recovery, full target geometry, anterior redirect, phase-selective carrier,
reactive rudder, and terminal relief exactly. It is an evidence-backed actuator
reallocation, not a scalar gain sweep or a new unqualified composition.

Falsify this exploitation candidate if it does not reproduce capture at
`23.122009T` with scored mean distance `2.133413L`, or if the established
top-down route, mean action near `60.062`, rate-cap occupancy near
`11.92/7.06%`, or peak normalized force/moment near `0.030360/0.015861`
changes. A complete oblique sheet should show discrete three-dimensional wake
structures comparable to the whole-carrier reference; another blank oblique
row is missing visual evidence, not a wake failure or confirmation. Even an
exact fixed-pose reproduction would establish determinism only, not robustness
to pose, inflow, wake, or hydrodynamic variation.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: sustain a traveling bend by placing feedback-recruited posterior authority in phase delay rather than adding stroke-reversal excursion
transferable_invariant: normalized through-water slowdown may recruit the velocity-quadrature delay of a joint-state carrier while slow body-frame target geometry retains route control
nontransferable_details: published gains, dimensional speeds and frequencies, distributed-body envelopes, species-specific kinematics, robot calibration, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: preserve the sampled state-feedback carrier and move the bounded posterior recovery share from whole-carrier amplitude to the anterior-velocity term of the tail-lag target, with no added angle quadrature
falsification: reject if capture differs from 23.122009T, scored mean distance differs from 2.133413L, or the route, complete two-view wake, action, saturation, force, or moment envelopes worsen
