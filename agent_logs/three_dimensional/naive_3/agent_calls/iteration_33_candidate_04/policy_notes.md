# Target-ray-rate steering-priority candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, and capture termination. I
  inspected the combined sheets for the strongest replicated policy and the
  informative adverse-yaw-suppression regression from release through capture,
  including both top-down vorticity and oblique body/Lambda2 rows. Both retain
  a coherent alternating red/blue street and compact three-dimensional caudal
  structures; neither shows a held-joint coast, passive advection, collision,
  boundary exit, or wake collapse. Peak body speed is about `1.39U` while peak
  sampled local flow remains below `0.033U`, confirming self-propulsion.
- Three byte-identical target-signed adverse-yaw samples capture at
  `16.93205T`, score `-0.20004481`, and mean distance `2.08513L`, with no exact
  speed-limit contact and bounded posterior angle/force/yaw-moment peaks of
  `0.59921/0.03693/0.01835`. The sampled bidirectional suppression variant
  arrives slightly earlier at `16.92618T` and lowers peak force to `0.03667`,
  but worsens mean/final distance to `2.08585/0.74483L` and score to
  `-0.20096611`. Therefore suppressing established anterior-to-posterior
  carrier transfer on a presumed adverse posterior sign does not improve the
  route and is not carried forward.
- The assigned-parent logs supply two further completed negative controls.
  Replacing the signed residual's receiver taper with a plateau gate captures
  at `16.96004T`, score `-0.20408924`, and mean distance `2.08869L`; isolating
  the same residual behind remaining acceleration headroom captures at
  `16.95311T`, score `-0.20239073`, and mean distance `2.08720L`. Together with
  the three exact replications, these results support preserving the successful
  signed residual and its existing receiver semantics rather than adding a
  third discretionary gate.
- The remaining visible defect is terminal geometry, not propulsion. On the
  replicated trace, target-relative line-of-sight rate rises from a mean
  `0.025/T` beyond `6L` to `0.255/T` over `1--2L` and `0.422/T` inside `1L`,
  reaching about `0.71/T` near `0.80L`. At that point radial closing remains
  about `1.18U`, but tangential speed is about `0.57U`, course error is
  `+0.45 rad`, and the turn request is nearly saturated. Inside `3L`, the
  posterior traveling-carrier acceleration opposes the instantaneous steering
  component in roughly `84%` of recorded states, so the fixed reserve often
  reduces counter-steering work without giving steering temporary priority.

## Single-candidate policy hypothesis

Preserve the replicated zero-centered anterior oscillator, posterior traveling
lag, body-frame target/velocity-course observation, terminal acceleration
allocation, smooth command envelope, high-onset positive-power speed guards,
base bidirectional work transfer, target-signed adverse-yaw residual, and
posterior stopping-risk projection. Add one bounded terminal allocation
mechanism: compute target line-of-sight rate from the cross product of
`target_body_L` and `velocity_body_U`, normalize it in body coordinates, and
raise the posterior steering-reserve fraction only when its sign agrees with
the existing turn request and the instantaneous posterior carrier opposes the
steering component. A narrow C1 distance gate begins at `3L`, after the recorded
signed-load donor events, and reaches full authority at `2L`, where measured
ray rate starts rising sharply; a second C1 gate scales the priority with ray
rate. Helpful carrier half-cycles remain unchanged, and carrier and steering
still share the same physical acceleration envelope, so this is phase-selective
work allocation, not extra drive or a hard clip.

Expected result: preserve capture and the alternating wake while reducing the
late tangential component enough to improve final/mean distance or arrival,
without exact actuator contact or greater load than the replicated envelope.
Falsify the mechanism if it loses capture, changes the broad route before the
terminal regime, destroys alternating shedding, exceeds `0.5993 rad`,
`0.0370` force, or `0.0184` yaw moment, or merely slows radial approach while
leaving target-ray rotation unchanged.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and asymmetric propulsive flapping
source_mechanism: preserve the coupled traveling rhythm while sensor feedback reallocates bounded half-cycle authority for turning
transferable_invariant: near a tight target, give corrective work priority only when normalized target-relative transverse motion shows that propulsion is carrying the swimmer across the target ray
nontransferable_details: published gains, dimensional beat settings, species-specific envelopes, duty ratios, exact vortex phases, and task-specific routes
policy_translation: use the body-frame target/velocity cross product divided by squared target distance to gate a bounded increase in posterior steering reserve only across a smooth 3L-to-2L terminal range and only on carrier half-cycles that oppose steering, without changing carrier gains or either actuator limit
falsification: reject if capture or coherent shedding is lost, broad-route commands change materially, line-of-sight rotation is not reduced, or angle, speed, force, and yaw-moment bounds exceed the replicated signed-load policy
```

## Non-CFD activation check after the edit

A policy-level replay on the strongest sample's 3,079 recorded states changes
273 posterior outputs and no anterior outputs relative to the replicated signed
policy. Every changed state is inside `2.998L` and on an opposing carrier half-
cycle; no broad-route, signed-load donor, or carrier/steering-aligned output
changes. The maximum posterior difference is `12.707 rad/T^2` where the
normalized ray-rate gate is fully open near capture, while the output remains
governed by the existing soft acceleration, speed, and angle projections. This
establishes that the mechanism is active and terminally isolated. Replaying
fixed states does not evolve the body or fluid and is not evidence of capture,
trajectory improvement, wake quality, or load reduction.
