# Carrier-demodulated velocity-course candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled solver examples satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, and inertially still
  fluid entering the moving window. All capture. Three byte-identical copies
  of the assigned parent are the strongest reference at `16.93205T`, score
  `-0.20004481`, mean distance `2.08513L`, and crossing distance `0.74389L`.
  Their joint speeds remain sublimit at `4.5192/4.5239 rad/T` and force/yaw-
  moment peaks are `0.03693/0.01835`.
- I inspected the combined sheets for that replicated parent and the sampled
  bidirectional-arbitration contrast from release through capture in both the
  top-down vorticity row and oblique body/Lambda2 row. Both show self-propelled
  target-directed translation, a coherent alternating red/blue street, and
  compact three-dimensional caudal structures through capture. Neither shows
  passive advection, a held-joint coast, collision, boundary exit, or wake
  collapse. Peak body speed is about `1.39U`, whereas peak sampled local flow
  is only `0.0327U`. The bidirectional variant is visually indistinguishable
  and arrives `0.006T` sooner, but worsens mean distance to `2.08585L` and
  score to `-0.200966`; symmetric signed-load arbitration is therefore not a
  useful next mechanism.
- I also inspected both rows of the completed inherited adverse-yaw-reserve
  and capture-corridor-release sheets and cross-checked their diagnostics.
  Both preserve the alternating wake and capture, but score only `-0.204068`
  and `-0.204337`. Moving more of the fixed posterior envelope into steering
  raises peak speed to `1.436U`, posterior angle to `0.6722 rad`, and force to
  `0.03737`; releasing steering inside a predicted capture corridor leaves
  the parent's mechanical peaks unchanged but worsens mean/final distance to
  `2.08858/0.74805L`. Earlier capture alone is not evidence that either edit
  improves the route.
- The repeated parent trace exposes a different mechanism. Reconstructing
  body-frame velocity from the recorded pose shows that the existing lagged-
  carrier target `-q1 - 0.8*qdot1/omega` explains about `67%` of lateral-
  velocity variance over `4--12T`, `74%` from `4T` onward, and `88%` inside
  `2L`; its fitted sign is stable and its broad fitted scale is close to one
  velocity unit per radian. Thus much of the lateral term entering the current
  velocity-course angle is carrier-synchronous body sway, not route-scale
  slip or ambient flow. This explains the large alternating course requests
  without contradicting the productive wake.

## Single-candidate policy hypothesis

Preserve the zero-centered anterior oscillator, lagged posterior carrier,
body-frame target ray, physical-speed gate, posterior acceleration reserve,
soft command shoulder, phase-local speed guards and work transfer, signed-yaw
residual, and posterior stopping-risk projection. Change only the course
observation: form a bounded carrier-phase proxy from the already used lagged
posterior target, translate it into a predicted lateral sway velocity, and
subtract that component before computing course bearing. Continue to use the
measured physical speed for the low-speed target-bearing blend, so the new
estimate cannot invent a reliable course at release.

This is carrier-synchronous observation demodulation, not a gain increase or
another terminal authority schedule. It should reduce beat-contaminated
steering while retaining the traveling wave and the full target-relative
course mechanism. Falsify it if capture or coherent alternating shedding is
lost; if score/mean distance fail to beat `-0.200045/2.08513L`; if either
joint touches a speed or angle limit; or if posterior angle, force, or yaw
moment exceed `0.5993 rad`, `0.0370`, or `0.0184`. Also reject it if a static
replay shows no overlap or if subtraction amplifies rather than reduces the
carrier-frequency course oscillation.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and traveling-wave reactive swimming
source_mechanism: preserve a coupled propulsive rhythm while separating its fast state-observed oscillation from the slower target-course command
transferable_invariant: do not treat carrier-synchronous lateral body motion as persistent route slip; use observed oscillator phase to remove only the bounded rhythmic component before steering feedback
nontransferable_details: published CPG gains, dimensional beat frequency, species-specific kinematics, full-body phase networks, exact vortex phases, and task-specific routes
policy_translation: normalize the existing lagged-carrier target by the joint-angle envelope, map it to a bounded body-frame lateral-velocity estimate owned by policy parameters, subtract it only in the course-bearing observation, and retain measured speed plus the original two-joint actuation and safety layers
falsification: reject if course oscillation is not reduced on recorded states, or if the evaluated rollout loses capture or alternating shedding, regresses route score, reaches a joint limit, or exceeds the sampled posterior-angle and load envelope
```

Formal CFD is not run in this worker. The candidate's rollout becomes evidence
for a later worker.

## Post-edit non-CFD checks

An exact policy-level replay on the 3,079 recorded parent states confirms that
the new observation is active after the measured-speed gate opens: 2,325
outputs differ, first at `2.778T`. The direct posterior-command difference is
bounded to `5.512 rad/T^2`; joint 1 is structurally unchanged except in 31
states where the existing downstream cross-joint allocator responds to the
altered posterior command, with a maximum difference of `1.193 rad/T^2`.
Recomputing the observation over the same trace reduces course-error standard
deviation from `0.43080` to `0.42342 rad` after `4T` and from `0.31310` to
`0.29834 rad` inside `2L`; terminal turn-request saturation falls from
`49.73%` to `47.54%`. This establishes selective bounded overlap and the
intended signal effect only. It does not establish a new trajectory, load,
score, or capture result.
