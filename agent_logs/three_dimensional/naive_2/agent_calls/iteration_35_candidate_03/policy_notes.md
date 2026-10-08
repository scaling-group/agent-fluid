# Evidence-identifiable multi-wake target-policy candidate

## Visual and rollout diagnosis before candidate selection

- All four sampled candidates are byte-identical to the prefilled policy, and
  their trajectories and combined keyframe sheets are also byte-identical.
  Each direct-uniform, zero-background-flow rollout captures after 237
  moving-window shifts at `16.604496T`, reaches `0.743958L`, has a
  `1.998146L` scored distance integral, and scores `-0.113729`. These samples
  establish a deterministic nominal trajectory class, not four independent
  mechanisms or held-out robustness.
- I inspected both visual rows from release through capture. The top-down
  mid-plane sequence shows self-propelled left/down progress along a shallow
  target-crossing arc, with a coherent alternating vorticity street that grows
  behind the fish without visible breakup. The oblique Lambda2 sequence shows
  compact three-dimensional posterior structures connected to the body and
  traveled path through the final crossing. Direct quiescent initialization
  excludes passive advection or a prewarmed-wake explanation.
- The trajectory agrees with the images: distance falls from `12.327720L` to
  the first-crossing value without instability; peak planar force and yaw
  moment are about `0.037165` and `0.018356`; peak joint speed reaches the
  released `260 deg/T` envelope, while the existing narrow one-sided guard
  retains inward reversal commands. Capture occurs while speed is
  `1.132762U` and recent yaw is `2.238745 rad/T`, which is not a semantic
  defect in this no-dwell task.
- No informative failed visual artifact is present in the sampled evidence.
  The assigned parent and inherited logs provide the nearest controlled
  contrast: qualified terminal yaw-response release crossed one `0.0055T`
  step earlier but worsened crossing depth (`0.744276L`), distance integral
  (`1.998380L`), and score (`-0.114037`) without a meaningful feasibility or
  load benefit. Other completed terminal, line-of-sight-rate, moment,
  bearing, and local-flow residuals likewise failed to improve this carrier.

## Sole candidate and falsifiable hypothesis

Retain the prefilled normalized body-frame controller byte-for-byte as this
workspace's one candidate. It already combines the evidenced posterior-lagged
traveling carrier with target geometry, mean-preserving yaw and lateral
response demodulation, relative-crossflow feedback, bounded phase-selective
posterior steering, smooth acceleration limiting, and the narrow joint-speed
guard. The current evidence exposes no distinct error for another feedback
channel to correct, so changing a scalar or adding terminal control would be
neither identifiable nor supported.

Expected result: reproduce the nominal target-directed arc, connected
two-view wake, capture, route cost, crossing depth, feasibility, and load
envelope. Reject preservation if this candidate does not reproduce capture.
Only reopen a bounded state-feedback primitive after a nonduplicate pose,
target, or flow rollout isolates a repeatable body-frame response deficit;
reject that primitive if it perturbs the demonstrated nominal envelope.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG direction tracking, and wake-interaction control
source_mechanism: preserve a productive posterior-lagged rhythm and recruit a separate bounded route, disturbance, or terminal correction only for an observed response deficit
transferable_invariant: repeated carrier-correlated motion is not itself an error; preserve an evidenced traveling carrier until nonduplicate body-frame observations identify a persistent response deficit
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, fixed capture schedules, wake geometry, and task-specific routes
policy_translation: retain the existing normalized two-joint carrier and response separation exactly because every current sample is the same successful trajectory class and completed residual or terminal interventions regress route cost
falsification: test one new bounded primitive only after nonduplicate or held-out evidence isolates its target error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All numerical and visual results above come from completed sampled or inherited
rollouts. The current candidate is evaluated only after this worker exits, so
no same-worker performance claim is made. Exact nominal repetition supports
determinism but cannot establish robustness to changed pose, target, or flow.
