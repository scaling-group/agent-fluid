# Evidence-preserving multi-wake target-policy candidate

## Visual and completed-rollout diagnosis

- The four sampled solver examples and the prefilled solver contain the same
  policy (SHA-256 `452903db...9781`). Their trajectory files and combined
  keyframe sheets are also respectively byte-identical. Each evaluation uses
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm snapshot; each remains finite for 3019 steps and
  237 moving-window shifts, captures at `16.604496T`, crosses at
  `0.743958L`, records a `1.998146L` scored distance integral, and scores
  `-0.113729`. These artifacts represent one deterministic nominal response,
  not four distinct controller mechanisms or held-out conditions.
- I inspected both rows of the combined sheet from release through capture.
  The top-down row shows acceleration from rest, a shallow left/down
  target-closing arc, and an alternating mid-plane vorticity street connected
  to the tail. The oblique row shows compact alternating three-dimensional
  Lambda2 structures attached to the posterior body and traveled path. With
  zero imposed flow this is self-propulsion rather than advection; neither
  view shows collision, virtual-boundary exit, wake breakup, storage-shift
  discontinuity, or an instability precursor.
- The trajectory cross-check supports the visual interpretation. Distance
  decreases on every logged step inside `6.5L`, including the active final
  beat. At all 237 frame-origin changes,
  `center_world = frame_origin + center_local` holds exactly in both planar
  coordinates. Maximum per-step changes at a recentering are no larger than
  ordinary steps: center `0.006202/0.005406L` versus
  `0.006211/0.005445L`, head `0.007005/0.005407L` versus
  `0.007019/0.005444L`, and distance `0.007275L` versus `0.007320L`.
  The storage transport is therefore not an observed physical disturbance or
  a feedback opportunity in this rollout.
- No informative failed visual artifact is present: every supplied keyframe
  sheet is the same capture. The valid failure contrast is limited to
  completed inherited metrics and notes. A closure-qualified yaw-response
  release crossed one `0.0055T` step earlier but made crossing shallower and
  regressed distance integral and score to
  `0.744276L/1.998380L/-0.114037`, without a meaningful feasibility or load
  benefit. Carrier-phase local-flow subtraction, line-of-sight-rate terms,
  bearing or moment residuals, projected-corridor release, and other terminal
  reliefs likewise failed to improve the established carrier.
- The assigned parent and inherited optimizer logs contain at least three
  consecutive completed selections with neither a new controller mechanism
  nor semantic improvement, so the structured bookshelf consultation is
  required. Its traveling-wave, bounded asymmetry, disturbance-residual, and
  terminal-control families are already implemented or have completed
  negative controls here. The duplicate nominal evidence exposes no new
  normalized body-frame error that can identify another mechanism.

## Sole candidate and falsifiable hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as the sole candidate. It retains the evidenced full traveling-
wave carrier, raw target geometry and anterior course center, mean-preserving
yaw and lateral-response demodulation, relative-crossflow feedback, phase-
compatible posterior steering, smooth acceleration bound, and narrow one-
sided speed guard. It does not react to frame origin or local storage-center
motion, and no sibling candidate, scalar gain edit, or unevidenced terminal or
residual primitive is introduced.

This is an evidence-constrained architecture selection, not a same-worker CFD
claim. The next evaluation should reproduce capture, the shallow target arc,
connected wake in both views, arrival, route cost, crossing depth, joint
feasibility, effort, force, moment, and inertial continuity through window
shifts. Falsify preservation if that nominal envelope fails to reproduce.
Only reopen one compact body-frame primitive after a nonduplicate or held-out
pose, target, or flow rollout isolates a persistent response deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG direction tracking, wake-interaction control, and prey-capture control
source_mechanism: preserve a productive posterior-lagged rhythm and recruit separate bounded route, disturbance, or terminal feedback only for an observed response deficit
transferable_invariant: separate productive rhythmic motion from persistent physical error, and do not suppress or augment a carrier when completed body-frame response and target-distance history already show uninterrupted capture
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed capture schedules, storage-window motion, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized two-joint response-demodulated carrier because every current sample is one successful trace, inherited terminal and residual additions regress, and storage recentering produces no inertial discontinuity to reject
falsification: test one bounded state-feedback primitive only after a nonduplicate or held-out rollout isolates its physical error, and reject it if capture, route cost, crossing depth, wake connectivity, inertial continuity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All positive and negative results above belong to completed sampled or
inherited evaluations. This worker's candidate is evaluated only after exit.
Exact nominal reproduction does not establish robustness to a changed pose,
target, inflow, imposed wake, or a different moving-window implementation.
The absence of a failed image is recorded rather than replaced with a
scalar-only visual claim.
