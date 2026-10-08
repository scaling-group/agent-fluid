# Candidate diagnosis and hypothesis

## Inherited evidence

- All four sampled rollouts report direct uniform initialization at
  `U_infinity=(0,0,0)`, remain finite, and capture. The assigned v40 parent
  (`solver_dc7991cddfff`) is strongest: score `-0.26138429`, mean distance
  `2.15109279 L`, final distance `0.74830240 L`, and capture at `19.68449 T`.
  The v39 geometry-agreed parent and two carrier-rescue siblings capture at
  `19.78351 T` with scores from `-0.2621800` to `-0.2621414`.
- In both inspected combined sheets, the top-down row shows self-propelled
  target motion and a coherent alternating reverse-vortex street; the oblique
  row shows compact, finite three-dimensional Lambda2 structures through
  capture. The assigned parent and carrier-recovery sibling have the same
  useful outer trajectory. Their distinction is therefore terminal response,
  not wake creation or gross route selection.
- The assigned parent's intercept-supported posture begins changing the
  realized path only inside `4 L`. Relative to v39 it reduces below-`4 L`
  `|action|>30 rad/T^2` counts from `318/373` to `229/302`, anterior excursion
  from `0.6982` to `0.6615 rad`, and capture time by about `0.099 T`. This is
  evidence to preserve both the geometry-agreed outer allocator and the
  posture handoff.
- At `1 L`, the assigned parent still has a helpful clockwise yaw
  (`-0.236 rad/T`) against positive signed course miss, so indiscriminate yaw
  damping would oppose useful correction. At capture, however, signed course
  sine is about `+0.822` while yaw has reversed to `+0.433 rad/T`; the same-sign
  product indicates rotation away from the target ray. Course error is about
  `0.964 rad` and predicted miss `0.615 L`. The weaker samples finish with the
  same topology and still larger course error/predicted miss, about
  `1.108-1.109 rad` and `0.670-0.671 L`.
- The inherited closure-efficiency gate is a negative control: a gait-subscale
  closure ratio produced a finite `30.58 L` loop and capture only at
  `44.8855 T` (`-0.93693931`). No short-window closure-efficiency gate is
  reused.

## Policy hypothesis

Preserve the v40 policy byte-for-byte outside the terminal blend. Inside it,
form a smooth `course_signed_sine * turn_rate` support that is positive only
when measured yaw is worsening an already material center-course miss. Use
that support only to raise the existing terminal allocation toward the same
damped mean-curvature equilibrium; combine it by `max` with the inherited
response allocation. This transfers authority from the carrier rather than
adding acceleration or a new curvature command. It should leave helpful
negative yaw near `1 L`, outer saturation arbitration, wake coherence, and the
capture topology unchanged while opposing the observed late yaw reversal.

Falsification: reject the candidate if commands change outside `4 L`, helpful
opposite-sign yaw is damped, capture is delayed or lost, mean/final distance
regresses, terminal high-command counts or force/moment maxima materially
increase, or either wake view loses coherence. An earlier threshold crossing
without a smaller course miss or at least preserved capture margin is not
sufficient.

## Offline contract audit

Replaying only the selector algebra over the assigned parent's stored
kinematics (not CFD) makes the new support nonzero on 79 late samples, greater
than the inherited `0.82` settled allocation on 31 samples, and full near
`0.761 L`. It is zero at the `1 L` crossing where yaw still has the helpful
opposite sign. Direct Julia comparisons against the assigned-parent policy
give identical commands outside and at `4 L`, identical commands for a
synthetic helpful-yaw terminal state, and different finite commands for its
same-sign worsening-yaw counterpart. This establishes activation and nominal
noninterference only; the later CFD evaluation must decide hydrodynamic value.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish control and terminal capture scheduling
source_mechanism: preserve the traveling-wave gait far from the target, then use measured near-target yaw/slip response to schedule a damped posture without coasting early
transferable_invariant: separate productive propulsion from a bounded response correction, and intervene only when measured motion is carrying the approach away from the target ray
nontransferable_details: published gains, oscillator clocks, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame center-course cross product, measured turn rate, distance, and the existing two-joint damped curvature equilibrium to select terminal allocation without adding authority
falsification: lost or delayed capture, changed outer commands or wake, damping of helpful yaw, worse distance or miss, renewed saturation, or larger force and moment loads
