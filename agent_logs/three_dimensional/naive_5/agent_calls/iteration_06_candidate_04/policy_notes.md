# Large-error redirect with carrier release

## Visual and trace diagnosis before the edit

- All four sampled rollouts satisfy the experiment contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Their motion is self-propulsion rather than advection. In every
  combined sheet the top-down row shows an alternating caudal vortex street,
  while the oblique row independently shows a three-dimensional Lambda2 trail.
- The assigned parent, `solver_12fc3441a636`, has the best scalar score but is
  an informative early failure rather than the best target controller. Its
  course-biased raw-yaw loop bends the top-down wake upward and terminates the
  oblique trail at `20.790T`; the trace confirms an upper-margin exit at
  `(12.027,15.200)L`, with monotonically decreasing distance only to `6.268L`.
  It reaches the `45 deg` angle boundary and spends about `57%` of samples at
  either the speed or acceleration cap. Its maximum lateral force and yaw
  moment are also roughly three times those of the long-running samples.
- The three phase-separated samples retain coherent wakes to about `38.5T` and
  avoid the angle boundary. The bearing-only response-gated carrier reaches
  `4.676L`; adding a course request through that residual loop reaches
  `5.016L`. Directly allocating the empirically correct negative anterior
  half-cycle in `solver_8b43d67d5abc` is the useful positive result: it reaches
  `4.516L`, keeps `y=13.722--14.171L`, and crosses the target's x station near
  `y=14.085L`. Its top-down and oblique rows retain the same coherent carrier.
  Yet the target remains about `4.6L` below the path, and roughly `56%` of the
  trace is still near a joint-speed cap while `59%` touches an acceleration
  clamp. More carrier energy or another raw-yaw/course gain change is therefore
  unsupported.
- Reconstructed body-frame geometry explains the remaining failure. From
  `16--28T`, the direct allocator sees mean bearing from about `-0.88` to
  `-1.28 rad` and normalized course error from `+0.71` to `+0.93`, but the
  phase-rejected mean yaw response remains only about `+0.004` of the carrier
  rate. Thus the correct turn side is known and propulsion is stable, but a
  continuously beating half-cycle bias does not produce the large redirect
  needed before longitudinal overshoot.

## Policy hypothesis

Preserve the sampled `0.90T/18 deg` state-feedback carrier, explicit symmetric
phase pump, lagged posterior follower, anterior actuator placement, soft angle
headroom, and empirically calibrated route sign. Add one new control mode from
the shelf: a continuous, observation-gated C-start-like redirect. When
body-frame bearing is large, blend from the propulsive wave toward a bounded
same-sign two-joint curvature target. As the heading rotates and bearing
returns toward a centerline band, release continuously back into the traveling
wave; no time, hidden stage, or fixed route is used. Retain the smaller
sign-corrected half-cycle allocation outside the redirect so measured course
error continues to correct the long translation.

The expected signature is a finite downward-heading excursion after the target
falls far off-axis, followed by recovery of the coherent alternating wake and
crossing of `x=9L` below the sampled `14.085L` corridor. Falsify the mechanism
if it recreates the near-`21T` upper exit, holds a static bend instead of
releasing, loses leftward propulsion, fails to beat the `4.516L` closest
approach, or increases angle/speed/acceleration residence beyond the sampled
direct allocator.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: large observed heading error evokes bounded curvature, then observed alignment releases the body into a propulsive posterior beat
transferable_invariant: separate a large-error redirect from the cruise rhythm and gate both entry and release by current target-relative body-frame geometry
nontransferable_details: species-specific C-start shape and timing, published gains, clocked CPG phase, robot linkage geometry, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: infer gait phase from normalized joint state, infer redirect side and release from bounded body-frame bearing, blend toward same-sign two-joint curvature only at large error, and recover the sampled posterior-lag carrier continuously near alignment
falsification: reject if the redirect does not lower the target-station crossing, latches into a static bend, destroys the coherent wake or leftward progress, repeats an early boundary exit, or worsens actuator-limit residence
