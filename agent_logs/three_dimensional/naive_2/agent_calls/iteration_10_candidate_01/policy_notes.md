# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. In both rows of each
  combined keyframe sheet the fish is self-propelled: the top-down view develops
  a coherent alternating vortex street and the oblique Lambda2 view shows
  tail-connected three-dimensional structures rather than passive advection.
- The useful carrier is therefore not the missing capability. Every sampled
  policy instead follows the same broad upper-exit topology. The assigned parent
  (`solver_37a652a3989e`) reaches `4.162L` at about `17.51T`, recedes to
  `6.363L`, and crosses the upper margin at `23.36T`. The best scalar sample
  (`solver_4482d3d05d9c`, score `-7.588`) exits sooner at `20.86T` and never
  gets closer than `5.126L`; its top-down and oblique sheets retain a wake but
  do not show a route correction. The course-gated half-cycle sample
  (`solver_963e74a3f179`) likewise exits upward and degrades closest approach to
  `5.000L`. Thus neither drive relief nor posterior half-cycle attenuation fixes
  the directional response.
- Trajectory reconstruction exposes a semantic sign conflict shared by all
  samples. The policy computes `target x velocity`, which is the signed angle
  from target direction to velocity, and then adds it as though it were the
  corrective angle from velocity to target. At the assigned parent's closest
  approach, target bearing is `+0.969 rad`, speed is `0.824U`, and the existing
  course value is `-1.257 rad`; the actual velocity-to-target correction is
  `+1.257 rad`. The other three closest-approach rows have the same opposition:
  positive bearing near `+0.99` to `+1.30 rad` but raw course angles from
  `-1.36` to `-1.95 rad` (clamped at `-pi/2` where applicable). The present
  course term therefore cancels the needed redirect while the body translates
  above the target.
- Measured yaw is also added directly to the turn request. In the parent, a
  needed positive route correction at `16T` coincides with yaw rate
  `-1.135 rad/T`; adding that rate further suppresses the correction instead of
  rejecting the wrong-sign response. This is consistent with the inherited
  guidance: terminal drive relief and proximity-only half-cycle modulation kept
  a coherent carrier but preserved the upper exit, with prior closest approaches
  of `3.926L` and `3.259L` respectively. The new mechanism should act on route
  response before the terminal regime.

## Policy hypothesis

Preserve the full anterior state-feedback oscillator and full lagged posterior
wave. Replace the oppositely signed, centerline-only course brake and additive
yaw-rate term with one speed-qualified body-frame direction-tracking mechanism:
compute the velocity-to-target angle, use it with bearing to request a bounded
yaw rate, and feed back desired-minus-measured yaw rate into the posterior mean
curvature. Retain the inherited bounded crossflow residual. This changes the
feedback semantics rather than tuning a scalar or shedding propulsion.

Expected result: after useful translation begins, course correction and bearing
should reinforce rather than cancel, while wrong-sign yaw should increase the
restoring request. The full alternating wake should remain connected to the tail,
the upper drift should reverse before the prior `16--20T` divergence, and the
candidate should improve the `4.162L` parent approach without increasing the
roughly `0.032` peak planar-force or `0.016` peak-yaw-moment scales.

Reject the mechanism if it destroys the alternating carrier, increases limit
residence or load spikes, loses the parent's closest approach, or repeats the
same upper-boundary exit without an earlier downward course response.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: sensor feedback modulates a low-dimensional rhythmic carrier through a bounded residual turn command
transferable_invariant: preserve the propulsive rhythm while comparing requested and measured directional response in a body-relative frame
nontransferable_details: published CPG gains, robot geometry, dimensional beat timing, species kinematics, and source-task routes
policy_translation: keep the two-joint traveling wave, derive a normalized velocity-to-target request, and apply desired-minus-measured yaw feedback only to posterior mean curvature
falsification: reject if the coherent wake or parent approach is lost, loads or saturation rise materially, or the same upper-exit topology survives without earlier course correction
