# Candidate wake-policy notes

## Evidence diagnosis

- The only sampled solver is the common naive seed (`solver_ab755c2206e8`),
  evaluated from direct uniform still water (`U_infinity=[0,0,0]`), so the
  observed motion is self-propulsion rather than imposed advection. No
  inherited optimizer log is present in this fresh parent workspace.
- In the combined visual sheet, the best finite part of the rollout is the
  early-to-middle segment: the top-down row develops a compact alternating
  wake while the fish moves left, and the oblique Lambda2 row confirms
  coherent three-dimensional tail vortices rather than a planar rendering
  artifact. Distance falls from `12.3277L` to `12.0782L` by `6.358T`.
- The informative failure is the late segment. The fish curls away from the
  lower-left target, its wake remains energetic, and the body follows a broad
  upward arc. Metrics confirm that this is a guidance failure, not loss of
  propulsion: speed reaches `0.636U`, heading rate reaches `2.792 rad/T`, and
  final center/head y are `15.2004L/15.5913L`, producing `left_domain` at
  `8.547T`. Final distance is worse than initial (`12.3800L`) even though the
  wake remains coherent.
- The target bearing is initially only about `+0.155 rad`, crosses essentially
  zero near `4T`, then reaches about `-1.18 rad` by `8T`; the seed cannot use
  that sign reversal. Joint angles remain below the 45-degree envelope, and
  velocity-limit contact is brief (about 1.3%/1.8% of samples), so the first
  intervention should preserve the demonstrated traveling-bend carrier rather
  than replace it. Commanded acceleration exceeds the nominal acceleration
  envelope often, so added steering must be bounded and must not increase the
  carrier gains.

## Policy hypothesis

Retain the seed's state-feedback oscillator and posterior lag. Add one bounded
target-vector-to-mean-curvature mechanism by biasing the posterior joint's
tail-tangent target. The bias uses normalized body-frame `bearing` plus measured
`heading_rate`: bearing supplies the required turn sign, while rate feedback
releases or reverses curvature as yaw develops. This preserves oscillatory
propulsion around a slowly varying mean tail tangent and introduces no time,
route, coordinate, wake-phase, or mutable-state dependency.

Expected result: the controller should keep the early coherent wake and
leftward progress, reverse curvature after the bearing crosses zero, avoid the
upper boundary, and survive materially beyond `8.547T`. Falsify the mechanism
if it retains the same upward-exit topology, fails to reverse after negative
bearing, destroys the alternating wake, increases joint saturation materially,
or yields less minimum-distance progress than `0.2496L`.

```text
bookshelf_consulted: true
source_domain: biological and robotic fish turning by biased tail beats / mean curvature
source_mechanism: target-driven bounded mean-curvature bias superposed on a traveling posterior-lag gait
transferable_invariant: preserve the propulsive traveling bend while a signed sensory error shifts its mean curvature, with measured yaw rate opposing continued rotation
nontransferable_details: published gains, species-specific envelopes, dimensional frequencies, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame bearing and heading rate to a bounded posterior tail-tangent bias inside the existing two-joint state-feedback oscillator
falsification: reject if target-bearing sign reversal does not produce a recovery turn, if the wake/forward progress collapses, or if saturation and loads worsen while the upper-domain exit persists
```
