# Evidence-preserving multi-wake target-policy candidate

## Visual and completed-rollout diagnosis before candidate selection

- The prefilled candidate and all four sampled solvers have policy SHA-256
  `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`.
  Their trajectory CSVs and combined keyframe sheets are byte-identical.
  Five distinct completed solver IDs retained in the sampled inherited logs
  have those same policy, trajectory, and keyframe hashes as well. Thus the
  available population is repeated evidence for one nominal response, not
  independent controller mechanisms or held-out conditions.
- Every sampled evaluation reports direct uniform initialization in still
  water, `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Each remains
  finite through 3019 steps and 237 moving-window shifts, captures at
  `16.604496T`, crosses at `0.743958L`, records a scored distance integral of
  `1.998146L`, and scores `-0.113729`.
- I inspected the shared combined sheet from release through capture. The
  top-down row shows acceleration from rest along a shallow left/down closing
  arc and a coherent alternating vorticity street connected to the posterior
  body. The oblique row shows finite three-dimensional Lambda2 structures
  attached to the active tail and traveled path. In zero imposed flow this is
  self-propulsion rather than advection. Neither row shows collision, boundary
  exit, wake breakup, instability, or a moving-window discontinuity.
- The trace supports the visual reading. Although 56 of 3018 early intervals
  briefly increase distance, all 1001 logged intervals after entry inside
  `6.5L` close monotonically. Peak body-frame planar force components and yaw
  moment remain about `0.023226/0.029013` and `0.018356`; both joints touch
  the `4.537856 rad/T` speed envelope without instability. Capture occurs
  during an active crossing, so the final `1.132762U` speed and
  `2.238745 rad/T` recent yaw are not a terminal defect in this no-dwell task.
- No informative failed keyframe sheet exists in the supplied artifacts: all
  sampled and inherited visual sheets are the same successful trace. The
  closest completed controlled failure is therefore metric-level. Releasing
  up to 35% of posterior yaw response under qualified terminal closure crossed
  one `0.0055T` step earlier but worsened crossing depth, distance integral,
  and score from `0.743958L/1.998146L/-0.113729` to
  `0.744276L/1.998380L/-0.114037`, without a meaningful feasibility or load
  benefit. Inherited projected-corridor relief, posterior half-cycle relief,
  line-of-sight-rate, bearing, moment, and local-flow residual variants also
  failed to improve the established capture envelope.

## Sole candidate and falsifiable policy hypothesis

Retain the prefilled normalized body-frame two-joint controller byte-for-byte
as the sole candidate in `solver/`. It preserves the demonstrated full
traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, relative-crossflow
feedback, phase-compatible posterior steering, smooth acceleration bound, and
narrow one-sided joint-speed guard. The current evidence identifies neither a
semantic failure nor a body-frame response deficit for another mechanism to
correct, while the nearby completed interventions regress target cost.

This is an evidence-constrained candidate decision, not a claim about the
current worker's unevaluated CFD result. The expected evaluation is nominal
capture with the same target-directed arc, connected alternating two-view
wake, arrival, distance cost, crossing depth, joint feasibility, effort,
force, and moment envelope. Falsify preservation if that envelope does not
reproduce. Reopen one compact bounded mechanism only after a nonduplicate pose,
target, or flow rollout exposes a persistent state-derived response error.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG steering, wake-interaction control, and prey-capture control
source_mechanism: separate a productive posterior-lagged rhythmic carrier from bounded route, disturbance, and terminal corrections recruited for an observed response deficit
transferable_invariant: preserve an evidenced traveling carrier while measured target distance continues closing, and add one bounded correction only after normalized body-frame observations isolate a persistent error
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, capture schedules, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the existing response-demodulated two-joint controller because all supplied evaluations reproduce one successful nominal trajectory and completed terminal or residual additions regress its capture envelope
falsification: reconsider one bounded body-frame primitive only if a nonduplicate or held-out rollout shows carrier-scale closure loss, route error, wake disturbance, or feasibility/load excess and the addition improves that deficit without worsening nominal capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment

## Evidence boundary

All favorable and negative outcomes above come from completed sampled or
inherited evaluations. Exact repeats establish deterministic nominal behavior,
not robustness to changed pose, target, flow, or imposed wake. The absence of
a failed visual artifact is recorded rather than replaced by a scalar-only
visual claim.
