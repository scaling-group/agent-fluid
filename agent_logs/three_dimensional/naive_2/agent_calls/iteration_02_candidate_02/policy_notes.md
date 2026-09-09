# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm and no cylinders), so their motion and
  wakes are self-generated. None captures the target; all leave through the
  upper virtual boundary despite the generic `left_domain` label.
- The top-down and oblique rows show that the naive seed and posterior-only
  curvature candidate retain the strongest alternating, three-dimensional
  posterior wakes and useful leftward propulsion. The posterior candidate is
  the best finite sample: it moves the center `1.056L` left and improves
  distance from `12.328L` to `12.056L`, but then drifts `1.200L` upward and
  exits at `9.146T`. Its heading-rate oscillation reaches roughly `2.15/T`,
  both joint rates reach `260 deg/T`, and raw joint accelerations reach about
  `60` and `112 rad/T^2`; the visible curved vortex trail therefore agrees
  with actuator-limited over-turn, not absent propulsion.
- The naive sample has the same trajectory topology and ends at `8.596T`
  after a `12.069L` closest approach. The two sampled policies that steer both
  joints reduce rate saturation, but their wakes and targetward translation
  weaken: their closest approaches are only `12.235L` and `12.297L`, followed
  by the same upward exit. Thus adding a static/mean curvature to both joint
  rhythms is not a surviving positive mechanism in this evidence.
- An inherited evaluated worker reinforces that negative result: centering a
  slower two-joint carrier on bearing/slip/yaw mean curvature avoids rate
  saturation but produces a large wrong-way loop, moves `2.201L` away in x,
  and exits the right boundary at `13.057T` with final distance `15.408L`.
  Later workers should not infer a universal curvature-to-yaw sign across
  carrier regimes or treat longer survival alone as semantic improvement.
- Reconstructed normalized body-frame evidence makes slip a cleaner response
  signal than instantaneous yaw for this candidate. Near `4T`, before the
  naive bearing crosses through zero, body-frame lateral velocity is already
  about `0.23U` toward the requested side while raw yaw continues to alternate
  at the beat scale. The sampled posterior controller's raw-yaw term therefore
  switches strongly within cycles rather than supplying a slow turn-response
  estimate.

## Single candidate hypothesis

Keep the common seed's state-feedback oscillator and posterior lag exactly as
the evidenced propulsion carrier. Replace static curvature with one bounded
half-cycle acceleration-asymmetry mechanism: normalized target bearing asks
which curvature side should be stronger, normalized body-frame lateral
velocity releases or reverses that request when the fish is already sliding
across the line of sight, and the signed request strengthens accelerations on
one half-cycle while weakening the other. Posterior emphasis should retain the
traveling wave and create a turn without pinning either joint around a static
offset. This is falsified if the alternating wake or leftward surge collapses,
if joint-limit occupancy exceeds the naive/posterior samples, if the initial
turn sign is wrong, or if closest approach does not beat `12.056L` and the same
upper-boundary exit persists.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: body-response feedback makes the target-side half-cycle stronger while preserving a propulsive rhythm
transferable_invariant: persistent normalized body-frame target error may select a bounded beat asymmetry, and measured lateral response should release that asymmetry before route overshoot
nontransferable_details: published gains, dimensional beat frequency, robot linkage geometry, species-specific envelopes, clocked phase, exact vortex phase, and task-specific routes
policy_translation: infer half-cycle direction from each seed acceleration, bias its magnitude with a tanh-bounded command from state.bearing minus normalized lateral slip, and retain posterior emphasis and joint-state phase
falsification: reject if propulsion weakens, saturation grows, turn sign is wrong, or closest approach and upper-boundary termination do not improve together

## Dry validation (not rollout evidence)

The final policy passes the parameter-schema/finite-output contract and is
reflection equivariant under simultaneous sign reversal of joint state,
bearing, and body-frame lateral velocity. A joint-only 50T probe (which has no
fluid or free-body dynamics) preserves roughly `1.02/1.04 rad` anterior and
posterior peak-to-peak oscillations. Averaged over its final 20T, total mean
curvature changes monotonically from `-0.0287` through approximately zero to
`+0.0303 rad` for bearings `-0.155/0/+0.155`, while rate-limit contacts remain
within about two percent of the zero-command probe. The probe establishes only
that the translated half-cycle actuator is bounded, directional, and does not
erase its carrier; post-worker CFD must decide every trajectory and wake
falsifier above.
