# Translational line-of-sight transfer onto axial-response propulsion

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics,
  and capture. The assigned parent is the only axial-response-gated policy.
  It improves the earlier forward-speed-gated carrier from `15.977511T`,
  `1.928580797L` distance integral, 2,905 steps, 238 shifts, and score
  `-0.045506315` to `15.768509T`, `1.924071330L`, 2,867 steps, 232 shifts,
  and `-0.041679331`. It advances every milestone from `6L` through capture,
  although its final crossing distance `0.745725L` is slightly worse and its
  posterior acceleration-limit residence rises from `22.58%` to `23.58%`.
- I inspected the assigned-parent and exact-translational-response combined
  sheets from release through capture. In both top-down rows, the release
  disturbance develops into a coherent alternating wake and the fish follows
  a smooth target-directed arc, so motion is self-propelled rather than
  advection by the zero background flow. Both oblique body/Lambda2 rows retain
  compact paired caudal structures without wake collapse, collision,
  virtual-boundary exit, or out-of-plane instability. Their route differences
  are below sheet resolution; the trace and metrics establish the stronger
  parent's earlier approach. No failed-termination sheet is present in this
  sample, so the lower-value finite capture and inherited logged regressions
  are the informative comparisons rather than a claimed visual failure.
- The three policies without axial-response allocation isolate a terminal
  feedback comparison on the same forward-speed-gated carrier. Replacing only
  the net bearing-rate input with the exact body-frame translational
  line-of-sight rate keeps the same `15.977511T` arrival, milestones, coherent
  wake, and exact limit residence while improving final distance from
  `0.744403L` to `0.744039L`, distance integral from `1.928581L` to
  `1.928275L`, and score from `-0.045506` to `-0.045128`. A windowed
  bearing-minus-turn approximation reaches only `0.744325L`, `1.928515L`, and
  `-0.045425`. This supports the exact kinematic decomposition, not another
  terminal threshold or curvature retune.
- The assigned parent's terminal geometry is materially different and makes
  the transfer nontrivial. Across its 21 samples below `0.9L`, the existing
  net-rate and exact translational-rate tests disagree about reopening on 19;
  the net rate flags 5 samples while translation flags 14. Bearing moves from
  `+0.319` through zero to `-0.112 rad` as body yaw reaches about
  `-4.00 rad/T`, whereas the translational component changes from about
  `-0.028` to `+0.201 rad/T`. Thus the current terminal input aliases body yaw
  with target-relative slip, but the sign support cannot be assumed to match
  the prior route. The candidate must change only feasible terminal action and
  be rejected if this different response topology loses the parent's faster
  capture.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and target-relative terminal approach feedback
source_mechanism: preserve the rhythmic carrier and mean turn while applying bounded residual correction only to the measured response component that worsens the route
transferable_invariant: separate target-relative translational line-of-sight motion from body rotation and carrier yaw, then oppose only translation that increases absolute bearing inside a reliable closing corridor
nontransferable_details: published CPG gains, dimensional frequencies, species-specific kinematics, exact tail or vortex phase, source response scales, fixed burst timing, world coordinates, and task-specific routes
policy_translation: retain the evaluated axial-response-gated posterior wave, anterior oscillator, navigation, yaw residual, approach schedule, mean-first allocation, and actuator projections; replace only the near-capture net bearing-rate input with normalized translational line-of-sight rate computed from body-frame target displacement and body velocity
falsification: reject if capture, the coherent two-view wake, arrival time, pre-corridor milestones, distance integral, final crossing, limiting, or force/moment envelope regresses, or if the branch changes no feasible posterior commands on the assigned-parent trace

## One candidate hypothesis

Produce exactly one candidate by transferring the evaluated exact
translational line-of-sight terminal damper onto the assigned axial-response
parent. For a stationary target, the body-frame cross product of target
displacement and center velocity divided by target distance squared gives the
signed bearing change caused by translation alone. Normalize it by carrier
frequency and use the existing bounded terminal curvature only when that
translation reopens the measured bearing. Body yaw that changes net bearing
does not by itself open this damper.

This is a semantic observation change under an existing terminal envelope,
not a scalar gain sweep. The winning force-response allocation and every
earlier steering, wave-shaping, approach, and actuation role remain unchanged.
The falsifiable expectation is that separating slip from the parent's rapid
terminal yaw preserves its `15.768509T` capture and improves crossing geometry
or distance integral without increasing limiting or loads. Formal CFD remains
post-exit, so no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `650e06ec7aa35c2f4ca73281f99c4819a1f79ad6a395c9450c8fa1fefc19a1b8`.
  Its source diff from the assigned parent contains only the exact
  translational-rate calculation and replacement of the terminal gate/rate
  input; all 52 parameters and the axial-response propulsion branch are
  unchanged.
- Static schema validation resolves all 52 direct `params.FIELD` references
  against exactly 52 fields returned by `target_policy_params()`, with no
  missing or unused field. The lightweight Julia contract returns two finite
  bounded accelerations.
- A deterministic 20,000-pair sweep across target side and distance,
  body-frame velocity and force, bearing/yaw response, and joint phase returns
  finite bounded commands with zero lateral-reflection error. Non-finite
  target, velocity, force, bearing, and yaw observations also return a finite
  fallback action.
- Counterfactual evaluation of the candidate and assigned-parent functions on
  the same reconstructed parent states changes eight posterior commands only,
  over `15.669507-15.708008T` and `0.878876-0.823136L`. Anterior action is
  exactly unchanged; maximum and mean posterior differences are `0.718934`
  and `0.260691 rad/T^2`, and no new acceleration-limit hit appears. This
  establishes feasible, terminal-only, non-clamp-equivalent support without
  predicting the unevaluated closed-loop hydrodynamic response.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were run
  directly and separately: guidance materiality, the lightweight Julia policy
  contract, and solver editable-boundary enforcement all pass. The first
  materiality run exposed and then passed after removal of only the duplicate
  assigned-parent marker in the rendered workspace `README.md`. No CFD was
  run.
