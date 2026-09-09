# Wake-policy candidate diagnosis

## Evidence read before editing

- The assigned parent is the response-gated yaw-brake controller evaluated as
  `solver_cd1c5b66daaa`. All four sampled rollouts use direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm snapshot. All are finite `left_domain` trajectories; none is a
  numerical instability or an ambient-advection result.
- Both visual rows show that the `0.55T`, `28 deg` joint-state oscillator and
  posterior lag remain a useful propulsive carrier. The long runs shed a
  coherent alternating mid-plane street and compact three-dimensional
  Lambda2 structures through their turns. Local-flow components are only
  about `0.02U`, including near the closest approaches, so another wake-flow
  rejection term is not supported in this quiescent sample.
- The inherited yaw brake is a genuine improvement over its course-residual
  parent: closest approach improves from `6.067L` to `5.323L`, final distance
  from `10.494L` to `9.223L`, and the later heading is reduced. It still acts
  too late to arrest downward course: the fish passes below the target, then
  crosses the lower boundary near `26T`. Its raw drive remains hidden-clipped,
  with joint acceleration beyond `1800 deg/T^2` on roughly `70%` and `75%` of
  logged steps.
- The phase-compensated bearing-to-turn-rate controller
  `solver_5c5f9d80447b` changes the failure topology and keeps both returned
  accelerations inside the envelope. It reaches `3.003L`, but a body-axis
  bearing servo holds the trajectory near `y=13L`; it passes above the target
  and exits left. This supports response-aware posterior mean curvature, but
  not body-axis bearing alone as the outer route error.
- The achieved-course servo `solver_1f40fb567c74` supplies the strongest route
  signal. It moves from `(21,14)L` to within `1.0435L` at `18.85T` while the
  coherent wake persists, then overshoots below and leaves the lower boundary.
  Its direct shared-acceleration steering is not reusable unchanged: raw
  accelerations exceed the envelope on about `70%` of steps for both joints,
  and both joint rates reach the hard limit on about `8%` of steps. The near
  miss therefore supports achieved-course feedback, not its saturated
  actuator realization.
- Inherited optimizer notes predicted both pieces of this comparison: the
  unchanged lower-exit topology falsified scalar-only course-gain escalation,
  while the phase-compensated loop was intended to release mean curvature in
  response to achieved yaw. The sampled results now show that the inner loop
  changes topology, while target-versus-velocity course is the outer signal
  that gets closest.

## One candidate mechanism

Preserve the evidenced propulsive carrier and combine the two independently
useful feedback roles in one cascade. A speed-gated, normalized body-frame
target-versus-velocity course error requests a bounded target yaw rate. The
existing joint-velocity compensation removes beat-phase yaw from measured
heading rate; the yaw-rate residual then drives only bounded posterior mean
curvature. This translates the achieved-course route improvement without
copying its persistently clipped shared-acceleration actuator, and replaces
the phase-compensated sample's insufficient bearing-only outer loop.

Expected test: the initial redirect should remain clockwise, but course error
should keep the fish descending toward the target instead of following the
`y≈13L` left-exit route. The inner response loop should release or reverse the
tail mean before the closest sampled course servo overshoots below the target.
The alternating wake should remain coherent and returned accelerations should
stay within the owned physical bound.

Falsification: reject the cascade if it loses early leftward translation,
collapses the alternating wake, develops sustained joint angle/rate clipping,
returns to either the phase-compensated upper/left route or the inherited
lower-boundary sweep, or fails to improve the `1.0435L` near miss without a
better termination class. If course geometry is correct but response remains
too slow, later work should test a bounded half-cycle actuator rather than
increase the course gain or restore direct clipped acceleration steering.

## Non-CFD signal replay

Replaying the new outer signal on the phase-compensated trace distinguishes
the needed course correction from its old body-axis request: near `4T`, target
angle is about `-0.14 rad` but achieved course is `-0.79 rad`, so the cascade
requests about `-0.18 rad/T` yaw instead of reversing solely because bearing
crossed zero; by `6T`, the route residual changes sign and requests braking.
On the near-miss trace at `18T`, the target-versus-course residual is at its
bounded positive limit and the inner loop requests negative posterior mean
curvature, the evidenced sign for clockwise redirection toward the target.
The replay also confirms reflection symmetry when target, velocity, joint
state, and yaw are mirrored. This is a signal/sign audit only, not CFD
evidence of capture or actuator loads.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and bounded fish turning
source_mechanism: achieved-course direction feedback cascaded through response-released mean-curvature steering around a propulsive rhythm
transferable_invariant: preserve the traveling posterior-lag bend while target-versus-achieved-course error requests yaw and measured route yaw releases or reverses the mean bend
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact vortex phase, CPG clocks, and task-specific routes
policy_translation: form target and velocity angles from normalized body-frame observations, speed-gate their error into a bounded desired yaw rate, compensate observed joint-phase yaw, and map only the residual to bounded posterior mean curvature
falsification: reject if the coherent wake or early closure degrades, actuation becomes persistently saturated, the route repeats either sampled exit topology, or the controller does not improve the 1.0435L near miss or termination class
