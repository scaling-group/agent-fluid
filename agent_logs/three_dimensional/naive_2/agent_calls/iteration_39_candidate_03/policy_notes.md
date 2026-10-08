# Evidence-constrained multi-wake target-policy candidate

## Visual and completed-evidence diagnosis before candidate selection

- The assigned parent, prefilled solver, and all four sampled solvers contain
  the same policy (SHA-256
  `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`).
  The sampled trajectories and combined keyframe sheets are respectively
  byte-identical as well. Every rollout starts directly from uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot, then
  remains finite through 3019 steps and 237 moving-window shifts. Each
  captures at `16.604496T`, crosses at `0.743958L`, records a scored distance
  integral of `1.998146L`, and scores `-0.113729`. This is one reproducible
  nominal response, not four distinct mechanisms or held-out conditions.
- I inspected the shared top-down and oblique sheets from release through
  capture. The top-down sequence shows the fish accelerating from rest along
  a shallow left/down target-closing arc while forming an alternating
  mid-plane vorticity street connected to the posterior body. The oblique
  sequence shows finite three-dimensional Lambda2 structures connected to the
  active tail and traveled path through capture. Direct zero-flow
  initialization makes the translation self-propulsion rather than passive
  advection. Neither view shows collision, boundary exit, wake breakup,
  instability, or a discontinuity associated with window shifts.
- The trajectory cross-check agrees with that diagnosis. From the first sample
  inside `6.5L`, all 1000 subsequent intervals reduce head distance, with
  finite-difference closure between `0.704` and `1.331 L/T`. Capture occurs
  during active motion at speed `1.132762U` and recent yaw rate
  `2.238745 rad/T`; those endpoint values are not a terminal failure in this
  no-dwell first-crossing task. Peak planar force and moment remain finite at
  about `0.037165/0.018356`, both joint speeds touch the released
  `260 deg/T` envelope, and the existing narrow one-sided speed guard retains
  reversal authority.
- No informative failed keyframe sheet is supplied: all sampled and inherited
  visual artifacts available here reproduce the same successful trace. The
  failure contrast is therefore limited to completed inherited metrics and
  notes. The closest controlled terminal change released up to 35% of
  posterior yaw response under qualified closure and crossed one `0.0055T`
  step earlier, but regressed crossing depth, distance integral, and score
  from `0.743958L/1.998146L/-0.113729` to
  `0.744276L/1.998380L/-0.114037` without meaningful feasibility or load
  benefit. Completed projected-corridor relief, posterior relief,
  line-of-sight-rate, bearing, moment, and local-flow residual variants also
  failed to improve the capture envelope.
- The assigned guidance and inherited optimizer notes document at least three
  consecutive completed iterations with neither a new mechanism nor a
  semantic improvement, so the structured bookshelf review is required. The
  shelf's productive-carrier, route-asymmetry, response-residual,
  wake-rejection, and terminal families are already present in the incumbent
  or delimited by completed negative controls. The duplicate nominal evidence
  exposes no distinct body-frame deficit that selects another primitive.

## Sole candidate and falsifiable policy hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte unchanged as the sole candidate. It preserves the demonstrated
full traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, relative-crossflow
feedback, phase-compatible posterior steering, smooth acceleration bound, and
narrow one-sided joint-speed guard. No scalar-only tuning, new terminal
channel, or sibling candidate is introduced.

This is an evidence-constrained architecture selection, not a claim about the
current worker's unevaluated CFD outcome. Under the same nominal episode, the
candidate should reproduce capture, the target-directed arc, connected
alternating wake in both views, arrival, distance cost, crossing depth, joint
feasibility, effort, force, and moment envelope. Falsify preservation if that
envelope does not reproduce. Reopen one compact bounded body-frame primitive
only after a nonduplicate or held-out pose, target, flow, miss, or dwell test
isolates a persistent response deficit; for terminal control, require measured
head-distance closure to fail for at least a carrier-scale window rather than
overriding uninterrupted progress with an instantaneous proxy.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG steering, wake-interaction control, and prey-capture control
source_mechanism: separate a productive posterior-lagged rhythmic carrier from bounded route, disturbance, and terminal corrections recruited only for an observed response deficit
transferable_invariant: preserve an evidenced traveling carrier while the controlled performance variable continues improving, and add one bounded correction only after state history isolates a persistent error
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, capture schedules, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized two-joint response-demodulated carrier because all supplied samples are one successful trace with uninterrupted measured closure and completed terminal or residual additions regress its capture envelope
falsification: reconsider one bounded body-frame primitive only if a nonduplicate or held-out rollout shows repeatable carrier-scale closure loss, route error, wake disturbance, or feasibility/load excess and the addition improves that deficit without worsening nominal capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment

## Evidence boundary

All favorable and negative results above belong to completed sampled or
inherited evaluations. Formal CFD for this candidate runs only after this
worker exits. Exact nominal repetition demonstrates determinism, not
robustness to a changed pose, target, flow, or imposed wake; the absence of a
failed visual artifact is recorded rather than replaced by a scalar-only
visual claim.
