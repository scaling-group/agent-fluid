# Course-error half-cycle steering candidate

## Evidence diagnosis before policy edit

All four sampled evaluations satisfy the lane contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
prewarm, and lossless moving-window transport.  Motion in both visual rows is
therefore self-propulsion and closed-loop steering, not ambient advection.

- `solver_b6bb94d9cdaf` is the strongest finite sample by score (`-7.6367`)
  and mean distance (`6.5015L`).  Its top-down row shows sustained leftward
  travel with a coherent alternating vortex street, and its oblique row shows
  organized three-dimensional Lambda2 structures rather than breakup.  It
  reaches `5.3570L` at `19.05T`, but the path rises after about `10T` and exits
  the upper boundary at center `(8.6493,15.2024)L`, final distance `5.8935L`.
  At `16T` its body-frame course is about `+28.7 deg` while target bearing is
  about `-37.7 deg`: propulsion is useful, but additive bearing/yaw-rate mean
  curvature does not settle inertial course.
- `solver_e450df1efa49` retains the cleanest long axial wake and makes the best
  closest pass (`4.1281L`), yet remains above the target row, passes it, and
  exits left at center `y=12.4806L` with final distance `9.1538L`.  Its raw
  acceleration exceeds the physical envelope on roughly `71.3%/68.4%` of
  rows.  This is evidence for preserving posterior-lag propulsion, but against
  importing its layered static-curvature controller or actuator usage.
- `solver_59bc4ebdddec` directly falsifies the inherited release-only
  mean-curvature hypothesis.  It preserves a coherent propulsive wake and
  monotonically reaches `7.5311L`, but still rises to the upper boundary at
  center `y=15.2011L` after only `14.65T`; bearing-rate attenuation without a
  curvature-sign reversal neither improves the `5.3570L` benchmark nor changes
  the upper-exit topology.
- The prefilled `solver_d146183ecace` directly falsifies the course-to-yaw-rate
  inner loop.  The top-down frames show little translation followed by a tight
  upward curl, while the oblique frames never develop the long wake visible in
  the useful samples.  Beat-scale measured yaw rate repeatedly drives the
  posterior mean-curvature command between its smooth bounds: distance improves
  only to `12.2257L`, then the fish exits the upper boundary near release at
  `(20.3948,15.2002)L` and `8.646T`, final distance `12.7468L`.  Course error is
  still a relevant route observation, but a yaw-rate servo is not supported at
  this gait bandwidth.

The reusable implication is to stop refining the same static mean-curvature
actuator or its beat-scale yaw brake.  Preserve the joint-state oscillator and
posterior lag, use normalized target-minus-course error as the slow route
request, and test a different actuator primitive: body-state half-cycle
asymmetry.  The anterior oscillator remains centered.  The posterior target is
made stronger on only the request-compatible observed half-cycle, so its
cycle-average bend has the route-error sign without adding a static offset or
tracking instantaneous yaw rate.

Expected result: retain the coherent self-propelled wake, build left/downward
course correction after speed develops, and move the route away from the
sampled upper exits while keeping both acceleration commands controller-bounded.
Falsify the mechanism if propulsion decays like `solver_d146183ecace`, the
trajectory again exits high without beating `5.3570L`, course-to-target error
does not shrink, or joint angle/rate residence worsens.  This evidence does not
support terminal scheduling because no sampled run entered the `0.75L` capture
neighborhood.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and direction tracking
source_mechanism: sensor-driven asymmetric half-cycle amplitude modulation of a propulsive rhythm
transferable_invariant: persistent body-frame route error can steer a traveling bend by strengthening one observed-state half-cycle while preserving posterior lag and releasing continuously as course aligns
nontransferable_details: published gains, dimensional cadence, clock-driven CPG phase, species-specific envelopes, full-body waveforms, exact vortex phases, and source-task routes
policy_translation: map normalized target-minus-body-course angle to a bounded request and use joint angle plus normalized joint velocity to select posterior tracking gain for each half-cycle; retain a centered anterior state oscillator and controller-owned acceleration bounds
falsification: reject if the coherent wake or forward progress collapses, target-course error remains large, the same upper exit persists without a closer pass than 5.3570L, or actuator-limit residence worsens
