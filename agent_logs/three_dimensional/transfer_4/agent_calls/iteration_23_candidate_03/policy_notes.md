# Terminal return to symmetric mean-bias steering

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, all sampled policies, scores,
  observations, metrics, diagnostics, and trajectories, and the available
  inherited optimizer notes/results before editing. I inspected both the
  top-down vorticity and oblique Lambda2 rows of the combined keyframe sheets
  for the sampled-best posterior envelope and the informative signed-course
  failure. The evidence is contract-valid: every sampled rollout begins
  directly in uniform still water with `U_infinity=(0,0,0)`, no prewarm, and no
  cylinders.
- All four samples capture. The fish visibly self-propel from rest, retain a
  coherent alternating and advecting top-down wake, and shed compact posterior
  three-dimensional structures through capture. There is no passive
  advection, collision, boundary exit, wake breakup, or out-of-plane
  instability. The useful distinction is therefore trajectory and terminal
  control, not gross wake existence.
- Three samples reproduce the phase-consistent trajectory exactly at
  score/mean distance `-0.064599/1.950823L`, capture `18.0125T`, center path
  `13.2330L`, and head cross-track `0.7417L`. The assigned alignment-qualified
  posterior-wave envelope preserves the far/middle trajectory and both wake
  views while improving score/mean distance to `-0.064545/1.950801L`, reducing
  path/cross-track to `13.2111L/0.7232L`, raising near/final course alignment
  to `0.6722/0.1818`, and lowering near/final absolute yaw to
  `1.8883/0.4200 rad/T`. It remains an energetic crossing: below `2.10L`, mean
  speed is `0.8866U`, mean signed target-course sine is `0.5951`, and yaw still
  swings with the carrier from approximately `+2.48` to `-2.77 rad/T` over
  sampled terminal strokes. Posterior acceleration-ceiling residence remains
  `72.47%` there.
- The sampled signed course-to-curvature residual retains capture and wake but
  regresses score/mean distance to `-0.064645/1.950875L`, lowers final
  alignment to `0.1640`, and increases final absolute yaw to `0.5884 rad/T`.
  Direction-selective posterior half-cycle relief likewise retains capture and
  visible wake but regresses to `-0.065358/1.951413L`, restores final yaw to
  `1.3862 rad/T`, and reduces final alignment to `0.0428`. Completed inherited
  evaluations now add two consistent negatives: mapping signed course to a
  desired yaw-rate reference captures at score `-0.064995`, and holding the
  posterior envelope from course slip captures at `-0.065308` after about
  `0.11T` more than the assigned parent. Course-derived bend, rate-reference,
  and posterior-hold paths therefore do not survive the evidence as the next
  mechanism.

## Single policy hypothesis

Start from the evaluated-best alignment-qualified posterior-wave envelope,
preserving its odd body-frame target-to-curvature map, anterior state-feedback
carrier, posterior lag/emphasis, phase-consistent reserve, far/middle route
observer, mean steering, symmetric terminal posterior relief, and
reversal-preserving rate governor. Change only the allocation of the existing
phase-dependent half-cycle steering multiplier. It currently remains fully
active during approach even as the posterior wave is relieved, so its tail
angle/rate terms continue to modulate both joints' mean steering at carrier
frequency. Continuously fade those phase-dependent terms with normalized
target distance inside the established `2.10L` approach region. The underlying
mean steering request remains fully available and the multiplier is exactly
unchanged outside approach.

This is a return from asymmetric turning strokes toward a symmetric
mean-bias gait during capture, not another gain adjustment or course-error
injection. The authority is `smoothstep(distance_L / approach_distance_L)`, so
it is exactly one throughout far/middle transit and about `0.29` at the sampled
capture boundary; only the deviation of the half-cycle multiplier from one is
faded. Expected evidence is identical pre-approach closure and wake, preserved
capture and sampled-best mean distance, lower carrier-scale yaw variation and
acceleration pressure, and no loss of the parent's path/alignment gains.
Falsify if any pre-approach action changes, capture or score regresses, yaw and
limit residence do not improve, mean steering becomes ineffective, reflection
fails, or either coherent wake view deteriorates.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping for turning and terminal capture staging
source_mechanism: use half-cycle asymmetry to augment a propulsive turn, then return continuously toward a symmetric gait while retaining slower mean steering during close stabilization
transferable_invariant: phase-dependent turning authority and mean curvature are distinct control allocations; when a stable propulsive route is established but carrier-scale yaw persists near capture, reduce only the former while preserving the latter
nontransferable_details: published gains, dimensional cadence, species-specific duty ratios and kinematics, full-body oscillator networks, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: use normalized body-frame target distance to fade only the tail-angle/rate half-cycle terms multiplying the two-joint turn request, leaving the state-feedback traveling wave and odd mean-steering request unchanged
falsification: reject if far/middle actions move, capture or sampled-best distance integral is lost, terminal yaw/path/alignment or limit residence does not improve, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable with this ChatGPT account, so the agent
  could not start. Its material-guidance and repository-boundary commands were
  run directly and pass. The rendered `README.md` initially marked the same
  assigned parent twice; removing only the duplicate marker made the parent
  selection unambiguous without changing the assignment.
- Julia is not installed, so the checker's exact include/action probe cannot
  execute in this shell. The deterministic substitute finds one public
  `target_policy_params`, one public `target_policy`, balanced delimiters, and
  all `62` direct `params.FIELD` references covered by the `64` unique fields
  returned from `target_policy_params`; the two unused fields are the public
  metadata/adapter fields `version` and `control_period`. The candidate is
  nonempty and contains no time, step, random, cylinder-coordinate, file-I/O,
  or mutable-global source.
- Replaying the new distance authority on the sampled-best trajectory makes it
  exactly `1.0` for all `2881` samples at or beyond `2.10L`. It averages
  `0.6718` over the `396` approach samples and reaches `0.2909` at capture.
  An algebraic reflected-state probe flips target request, joint bend, and
  joint rate together: the half-cycle multiplier is unchanged to machine
  precision and the resulting steer changes sign with equal magnitude. These
  are contract and activation checks, not CFD evidence; EvE must evaluate the
  trajectory hypothesis after this worker exits.
