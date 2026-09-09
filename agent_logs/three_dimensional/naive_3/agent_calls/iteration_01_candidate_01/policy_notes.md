# Candidate wake-policy notes

## Evidence diagnosis before editing

- The only sampled rollout is the common naive seed (`solver_35fea652543a`),
  evaluated from direct uniform still water (`U_infinity=(0,0,0)`) with no
  prewarm and no cylinders. It is a physically self-propelled failure rather
  than an advection artifact: both visual rows show body motion and a growing
  three-dimensional, alternating shed wake.
- The top-down row shows a coherent propulsive wake from 2--6 T, followed by a
  tightening clockwise trajectory and a strongly curved wake by 8 T. The
  oblique Lambda2 row confirms compact three-dimensional structures shed from
  the posterior body and caudal fin; it does not show an imposed-flow event
  that could explain the route loss.
- Scalar and trajectory evidence agree with the visual diagnosis. Distance
  improves only from 12.328 L to 12.070 L, then ends at 12.368 L with
  `left_domain` at 8.602 T. Body-frame bearing crosses zero at 3.174 T, but the
  unguided fish keeps rotating clockwise to a minimum heading of -1.186 rad.
  At the best finite stage (6.358 T), bearing is already -0.770 rad; the later
  failure frame shows that the controller never releases or reverses that
  turn. Both joints reach the 260 deg/T velocity envelope, so stronger
  propulsion alone is not a supported remedy.
- No inherited optimizer notes are present in this fresh workspace. The
  assigned parent guidance identifies missing target sensing as deliberate;
  the sampled rollout provides the concrete failure topology needed to add it.

## Policy hypothesis

Preserve the seed's state-feedback oscillator and posterior phase lag because
they already form a coherent self-generated wake. Add one bounded
target-vector-to-mean-curvature mechanism: body-frame bearing requests signed
curvature, while normalized measured heading rate reduces curvature that is
already producing an excessive turn. Distribute the requested mean bend over
both joints, with posterior emphasis, without explicit time, world coordinates,
or a memorized route. This should keep early thrust, reverse the curvature
request shortly after the target crosses the body centerline, avoid the
upper-boundary arc, and turn minimum-distance progress into sustained approach.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG direction tracking and fish tail-beat mean-curvature turning
source_mechanism: modulate a propulsive rhythm with a bounded signed mean bend, then release it when measured yaw response catches the target error
transferable_invariant: preserve the traveling propulsive bend while slow body-frame target error commands mean curvature and observed turn response damps overshoot
nontransferable_details: published gains, clocked CPG phase, species-specific joint envelopes, exact tail-beat shapes, dimensional frequencies, and task-specific routes
policy_translation: form a bounded command from normalized body-frame bearing plus heading-rate feedback; shift the anterior oscillator center modestly and the posterior lag target more strongly under the two-joint acceleration contract
falsification: reject if the rollout still crosses bearing zero and continues the same clockwise boundary-exit arc, if target progress does not persist beyond 6.36 T, or if steering destroys the coherent wake, increases joint saturation, or causes instability
