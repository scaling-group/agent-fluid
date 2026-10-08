# Wake-policy candidate notes

## Evidence diagnosis

All four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=[0,0,0]`, no prewarm) and terminate in capture. The three v21
samples are executable-equivalent replicas: their combined-keyframe hashes,
trajectories, `23.8755T` arrival, and `2.4357L` scoring mean distance are
identical. In both visual rows the fish accelerates itself from rest, retains a
coherent alternating top-down wake with three-dimensional Lambda2 structures,
and curves smoothly toward the target; neither advection nor wake collapse is
the active defect. The sampled set contains no domain-exit or unstable visual
failure. The informative weakness is therefore the v21 capture's approach
history, cross-checked against the inherited failed routes: inside `2.1L`, mean
absolute yaw remains `1.558 rad/T`, `76.3%/69.6%` of anterior/posterior commands
exceed 80% of the acceleration scale, and both joints reach the velocity cap.
Earlier opposite-sign static-posture replacements destroyed this useful
carrier and exited upward, so the traveling wave and same-sign C-bend must stay.

The distinct v22 terminal excess-yaw amplitude-relief sample preserves the
same visible trajectory and wake. Its score changes from `-0.5377627` to
`-0.5374625`, but capture is `0.0055T` later, near-target mean absolute yaw
changes only from `1.5575` to `1.5570 rad/T`, peak yaw only from `2.9489` to
`2.9486 rad/T`, and high-command/high-speed exposure is effectively unchanged.
That mechanism is not a semantic improvement and is not inherited here.

## Policy hypothesis

Keep the evaluated v21 carrier, target-derived same-sign redirect, response
release, and fourth-order command envelope unchanged outside the approach.
Inside `2.1L`, continuously blend to residual-priority command allocation:
smoothly bound the target-steering residual, give it first claim on a small
fraction of each joint's physical acceleration envelope, and fit the oscillator
into the remaining component-wise headroom. This changes allocation rather
than cadence or curvature gains. It should retain capture and the coherent wake
while making steering effective on saturated half-cycles and reducing approach
yaw or velocity/command-limit exposure. Falsify it if capture/wake coherence is
lost, if `23.875T`/`2.4357L` materially regress without a yaw/limit/load gain,
or if the histories show that reserved residual authority does not change the
approach topology.

bookshelf_consulted: true
source_domain: robotic-fish CPG path following and residual control
source_mechanism: preserve a low-dimensional rhythmic gait while applying bounded feedback through a separate residual channel
transferable_invariant: propulsion and target correction need explicit authority allocation when their summed command meets a shared actuator envelope
nontransferable_details: published CPG gains, oscillator phases, species kinematics, dimensional frequencies, and task-specific paths
policy_translation: use normalized body-frame distance and target-derived steering demand to blend from the retained two-joint carrier to residual-priority acceleration headroom near the target
falsification: reject if capture or alternating-wake coherence regresses, or if approach yaw and limit exposure do not improve enough to offset any arrival or distance cost
