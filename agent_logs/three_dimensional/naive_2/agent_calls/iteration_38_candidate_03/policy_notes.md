# Evidence-preserving multi-wake target-policy candidate

## Visual and completed-rollout diagnosis before candidate selection

- The four sampled solver examples and the prefilled solver use the same
  policy (SHA-256 `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`).
  Their trajectories and top-down, oblique, and combined keyframe sheets are
  also byte-identical. Each rollout begins with direct uniform initialization
  in still water at `U_infinity=(0,0,0)`, with no cylinders or prewarm
  snapshot, and captures at `16.604496T` after 3019 steps and 237 moving-window
  shifts. Each reaches `0.743958L`, records a `1.998146L` scored distance
  integral, and scores `-0.113729`. These samples are one reproducible nominal
  response, not four distinct mechanisms or held-out conditions.
- I inspected both visual views from release through capture. The top-down
  sheet shows acceleration from rest, a shallow left/down target-closing arc,
  and an alternating mid-plane vorticity street connected to the tail. The
  oblique sheet shows finite, compact, alternating three-dimensional Lambda2
  structures attached to the posterior body and traveled path. With zero
  imposed flow, the translation is self-propelled rather than advected.
  Neither view shows collision, boundary exit, wake breakup, a moving-window
  discontinuity, or an instability precursor.
- The trajectory cross-check makes the terminal interpretation decisive.
  Once head distance is below `6.5L`, every one of the 1,001 logged intervals
  continues closing, with finite-difference closure between about `0.704` and
  `1.331 L/T`. Capture therefore occurs during uninterrupted approach even
  though endpoint speed is `1.132762U`, heading error is `0.409227 rad`, yaw
  rate is `2.238745 rad/T`, and both joints touch the released speed envelope.
  Those active-crossing states do not diagnose excess drive or a hold error in
  this first-crossing, no-dwell task.
- No informative failed visual artifact is supplied: all four sheets are the
  same capture. The valid failure comparison is consequently the completed
  inherited metric evidence. Closure-qualified yaw-response release crossed
  one integration step earlier but made the crossing shallower and regressed
  distance integral and score from `0.743958L/1.998146L/-0.113729` to
  `0.744276L/1.998380L/-0.114037`, without a meaningful feasibility or load
  benefit. Completed projected-corridor, posterior-relief, line-of-sight-rate,
  bearing, moment, and local-flow-residual variants likewise failed to improve
  the demonstrated carrier.
- The inherited guidance and optimizer logs contain more than three completed
  iterations with neither a new controller mechanism nor a semantic
  improvement, so the structured bookshelf review is required. Its
  traveling-wave, bounded-asymmetry, response-residual, and terminal-control
  families are already present or have completed negative controls in this
  lineage. Duplicate nominal evidence exposes no new body-frame error that
  identifies another feedback channel.

## Sole candidate and falsifiable hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as the sole candidate. It retains the evidenced full traveling-
wave carrier, raw target geometry and anterior course center, mean-preserving
yaw and lateral-response demodulation, relative-crossflow feedback, phase-
compatible posterior steering, smooth acceleration bound, and narrow one-
sided speed guard. No sibling candidate, scalar-only retune, or unidentified
terminal/residual mechanism is introduced.

The next evaluation should reproduce capture, the shallow target arc,
connected two-view wake, arrival, route cost, crossing depth, joint
feasibility, effort, force, and moment envelope. Falsify preservation if that
nominal envelope fails to reproduce. Reopen one bounded state-feedback
primitive only after a nonduplicate or held-out pose, target, or flow rollout
isolates a persistent response deficit; for terminal control, require actual
head-distance stalling, recession, or a repeated miss rather than disagreement
in a projected proxy alone.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG steering, wake-interaction control, and prey-capture control
source_mechanism: preserve productive posterior-lagged rhythm and recruit a separate bounded route, disturbance, or terminal correction only for an observed response deficit
transferable_invariant: separate productive rhythmic motion from persistent route error, and do not suppress a carrier while normalized body-frame response and actual head-distance history show uninterrupted capture
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed capture schedules, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized two-joint response-demodulated carrier because all current samples are one successful trace and completed terminal or residual interventions regress
falsification: test one bounded primitive only after nonduplicate or held-out evidence isolates its error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All favorable and negative results above come from completed sampled or
inherited evaluations. This candidate receives CFD evaluation only after this
worker exits, so no same-worker improvement is claimed. Exact nominal
replication does not establish robustness to changed pose, target, inflow, or
imposed wake, and the absent failure sheet is recorded rather than replaced by
a scalar-only visual claim.
