# Translation-qualified posterior-work reserve

## Visual and quantitative diagnosis before editing

- I read the assigned guidance, all four sampled policies, scores,
  observations, metrics, diagnostics, and trajectories, plus the inherited
  notes and rollout for the body-translation qualifier. Every compared rollout
  satisfies the Phase-2 contract: direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders or prewarm, stable dynamics, and
  capture termination. There is no literal termination failure in the current
  sample, so the lowest-quality route/capture states are the informative
  negative controls.
- I inspected the release-to-capture top-down vorticity and oblique Lambda2
  rows for the best-scoring posterior-work sample, the closure-qualified
  prefill, the unqualified energy reserve, and the inherited translation-gated
  reserve. All self-propel from rest, establish a coherent alternating
  mid-plane street, and retain compact three-dimensional posterior structures
  through capture. None shows passive advection, collision, wake breakup, or
  out-of-plane instability. The sheets do not support replacing the traveling
  gait; route state and posterior actuation semantics distinguish the results.
- The assigned closure-qualified amplitude reserve captures at `17.6935T`,
  score `-0.07556104`, mean distance `1.960960L`, center path `12.8750L`, and
  maximum head cross-track `0.457L`; its mean approach and final course
  alignments are `0.881/0.637`, with final yaw `-0.046 rad/T`. The unqualified
  energy reserve improves early mean distance through `3T` from `12.22063L`
  to `12.21444L` and score to `-0.07395193`, but lengthens the path to
  `13.0672L`, increases cross-track to `0.663L`, and ends at only `0.132`
  alignment with `-2.146 rad/T` yaw. Thus extra posterior demand is useful for
  carrier establishment but is not route-neutral.
- The sampled posterior-work reserve preserves the lagged target and injects
  bounded acceleration aligned with measured posterior velocity. It supplies
  the best finite score (`-0.07214640`), best mean distance (`1.958037L`), and
  essentially the unqualified reserve's early distance (`12.21452L` through
  `3T`). Its route perturbation is smaller than the unqualified target-scaling
  reserve but remains material: `13.0071L` center path, `0.610L` maximum
  cross-track, `0.787` mean approach alignment, and almost tangential final
  alignment `-0.003` with `-3.068 rad/T` yaw. Acceleration-ceiling residence
  (`69.74/65.31%`) remains in the existing posterior-priority load class, so
  no desaturation benefit is established.
- The inherited body-center-translation qualifier is a useful semantic
  control. Applied to target-scaling reserve, it is not score-positive versus
  the assigned parent (`-0.07673877`, mean distance `1.962279L`), but it
  captures faster at `17.6495T`, shortens the center path to `12.8363L`,
  reaches `0.899` mean approach alignment, and ends at `0.840` alignment. The
  inherited notes also show that during the first `3T` the head-range
  derivative labels `13.2%` of samples as receding, versus `7.5%` for
  target-projected body-center velocity. This supports changing the progress
  observation, not merely retuning reserve magnitude.

## One policy hypothesis

Use the best sampled posterior-work architecture, but gate its extra work by
normalized target-projected body-center velocity rather than the rotating
head-range derivative. Preserve the anterior phase-plane oscillator,
posterior lag and base emphasis, odd body-frame target-to-curvature mapping,
error-qualified far/middle route observer, approach handoff, cadence scheduler,
half-cycle steering, and reversal-preserving rate governor. Keep the original
range-closure signal only for its separately evaluated cadence path. This is
one observation-semantic correction to a posterior energy-recovery mechanism;
it adds no time, coordinates, target identity, route memory, or mutable state.

Expected evidence is retention of the work reserve's early distance benefit
with a route and terminal state closer to the inherited translation qualifier:
stable capture, a center path below `13.0L`, reduced cross-track, positive
terminal alignment, and the same coherent two-view traveling wake. Falsify the
candidate if early progress falls back to the no-reserve control, capture or
mean distance regresses materially, work authority persists during useful
body translation, route/alignment or acceleration residence worsens, reflection
symmetry fails, or either visual wake view loses coherence.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: reinforce posterior phase-plane work only while locomotor energy and target-directed translation both indicate a propulsion deficit
transferable_invariant: bounded posterior recovery should preserve the traveling-wave target and release continuously once normalized body-frame translation is useful, leaving route steering on a separate feedback path
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, elapsed startup schedules, and task-specific routes
policy_translation: multiply the anterior carrier-energy deficit by a bounded deficit of target-projected body-center velocity, use it only for posterior velocity-aligned work, and retain the established odd two-joint steering and cadence paths
falsification: reject if early closure and distance integral do not improve without route, capture, terminal alignment, actuator-load, reflection, or top-down/oblique wake-coherence regression
