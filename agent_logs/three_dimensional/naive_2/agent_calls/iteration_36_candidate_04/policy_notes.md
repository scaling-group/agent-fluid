# Evidence-preserving multi-wake target-policy candidate

## Visual and completed-rollout diagnosis before candidate selection

- The assigned parent, prefilled solver, and all four sampled solvers contain
  the same policy (SHA-256 `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`).
  The four trajectories and both view-specific keyframe sheets are also
  respectively byte-identical. Each evaluation begins from direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm, then
  remains finite through 3019 steps and 237 moving-window shifts. Each
  captures at `16.604496T`, crosses at `0.743958L`, records a scored distance
  integral of `1.998146L`, and scores `-0.113729`. The population therefore
  supplies one reproducible nominal response, not four independent mechanisms
  or held-out conditions.
- I inspected the top-down and oblique sheets from release through capture.
  The top-down frames show acceleration from rest, a shallow left/down
  target-closing arc, and an alternating mid-plane vorticity street connected
  to the posterior body. The oblique frames show finite alternating 3D
  Lambda2 structures along the traveled path and connected to the active tail
  near capture. With zero imposed flow and direct initialization, the motion
  is self-propelled rather than advection. Neither view shows a window-shift
  discontinuity, collision, boundary exit, wake breakup, or instability.
- Trajectory history agrees with the visual diagnosis. Once head distance
  first falls below `6.5L`, all 1001 subsequent logged intervals reduce
  distance; finite-difference closure stays between `0.704` and `1.331 L/T`
  through the first crossing. Capture nevertheless occurs with speed
  `1.132762U`, heading error `0.409227 rad`, recent yaw
  `2.238745 rad/T`, and active joint motion. These instantaneous signals do
  not establish terminal closure loss in a no-dwell first-crossing task.
  Peak planar force and moment remain finite at about
  `0.037165/0.018356`, while the existing narrow one-sided speed guard
  preserves reversal authority at the `260 deg/T` joint-speed envelope.
- No informative failed keyframe sheet is available: every sampled and
  inherited visual artifact supplied here is the same successful trace. The
  valid failure contrast is limited to inherited completed metrics and notes.
  The closest controlled terminal change released up to 35% of posterior yaw
  response under qualified closure; it arrived one `0.0055T` integration step
  earlier but made the crossing shallower and regressed distance integral and
  score from `0.743958L/1.998146L/-0.113729` to
  `0.744276L/1.998380L/-0.114037`, without a meaningful feasibility or load
  benefit. Projected-corridor relief, posterior half-cycle relief,
  line-of-sight-rate, bearing, moment, and local-flow residual variants also
  failed to improve the established capture envelope.
- The assigned guidance and inherited logs report more than three consecutive
  completed iterations with neither a new controller mechanism nor a semantic
  improvement, which triggers the required structured bookshelf review. Its
  carrier, route-asymmetry, response-residual, wake-rejection, and terminal
  families are already represented by the incumbent or completed negative
  controls. The current duplicate nominal trace exposes no new body-frame
  error that identifies another mechanism.

## Sole candidate and falsifiable policy hypothesis

Select the prefilled normalized body-frame two-joint controller unchanged as
the sole candidate in `solver/`. It preserves the demonstrated full
traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, relative-crossflow
feedback, phase-compatible posterior steering, smooth acceleration bound, and
narrow one-sided joint-speed guard. No sibling candidate, scalar-only gain
change, or new terminal/residual channel is introduced.

This is an evidence-constrained architecture selection, not a claim about the
current worker's unevaluated CFD result. The expected evaluation is nominal
capture with the same target-directed arc, connected alternating wake in both
views, arrival, distance cost, crossing depth, feasibility, effort, force, and
moment envelope. Falsify preservation if that envelope does not reproduce.
Reopen one compact bounded primitive only after a completed nonduplicate or
held-out pose, target, or flow rollout exposes a repeatable body-frame response
deficit. For a terminal intervention, require actual head-distance history to
lose closure for at least a carrier-scale window; reject a projected cue that
contradicts uninterrupted measured closure.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG steering, wake-interaction control, and prey-capture control
source_mechanism: separate a productive posterior-lagged rhythmic carrier from bounded route, disturbance, and terminal corrections that are recruited only for an observed response deficit
transferable_invariant: preserve an evidenced traveling carrier while measured target distance continues closing, and add one bounded correction only after state history isolates a persistent error
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, capture schedules, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized two-joint response-demodulated carrier because all supplied samples are one successful trace and completed terminal or residual additions regress its capture envelope
falsification: reconsider one bounded body-frame primitive only if a nonduplicate or held-out rollout shows repeatable carrier-scale closure loss, route error, wake disturbance, or feasibility/load excess and the addition improves that deficit without worsening nominal capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment

## Evidence boundary

All favorable and negative outcomes above come from completed sampled or
inherited evaluations. The current candidate receives formal CFD evaluation
only after this worker exits. Exact nominal repetition demonstrates
determinism, not robustness to changed pose, target, flow, or imposed wake; the
absence of a failed visual artifact is recorded rather than replaced by a
scalar-only visual claim.
