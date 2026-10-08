# Translation-qualified posterior-work candidate

## Evidence and visual diagnosis before editing

- I reviewed the assigned guidance, the inherited optimizer notes, and all four
  sampled policies, scores, observations, metrics, diagnostics, trajectories,
  and combined keyframe sheets. Every sampled rollout uses direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders or prewarm, remains
  stable, and terminates in capture. `solver_1fb60267421e` and the prefilled
  `solver_2a272b23001c` differ only in their version string and reproduce the
  same trajectory, so they are one deterministic control rather than two
  mechanisms.
- In the release-to-capture top-down vorticity and oblique Lambda2 rows, the
  prefilled closure-qualified amplitude reserve, the energy-only reserve, and
  the best-scoring posterior-work reserve all self-propel from rest, form a
  coherent alternating wake by `4T`, and retain compact three-dimensional
  posterior structures through capture. There is no passive advection, wake
  collapse, collision, or out-of-plane instability. The unresolved defect is
  therefore route-neutral recovery allocation, not wake production or steering
  polarity.
- The velocity-aligned posterior-work sample `solver_dc881bcb1d49` has the
  best score and mean score-distance (`-0.072146`, `1.958037L`) and preserves
  the energy-only reserve's early `0--3T` distance (`12.21452L`). Relative to
  the prefilled closure-qualified amplitude reserve, however, it captures
  later (`17.8695T` versus `17.6935T`), takes a longer center path
  (`13.0071L` versus `12.8750L`), reaches larger cross-track (`0.610L` versus
  `0.457L`), and degrades near/final course alignment (`0.787/-0.003` versus
  `0.881/0.637`) with final yaw `-3.068` rather than `-0.046 rad/T`. Its
  coherent two-view wake and similar force/moment class show that useful early
  work, rather than gross wake quality, carries a persistent course cost.
- The assigned parent log supplies the relevant observation comparison but no
  new CFD claim for this candidate. On the same amplitude reserve, replacing
  single-step head-range closure with target-projected body-center velocity
  shortened capture from `17.6935T` to `17.6495T`, shortened path from
  `12.8750L` to `12.8363L`, and improved approach/final alignment from
  `0.881/0.637` to `0.899/0.840`, while retaining the wake and load class. It
  slightly worsened score, early distance, and maximum cross-track, so the
  observation is a route/arrival trade rather than a universal improvement.
  In the sampled work rollout, the inherited analysis found head-range and
  center-translation progress signs disagree in `17.5%` of samples through
  `3T`; the range derivative also labels receding motion more often
  (`12.3%` versus `7.0%`).

## One policy hypothesis

Preserve the evaluated posterior-work architecture: the anterior phase-plane
oscillator, posterior lag and emphasis, velocity-aligned posterior work sign,
odd body-frame target-to-curvature map, error-qualified far/middle observer,
ordinary approach handoff, cadence, half-cycle steering, and
reversal-preserving governors. Change only the extra work's progress
qualifier. Project normalized body-center velocity onto the normalized
body-frame target vector and smoothly withdraw work as this translation
becomes useful. Keep head-range closing deficit on its separately evaluated
cadence path. This tests observation semantics without a clock, coordinates,
target identity, route memory, or mutable state.

Expected evidence is retention of the work reserve's early and mean-distance
benefit with capture no later than `17.8695T`, shorter path, reduced cross-track,
improved approach/final alignment, and the same coherent two-view wake and
actuator/load class. Falsify the candidate if early progress or score-mean
distance regresses materially, the work gate remains open during useful
translation, route/capture state fails to improve, or reflection behavior,
saturation, force/moment scale, or either visual wake view worsens.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: retain a posteriorly emphasized traveling bend while extra propulsive recovery releases with measured useful translation and remains separate from steering
transferable_invariant: bounded posterior recovery should depend on normalized locomotor state and target-directed body translation, not a yaw-contaminated range transient, while odd body-frame route control remains independent
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, elapsed startup schedules, and task-specific routes
policy_translation: gate only velocity-aligned posterior work with a smooth deficit of body-frame target-projected center velocity; preserve the established cadence, lagged wave target, and steering paths
falsification: reject if early or mean-distance benefit is lost, route and terminal course do not improve, actuator/load class or reflection symmetry regresses, or top-down and oblique wake coherence deteriorates
