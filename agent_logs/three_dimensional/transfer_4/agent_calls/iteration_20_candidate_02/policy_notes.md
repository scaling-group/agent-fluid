# Error-conditioned posterior-work phase partition

## Visual and quantitative diagnosis before editing

- I read the assigned-parent guidance and inherited rollout, all four sampled
  policies, scores, observations, metrics, diagnostics, and trajectories, and
  both the top-down vorticity and oblique Lambda2 rows of the combined sheets.
  Every compared episode is a stable capture from direct uniform still water
  with `U_infinity=(0,0,0)`, no prewarm, and no cylinders. The fish visibly
  self-propel from rest. Both views retain the same coherent traveling-wake
  class through capture: an alternating top-down vortex street and compact
  three-dimensional posterior structures, without passive advection, wake
  collapse, collision, or out-of-plane instability. The remaining defect is
  route allocation within a productive gait.
- The combined steering-plus-wave phase guard is the sampled score leader,
  reproduced twice with the same policy hash at score/mean distance
  `-0.064599/1.950823L`. It preserves first-`3T` distance/speed near
  `12.214593L/0.2519U`, but arrives at `18.0125T` on a
  `13.2330L/0.7417L` path/cross-track and has only `0.664/0.068`
  near/final target-course alignment. The closure-qualified unguarded reserve
  captures sooner at `17.8695T` with a tighter `13.0071L/0.6102L` route and
  `0.787/-0.003` near/final alignment, but regresses score/mean distance to
  `-0.072146/1.958037L`. Its two-view wake and peak load class remain similar,
  so neither wake existence nor scalar desaturation explains the ordering.
- The inherited global wave-reference candidate supplies the informative
  negative result missing from the assigned-parent prose. It preserves capture
  and both coherent wake views, advances arrival to `17.8585T`, and contracts
  path/cross-track to `12.9783L/0.5621L`, but weakens first-`3T` speed to
  `0.2469U` and worsens score/mean distance to
  `-0.080637/1.966422L`. Excluding mean steering throughout transit therefore
  repairs part of the route at an unacceptable closure cost.
- The sampled terminal-partition candidate changes the phase reference only
  inside the established `2.10L` approach region, yet its trajectory, arrival,
  score, mean/final distance, and moving-window shift count are exactly those
  of the combined-reference leader. That is a concrete semantic no-op: the
  terminal distance gate does not expose useful reserve-work authority on this
  already closing approach. A useful separator must act earlier than the
  distance handoff while retaining mean-assisted work during material target
  error.

## One policy hypothesis

Start from the reproducible score-leading combined-reference controller and
preserve its anterior state-feedback oscillator, posterior lag and amplitude,
odd body-frame target-to-curvature map, error-qualified route observer,
approach controller, cadence schedule, closure/carrier reserve gate,
half-cycle steering, and reversal-preserving rate governor. Change only the
phase-consistency reference for extra posterior work. Include the full bounded
mean-curvature target while either current body-frame bearing or target-vector
angle lies outside its established centerline band; continuously remove that
mean component as both observed errors center, leaving the zero-mean lagged
wave to qualify reserve work. The actual posterior target and all steering
accelerations remain unchanged.

This target-error partition should retain the leader's useful redirect and
early closure because its initial material error gives full mean-steering
authority, while activating before the terminal distance-only no-op whenever
the route is aligned. Falsify it if capture or first-`3T` closure is lost,
mean distance regresses toward `1.9664L`, path/cross-track fail to improve from
`13.2330L/0.7417L`, the peak force/moment or actuator class rises, reflection
equivariance fails, or either coherent visual wake view degrades.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish coupled oscillators and classical traveling-bend propulsion
source_mechanism: coordinate a bounded mean steering offset with the rhythmic posterior bend during redirect, then separate surplus oscillator work as sensed directional error centers
transferable_invariant: steering offset may assist a target-directed bend while body-frame error is material, but phase-energy admission should return to the zero-mean traveling-wave component once that error contracts
nontransferable_details: published CPG gains, clock phase, dimensional cadence, species-specific envelopes, exact vortex phases, world-frame routes, and task-specific capture geometry
policy_translation: use the existing smooth normalized maximum of absolute body-frame bearing and target-vector angle to interpolate the posterior-work reference between wave-plus-mean curvature and the lagged wave alone, without changing the actual two-joint target
falsification: reject if early or integrated closure regresses, route width does not contract, capture or reflection behavior fails, loads or actuator residence worsen, or either coherent wake view deteriorates

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account, so the checker agent did
  not start. I ran its non-CFD commands locally instead. The guidance check
  first exposed a duplicated assigned-parent marker in the rendered workspace
  `README.md`; removing only that duplicate left the assigned parent unchanged,
  and the check then passed. The solver repository-boundary check also passed.
- Static schema validation finds 60 unique direct `params.FIELD` references,
  all present among the 62 unique fields returned by
  `target_policy_params()`, with no duplicate schema fields. The candidate is
  nonempty and has a policy hash distinct from every sampled and inherited
  candidate. The check-runner's Julia load assertion remains unavailable
  because no `julia` executable is installed in this workspace or shell.
- A focused algebraic check confirms that phase-steering authority is zero at
  centered body-frame error, one at either established centerline boundary,
  strictly interpolated inside, and invariant when bearing and vector angle
  are reflected together. This is a mechanism/contract check, not CFD
  evidence; all rollout predictions remain unvalidated until EvE evaluates the
  candidate after this worker exits.
