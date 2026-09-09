# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled evaluations report direct uniform quiescent initialization
  (`U_infinity=(0,0,0)`), no capture, stable dynamics, and `left_domain`
  termination. Thus the visible motion is self-propulsion rather than imposed
  advection.
- The top-down and oblique rows of the combined sheets show a coherent,
  alternating reverse-street-like wake and continued three-dimensional
  Lambda2 structures. The `solver_5c5f9d80447b` phase-compensated bearing
  servo is the best scalar sample (`-10.0272`) and travels more gently across
  the field, but never comes closer than `3.0031L`. It is not the terminal
  mechanism to preserve.
- The closest sampled trajectory, `solver_213717a6b100`, blends the inherited
  course servo into posterior mean curvature. It reaches `1.5454L`, then the
  keyframes show a sharp downward turn and the trace ends through the lower
  boundary. The prefilled energy-guarded half-cycle policy
  (`solver_9ddd873113a3`) has the same strong-turn/lower-exit topology and is
  worse at `1.7708L`. Both are worse than the assigned parent's inherited
  direct course-servo near-miss at `1.0435L`.
- The carrier remains forceful but is envelope-limited: at least one returned
  joint acceleration is at `1800 deg/T^2` on about `91--97%` of sampled trace
  rows. Therefore another larger scalar route or steering gain is not a
  credible new mechanism. Near `2L`, the sampled curvature and guarded
  half-cycle traces already have a large signed turn response while the route
  command is saturated; steering realization needs anticipatory release, not
  more terminal carrier suppression.

## Policy hypothesis

Restore the inherited direct shared-acceleration course servo as the steering
baseline and leave both accelerations of its traveling-bend carrier intact.
Inside a normalized terminal distance gate only, estimate the slow yaw response
by compensating measured heading rate with observed joint velocities. When
that response is already in the direction requested by the course servo, use a
smooth one-sided gate to release shared steering toward zero; never reverse it
and never attenuate the carrier. This tests whether earlier steering release
can convert the `1.0435L` lower-side near-miss into capture without repeating
the weak global yaw-rate cascade or the two carrier-modifying failures.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish CPG direction tracking
source_mechanism: strong bounded redirect followed by response-triggered release into the propulsive posterior beat
transferable_invariant: steering authority should decay when observed signed turning response is already established, while the traveling propulsion wave continues
nontransferable_details: species-specific C-start shapes, published CPG gains, dimensional timing, exact beat or vortex phase, and task-specific routes
policy_translation: use normalized body-frame target-versus-course error for the request; near the target, smoothly release only its shared-acceleration steering component using joint-state-compensated signed yaw response, leaving the two-joint carrier unchanged
falsification: reject if it loses early closure or wake coherence, fails to beat the inherited `1.0435L` near-miss or termination class, increases saturation, or retains the same lower-exit topology without an earlier steering release
