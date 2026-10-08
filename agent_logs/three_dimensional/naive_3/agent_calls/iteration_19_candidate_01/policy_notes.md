# Predictive posterior stopping-margin candidate

## Visual diagnosis and completed evidence

- Every current sample and the inherited comparison report direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. The motion and wake are controller-generated rather than ambient
  advection or moving-window transport.
- The prefilled `solver_3991cf23285f` capture is the strongest current finite
  example. Its top-down row shows an alternating vorticity street persisting
  through the target approach, while its oblique row shows discrete
  three-dimensional Lambda2 structures shed behind the undulating posterior
  body. Peak body speed is `1.329U` against only `0.0315U` peak local flow, so
  the terminal motion is self-propelled. It captures at `18.271T` and
  `0.748232L`.
- The inherited `solver_eae76e537f62` measured-moment residual is the useful
  visual failure. Its top-down and oblique sheets retain an alternating,
  self-propelled wake, but the trajectory passes the target and continues to
  a left-boundary exit after reaching only `0.845170L`. Together with the
  assigned-parent history of `0.834--0.876L` left exits, this shows that a
  coherent carrier and nominal course request were insufficient before
  actuator allocation, rather than diagnosing weak propulsion.
- The assigned parent's acceleration-reserve hypothesis is now confirmed by
  all four sampled rollouts: the three equivalent reserve controllers capture
  at `18.265T` and `0.749826L`, and the prefilled reserve-plus-brake controller
  also captures. Relative to the inherited unallocated `0.857L` near miss,
  the reserve controller lowers posterior raw acceleration exceedance from
  about `67.5%` to `46.4%` and changes termination from left exit to capture.
  Preserve that allocation mechanism and its full-quadrant body-frame
  velocity-course observation.
- The prefilled geometric angle guard does not achieve its stated primary
  objective. It first changes the posterior command near `18.188T`, lowers the
  terminal force-norm peak from `0.20756` to `0.17183` and the yaw-moment peak
  from `0.09276` to `0.07699`, but the posterior joint still reaches exactly
  `-45 deg` at `18.210T`. The preceding sample still carries `-1.669 rad/T`
  outward velocity before the hard-limit reset. The guard blends from the
  full outward acceleration ceiling according only to angle proximity, so it
  does not require braking until the remaining margin is already dynamically
  infeasible.

## Policy hypothesis written before the solver edit

Preserve the captured velocity-course controller, zero-centered anterior
oscillator, posterior traveling-wave target, mean-curvature request, and
distance-conditioned acceleration reserve. Replace only the ineffective
geometric posterior guard with a predictive stopping-margin barrier. From
observed posterior angle and outward velocity, compare the remaining angle
margin with the distance required to stop under the existing acceleration
limit. Smoothly transition from the allocated carrier command to required
inward braking before the stopping distance consumes a small protected angle
buffer. Release the barrier as soon as posterior motion turns inward. This is
bounded state feedback and neither raises a physical limit nor introduces a
clock, route, mutable phase, or environment edit.

The expected signature is the same broad approach, alternating wake, and
capture, but with posterior reversal before `45 deg` and without the hard-stop
force/moment impulse. Falsify the mechanism if capture or the sub-`1L` path is
lost, the barrier alters the broad trajectory rather than only the threatened
posterior stroke, limit occupancy rises, the carrier becomes one-sided, or
posterior contact and the terminal load spike remain.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture under a fixed actuator envelope
source_mechanism: preserve a productive rhythmic carrier while bounded state feedback reduces only excess motion in a constrained terminal regime
transferable_invariant: constraint protection should modulate the observed two-joint rhythm only when measured state and remaining authority predict loss of the useful motion, then release when the state response recovers
nontransferable_details: published gains, linkage geometry, species-specific joint ranges, dimensional cadence, clock phase, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the allocated posterior carrier; use posterior joint angle and velocity to compare normalized remaining angle margin with stopping distance under the existing acceleration limit and blend toward bounded inward braking before contact
falsification: reject if capture or alternating 3D shedding is lost, broad approach changes, limit occupancy or one-sided effort increases, or posterior contact and terminal force/moment peaks are not reduced
```
