# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release after four staggered cylinder streets have developed and merged
  around the target. It is a common initial condition, not evidence for a
  fixed vortex phase or route.
- Every raw sampled and inherited rollout available here is a finite
  `target_reached` result; no failed keyframe sheet is present. The strongest
  sampled sheet (`solver_7d55244a5bdc`) and the latest distinct inherited sheet
  (`solver_b419afd08bcf`) are visually nearly identical: a coherent
  zero-centered traveling wake accompanies active diagonal upstream/downward
  swimming, then one broad correction carries the fish through the interacting
  wakes into the capture circle. Active propulsion is confirmed by mean body
  velocity x `-0.242` versus mean local-flow x `-0.177` in the strongest
  rollout. The inherited propulsive-priority collision is retained only as a
  nonvisual boundary: broad propulsion reallocation passed below capture and
  collided at `58.93` after a `1.872L` closest approach with `537/4995`
  force/moment RMS.
- Three functionally identical prefill samples repeat arrival `45.260`, mean
  distance `1.71529L`, score `0.165009`, and `439/4342` force/moment RMS. The
  distance/body-speed terminal heading-horizon cap changes those values to
  `45.221`, `1.71458L`, `0.165860`, and `439/4345`; replacing total body speed
  with positive range closure changes them to `45.243`, `1.71537L`, `0.164890`,
  and `439/4343`. These are small continuous refinements with the same visible
  topology and no load separation, so another denominator or scalar edit is
  not supported.
- The useful trajectory still has a large late lateral correction, maximum
  lateral target offset `4.30L`, RMS relative crossflow `0.289`, and both joint
  rates at their `4.538` cap. The current heading-response predictor accounts
  for body yaw but not explicitly for the part of line-of-sight motion caused
  by lateral translation through the wake. Sign-resolved moment or crossflow
  histories are unavailable, so this candidate does not add a signed force,
  moment, or flow residual.

## Policy hypothesis

Start from the strongest sampled distance/body-speed horizon cap and preserve
its traveling bend, posterior lag, yaw-gated half-cycle steering,
positive-closure posterior residual, course/headroom allocator, and smooth
limiter. Add one bounded translational line-of-sight response to the predicted
body-frame bearing. Because target bearing rate contains both body yaw and
translation, `bearing_window_rate + heading_rate` cancels the yaw contribution
and estimates only the observed translational line-of-sight drift. A worsening
translational drift then retains more steering; a helpful drift releases some
steering. The residual is disabled until the observation window has nonzero
duration, uses the same state-estimated response horizon, and is capped below
the existing heading-response limit.

The rollout falsifies this mechanism if target capture or the diagonal
traveling-wake topology is lost, arrival is later than the `45.260` prefill,
mean distance worsens beyond `1.7153L` without a material load reduction, or
the prior below-target collision topology returns. A positive result on the
fixed prewarm snapshot would still not demonstrate robustness to changed wake
phase, inflow, geometry, target, or capture radius.

bookshelf_consulted: true
source_domain: wake-interaction studies and closed-loop robotic-fish path following
source_mechanism: separate slow target-route control from bounded response to wake-driven lateral motion while preserving the propulsive rhythm
transferable_invariant: use observed target-relative motion to correct only the part of predicted route error not already explained by body yaw
nontransferable_details: published gains, species-specific kinematics, dimensional response times, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: decompose windowed body-frame bearing rate into yaw and translational line-of-sight components, then add a small capped translational prediction to the existing two-joint heading-response steering law
falsification: reject if capture or upstream diagonal topology is lost, arrival or mean distance regresses without a material load benefit, or saturation and hydrodynamic loads rise without a shorter useful route
