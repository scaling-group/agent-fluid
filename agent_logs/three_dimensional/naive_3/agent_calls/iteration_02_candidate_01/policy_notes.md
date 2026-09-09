# Wake-policy candidate notes

## Evidence diagnosis before editing

- The assigned parent guidance identifies the common seed's useful alternating
  traveling bend and its missing target-aware curvature.  All four sampled
  examples satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm), and both the top-down
  vorticity and oblique Lambda2 rows were inspected for each.
- The seed is self-propelled and develops a coherent three-dimensional wake,
  but curls toward the upper boundary: it exits at `8.602T`, improves
  `12.3277L` only to `12.0701L`, and ends at `12.3677L`.  This is route
  loss, not passive advection or a moving-window artifact.
- The strongest sibling preserves the `0.55T`, 28-degree carrier and centers
  the anterior oscillator fully on a bounded 7-degree mean-curvature request.
  It materially changes the trajectory: minimum distance is `4.0671L`,
  survival is `24.893T`, and the top-down/oblique sheets retain a strong
  alternating wake.  It is nevertheless finite: at closest approach its
  reconstructed body-frame bearing is about `1.02 rad`, velocity remains
  approximately `(-0.54,-0.69) L/T`, and it continues below the target to a
  bottom-boundary exit at final distance `9.1287L`.
- Two sampled siblings with only `0.25--0.30` anterior curvature share reach
  no closer than `12.29--12.31L` and exit near `9.7T`, even though one
  permits 14 degrees of total mean curvature.  The inherited worker-2 log
  reports the same failure for a 0.25-share variant.  The prefilled full-share
  controller also fails (`12.3238L` minimum, `15.3800L` final) after
  simultaneously slowing and shrinking the carrier and adding several
  feedback terms.  Therefore posterior-heavy or broad multi-term steering is
  not supported; full anterior centering on the proven carrier is the reusable
  part of the successful result.
- The strong sibling's target law subtracts measured heading rate even though
  its observed sign convention is positive curvature -> negative yaw.  Its
  bearing changes sign while the heading swings between turns, so a measured
  negative yaw response should *reduce* a positive bearing request by addition,
  not amplify it by subtraction.  Joint rates also reach the `260 deg/T`
  envelope and raw accelerations exceed the episode limit, so the new policy
  will explicitly retain acceleration reserve rather than seek improvement by
  stronger carrier gains.

## Candidate hypothesis

Use one compact response-gated redirect mechanism around the only evidenced
successful scaffold.  Preserve the strong sibling's state-feedback carrier,
full anterior equilibrium shift, and posterior lag.  At small body-frame
bearing, retain approximately its validated 7-degree curvature authority.  As
absolute bearing grows, continuously raise authority toward a bounded redirect
limit; add correctly signed normalized heading-rate feedback so observed yaw
toward the target releases the request.  This is a geometry/response gate, not
elapsed-time staging.  Clamp final acceleration just below the episode hard
limit.

Expected evidence is the same early coherent wake and left/down progress as the
strong sibling, followed by lower absolute bearing and a turn toward the target
before the `4.0671L` closest-approach point.  Falsify the transfer if initial
propulsion weakens, the path still carries monotonically through the bottom
boundary, high-bearing redirect fails to change yaw sign, joint-limit residence
or loads worsen, or minimum distance does not improve on `4.0671L`.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: large observed direction error raises bounded mean bend, then measured heading response releases back into the propulsive rhythm
transferable_invariant: preserve the state-feedback traveling bend while body-frame target error and observed yaw response continuously gate redirect curvature
nontransferable_details: biological C-start timing, published gains, dimensional beat settings, species kinematics, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: use absolute normalized bearing to interpolate between cruise and redirect curvature limits, combine signed bearing with normalized yaw response, and shift the two joint-state targets without time or world coordinates
falsification: reject if the coherent wake or early target progress collapses, yaw does not release with falling bearing, the same bottom exit persists, closest approach is not below 4.0671L, or saturation and load histories worsen
