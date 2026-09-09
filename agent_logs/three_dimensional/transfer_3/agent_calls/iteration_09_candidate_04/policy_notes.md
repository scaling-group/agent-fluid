# Line-of-sight-response two-joint allocation candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts and the inherited step-8 redirect report direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their translation is self-propulsion. Both rows
  of the combined sheets show alternating top-down streets and compact
  oblique Lambda2 structures in the longer runs, so route control—not
  advection, wake collapse, or numerical instability—is the limiting failure.
- The assigned parent evidence supplies a useful semantic improvement. The
  line-of-sight-rate release crosses the target x station at `y=12.994L` and
  reaches `3.369L`, versus `y=13.718L` and `4.158L` for raw slip, while
  retaining a coherent wake through `30.12T`. It still leaves left with the
  target about `3.5L` off the route at crossing. The route signal therefore
  improves the trajectory but does not give the posterior-only actuator
  enough effective yaw authority.
- The sampled full projected-course release is the opposite failure: it curls
  upward and exits at `11.30T`, reaching only `8.507L`. Inherited
  response-damped half-cycle steering is more severe, exiting at `8.70T`
  after reaching only `12.072L`. These results reject another instantaneous
  course branch or half-cycle gain tune as the next change.
- The completed inherited same-sign C-bend test also falsifies a delayed
  abeam/behind burst. It activates only after the useful steering window,
  crosses `x=9L` at `y=14.072L`, reaches `4.467L`, and exits left at
  `28.31T` with final distance `10.299L`. Its combined sheet retains a wake,
  so the degradation is actuator timing/polarity rather than lost propulsion.
- Applied acceleration is already clipped often: the line-of-sight rollout
  is at the envelope in `57.7%` of anterior and `74.0%` of posterior samples;
  the inherited C-bend is similar (`57.8%` and `73.3%`). Increasing the same
  posterior curvature limit would mostly increase hidden clipping, not test a
  new control hypothesis.

## Policy hypothesis recorded before editing

Preserve the assigned parent's normalized bearing plus inertial
line-of-sight-rate response and its phase-conditioned yaw residual. Change
only where the resulting bounded mean-bend command is expressed: continuously
allocate a small share to the anterior oscillator center with the opposite
joint-coordinate sign, and reduce the posterior share by the same amount.
The opposite signs are deliberate actuator polarity, not a fixed route:
sampled policies map positive posterior mean curvature to positive yaw, while
the inherited body calibration reports that positive anterior/common bend
produces negative yaw. Thus `(-share, 1-share)` makes both joint contributions
support the same observed yaw request and is distinct from the failed
same-sign C-bend. The zero-command carrier remains exactly the assigned
traveling bend, and the response loop can reverse both shares without a clock,
stage counter, or memorized coordinate.

Expected evidence is the assigned parent's coherent wake and early minus-x
progress, but with target-line crossing below `12.994L`, closest approach below
`3.369L`, or a better termination class. Reject this allocation if it produces
either inherited short upper exit, weakens the long alternating wake, raises
joint/acceleration saturation materially, or repeats the more-than-`3L` high
left pass. That would show that continuous two-joint mean-bend authority is not
the missing mechanism and favor a genuinely beat-scale route estimator or a
different propulsive carrier.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking with mean-curvature steering
source_mechanism: preserve a rhythmic propulsive carrier while a bounded sensory route residual distributes steering across available bending joints
transferable_invariant: use observed route response to reverse a small continuous whole-body steering asymmetry, with joint-coordinate polarities chosen so both actuators support the same yaw request
nontransferable_details: published gains, robot linkage geometry, dimensional frequencies, clock-driven phases, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame bearing and rotation-invariant line-of-sight rate, then allocate their phase-conditioned bounded mean-bend residual as opposite-sign anterior and posterior centers in the two-joint state-feedback carrier
falsification: reject if the short upper-exit topology returns, wake coherence or propulsion degrades, saturation grows materially, or target crossing and the `3.369L` minimum do not improve

## Dry validation after the edit

- The required guidance, Julia contract, parameter-schema, and solver-boundary
  checks pass, as does reflection equivariance. With zero route/yaw residual,
  the candidate matches the assigned carrier to floating-point precision.
- Algebraic replay on the assigned parent's recorded states is not new CFD and
  does not predict the changed trajectory. It bounds the intended edit: the
  allocated centers stay within `3 deg` anterior and `7 deg` posterior;
  anterior raw-envelope occupancy is essentially unchanged (`57.7%` to
  `57.6%`), while posterior mean absolute raw command falls from `59.47` to
  `55.58 rad/T^2` with similar occupancy (`73.8%` to `74.5%`). The later CFD
  evaluation must decide the route and wake falsification criteria above.
