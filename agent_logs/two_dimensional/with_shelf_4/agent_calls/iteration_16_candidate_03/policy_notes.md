# Multi-wake target-policy candidate

## Visual diagnosis and rollout evidence

- The shared prewarm sheet fixes the fish in the upper-right while four
  developed staggered-cylinder streets merge around the downstream target.
  This is common initial-condition evidence, not a candidate-specific wake
  phase or a transferable route.
- All four local sampled rollouts are finite target captures; no sampled
  collision, domain exit, instability, or horizon-miss sheet is available.
  The two `137.357`-unit examples are exact physical replications of the
  progress-qualified scaffold. Their sheets show self-propelled upstream
  translation, an alternating posterior-lagged bend, a broad initial redirect,
  several midcourse folds, and capture from the right. Metrics corroborate the
  visual behavior: `-10.914L` upstream displacement versus `-0.0542` mean local
  streamwise flow, `4.18356L` mean distance, `90228` command energy, and
  `0.12955/14.75/303.02` RMS crossflow/force/moment.
- The assigned parent adds closing-qualified body-course alignment. Its sheet
  retains active propulsion and capture and makes the midcourse path visibly
  smoother. Relative to the replicated scaffold, mean distance improves by
  `0.10690L` (`2.56%`) and arrival improves only `0.110` time units, while
  command energy rises `1.30%` and RMS crossflow/force/moment rise
  `3.11%/1.08%/1.15%`. Maximum anterior acceleration also rises from `30.846`
  to `30.926 rad/time^2` against the `31.416` cap. Thus measured course error
  contains useful route information, but adding it as steering authority is
  not a joint distance-and-load improvement.
- The fastest sampled policy filters both computed accelerations through the
  previous applied action. It reaches in `130.729` units with `3.75391L` mean
  distance, but its keyframes contain sharper yaw reversals and the diagnostics
  falsify the stated effort-trimming hypothesis: energy rises to `115750`, RMS
  crossflow/force/moment to `0.15435/18.30/359.97`, anterior acceleration hits
  the hard cap, and posterior acceleration reaches `30.851`. Do not stack that
  actuator filter onto the parent merely because its scalar score is higher.
- Inherited logs reinforce the boundary. Gating direct moment or route loops,
  moving route modulation posteriorly, and adding unconditioned flow residuals
  all delay capture or lose it. Smoothly composing route and moment inside one
  saturation also delayed capture to `223.746` with `6.429L` mean distance and
  `144686` energy. The next test must preserve the direct bearing and moment
  loops rather than deactivate or recombine them.

## Policy hypothesis

Make one topology change to the assigned parent. Preserve its instantaneous
body-frame bearing drive, progress-qualified bearing-rate damping, direct
normalized moment residual, state-inferred half-cycle steering, regulated
oscillator, and posterior traveling bend. Recast only the auxiliary
bearing-minus-velocity course term as response damping: admit it when its sign
opposes the persistent route drive, and limit it to one half of that drive so
it cannot reverse the route command. Discard the auxiliary term when it would
increase the requested turn. Positive closing speed still qualifies this
course observation, but direct route authority never falls below half and the
course term can no longer add curvature or actuator demand.

The expectation is retained target capture, upstream translation, and the
alternating traveling bend, with the parent's smoother/lower-distance corridor
and effort/load closer to or below the replicated scaffold. Falsify the
mechanism if capture is lost or delayed beyond `137.357`, the broad folds
return without an effort/load benefit, mean distance regresses to or above
`4.18356L`, direct route ownership is visibly lost, or energy, crossflow,
force, moment, or acceleration-cap contact fail to improve together. The new
CFD result is unavailable until after this worker exits and is not claimed as
evidence here.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and residual control in adaptive wake swimming
source_mechanism: preserve the low-dimensional propulsive rhythm and persistent direction command while admitting measured translational response only through bounded residual authority
transferable_invariant: body-frame target bearing should own the route, while course response may damp an overshooting route command but should not add curvature or replace persistent target feedback
nontransferable_details: published gains, robot servo constants and linkage geometry, dimensional beat settings, species-specific kinematics, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: preserve the two-joint state-feedback half-cycle traveling bend and direct moment residual, but project the closing-qualified bearing-minus-course term onto the sign opposing the route drive and cap it at half that drive
falsification: reject if capture, upstream translation, or the alternating wave is lost, or if arrival, mean distance, effort, crossflow, force, moment, or actuator-cap contact do not jointly improve against the parent and replicated scaffold
