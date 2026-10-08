# Promoted target-signed adverse-yaw allocation candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertially still fluid
  inserted by the moving window. All terminate in capture, so the useful
  contrasts are route quality, actuator viability, and whether a proposed
  feedback channel has closed-loop authority.
- I inspected the combined sheets for the best target-signed sample and the
  prefilled bidirectional sample from release through termination, including
  both the top-down vorticity row and oblique body/Lambda2 row. Both fish
  translate toward the target while shedding a coherent alternating red/blue
  street and compact three-dimensional caudal structures. Neither exhibits a
  standing wiggle, passive coast, collision, boundary exit, or wake collapse.
  The traces confirm self-propulsion rather than ambient or moving-window
  advection: peak body speed is `1.391U` for the best sample while peak sampled
  local flow is only `0.0327U`.
- The prefilled allocator was reproduced twice byte-for-byte and captures at
  `16.988T`, with score `-0.204764`, mean distance `2.08931L`, posterior angle
  peak `0.5700 rad`, and force/yaw-moment peaks `0.03634/0.01804`. A
  joint-angle phase residual changes the route only modestly: it captures at
  `16.965T`, scores `-0.204466`, and has mean distance `2.08904L`.
- The target-signed measured-yaw residual is the only sampled edit with a
  clearly distinct beneficial trajectory. It captures at `16.932T`, improves
  score to `-0.200045` and mean distance to `2.08513L`, and ends at
  `0.74389L`. It retains sublimit joint speeds (`4.5192/4.5239 rad/T`) and the
  same peak raw command envelope (`31.1018/29.8451 rad/T^2`). The tradeoff is
  measurable but bounded: posterior angle rises to `0.5992 rad`, peak force to
  `0.03693`, and peak yaw moment to `0.01835`, all still below mechanical
  limits or within about two percent of the prefilled load envelope.
- These comparisons sharpen the inherited null result. Whole-trace moment
  magnitude did not help when it failed to overlap the discretionary donor
  events. In contrast, the product of body-frame turn request and signed
  measured yaw moment acts only when the current yaw response is adverse, and
  the prior non-CFD replay established 16 changed anterior commands rather
  than an inactive gate. The completed rollout now establishes a small route
  and arrival improvement, not merely syntactic activation.

## Single-candidate policy hypothesis

Promote the sampled target-signed adverse-yaw allocator as the sole candidate.
Preserve the demonstrated zero-centered anterior oscillator, posterior
traveling lag, body-frame target/velocity-course feedback, terminal posterior
acceleration reserve, smooth acceleration shoulder, high-onset positive-power
speed guards, bidirectional phase-local work transfer, and posterior
stopping-risk projection. During an existing posterior speed-guard donor
event, retain the established transfer fraction and add a bounded residual
only when the anterior receiver command agrees with target-relative turn
intent and opposes the signed measured yaw moment. Existing receiver-speed and
`0.99` acceleration-headroom gates remain prerequisites.

This is a mechanism selection from completed evidence, not scalar gain tuning.
Expect capture with coherent alternating three-dimensional shedding, arrival
no later than `16.932T`, score no worse than `-0.200045`, no exact joint-speed
contact, and posterior angle/force/yaw-moment no larger than
`0.5993/0.0370/0.0184`. Falsify the promotion if it cannot reproduce the
distinct route, loses capture or wake coherence, reaches a joint limit, or its
small arrival benefit proves inseparable from materially increased load or
angle use in a later held-out rollout.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and wake-disturbance rejection
source_mechanism: preserve a coupled propulsive rhythm while feedback allocates bounded corrective work only during an observed adverse yaw response
transferable_invariant: separate target-relative turn intent from signed measured yaw response, and intervene only where their mismatch overlaps an already available phase-local work channel
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, duty ratios, full-body oscillator networks, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame course turn request and signed yaw moment to increase only posterior-blocked work transferred into an agreeing anterior stroke, subject to measured receiver speed and acceleration headroom
falsification: reject if the signed residual loses capture or alternating shedding, touches an actuator boundary, does not reproduce the distinct arrival and mean-distance improvement, or raises posterior angle and hydrodynamic loads beyond the sampled bounded tradeoff
```

No formal CFD is run in this worker. The promoted mechanism is supported by a
completed sampled rollout; evaluation of this materialized candidate remains
evidence for the next worker.
