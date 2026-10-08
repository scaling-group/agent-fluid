# Response-aware, smoothly projected C-bend candidate

## Evidence diagnosis

- Every sampled rollout used direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot, so the motion
  and wakes are policy-generated rather than advected or inherited.
- The informative inherited failure `solver_f578f8771e8a` visibly curls into a
  tight static posture with a weak, non-alternating wake, improves only from
  `12.328L` to `12.173L`, and exits the upper boundary at `7.99T`. Its
  posterior joint is at the angle limit for `78.0%` of samples. Together with
  the seed's coherent-wake lower-boundary miss, this rejects wholesale carrier
  replacement and the inverted request-to-bend mapping.
- The assigned-parent C-bend `solver_d594e3893325` preserves a compact,
  alternating top-down wake and coherent oblique Lambda2 shedding throughout
  a target-directed arc. It captures at `25.388T` with mean distance `2.557L`,
  establishing its same-sign bend polarity, target-error gate, drive relief,
  and traveling-wave carrier as the mechanism to preserve.
- `solver_82fca3f02154` changes only that C-bend's release: observed
  correct-sign yaw restores some propulsive authority. It preserves capture
  and wake coherence while improving arrival to `25.152T`, mean distance to
  `2.522L`, and peak yaw rate from `2.781` to `2.705 rad/T`. It does not,
  however, make final raw commands actuator-feasible.
- The best sampled finite rollout `solver_953f16c610ad` instead changes only
  the final acceleration interface with a fourth-order smooth projection. Its
  two wake views preserve the target-directed alternating vortex train, and it
  improves capture to `23.997T` and mean distance to `2.438L`; recorded raw
  accelerations remain below `31.42 rad/T^2` instead of reaching roughly
  `80/109 rad/T^2`. Posterior velocity-cap exposure (`4.5%`) and peak yaw
  (`2.922 rad/T`) are not better than the parent, so command feasibility must
  not be mistaken for complete kinematic damping.

## Policy hypothesis

Use the best sampled smoothly projected controller as the carrier, and add the
independently successful response-release gate inside its existing C-bend.
The mechanisms act at different interfaces: normalized body-frame target
geometry and recent yaw determine how much posture/lag relief remains, while a
component-wise projection keeps the resulting joint accelerations inside the
physical envelope. Their small compatible combination should preserve the
captured arc and coherent wake while avoiding sustained redirect after the body
has begun the requested turn.

Falsify the combination if capture is lost, capture is materially later than
`23.997T`, mean distance exceeds `2.438L`, the trajectory reverts to either
sampled boundary-exit topology, the alternating wake collapses, or yaw/joint
velocity saturation grows enough to offset the command-feasibility benefit.
The new CFD rollout occurs only after this worker exits, so this hypothesis is
not recorded as a demonstrated improvement.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and closed-loop robotic-fish CPG modulation
source_mechanism: strong curvature for large direction error should release into posteriorly lagged propulsion once sensed yaw follows the request, with the combined actuation kept bounded
transferable_invariant: separate target-referenced mean turning from the traveling-wave carrier and schedule their authority from observed geometric error and response
nontransferable_details: species-specific bend shapes, published gains and frequencies, exact tail-beat or vortex phase, dimensional maneuver timing, and task-specific routes
policy_translation: multiply the normalized body-frame error C-bend by a bounded gate derived from requested and recent yaw, retain the joint-state oscillator, and smoothly project both final joint accelerations into the owned physical envelope
falsification: reject if capture, target-directed wake coherence, arrival/mean distance, or joint/yaw histories regress despite bounded raw acceleration
```
