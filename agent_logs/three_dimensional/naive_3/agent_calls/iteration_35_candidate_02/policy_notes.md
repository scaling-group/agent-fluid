# Wake-policy candidate notes

## Prior evidence diagnosis

- The three sampled copies of the assigned target-signed adverse-yaw policy
  reproduce the same complete rollout: capture at `16.932T`, score
  `-0.200045`, mean distance `2.08513L`, and final distance `0.74389L`. The
  direct-uniform still-water contract is intact (`U_infinity=0`, no prewarm).
- In both the top-down and oblique rows, the replicated parent sustains an
  alternating, laterally organized wake from release through capture, with
  compact three-dimensional Lambda2 structures following the fish. Motion is
  self-propelled rather than background advection; the inherited guidance
  reports peak local flow below `0.033U` for this carrier family.
- The informative counterexample mirrors adverse-yaw arbitration onto the
  anterior-to-posterior transfer. Its visual wake is effectively unchanged and
  it still captures at `16.926T`, but score worsens to `-0.200966`, mean
  distance to `2.08585L`, and crossing distance to `0.74483L`. This rejects a
  symmetric load selector even though the semantic termination is preserved.
- The replicated parent's terminal trajectory already supplies a safe
  intercept intermittently: near `15.998T`, distance is `1.941L`, projected
  straight-course miss is about `0.219L`, normalized closure cosine is
  `0.994`, and speed is `1.204U`. The course-miss signal then oscillates with
  the beat, so a valid gate must restore steering whenever the projected miss
  leaves the capture cone rather than latch a terminal stage.

## Candidate hypothesis

Preserve the demonstrated traveling carrier, target-signed adverse-yaw
allocation, soft acceleration envelope, narrow positive-power speed guard, and
stopping-risk projection. Add one continuous collision-cone release on the
posterior mean-steering component: only near the target, at reliable speed,
with positive closure, and with projected miss inside a conservative capture
cone, attenuate mean steering while leaving carrier propulsion untouched. The
gate is recomputed from normalized body-frame target and velocity observations
on every call. Expected result: avoid needless terminal curvature and preserve
forward work, improving arrival or distance integral without changing the
broad route, wake topology, or safety envelope. Falsify if capture is lost,
the `16.932T/2.08513L` reference is not improved, speed or angle contact
returns, or force/moment peaks exceed roughly `0.0370/0.0184`.

bookshelf_consulted: true
source_domain: fish and robotic-fish terminal target capture
source_mechanism: distance-scheduled approach that damps excess yaw or slip without coasting away propulsion
transferable_invariant: once measured motion is positively closing through the capture neighborhood, angular error alone should not demand additional mean curvature
nontransferable_details: published gains, species kinematics, clock phase, exact vortex phase, and prescribed routes
policy_translation: form a continuous safe-intercept gate from body-frame target distance, course error, speed, positive closure, and projected miss; apply it only to posterior mean steering
falsification: reject if it changes the broad route, loses capture or coherent shedding, worsens arrival or mean distance, restores a hard stop, or exceeds inherited load peaks

## Offline gate audit

Replaying only the gate formula over the replicated parent's recorded states
(not CFD and not a claim about the new trajectory) gives zero overlap before
`15.5T`; the first gate value above `0.01` occurs at `15.740T` and `2.213L`.
It reaches one only when projected miss is essentially zero near `16.455T` and
returns continuously with the beat-dependent course geometry. This confirms
that the proposed mechanism is terminal-local on the inherited trace while
remaining able to restore steering whenever the current collision cone is
unsafe.
