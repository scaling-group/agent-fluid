# Evidence-preserving multi-wake target-policy candidate

## Visual and completed-rollout diagnosis before candidate selection

- The four sampled solver examples and the prefilled solver contain the same
  policy (SHA-256 `452903db...9781`). Their trajectory CSVs and their combined,
  top-down, and oblique keyframe sheets are respectively byte-identical. Each
  evaluation reports direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and a finite
  `16.604496T` capture after 3019 steps and 237 moving-window shifts. Each
  crosses at `0.743958L`, records a `1.998146L` distance integral, and scores
  `-0.113729`. The sample is one reproducible nominal response, not four
  controller mechanisms or held-out conditions.
- I inspected both visual rows from release through capture. The top-down row
  shows acceleration from rest, a shallow left/down target-closing arc, and an
  alternating mid-plane vorticity street connected to the tail. The oblique
  row shows compact alternating three-dimensional Lambda2 structures attached
  to the posterior body and traveled path. Zero imposed flow makes the motion
  self-propulsion rather than advection; neither view shows collision, boundary
  exit, wake breakup, a window-shift discontinuity, or numerical instability.
- The trajectory agrees with the visual diagnosis. Peak planar force and yaw
  moment remain finite at `0.037165` and `0.018356`, and both joint speeds stay
  at or below the released `4.537856 rad/T` envelope. Inertial state is also
  continuous across storage transport: `center_world = frame_origin +
  center_local` holds exactly at every logged row, and maximum one-step center,
  head, and distance changes on the 237 shift intervals are no larger than on
  ordinary intervals. Thus the moving-window origin and local-center jumps do
  not identify a physical disturbance or a control opportunity.
- No informative failed visual artifact is supplied: every sampled and
  available inherited sheet is the same capture. The valid changed-control
  contrast is therefore limited to completed inherited metrics and notes. A
  closure-qualified yaw-response release crossed one `0.0055T` step earlier
  but regressed crossing depth, distance integral, and score to
  `0.744276L/1.998380L/-0.114037` without a meaningful feasibility or load
  benefit. Carrier-phase local-flow subtraction, line-of-sight-rate terms,
  bearing and moment residuals, projected-corridor release, and other terminal
  reliefs likewise failed to improve the demonstrated carrier.
- The assigned parent and inherited optimizer logs contain at least three
  consecutive completed selections without a new mechanism or semantic
  improvement, so the structured bookshelf review is required. Its
  traveling-wave, bounded route-asymmetry, disturbance-residual, and terminal
  families are already implemented or have completed negative controls in
  this lineage. The current duplicate nominal trace exposes no new normalized
  body-frame response deficit with which to identify another mechanism.

## Sole candidate and falsifiable hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as the sole candidate. It retains the evidenced full traveling-
wave carrier, raw target geometry and anterior course center, mean-preserving
yaw and lateral-response demodulation, relative-crossflow feedback, phase-
compatible posterior steering, smooth acceleration bound, and narrow one-
sided joint-speed guard. It deliberately ignores moving-window bookkeeping.
No sibling candidate, scalar-only gain edit, or unevidenced terminal or
residual channel is introduced.

This is an evidence-constrained architecture selection, not a same-worker CFD
claim. The next evaluation should reproduce capture, the shallow target arc,
connected wake in both views, arrival, route cost, crossing depth, inertial
continuity through recentering, joint feasibility, action, force, and moment.
Falsify preservation if that nominal envelope does not reproduce. Reopen one
compact body-frame primitive only after a nonduplicate or held-out pose,
target, or flow rollout isolates a persistent physical response deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG direction tracking, wake-interaction control, and prey-capture control
source_mechanism: preserve a productive posterior-lagged rhythm and recruit separate bounded route, disturbance, or terminal feedback only for an observed physical response deficit
transferable_invariant: separate productive rhythmic motion from persistent physical error, and do not alter an evidenced carrier in response to coordinate bookkeeping or already-successful target closure
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed capture schedules, storage-window motion, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized two-joint response-demodulated carrier because every current sample is one successful trace, storage shifts are inertially continuous, and completed terminal or residual additions regress
falsification: test one bounded state-feedback primitive only after nonduplicate or held-out evidence isolates its physical error, and reject it if capture, route cost, crossing depth, wake connectivity, inertial continuity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All favorable and negative outcomes above belong to completed sampled or
inherited evaluations. This candidate is evaluated only after this worker
exits. Exact nominal reproduction does not establish robustness to a changed
pose, target, inflow, imposed wake, or different moving-window implementation;
the absence of a failed image is recorded rather than replaced by a scalar-
only visual claim.
