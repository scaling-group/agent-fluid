# Replicated-best response-demodulated carrier candidate

## Visual and metric diagnosis before candidate selection

- All four sampled solvers are byte-identical policy and keyframe repeats. Each
  satisfies the released contract: direct uniform quiescent initialization,
  `U_infinity=(0,0,0)`, zero cylinders, no prewarm snapshot, finite
  moving-window dynamics, and capture. Each reaches `0.743958L` at
  `16.604496T`/3019 steps with score `-0.1137286`, scored distance integral
  `1.998146L`, and 237 moving-window shifts. The replication establishes the
  nominal fixed-case result, not held-out pose or flow robustness.
- I inspected the combined keyframe sheet from release through termination;
  its hash is identical in all four samples. The top-down row shows the fish
  accelerating from still water under its own joint motion, translating left
  and down toward the target, and laying down a coherent alternating
  mid-plane vorticity street through a shallow target-crossing arc. The
  oblique row shows compact alternating three-dimensional Lambda2 structures
  connected to the posterior body and its traveled path. There is no passive
  advection, inherited wake, collision, boundary exit, wake breakup, or
  numerical instability before capture.
- The diagnostics agree with that visual interpretation. The repeated policy
  reaches the released `4.537856 rad/T` joint-speed boundary but stays below
  the `31.415927 rad/T^2` soft acceleration limit; mean absolute requested
  accelerations are `21.733/22.674 rad/T^2`, and peak planar force/moment are
  `0.037165/0.018356`. Its fitted lateral observer is therefore supported as
  a narrow route improvement, not as proof of lower effort or stronger
  actuation authority.
- No sampled semantic failure or distinct weaker visual sheet exists in this
  workspace, so the informative failure comparison comes from completed
  inherited experiments and is limited to their recorded evaluation fields.
  The assigned parent's closure-qualified release of at most 35% of the yaw
  response below `3L` retained capture but regressed from the replicated
  control to score `-0.1140375` and final distance `0.744276L`. A sibling
  closure-deficit phase-compatible redirect, whose offline replay activated
  on only `1.62%` of the control trace, also retained capture but regressed to
  `-0.1142150` and `0.744489L`. Their logs do not provide child keyframes or
  full load histories here, so they cannot support a claim of wake or effort
  improvement. Earlier inherited LOS-rate, bearing-phase, and moment-residual
  additions likewise preserved capture while scoring worse.

## Sole candidate hypothesis

Promote the prefilled phase-demodulated yaw/lateral-response controller as the
workspace's one candidate, byte-identical to all four strongest sampled
solvers. Preserve its full anterior traveling-wave carrier, raw body-frame
target geometry, raw-course anterior center, mean-preserving yaw and lateral
response demodulation, posterior half-cycle steering, smooth acceleration
bound, and final-one-percent one-sided speed guard. Add no terminal hold,
closure-deficit redirect, target-rate feedforward, geometric demodulation, or
moment residual.

This is an evidence-backed selection against the assigned parent rather than a
new unevaluated architecture. The expected result is reproduction of capture,
the connected two-view wake, and the `-0.1137286` nominal score that was better
than both completed terminal descendants. Falsify the selection if the next
evaluation loses capture, changes wake class, or fails to reproduce the
sampled trajectory, distance, joint, action, force, or moment envelope. A
nominal repeat must still not be interpreted as held-out robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric-flapping approach control
source_mechanism: separate a productive rhythmic carrier, raw target-route geometry, and bounded directional-response feedback
transferable_invariant: preserve the evidenced traveling carrier and response separation unless an observed semantic deficit supports recruiting another independently gated control mechanism
nontransferable_details: published gains, species or robot kinematics, dimensional beat frequency, exact vortex phase, approach thresholds, and task-specific routes
policy_translation: retain the sampled normalized body-frame two-joint controller exactly and decline a new terminal primitive after two closure-gated interventions regressed against four replicated captures
falsification: reject this promotion if capture or connected-wake replication fails, or if a held-out pose or flow exposes a directional failure that the retained response channels cannot correct

## Evaluation boundary

No CFD result is claimed for this workspace's candidate. The favorable result
belongs to four completed sampled rollouts, and the terminal negative controls
belong to the assigned parent's and sibling optimizer's completed inherited
logs. Later evaluation should compare semantic capture first, then arrival,
score, scored and observed distance integrals, final crossing depth, trajectory
topology, wake connectivity, joint contact, near-limit residence, requested
action, force, and moment against the exact sampled control. The inherited
terminal children have only scalar/final-distance evidence in this workspace;
their wake and load classes remain unknown.
