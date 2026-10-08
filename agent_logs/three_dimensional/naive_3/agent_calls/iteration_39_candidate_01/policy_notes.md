# Dual-response target-ray half-cycle candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen direct-uniform still-water
  contract with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite traces,
  and capture termination. The assigned parent is the evaluated response-gated
  target-ray policy at score `-0.19997658`, mean distance `2.08507586L`,
  crossing distance `0.74382418L`, and `16.93206T` capture. The two independent
  course-agreeing target-ray samples reproduce `-0.19999072`, `2.08508726L`,
  and `0.74383789L`; the older signed-yaw allocator reaches
  `-0.20004481`, `2.08513085L`, and `0.74389035L`.
- I inspected both rows of the combined keyframe sheets for the assigned parent
  and the older signed-yaw allocator, the best finite and most informative
  weaker sampled policies. Their top-down rows show continuous self-propelled
  translation toward the target with a coherent alternating red/blue street.
  Their oblique rows retain compact caudal Lambda2 structures through capture.
  Neither shows held-joint coasting, passive advection, collision, domain exit,
  wake collapse, or instability. The metrics agree: peak fish speed is
  `1.39123U`, whereas peak sampled local flow is only `0.03270U`.
- The assigned parent changes only 69 evolved trace rows relative to the
  course-agreeing target-ray sample, beginning near `16.558T/1.233L`; it keeps
  the same arrival time and whole-trace maxima for joint angles, joint speeds,
  actions, force, moment, fish speed, and local flow. Its small improvement is
  therefore evidence for response-compatible terminal work placement, not
  stronger drive, a new route, or a different wake regime.
- Replaying the parent's gate definitions over its completed trace recovers 83
  target-ray increments between `2.243L` and capture. Every increment performs
  positive posterior joint work and opposes measured yaw moment, as intended.
  A new cross-check shows that all 83 also oppose measured body-frame lateral
  force; signed lateral-force response spans approximately
  `-0.03026` to `-0.00146` in normalized `force_body_L` units. Thus rotational
  and translational response agree on the useful correction channel, but the
  current policy releases work only from the rotational measurement.

## Single-candidate policy hypothesis

Preserve the assigned parent's zero-centered anterior oscillator, lagged
posterior carrier, full body-frame velocity-course loop, one-sided target-ray
geometry, forward-target release, posterior acceleration reserve, C1 command
envelope, high-onset positive-power speed guards, signed adverse-yaw work
transfer, receiver taper, and stopping-risk projection. Refine only the
existing terminal target-ray increment with a second closed-loop response
projection. Admit that already-positive-posterior-work increment through the
minimum of its inherited adverse-yaw gate and a C1 gate on adverse normalized
body-frame lateral force. The carrier and base course request remain
unchanged; favorable lateral response cannot be interpreted as permission to
add more target-ray work.

This is a mechanism test, not scalar carrier tuning. It asks whether the small
parent benefit generalizes from rotational load agreement to joint rotational
and translational response agreement. Expect no change outside the inherited
`2.25L` terminal window, continued capture and coherent alternating 3D
shedding, and a small reduction of weak-response target-ray work. Seek better
score, mean distance, or crossing depth than
`-0.19997658/2.08507586L/0.74382418L` without exceeding the parent's
`0.59922 rad` posterior angle or approximately `0.0370/0.0184` force/moment
envelope. Falsify the mechanism if it loses capture, changes the broad route,
removes the strong-response interventions, worsens distance quality without a
mechanical benefit, or disrupts joint viability or the coherent wake.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and asymmetric flapping for turning
source_mechanism: preserve a coupled propulsive rhythm while measured directional response schedules corrective work on a compatible half-cycle
transferable_invariant: add target-signed work only during a positive-work joint phase and only while normalized rotational and translational body responses remain adverse
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, duty ratios, full-body oscillator networks, exact vortex phases, capture radius, and task-specific routes
policy_translation: retain the body-frame velocity-course and one-sided target-ray requests; project only the target-ray turn increment through posterior positive-work, adverse normalized-yaw-moment, and adverse normalized-lateral-force gates before the existing two-joint allocation and safety layers
falsification: reject if broad-route equivalence, capture, sublimit joints, or alternating three-dimensional shedding is lost; if strong useful parent interventions are suppressed; or if score, mean/crossing distance, posterior angle, or force/moment loads regress without a new semantic or mechanical benefit
```

No formal CFD is run in this worker. The candidate rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying the new force-response projection over the assigned parent's 3,079
recorded states retains all 83 inherited target-ray interventions and leaves
78 exactly unchanged. It smoothly attenuates five weak-lateral-response
samples between `16.547T/1.251L` and capture; total absolute turn-request
increment falls only from `1.851244` to `1.850944`, while its signed sum is
effectively unchanged. The force gate ranges from `0.267` to `0.987` only in
those five affected samples. This establishes a non-inert, bounded
dual-response test without changing carrier gains, broad-route feedback, or
the strong-response half-cycle work. It does not evolve the fish or fluid and
is not evidence for the unevaluated candidate's CFD outcome.
