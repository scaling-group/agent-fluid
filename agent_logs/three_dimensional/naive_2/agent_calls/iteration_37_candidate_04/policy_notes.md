# Evidence-preserving multi-wake target-policy candidate

## Visual and rollout diagnosis before candidate selection

- The assigned parent's completed preservation rollout and all four sampled
  solvers use the prefilled policy with SHA-256 `452903db...9781`. The four
  sampled policy files, trajectory CSVs, combined keyframe sheets, and both
  view-specific sheets are byte-identical. Each reports direct uniform still
  water, no cylinders or prewarm, capture at `16.604496T` after 237 moving-
  window shifts, a `0.743958L` crossing, `1.998146L` scored distance integral,
  and score `-0.113729`. The nonidentical summary and metric-file hashes come
  only from evaluation paths, generation/runtime metadata, and wall time, not
  from a different controller or physical trajectory.
- I inspected the shared top-down and oblique sheets from release through
  capture. The top-down row shows self-propelled left/down progress on a
  shallow target-crossing arc and an alternating red/blue wake that remains
  attached to the posterior body. The oblique row shows finite three-
  dimensional Lambda2 structures connected to the tail and traveled path
  through the crossing. With zero imposed flow, the motion is propulsion, not
  advection; neither view shows wake breakup, a recentering discontinuity,
  boundary exit, collision, or instability.
- The trajectory cross-check agrees with the visual evidence: distance falls
  from `12.327720L` to the first-crossing threshold while the full carrier is
  active. Capture occurs with speed `1.132762U`, heading error `0.409227 rad`,
  and recent yaw `2.238745 rad/T`; these are crossing states rather than a
  demonstrated error in a no-dwell task. Inherited diagnostics place peak
  planar force/moment near `0.037165/0.018356`, and the existing narrow speed
  guard preserves reversals despite contact with the released joint-speed
  envelope.
- No informative failed visual artifact is supplied: all four sampled sheets
  are the same successful trace. The closest controlled failure in inherited
  logs and parent guidance is qualified terminal yaw-response release. It
  crossed one integration step earlier but made the crossing shallower and
  regressed distance integral and score to
  `0.744276L/1.998380L/-0.114037`, without meaningful feasibility or load
  benefit. Completed line-of-sight-rate, bearing, moment, local-flow, and
  terminal variants likewise provide no surviving positive mechanism.

## Sole candidate and falsifiable hypothesis

Retain `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as this workspace's one candidate. It preserves the evidenced
posterior-lagged full-wave carrier, raw target geometry and anterior course
center, mean-preserving yaw and lateral-response demodulation, bounded
posterior steering, smooth acceleration limit, and one-sided joint-speed
guard. The supplied evidence exposes no noncapturing trajectory or distinct
body-frame response deficit that identifies another channel. Changing a
scalar or recombining a failed terminal mechanism would treat duplicate
execution metadata as control evidence.

Expected result: reproduce the established shallow capture arc, two-view wake,
arrival, route cost, crossing depth, joint feasibility, and load envelope.
Reject preservation if the nominal envelope does not reproduce. Reopen one
bounded state-feedback primitive only after a nonduplicate or held-out pose,
target, or flow isolates a persistent route, slip, feasibility, or load
deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction control
source_mechanism: preserve a posterior-emphasized traveling bend and recruit separate bounded steering only for an observed directional deficit
transferable_invariant: productive rhythmic motion must be separated from persistent route error before modifying the carrier
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, capture schedules, and task-specific routes
policy_translation: null translation; retain the normalized two-joint response-demodulated carrier because every supplied physical payload is the same successful trace and completed terminal or residual additions regress
falsification: test one new bounded primitive only after nonduplicate evidence isolates its error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All numerical and visual outcomes above belong to completed sampled or
inherited rollouts. The retained candidate receives formal CFD evaluation only
after this worker exits, so no same-worker performance or robustness claim is
made.
