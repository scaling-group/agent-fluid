# Translation-qualified posterior-work candidate

## Evidence and visual diagnosis before editing

- I reviewed the assigned parent guidance, all four sampled policies, scores,
  observations, metrics, diagnostics, trajectories, and combined keyframe
  sheets, plus the inherited reserve notes and the evaluated body-translation
  qualifier. Every referenced rollout uses direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remains stable, and terminates
  in capture.
- In both the release-to-capture top-down vorticity and oblique Lambda2 rows,
  the strongest score sample and the informative reserve controls self-propel
  from rest, form the same coherent alternating wake, and retain compact 3D
  posterior structures through capture. There is no passive advection, wake
  breakup, collision, or out-of-plane instability. The missing capability is
  therefore route-neutral recovery allocation, not wake generation or a new
  steering polarity.
- The prefilled velocity-aligned posterior-work reserve has the best sampled
  score and mean score-distance (`-0.07215`, `1.95804L`) and matches the
  unqualified amplitude reserve's early `0--3T` distance (`12.21452L`). Against
  the closure-qualified amplitude reserve, however, it captures later
  (`17.8695T` versus `17.6935T`), takes a longer center path (`13.0071L` versus
  `12.8750L`), reaches larger cross-track (`0.610L` versus `0.457L`), lowers
  approach alignment (`0.787` versus `0.881`), and ends nearly tangential
  (`-0.003` alignment, `-3.068 rad/T` yaw versus `0.637`, `-0.046 rad/T`). Its
  useful early work therefore carries a persistent course cost that the scalar
  score alone conceals.
- The inherited evaluated amplitude-reserve comparison isolates a useful
  observation change. Replacing single-step head-range closure with
  target-projected body-center velocity shortened capture from `17.6935T` to
  `17.6495T`, path from `12.8750L` to `12.8363L`, raised approach/final
  alignment from `0.881/0.637` to `0.899/0.840`, and kept the same coherent wake
  and actuator-load class. It slightly worsened score (`-0.07556` to
  `-0.07674`), early distance (`12.22063L` to `12.22081L`), and maximum
  cross-track (`0.457L` to `0.531L`), so the observation is a route/arrival
  trade rather than an established universal improvement. In the current work
  rollout, finite-difference head range and body translation disagree on
  progress sign in `17.5%` of samples through `3T`; head range classifies
  receding motion in `12.3%`, versus `7.0%` for center translation.

## One policy hypothesis

Preserve the prefilled anterior phase-plane oscillator, posterior lag and
emphasis, velocity-aligned posterior work injection, odd body-frame
target-to-curvature map, error-qualified far/middle route observer, approach
handoff, cadence, half-cycle steering, and reversal-preserving rate governors.
Change only the work reserve's progress qualifier: project normalized
body-center velocity onto the normalized body-frame target vector and smoothly
withdraw recovery work as that translation becomes useful. Keep the original
head-range closing deficit on its separately evaluated cadence path. This is an
observation-semantic change, not gain tuning, and it uses no clock, coordinates,
route memory, target identity, or mutable state.

Expected evidence is retention of the work reserve's early-distance and mean
distance advantage with capture no later than its `17.8695T` parent, a shorter
path, improved approach/final course alignment, no larger cross-track, and the
same coherent two-view wake and actuator/load class. Falsify the transfer if
early progress or score-mean distance regresses materially, if route or capture
state does not improve, if recovery remains open during useful body
translation, or if saturation, force/moment scale, reflection behavior, or
either wake view worsens.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: retain a posteriorly emphasized traveling bend while extra propulsive recovery releases with measured useful translation and remains separate from steering
transferable_invariant: posterior recovery authority should depend on normalized locomotor state and target-directed body translation, not a yaw-contaminated range transient, while the odd route controller remains independent
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, elapsed startup schedules, and task-specific routes
policy_translation: replace only the posterior work gate's head-range progress deficit with a bounded body-frame target projection of center velocity; preserve the established cadence, work direction, wave target, and steering paths
falsification: reject if early distance, score-mean distance, capture, path, cross-track, terminal alignment, actuator/load class, reflection symmetry, or top-down and oblique wake coherence regress
