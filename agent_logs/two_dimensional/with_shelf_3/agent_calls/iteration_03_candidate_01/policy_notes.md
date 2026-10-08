# Multi-Wake Target-Policy Candidate Notes

## Evidence read before the policy edit

- The assigned parent says to preserve the naive seed's traveling-bend scaffold
  while adding target-aware curvature. Its inherited step-1 notes show why: the
  target-blind seed moved `(-3.545,-13.300)L`, only approached to `8.615L`, and
  left the lower domain after `50.127` released time units despite active
  undulation. A later weak-gait variant (`0.9` period, `20 deg` amplitude) was
  instead advected `(+2.185,-0.917)L` and left the downstream boundary after
  `16.984`, so freeing actuator headroom by weakening propulsion is contradicted.
- The common prewarm sheet shows the fish held above four fully developed,
  interacting vortex streets. This is shared initial-condition evidence. The
  best released sheet shows an early targetward rotation, a sustained posterior
  traveling bend, and then a compact diagonal crossing to the target rather
  than passive advection or a boundary exit.
- The successful total-curvature-split policy reaches the `0.75L` target in
  `39.737` released time units with `0.940` progress and `1.934L` mean distance.
  It does so through `0.227U` RMS relative crossflow and `761.948` RMS moment,
  but both joint velocities reach `4.538 rad/time` (the `260 deg/time` limit)
  and both acceleration commands reach `31.416 rad/time^2` (the
  `1800 deg/time^2` limit). The visible trajectory is useful, but the sharp
  initial turn and saturated actuation leave room to reject fast error growth
  without changing the evidenced gait scalars.
- All four sampled solver results have byte-identical released keyframes and
  identical physical metrics except wall time. Three policy-file hashes differ
  only in comments; their executable parameter values and equations are the
  same. They are duplicate evaluations of one mechanism, not independent
  evidence for further scalar tuning.
- The informative failed bearing controller had low joint excursions
  (`0.249/0.191 rad`) and mean command energy `187.659`, was carried
  `(+2.195,-1.302)L`, never came closer than `12.424L`, and exited after
  `18.683`. Low loads alone therefore do not justify reducing the successful
  traveling wave or steering authority.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and wake-adaptive swimming with short observation histories
source_mechanism: sensor feedback modulates the mean curvature of a propulsive rhythm, while recent direction-error motion distinguishes a persistent route request from a fast disturbance
transferable_invariant: retain the propulsive traveling wave, but reduce mean-turn demand when body-frame bearing is already correcting and reinforce it when recent bearing motion is growing the error
nontransferable_details: published gains, dimensional filter windows, robot or species geometry, oscillator phases, vortex phases, cylinder locations, and source-task routes
policy_translation: add a small separately bounded `bearing_window_rate` correction to body-frame bearing before the existing smooth total-curvature map; preserve the `0.55`-period, `28 deg` oscillator and the `45/55` curvature split
falsification: reject the rate residual if capture is lost or slower, the direct diagonal topology becomes an overshoot or domain exit, the traveling bend weakens, or acceleration saturation and force/moment loads increase without better distance progress

## Candidate hypothesis

This candidate introduces one mechanism beyond the successful inherited
mean-curvature controller: bounded derivative damping of target bearing. The
eight-observation `bearing_window_rate` is multiplied by a short `0.08` response
horizon and capped at `5 deg` before it is added to the current bearing. Thus a
correcting bearing trend releases curvature early, while an error-growing trend
adds limited recovery authority. The correction cannot replace the route error
or encode elapsed time, and every active value is owned by
`target_policy_params()`.

Expected downstream evidence is preservation of target capture and the compact
diagonal route, with a smoother early turn, no later arrival than `39.737`, or
lower saturation/load for comparable distance progress. This worker does not
claim a same-worker CFD improvement; the formal rollout after exit must decide
whether the new rate feedback survives the falsification criteria.
