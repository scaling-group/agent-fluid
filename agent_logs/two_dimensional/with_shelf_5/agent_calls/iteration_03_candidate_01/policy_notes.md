# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The shared prewarm sheet shows the four developed, interacting vortex streets
already reaching the held fish, so the released trajectories are compared from
the same wake initial condition. The naive seed is the informative failure: it
curls from the upper-right release pose into a nearly vertical descent, leaves
the lower domain after `50.127`, displaces `(-3.545,-13.300)L`, and never gets
closer than `8.615L`. Its mean velocity differs little from local advection and
both joints hit the rate and acceleration caps. The inherited notes correctly
identify missing target-directed steering rather than missing scalar drive.

The body-frame bearing-to-mean-curvature controller in sampled solvers
`solver_0e81665db579` and `solver_f2c0f439f630` is the strong finite baseline.
Their released sheets show the same sustained diagonal traverse into the
interacting wake and the target, not the seed's downward exit. Both reach the
`0.75L` boundary after `93.032`, with mean/final distance `4.033/0.749L`,
progress `0.940`, and displacement `(-10.915,-4.204)L`. This establishes the
`8 deg` bounded target-bearing bias plus posterior-lagged carrier as the useful
mechanism to preserve. The sheets also show an initially broad arc followed by
a pronounced mid/late redirect, while the diagnostics report both joint-rate
and acceleration caps, RMS force/moment `95.50/1146.61`, and mean command
energy `972.515`.

The assigned parent's distance-conditioned amplitude relief does not deliver
its predicted terminal load or effort effect. Relative to the unscheduled
successful controller, `solver_43a9991337b7` has the same `93.032` arrival,
the same joint angle/rate/acceleration maxima, visually indistinguishable
keyframes, and only `0.00075L` lower mean distance. Mean command energy changes
by less than `0.001`, while RMS force and moment rise slightly to
`95.55/1147.03`. The current envelope therefore preserves success but is
falsified as meaningful drive relief at this capture boundary. Inherited
failures also rule out replacing the carrier with a globally slower/narrower
one, increasing static curvature to `12 deg`, or adding uncalibrated raw-yaw
damping; each changes the successful topology to an early exit or instability.

## Policy hypothesis

Return to the demonstrated successful carrier and replace the ineffective
range envelope with one feedback mechanism: a bounded line-of-sight lead term.
Add a small, smoothly saturated correction from normalized body-frame
`state.bearing_window_rate` to the current bearing before the existing
mean-curvature map. A target bearing that is worsening reinforces the turn;
one already closing releases it early. At zero trend the candidate is exactly
the sampled successful formula, and the oscillator frequency, amplitude,
posterior lag, damping, and curvature limits remain unchanged.

This should reduce the delayed broad arc and later corrective curl without
asking fast wake crossflow, force, or yaw signals to define the route. It is
falsified if target capture or upstream propulsion is lost, if the route and
arrival remain materially unchanged, if bearing-trend noise creates switching
or a new exit, or if force/moment and cap contact grow without better distance
closure.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and fish turning by sensor-modulated mean curvature
source_mechanism: bounded lead correction of a propulsive rhythm from the recent direction-error trend
transferable_invariant: the sign of recent body-frame target-bearing change distinguishes a worsening turn from one already correcting, so mean curvature can be reinforced or released without replacing the traveling bend
nontransferable_details: published gains, dimensional sensor rates, robot or species kinematics, clocked CPG phase, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: smoothly bound `state.bearing_window_rate` into a small angular lead, add it to current body-frame bearing, and pass the result through the proven bounded mean-curvature map while leaving the two-joint carrier unchanged
falsification: reject if capture, distance closure, or propulsion degrades; if rate noise causes switching or instability; or if the same route and saturation persist without a semantic or load benefit
