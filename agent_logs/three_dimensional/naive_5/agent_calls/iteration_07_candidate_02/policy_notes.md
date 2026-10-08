# Terminal intercept guard on the observation-gated redirect

## Visual and trace diagnosis before the edit

- All four sampled rollouts are contract-valid direct-uniform still water:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. Both visual rows therefore show self-propulsion. The top-down
  sheets resolve alternating caudal vorticity, and the oblique sheets confirm
  three-dimensional body motion and Lambda2 wakes rather than frame advection.
- The assigned parent `solver_12fc3441a636` retains an alternating wake but
  bends it upward, reaches only `6.268L`, touches the `45 deg` joint limit, and
  exits the upper margin at `(12.027,15.200)L` after `20.790T`. The inherited
  notes attribute this to routing slow course error through gait-contaminated
  raw yaw closure; its roughly `57%` joint-speed/acceleration-cap residence and
  elevated loads also rule out more carrier drive.
- The sign-corrected long-wake descendant `solver_8b43d67d5abc` remains a
  useful control: it self-propels to `38.484T`, but its coherent wake stays in
  the high corridor and misses by `4.516L`. Moving the same asymmetry to the
  posterior joint in `solver_b6ed3f84ab58` does not add useful spatial
  authority: it turns upward and exits at `(8.770,15.201)L`, with a worse
  `5.386L` closest approach. Another posterior allocation or drive increase is
  therefore unsupported.
- `solver_4365157e5ac8` is the only sampled semantic near-miss. Its
  observation-gated same-sign two-joint redirect visibly bends the top-down
  trajectory down out of the high corridor while the oblique view shows
  controlled self-propulsion, a large redirect, and later carrier recovery.
  It reaches `1.165L` at `27.055T`, versus `4.516L` for the best continuous
  allocator, then overshoots and exits left at `39.253T`. This large routing
  improvement matters more than its lower scalar score.
- The near miss is a terminal momentum/allocation failure, not weak cruise
  propulsion. From about `25--29T`, the redirect settles both joints into a
  nearly static negative bend while speed remains about `0.64--0.70L/T`. At
  closest approach, the head is `(8.184,10.331)L`, distance is `1.165L`, the
  straight-line projected miss is also about `1.16L`, joint rates are only
  about `(-0.07,-0.18) rad/T`, and requested accelerations are approximately
  zero because partial cruise release cancels redirect tracking. The fish
  consequently coasts roughly `0.42L` outside the capture radius before the
  target moves behind it.

## Policy hypothesis

Preserve the evidenced C-start descendant's state-feedback traveling bend,
anterior phase pump, posterior lag, sign-corrected route side, soft headroom,
and observation-gated two-joint redirect. Add one terminal mechanism: while
the target is near, still ahead/closing, and the velocity/target cross product
predicts a miss wider than the capture corridor, continuously override partial
redirect release toward the full existing redirect. This spends no additional
acceleration amplitude; it prevents cruise/redirect cancellation early enough
to deepen the same-sign bend, increase drag, and continue turning during the
last approach. The guard fades to zero for a capture-aligned course and after
closest approach, so it cannot become a hidden timed stage or a permanent
post-pass latch.

On the frozen near-miss observations, the proposed normalized guard begins
near `22.9T`, rises from `0.37` at `2.34L` to `1.0` at `1.40L`, and releases
as measured closing alignment changes sign just before closest approach. This
is a signal audit only, not new CFD evidence. Expected evaluation evidence is
the same coherent far-field carrier and large downward redirect, followed by
a deeper/slower intercept that crosses `0.75L`. Falsify the mechanism if it
returns to an early upper exit, loses the coherent far-field wake, holds a
static bend after the target is receding, fails to beat `1.165L`, or increases
actuator-limit residence despite reusing the existing redirect targets and
acceleration limit.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a propulsive rhythm at long range, then condition redirect release on observed terminal approach geometry and momentum
transferable_invariant: after broad target-directed motion works, use normalized distance, projected miss, and closing alignment to sustain bounded curvature only while the current trajectory would miss the capture corridor
nontransferable_details: species-specific C-start timing and shape, published gains, clocked CPG phase, linkage geometry, dimensional cadence, exact vortex phases, capture route, and world coordinates
policy_translation: compute straight-line miss from body-frame target and velocity vectors, combine it with smooth normalized distance and closing gates, and use that guard only to suppress premature release of the existing two-joint redirect
falsification: reject if the closest approach does not beat 1.165L, the guard latches after closest approach, the far-field carrier or wake collapses, an early boundary exit returns, or actuator-limit residence worsens
