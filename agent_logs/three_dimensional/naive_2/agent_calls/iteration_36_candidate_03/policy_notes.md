# Evidence-preserving multi-wake target-policy candidate

## Visual diagnosis before candidate selection

- The four sampled solver examples and the prefilled solver use the same policy
  (SHA-256 `452903db...9781`). Their trajectory CSVs and combined keyframe
  sheets are also byte-identical, so they represent one deterministic nominal
  response rather than four controller mechanisms or held-out conditions.
  Every rollout reports direct uniform initialization, still water
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and capture at
  `16.604496T` after 237 moving-window shifts. Each reaches `0.743958L`, has a
  `1.998146L` scored distance integral, and scores `-0.113729`.
- I inspected both rows of the shared sheet from release through capture. The
  top-down row shows self-propelled left/down progress along a shallow
  target-crossing arc and a coherent alternating vorticity street that remains
  connected to the tail. The oblique row shows compact three-dimensional
  Lambda2 structures attached to the posterior body and traveled path. With
  zero imposed flow, this is propulsion rather than advection; neither view
  shows a wake break, storage-shift discontinuity, boundary exit, collision,
  or instability precursor.
- The trajectory cross-check supports the visual diagnosis. Once distance is
  below `6.5L`, all 1,001 logged intervals continue closing, with finite-
  difference closure between `0.704` and `1.331 L/T`. Peak planar force and
  yaw moment are about `0.037165` and `0.018356`, while the existing narrow
  guard permits reversals despite both joints reaching the released
  `260 deg/T` speed envelope. Final speed, heading error, and yaw are therefore
  active-crossing states, not evidence of terminal failure in this no-dwell
  objective.
- No informative failure image exists in the supplied solver examples because
  all four sheets are the same successful trace. The most informative
  completed failure comparison is necessarily metric-level: inherited
  closure-qualified yaw-response release crossed one integration step earlier
  but made the crossing shallower and regressed distance integral and score to
  `0.744276L`, `1.998380L`, and `-0.114037`, without a meaningful feasibility
  or load benefit. Other inherited terminal, target-rate, moment, bearing, and
  local-flow residuals also failed to improve the demonstrated carrier.

## Sole candidate and falsifiable hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as this workspace's one candidate. It retains the evidenced full
traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, relative-crossflow
feedback, phase-compatible posterior steering, smooth acceleration bound, and
narrow one-sided speed guard. The sampled evidence exposes no noncapturing
trajectory or body-frame response deficit that identifies a new channel;
scalar tuning or another terminal/residual combination would confound the
plateau and repeat completed negative families.

The next evaluation should reproduce capture, the shallow target arc,
connected two-view wake, arrival, route cost, crossing depth, joint
feasibility, effort, force, and moment envelope. Falsify preservation if that
nominal envelope does not reproduce. Reopen one bounded state-feedback
primitive only after a nonduplicate or held-out pose, target, or flow isolates
a persistent response deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG steering, wake-interaction control, and prey-capture control
source_mechanism: preserve productive posterior-lagged rhythm and recruit a separate bounded route, disturbance, or terminal correction only for an observed response deficit
transferable_invariant: separate productive rhythmic motion from persistent route error, and do not suppress an evidenced carrier when normalized body-frame response and head-distance history already show uninterrupted capture
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed capture schedules, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized two-joint response-demodulated carrier because all current samples are one successful trace and completed terminal or residual interventions regress
falsification: test one bounded primitive only after nonduplicate or held-out evidence isolates its error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All positive and negative outcomes above belong to completed sampled or
inherited evaluations. This candidate receives CFD evaluation only after this
worker exits, so no same-worker improvement is claimed. The absent failed
sheet is recorded as a limitation rather than replaced by a scalar-only visual
claim, and exact nominal repetition does not establish robustness to changed
pose, target, inflow, or imposed wake.
