# Evidence-identifiable multi-wake target-policy candidate

## Visual diagnosis before candidate selection

- The four sampled policies, trajectories, and combined keyframe sheets are
  byte-identical. Each is a direct-uniform still-water rollout with no
  cylinders or prewarm, captures at `16.604496T` after 237 moving-window
  shifts, crosses at `0.743958L`, has a `1.998146L` scored distance integral,
  and scores `-0.113729`. The available inherited worker policies have the
  same content and outcome, so this is one deterministically reproduced
  trajectory class rather than evidence from distinct mechanisms or flows.
- I inspected the combined sheet and both view-specific sheets from release to
  capture. The top-down row shows active left/down translation toward the
  target and a coherent alternating vorticity street growing behind the fish;
  the oblique Lambda2 row shows compact posterior three-dimensional structures
  connected to the body and traveled path through target crossing. With zero
  background velocity and direct quiescent initialization, the motion is
  self-propelled rather than passive advection.
- The trajectory and diagnostics agree with the images: distance falls from
  `12.327720L` to capture without instability, while peak planar force and yaw
  moment remain about `0.037165/0.018356`. Over the final seven logged
  intervals, distance decreases monotonically from `0.793405L` to
  `0.743958L` even as recent yaw rises from `1.156930` to
  `2.238745 rad/T`; the large endpoint yaw is therefore carrier-phase motion
  during successful closure, not an observed terminal error.
- No sampled failed visual artifact exists to compare against the successful
  sheets. The closest controlled negative result in the assigned parent and
  inherited logs is a closure-qualified release of up to 35% of posterior yaw
  response: it crossed one `0.0055T` step earlier but worsened crossing depth,
  distance integral, and score to `0.744276L`, `1.998380L`, and `-0.114037`
  without a meaningful feasibility or load improvement. Completed terminal,
  target-rate, moment, bearing, and local-fluid residual variants likewise
  failed to improve the demonstrated carrier.

## Sole candidate and falsifiable hypothesis

Keep the prefilled normalized body-frame controller byte-for-byte as this
workspace's one candidate. It already contains the evidenced posterior-lagged
traveling carrier, mean-preserving yaw and lateral-response demodulation,
target and relative-crossflow steering, bounded phase-selective posterior
relief, smooth acceleration limiting, and the narrow one-sided speed guard.
Neither the repeated nominal capture nor the terminal phase samples expose a
persistent response deficit that could identify a new correction channel.
Changing a scalar, damping the high endpoint yaw, or adding another terminal
gate would contradict the nearest completed controlled comparisons.

Expected result: reproduce the target-directed arc, connected two-view wake,
capture, route cost, crossing depth, joint feasibility, and load envelope.
Reject preservation if this candidate fails to reproduce capture. Reopen one
bounded state-feedback primitive only after a nonduplicate pose, target, or
flow rollout reveals a response deficit that persists beyond carrier phase;
reject it if it changes pre-approach action or worsens capture, route cost,
wake connectivity, feasibility, force, or moment.

bookshelf_consulted: true
source_domain: traveling-wave swimming, sensor-modulated robotic-fish CPG direction tracking, and wake-interaction control
source_mechanism: preserve a productive posterior-lagged rhythm and add bounded route or disturbance control only for an observed persistent response deficit
transferable_invariant: coherent carrier-phase motion is not itself an error; preserve an evidenced traveling wave unless body-frame observations show response loss beyond the oscillation phase
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, fixed terminal schedules, wake geometry, and task-specific routes
policy_translation: retain the existing two-joint carrier and its normalized response separation because the current samples reproduce capture and completed residual or terminal interventions regress route cost
falsification: after nonduplicate evidence isolates a persistent error, test one bounded primitive and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All performance statements above refer only to completed sampled or inherited
rollouts. This worker's candidate is evaluated after exit, so no same-worker
performance claim is made. Exact nominal repeats establish reproducibility,
not robustness to changed pose, target, or flow.
