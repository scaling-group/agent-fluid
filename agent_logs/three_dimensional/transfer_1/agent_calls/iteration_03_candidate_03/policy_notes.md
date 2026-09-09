# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled rollouts satisfy the frozen initialization contract: direct
  uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Every trajectory is finite and ends `left_domain`; none captures the target.
- The assigned `5c5f9d80447b` parent has the best scalar score (`-10.0272`) and
  improves the inherited response-gated branch from `5.323L` to `3.003L`
  closest approach. Its top-down row shows a persistent alternating vortex
  street as the fish self-propels left, but the fish passes about `3L` above
  the target and continues to the left boundary. The oblique row shows compact
  three-dimensional Lambda2 structures through the turn. This agrees with
  `unstable=false`, a `0.936L/T` maximum speed, and finite force/moment traces:
  the failure is route control, not advection, wake collapse, or instability.
- `1f40fb567c74` contains the strongest useful trajectory even though its score
  is lower. Its achieved-course servo preserves a similarly coherent wake,
  follows a much sharper down-left arc, and reaches `1.0435L` at `18.85T`, only
  `0.2935L` outside capture. It then crosses below the target and reopens to
  `11.216L` before the lower-left exit. At closest approach its speed is about
  `0.849L/T`, target angle is about `+1.24 rad`, achieved course angle about
  `-0.49 rad`, and their mismatch about `1.73 rad`; this is a fast terminal
  miss with unresolved slip, not too little far-field propulsion.
- The trajectory/action cross-check exposes an approach-authority problem.
  The `1f40fb567c74` raw joint acceleration exceeds the `1800 deg/T^2`
  envelope on about `96.9%` of logged steps, including the approach, while its
  speed peaks at `0.930L/T`. The assigned parent also sits at its explicit
  acceleration clamp on about `91.3%` of steps. The inherited guidance already
  rejects scalar-only course-gain escalation and sole static mean curvature;
  both sampled controllers need a semantic separation between cruise thrust
  and terminal steering authority.

## One candidate mechanism

Use the closest-approach achieved-course controller as the scaffold and add one
continuous approach-authority schedule. Preserve its joint-state oscillator,
posterior lag, body-frame target-versus-course error, and direct two-joint
steering. When normalized distance falls from `4L` toward `2L` while measured
closing speed remains positive, reduce oscillator frequency but do not reduce
the steering residual. Smoothly release the relief when the fish is far away
or distance reopens. On the sampled near-miss this begins after the useful
far-field route is established, lowers the carrier near `2.6L` and below, and
gives the saturated course servo more curvature per unit distance without a
clock, route stage, or capture-radius trigger.

Non-CFD signal replay on that sampled trajectory gives approach frequency
factors `1.000` at `4.316L`, `0.737` at `2.617L`, `0.620` at `1.232L`, and
`0.718` at the `1.044L` minimum as windowed closure decays; the factor returns
to `1.000` once distance is reopening. This checks gate selectivity only and is
not evidence that the changed policy will reproduce or improve the trajectory.

Expected test: retain the coherent far-field wake and the `1f40fb567c74`
approach topology, but reduce terminal speed/acceleration clipping enough to
turn the `1.0435L` near miss into a `0.75L` crossing. Falsify the mechanism if
closest approach is worse than `1.0435L`, early distance closure or wake
coherence degrades, the fish coasts before reaching the near gate, terminal
action remains persistently clipped, or the same lower-left departure remains.

## Bookshelf transfer record

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture scheduling
source_mechanism: preserve a propulsive rhythm while near-target closing feedback reduces excess carrier authority and leaves course correction active
transferable_invariant: separate far-field rhythmic propulsion from a continuous near-field regime that reduces excess drive and preserves yaw/slip correction
nontransferable_details: published CPG gains, dimensional cadence, robot or species kinematics, exact vortex phases, capture radius, and any task-specific route
policy_translation: use only normalized distance and windowed closing speed to gate the joint-state oscillator frequency; retain normalized body-frame target-versus-velocity course feedback on both joint accelerations
falsification: reject if early closure or the coherent wake is lost, closest approach exceeds 1.0435L, approach commands remain persistently clipped, or the fish repeats the lower-left terminal departure
