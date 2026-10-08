# Evidence-preserving multi-wake target-policy candidate

## Visual and completed-rollout diagnosis before candidate selection

- The assigned parent, prefilled solver, and all four sampled solvers use the
  same policy (SHA-256
  `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`).
  The sampled trajectory CSVs and combined keyframe sheets are also
  respectively byte-identical. Each rollout starts directly from uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm; each
  remains finite for 3,019 steps and 237 moving-window shifts, captures at
  `16.604496T`, crosses at `0.743958L`, records a `1.998146L` distance
  integral, and scores `-0.113729`. These are deterministic repetitions of one
  nominal controller and trajectory class, not independent mechanism or
  held-out tests.
- I inspected the common combined sheet and both view-specific sheets from
  release through capture. The top-down frames show active left/down progress
  along a shallow target-crossing arc and an alternating mid-plane vorticity
  street connected to the posterior body. The oblique frames show finite
  three-dimensional Lambda2 structures connected to the active tail and
  traveled path. Zero imposed flow and direct initialization establish
  self-propulsion rather than passive advection. Neither view shows wake
  breakup, a moving-window discontinuity, collision, boundary exit, or an
  instability precursor.
- The trajectory cross-check supports the visual reading. After first entering
  `6.5L` at `11.104500T`, all 1,000 subsequent logged intervals reduce head
  distance, with finite-difference closure between `0.704` and `1.331 L/T`.
  The capture sample still has speed `1.132762U`, heading error
  `0.409227 rad`, and recent yaw `2.238745 rad/T`; these are carrier-phase
  states during uninterrupted first-crossing closure, not an observed terminal
  deficit. Peak planar force norm and yaw moment remain about
  `0.037165/0.018356`, and both joint speeds touch the released
  `4.537856 rad/T` limit while the existing one-sided guard preserves reversal
  authority.
- No informative failed visual artifact is supplied: every sampled and
  inherited worker sheet available in this workspace is the same successful
  trace. The valid failure contrast is therefore metric-level evidence from
  the assigned guidance and inherited optimizer notes. The nearest changed
  control released up to 35% of posterior yaw response under qualified
  terminal closure; it crossed one `0.0055T` step earlier but made the crossing
  shallower and regressed distance integral and score to
  `0.744276L/1.998380L/-0.114037`, without a meaningful feasibility or load
  benefit. Projected-corridor relief, posterior half-cycle relief,
  line-of-sight-rate, bearing, moment, and local-flow residual variants also
  failed to improve the established capture envelope. Their missing keyframe
  sheets do not support a visual wake comparison.
- The assigned guidance and inherited completed logs show more than three
  consecutive selections with neither a new controller mechanism nor a
  semantic improvement, so the requested stagnation-triggered bookshelf review
  applies. The shelf's traveling-wave carrier, target-curvature, half-cycle,
  response-residual, wake-rejection, and terminal families are already
  represented by the incumbent or completed negative controls. The current
  duplicate capture exposes no persistent body-frame error that identifies a
  new mechanism.

## Sole candidate and falsifiable policy hypothesis

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as this workspace's single candidate. It preserves the evidenced
full traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, relative-crossflow
feedback, phase-compatible posterior steering, smooth acceleration bound, and
narrow one-sided joint-speed guard. No sibling candidate, scalar-only gain
change, or new terminal/residual channel is introduced.

The expected formal evaluation is the same target-directed capture arc,
connected alternating wake in both views, arrival, route cost, crossing depth,
joint feasibility, effort, force, and moment envelope. Falsify this preservation
decision if nominal capture does not reproduce. Reopen one compact bounded
primitive only after a completed nonduplicate pose, target, or flow rollout
isolates a persistent body-frame response deficit; for terminal action, require
measured head-distance history to lose closure over a carrier-scale interval
rather than trusting an instantaneous motion state or conflicting projection.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG steering, wake-interaction control, and prey-capture control
source_mechanism: separate a productive posterior-lagged rhythmic carrier from bounded route, disturbance, and terminal corrections recruited only for an observed persistent response deficit
transferable_invariant: preserve an evidenced traveling carrier while measured target distance continues closing, and add one bounded correction only when state history isolates a persistent error
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, fixed capture schedules, wake geometry, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized two-joint response-demodulated carrier because every supplied sample is the same successful trace and completed terminal or residual additions regress its capture envelope
falsification: reconsider one bounded body-frame primitive only if a nonduplicate or held-out rollout shows carrier-scale closure loss, route error, wake disturbance, or feasibility/load excess and the addition improves that deficit without worsening nominal capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment

## Evidence boundary

All performance statements above refer to completed sampled or inherited
rollouts. This worker's candidate receives CFD evaluation only after exit, so
no same-worker improvement is claimed. Exact nominal repetition demonstrates
determinism, not robustness to changed pose, target, flow, or imposed wake; the
absent failed visual artifact is recorded instead of replaced by a scalar-only
visual claim.
