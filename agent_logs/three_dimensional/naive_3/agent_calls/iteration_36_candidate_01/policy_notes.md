# One-sided signed-yaw allocator selection candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and capture termination. Three samples
  (`solver_6334f1f4fe88`, `solver_cf5406a979f8`, and
  `solver_db2418f56ce7`) have the same policy hash and byte-identical
  trajectory, while the prefilled `solver_292735cefd5b` is the informative
  contrasting policy.
- I inspected the combined keyframe sheets for a replicated strong sample and
  the prefilled contrast from release through capture, including both the
  top-down vorticity row and the oblique body/Lambda2 row. Both show continuous
  target-directed self-propulsion, a coherent alternating red/blue wake, and
  compact three-dimensional caudal structures through the capture sphere.
  Neither shows a held-joint coast, passive advection, collision, boundary
  exit, or wake collapse. The traces support that interpretation: the
  replicated policy reaches `1.3912U` while peak sampled local flow is only
  `0.03270U`; the prefilled policy is nearly identical at `1.3925U` and
  `0.03271U`.
- The replicated one-sided allocator captures at `16.93205T`, scores
  `-0.20004481`, has `2.08513085L` mean distance, and crosses at
  `0.74389035L`. The prefilled bidirectional arbitration captures about
  `0.0059T` earlier and has a slightly lower peak force norm
  (`0.03667` versus `0.03693`), but regresses score to `-0.20096611`, mean
  distance to `2.08585280L`, and crossing depth to `0.74482834L`. Both have
  essentially the same posterior angle (`0.59922 rad`), joint-speed peaks
  (`4.5192/4.5239 rad/T`), and peak yaw moment (`0.01835`). Mirroring the
  signed-yaw selector onto the opposite transfer therefore changes the route
  without improving wake coherence or mechanical viability.
- The assigned-parent logs add three later completed terminal mechanisms.
  Two collision-corridor steering-relief policies regress to
  `-0.204337/2.08858L` and `-0.202941/2.08746L` score/mean distance. The later
  agreement-gated terminal yaw increment also regresses, to
  `-0.2003615/2.085386L`, while its speed, angle, force, moment, and yaw-rate
  maxima remain effectively those of the replicated policy. Those results
  falsify further terminal steering overlays as the next useful change; they
  do not dislodge the replicated one-sided allocator.

## Single-candidate policy hypothesis

Promote the three-times-reproduced one-sided target-signed adverse-yaw
allocator as the sole candidate. Preserve the zero-centered anterior
oscillator, lagged posterior traveling carrier, normalized body-frame
target/velocity-course request, terminal posterior acceleration reserve,
smooth acceleration shoulder, high-onset positive-power speed guards,
bidirectional phase-local base work transfer, and posterior stopping-risk
projection. During an existing posterior donor event, retain the bounded
extra anterior work only when the receiving stroke agrees with target turn
intent and opposes measured yaw. Remove the prefilled mirrored suppression of
anterior-to-posterior transfer, because current evidence shows that applying
the same signed rule in both directions worsens integrated approach without a
new safety or wake benefit.

This is selection of a replicated feedback topology, not scalar-only gain
tuning. Expect capture, the same alternating three-dimensional wake, score
near `-0.200045`, mean distance near `2.08513L`, and no exact joint contact.
Falsify the selection if it does not reproduce capture and the established
route, loses wake coherence, touches an actuator limit, exceeds `0.5993 rad`
posterior angle or `0.0370/0.0184` force/yaw-moment peaks, or proves less
robust than the prefilled bidirectional policy under a held-out condition.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive swimming under measured yaw loads
source_mechanism: preserve a coupled propulsive rhythm while signed sensor feedback allocates bounded corrective work through a phase-local residual channel
transferable_invariant: retain the productive traveling bend and add corrective work only where target-relative intent and measured adverse yaw identify a demonstrated helpful receiver direction
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, full-body oscillator networks, exact vortex phases, and task-specific routes
policy_translation: keep the normalized body-frame course request and signed yaw-moment residual on posterior-blocked work transferred to an agreeing anterior positive-power stroke; remove the unevidenced mirrored suppression of the opposite base-transfer direction
falsification: reject if replicated capture, route, or alternating three-dimensional shedding is lost, if a joint limit is touched, or if posterior angle and hydrodynamic loads exceed the sampled bounded tradeoff without semantic benefit
```

No formal CFD is run in this worker. The materialized candidate's evaluation
becomes evidence only after this worker exits.
