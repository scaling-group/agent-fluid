# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the common initial condition,
  not candidate-specific evidence. The sampled released sheets all show an
  immediate targetward redirect, an active posterior traveling bend, a compact
  diagonal wake crossing, and direct first entry into the `0.75L` capture
  circle. No current sampled failure sheet exists, so the useful visual
  comparison is the strongest finite policy against the distinct slower
  success, while inherited logs provide the failure boundary.
- The distinct slower controller preserves the filtered body-frame bearing,
  bounded `12 deg` total curvature, bearing-conditioned `40/60 -> 35/65`
  allocation, and the `0.55`-period, `28 deg` traveling wave. It captures at
  `35.0625` released time with `1.73388L` mean distance, `56.57` lateral-force
  RMS, and `793.76` moment RMS. Adding an `8%` maximum bearing-gated gain only
  to the target-helping posterior half-cycle preserves the direct visual
  topology and improves capture to `32.4720` and mean distance to `1.64761L`.
  Three sampled files implement those same half-cycle equations and reproduce
  the result exactly, which is deterministic repeatability at one shared wake
  phase rather than three independent mechanism validations.
- The faster half-cycle mechanism has an explicit load cost. Relative to the
  slower policy, lateral-force RMS rises `21.4%` to `68.70` and yaw-moment RMS
  rises `17.4%` to `931.60`; both policies touch the `260 deg/time` joint-speed
  and `1800 deg/time^2` acceleration envelopes. Mean command energy changes
  only from `1431.01` to `1425.46`, so lower total energy is mainly the shorter
  episode. The evidence supports keeping the navigation mechanism while
  making only its extra posterior asymmetry responsive to measured load; it
  does not support weakening the base gait or claiming efficiency.
- The informative inherited failure is the bounded bearing-window-rate child.
  It destroyed the effective traveling bend, moved downstream, exited at
  `16.956`, approached no closer than `12.424L`, and showed only
  `0.140/0.163 rad` joint excursions with `8.64` mean command energy. The new
  candidate therefore adds no route derivative and places no moment, force, or
  flow signal upstream of the oscillator centers or total-curvature request.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: organized-wake fish interaction and sensor-feedback modulation of robotic-fish rhythmic propulsion
source_mechanism: preserve target-directed mean curvature and the posterior traveling wave while applying only a small bounded response to measured wake-induced load
transferable_invariant: a fast disturbance signal should modulate only the incremental gait asymmetry that may amplify it, while slow normalized body-frame target geometry retains route ownership and the base propulsive wave is never cancelled
nontransferable_details: published gains, dimensional load scales, species or robot kinematics, exact vortex phases, actuator shares, fixed routes, and source-specific synchronization objectives
policy_translation: retain the completed filtered-bearing, total-curvature, oscillator, posterior-lag, and helpful-half-cycle equations; use the magnitude of normalized `moment_z_L2` to smoothly attenuate only the extra posterior half-cycle gain, recovering the evaluated slower traveling-wave parent rather than reversing the wave as yaw load grows
falsification: reject the load gate if capture is lost or later than `35.0625`, mean distance exceeds `1.73388L`, the compact diagonal topology changes adversely, or force and moment fail to decrease materially from `68.70/931.60` while arrival regresses from `32.472`

## Candidate hypothesis

Make exactly one feedback-architecture change to the strongest sampled policy:
add normalized yaw-load gating to its incremental posterior half-cycle
asymmetry. The owned soft scale is `0.20` in `moment_z/L^2`, close to the
completed parent and faster policy RMS levels (`793.76/64^2 = 0.194` and
`931.60/64^2 = 0.227`). A quadratic soft gate leaves the full sampled `8%`
extra gain available near zero moment and continuously removes only that extra
gain as absolute yaw moment grows. It cannot change turn sign, total mean
curvature, or the underlying symmetric posterior wave.

This mechanism is deliberately downstream of route steering and propulsion:
filtered bearing still owns the bounded turn, and current joint state still
owns rhythmic phase. The expected tradeoff is arrival between the completed
`32.472` half-cycle result and its `35.0625` parent, with force and moment below
the faster result. The translation is unevaluated in this worker, so no new CFD
benefit is claimed.
