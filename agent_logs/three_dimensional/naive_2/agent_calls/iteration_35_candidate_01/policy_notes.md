# Evidence-preserving multi-wake target-policy candidate

## Visual and completed-rollout diagnosis

- All four sampled examples and the prefilled solver contain the same policy
  (SHA-256 `452903db...9781`). Their trajectory files and combined keyframe
  sheets are also respectively byte-identical, so the sample is one
  reproducible nominal response rather than four independent controller or
  wake conditions. Each evaluation reports direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot,
  and finite capture after `16.604496T` and 237 moving-window shifts. Each
  reaches `0.743958L`, records the inherited `1.998146L` distance integral,
  and scores `-0.113729`.
- I inspected the combined sheet from release through capture. The top-down
  row shows acceleration from rest, a shallow left/down target-closing arc,
  and an alternating mid-plane vorticity street that remains connected to the
  tail. The oblique row independently shows compact alternating three-
  dimensional Lambda2 structures attached to the posterior body and traveled
  path. With zero imposed flow, this is self-propulsion rather than advection;
  neither view shows a collision, boundary exit, wake breakup, or instability
  precursor.
- The trajectory strengthens the visual conclusion. Distance decreases on
  every one of the 1,001 logged step intervals inside `6.5L`; finite-
  difference closure remains positive between `0.704` and `1.331 L/T`. Thus
  the final active beat, `1.133U` speed, `0.409 rad` heading error, and
  `2.239 rad/T` yaw coexist with uninterrupted approach and valid first-
  crossing capture. They do not identify excess drive or closure loss in
  this no-dwell objective.
- No sampled or available inherited sheet is an informative failure: every
  available visual artifact is the same successful trace. The valid negative
  contrast is therefore metric-level inherited evidence. A closure-qualified
  yaw-response release crossed one integration step earlier but made crossing
  shallower and regressed distance integral and score to
  `0.744276L/1.998380L/-0.114037`, without a meaningful feasibility or load
  benefit. Local-flow phase subtraction, line-of-sight-rate terms, bearing or
  moment residuals, projected-corridor release, and other terminal reliefs
  likewise failed to improve the demonstrated carrier.
- The assigned parent and inherited optimizer logs contain at least three
  consecutive completed selections with neither a new controller mechanism
  nor semantic improvement, so the structured fish-control bookshelf review
  is required. Its traveling-wave, bounded asymmetry, wake-residual, and
  terminal-control families are already implemented or have completed
  negative controls here. The duplicate nominal evidence exposes no new
  body-frame response deficit that would identify another channel.

## Sole candidate and falsifiable hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as the sole candidate. It retains the evidenced full traveling-
wave carrier, raw target geometry and anterior course center, mean-preserving
yaw and lateral-response demodulation, relative-crossflow feedback, phase-
compatible posterior steering, smooth acceleration bound, and narrow one-
sided speed guard. No sibling candidate, scalar gain change, or unevidenced
terminal/residual primitive is introduced.

This is an evidence-constrained architecture selection, not a same-worker CFD
claim. The next evaluation should reproduce capture, the shallow target arc,
connected two-view wake, arrival, route cost, crossing depth, joint
feasibility, effort, force, and moment envelope. Falsify preservation if the
nominal envelope fails to reproduce. Reopen one bounded primitive only after
a nonduplicate or held-out trajectory isolates a persistent response deficit;
for terminal closure specifically, require disagreement in actual head-
distance history rather than an alternative projected proxy alone.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG direction tracking, wake-interaction control, and prey-capture control
source_mechanism: preserve a productive posterior-lagged rhythmic carrier and recruit separate bounded route, disturbance, or terminal feedback only for an observed response deficit
transferable_invariant: separate productive rhythmic motion from persistent route error, and do not suppress the carrier when completed body-frame response and target-distance history already show uninterrupted capture
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed capture schedules, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized two-joint response-demodulated carrier because all current samples are one successful trace, actual distance closes throughout the terminal region, and completed terminal or residual additions regress
falsification: test one bounded state-feedback primitive only after a nonduplicate or held-out rollout isolates its error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All positive and negative outcomes above belong to completed sampled or
inherited evaluations. This worker's candidate is evaluated only after exit.
Artifact equality demonstrates nominal determinism, not robustness to a
changed pose, target, inflow, or imposed wake. The absence of a failed image
is recorded as an evidence limitation rather than replaced with a scalar-only
visual claim.
