# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- Every sampled rollout reports direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Motion and wake
  structures are therefore self-generated rather than imposed advection.
- The strongest useful trajectory, `solver_19f251537923`, retains a dense,
  coherent alternating top-down wake and compact oblique Lambda2 structures.
  Its fast traveling bend reduces range from `12.328L` to `6.138L` at
  `16.505T`, but heading subsequently grows and the fish continues below the
  target to a lower-boundary exit at `26.147T`. Its raw joint commands exceed
  `1800 deg/T^2` in `3346/4754` anterior and `3655/4754` posterior samples, so
  the useful propulsion is inseparable from routine evaluator clipping.
- The three compact target-guided samples share the complementary topology.
  The fast mean-curvature policy `solver_97bc3c03d55b` reaches `9.175L`, but
  heading falls from `0.506 rad` to about zero by `8T` and it exits the upper
  boundary at `11.132T`. The smaller opposite-polarity posterior bias in
  `solver_a8731015fd6e` still drives heading to `-0.412 rad` by `8T`, reaches
  only `11.878L`, and exits the same boundary. The assigned half-cycle parent
  `solver_1b4176f9edeb` stays within its returned acceleration bound, yet its
  weaker visual wake accompanies only a `12.165L` closest approach; heading
  crosses to `-0.247 rad` by `6T` and it also exits upward. Thus merely
  reversing a static bend or closing an instantaneous yaw-rate loop changes
  turn onset and effort, not the over-rotation topology.
- Both rows support preserving a directed posterior traveling wave: the two
  fast carriers shed sustained alternating structures and translate, whereas
  the bounded `12 deg`, `0.70T` parent has much weaker Lambda2 structures and
  little durable forward progress. Local flow is small in this still-water
  evidence, so a wake-rejection residual is not supported.
- The actionable missing capability is response-aware steering release. The
  desired initial correction is modest: positive body-frame line-of-sight
  error should reduce heading only until the target is aligned. Static
  curvature continues loading the turn, while the parent's nearly
  instantaneous `turn_rate_recent` residual oscillates over the beat and does
  not provide a reliable slow braking signal. The available body-frame bearing
  trend can instead lead the geometric error and reduce or reverse steering
  before the line of sight crosses zero.

## Policy hypothesis

Use one response-gated asymmetric-flapping mechanism on an envelope-aware
traveling-bend scaffold. An `18 deg`, `0.68T` anterior state-feedback rhythm is
stronger than the failed parent but has a nominal anterior sinusoidal peak of
about `1540 deg/T^2` and `166 deg/T`; the posterior command receives a smooth
`1750 deg/T^2` bound. Preserve posterior lag, and create no static mean bend.
Instead, forward-predict normalized body-frame line-of-sight error with a
bounded `bearing_window_rate` contribution. Smoothly strengthen the posterior
half-cycle that requests negative yaw for positive predicted error and weaken
its opposite; when alignment is approaching, the lead term releases the
asymmetry early, and after overshoot it reverses.

Expected result: a wake materially stronger than the assigned parent, initial
heading reduction without passing far below zero, and progress beyond the
mean-curvature samples while avoiding routine raw-command clipping. Falsify
the mechanism if the wake remains as weak as the parent, the initial yaw sign
is wrong, heading crosses zero before useful range reduction, the upper exit
recurs without beating `9.175L`, the closest approach does not challenge
`6.138L`, or returned actions routinely reach their explicit smooth bound.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and asymmetric flapping
source_mechanism: sensor-modulated half-cycle amplitude asymmetry that is released as the observed heading response aligns the target
transferable_invariant: preserve a posterior-lagged propulsive rhythm while a bounded body-frame error and its closing trend set a small signed beat asymmetry that leads, rather than chases, turn response
nontransferable_details: published gains, dimensional frequencies, linkage geometry, clock-driven CPG phase, species kinematics, exact vortex phase, and task-specific routes
policy_translation: normalize `target_body_L` by `distance_L`, lead its line-of-sight error with bounded `bearing_window_rate`, and use observed posterior wave side to modulate only half-cycle scale under the two-joint state-feedback and acceleration contract
falsification: reject if wake strength and progress remain parent-like, initial yaw has the wrong sign, heading overshoots through zero before useful approach, upper-boundary exit repeats, or commands persist at the smooth bound
