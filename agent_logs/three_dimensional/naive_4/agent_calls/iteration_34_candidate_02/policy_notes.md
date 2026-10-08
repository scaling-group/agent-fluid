# Wake-policy candidate notes

## Evidence diagnosis before edit

- The assigned `solver_144c414f516d` rollout and the best finite sampled
  `solver_2acfcfa19ef8` rollout both use direct uniform still-water
  initialization (`U_infinity=[0,0,0]`), contain no cylinders or prewarm, and
  capture the target with a coherent self-propelled traveling bend. In both
  combined sheets, the top-down row develops a regular alternating red/blue
  wake by `4T` and carries it through capture; the oblique Lambda2 row shows
  compact alternating three-dimensional structures without a growing
  out-of-plane instability. Lateral body motion is rhythmic and productive,
  and neither rollout is passively advected.
- The visible routes are close, but the moment-residual sample makes a real
  route-scale improvement rather than only changing the last crossing: it
  captures at `15.735508T` with 231 shifts, distance integral `1.919818350L`,
  and final distance `0.744372L`, versus `15.768509T`, 232 shifts,
  `1.924067164L`, and `0.745720L` for the assigned rollout. The other two
  sampled policies reproduce the assigned result exactly. The inherited
  assigned-parent log also reports a finite capture (`-0.044582`, final
  `0.746834L`) but has no multimodal diagnostics, so it supports neither a
  new visual mechanism nor a scalar-only retune.
- Trace reconstruction over the established cruise (`elapsed >= 2T`, distance
  above `1.75L`) shows that normalized anterior joint position and velocity
  explain `95.26%` of body-lateral force variance in the assigned rollout and
  `95.34%` in the moment-residual rollout. The fitted coefficients are stable
  (`0.02748/0.00578` and `0.02766/0.00562`), while the residual RMS is only
  `0.00377/0.00374`. This supplies an observation scale and separates the
  carrier load from non-carrier lateral response.

## Policy hypothesis

Use the better sampled moment-residual controller as the carrier. Add a single
compatible response channel: subtract the joint-phase prediction from
normalized body-lateral force, and add at most `1.5 deg` of posterior mean
curvature only when that residual force opposes an already reliable
target-directed redirect. Fade the correction through the established
approach so it cannot rewrite the separately evidenced terminal handoff,
line-of-sight damping, propulsion allocator, or anterior settling law.

This is not a force-gain retune: it changes feasible action support using a
new normalized state observation. The expected result is earlier recovery
from target-opposing lateral acceleration, improving route milestones and
distance integral while retaining the coherent two-view wake. Reject the
mechanism if it changes only terminal samples, delays capture, raises limiting
or lateral load without route benefit, disrupts wake coherence, or aliases
the beat despite carrier subtraction.

A post-edit counterfactual evaluation on the recorded best trace confirms
measurable pre-approach support: the new channel contributes mean absolute
curvature `0.170 deg`, peaks at `1.404 deg`, and exceeds `0.1 deg` on `22.5%`
of samples before the `1.75L` boundary. This does not predict the closed-loop
CFD result, but it rules out an inert, clamp-equivalent, or terminal-only edit.

bookshelf_consulted: true
source_domain: wake interaction and adaptive swimming
source_mechanism: separate slow target-directed steering from fast load response rather than cancelling all lateral motion
transferable_invariant: remove repeatable locomotor-carrier content before applying a small bounded correction to target-opposing response
nontransferable_details: Karman-vortex phase, cylinder geometry, species kinematics, published gains, and wake-specific routes
policy_translation: predict normalized body-lateral force from normalized anterior joint state, gate its residual by body-frame redirect direction and response reliability, and apply bounded posterior mean curvature through the two-joint contract
falsification: reject if capture, route milestones, distance integral, coherent wake, or load and actuator envelopes regress, or if the residual merely reproduces carrier-phase switching
