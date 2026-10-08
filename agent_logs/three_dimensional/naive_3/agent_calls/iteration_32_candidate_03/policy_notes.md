# Replicated target-signed adverse-yaw allocation candidate

## Evidence-led diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and capture termination. The useful comparison is
  therefore route quality and actuator viability within one successful
  controller family, not success versus failure.
- I inspected the combined keyframe sheets for the best finite signed-yaw
  sample and the weaker prefilled bidirectional allocator from release through
  termination, including the top-down vorticity row and oblique body/Lambda2
  row. Both translate toward the target with a coherent alternating red/blue
  street and compact three-dimensional caudal structures. Neither shows a
  held-joint coast, passive advection, wake collapse, collision, or boundary
  exit. The trajectory evidence agrees: peak fish speed is `1.391U` in the
  best sample while peak sampled local-flow speed is only `0.0327U`.
- The prefilled allocator captures at `16.988T`, scores `-0.204764`, and has
  `2.08931L` mean distance, `0.57000 rad` peak posterior angle, and
  `0.03634/0.01804` peak force/yaw moment. The target-signed measured-yaw
  policy is reproduced exactly by two sampled solvers: both capture at
  `16.932T`, score `-0.200045`, and reach `2.08513L` mean distance with the
  same trajectory and policy hash. They retain sublimit joint-speed peaks of
  `4.5192/4.5239 rad/T` and the coherent wake, at a bounded cost of
  `0.59921 rad` posterior angle and `0.03693/0.01836` force/yaw moment.
- The remaining sample isolates the adverse-yaw increment behind a separate
  plateau receiver-speed gate. It still captures, but regresses to
  `16.960T`, score `-0.204089`, and `2.08869L` mean distance. Its code removes
  the established receiver taper from the residual below the new rollover,
  rather than adding safety to the already sublimit trace; the resulting
  `0.59395 rad` posterior excursion and `0.03668/0.01838` loads do not recover
  the replicated route benefit. This falsifies relaxing or replacing the
  existing receiver gate for the signed increment.

## Single-candidate policy hypothesis

Promote the twice-reproduced target-signed adverse-yaw allocator as the sole
candidate, unchanged from the two best sampled policies. Preserve the
zero-centered anterior oscillator, lagged posterior carrier, normalized
body-frame target/velocity-course request, terminal posterior acceleration
reserve, smooth acceleration shoulder, high-onset positive-power speed guards,
bidirectional phase-local work transfer, and posterior stopping-risk
projection. During an existing posterior donor event, add the demonstrated
bounded residual only when the anterior receiving stroke agrees with the
target-relative turn request and opposes signed measured yaw moment. Keep the
same receiver-speed taper and acceleration headroom on both base and residual
work.

This is selection of a reproduced feedback mechanism, not scalar-only gain
tuning. Expect capture, alternating three-dimensional shedding, arrival near
`16.932T`, score near `-0.200045`, and no exact speed or angle contact.
Falsify the promotion if it cannot reproduce the route and capture, loses wake
coherence, reaches a mechanical limit, or exceeds `0.5993 rad` posterior angle
or `0.0370/0.0184` force/yaw-moment peaks without a semantic benefit.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive swimming under measured yaw loads
source_mechanism: preserve a coupled propulsive rhythm while signed sensor feedback allocates bounded corrective work within an available phase-local channel
transferable_invariant: keep the productive traveling bend intact and condition corrective work on agreement between target-relative turn intent and measured adverse yaw response
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, full-body oscillator networks, exact vortex phases, and task-specific routes
policy_translation: use bounded body-frame course turn request and normalized signed yaw moment to augment only posterior-blocked work transferred to an agreeing anterior positive-power stroke, retaining normalized receiver-speed and acceleration-headroom gates
falsification: reject if capture or alternating shedding is lost, the distinct route and arrival do not reproduce, a joint limit is touched, or posterior angle and hydrodynamic loads exceed the sampled bounded tradeoff
```

No formal CFD is run in this worker. Evaluation of the materialized candidate
will become evidence for a later worker.
