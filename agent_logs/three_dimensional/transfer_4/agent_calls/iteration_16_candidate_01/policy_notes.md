# Consensus-qualified posterior-wave reserve

## Visual and quantitative diagnosis before editing

- All four sampled solver examples satisfy the frozen rollout contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no prewarm
  or cylinders, stable dynamics, and capture termination. The assigned parent
  and its version-only sibling reproduce exactly at `17.6935T`, score
  `-0.07556104`, and mean score-distance `1.960960L`; they are determinism
  evidence, not two mechanisms.
- I inspected the release-to-termination top-down vorticity and oblique
  Lambda2 rows for the assigned closure-qualified parent, the best-score
  posterior-work sample, the energy-only reserve, the response-qualified work
  child, and the inherited translation-qualified work failure. Every policy
  self-propels from rest and establishes a coherent alternating mid-plane wake
  with compact three-dimensional posterior structures. The inherited failure
  keeps that wake after passing the target and exiting the domain, so neither
  wake collapse nor weak propulsion explains its termination.
- The closure-qualified parent is the strongest balanced sampled control. It
  captures at `17.6935T` on a `12.8750L` center path with `0.4571L` maximum
  head cross-track, `0.8806` mean approach alignment, `0.6371` final
  alignment, and `-0.0459 rad/T` final yaw. The energy-only wave-target reserve
  improves score to `-0.07395193` but delays capture to `17.9740T`, lengthens
  path/cross-track to `13.0672L/0.6630L`, and finishes at only `0.132`
  alignment with `-2.146 rad/T` yaw. The best-score velocity-aligned work
  reserve similarly improves score to `-0.07214640` but captures at
  `17.8695T` on a `13.0071L/0.6102L` path/cross-track and finishes nearly
  tangentially (`-0.003` alignment, `-3.068 rad/T` yaw). Thus more posterior
  energy is not the supported next mechanism.
- Inherited completed evaluations sharpen the boundary. Qualifying posterior
  work by posterior response energy regresses to `-0.08228241` and `17.9630T`.
  Replacing head-range closure with target-projected center translation on the
  work reserve misses capture at `0.9166L`, then exits at `28.2752T` with
  score `-11.50339` despite a coherent wake. By contrast, inherited logs for a
  translation-qualified wave-target reserve report a faster `17.6495T`,
  shorter `12.8363L` path, and `0.840` final alignment, although its score
  slightly regresses to `-0.07673877`. They also report that the rotating
  head-range derivative labels `13.2%` of the first `3T` as receding versus
  `7.5%` for target-projected center velocity. Translation is therefore useful
  as a conservative semantic check on the bounded target reserve, but unsafe
  as a replacement progress channel for direct posterior work.

## One policy hypothesis

Preserve the assigned parent's anterior phase-plane carrier, posterior lag and
base emphasis, odd body-frame target-to-curvature map, error-qualified
far/middle route observer, approach handoff, cadence scheduler, half-cycle
steering, and reversal-preserving rate governor. Keep its bounded posterior
wave-target reserve rather than adding acceleration-level work. Add one
independent normalized body-frame progress observation: project center
velocity onto the target direction. Convert both the existing head-range
closure signal and this translation signal into bounded no-progress
authorities, then use their minimum as a consensus gate. Extra posterior wave
demand is available only when both observations diagnose deficient progress;
either observation of useful closure releases it continuously. This addresses
head-rotation false positives without allowing the translation channel to
reactivate a stronger work pump after a near miss.

Expected evidence is retention of the parent's early carrier benefit and
coherent two-view wake with fewer course-displacing reserve pulses, capture no
later than the parent's `17.69T` scale, path below `12.88L`, positive terminal
alignment, and no worse actuator/load class. Falsify the mechanism if early
distance falls back to the no-reserve baseline, if capture/score/path regresses,
if either progress channel has the wrong sign or scale, if the reserve remains
active during useful translation, or if reflection symmetry or either wake
view deteriorates.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: retain a posteriorly emphasized traveling bend while measured task feedback continuously releases recovery demand once translation is useful
transferable_invariant: extra posterior demand should require an observed locomotor deficit and remain separate from route steering; redundant normalized progress observations may conservatively veto recovery when either detects useful closure
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, elapsed schedules, and task-specific routes
policy_translation: preserve the bounded lagged-wave target reserve, compute target-projected body-center translation in the body frame, and gate the reserve by the minimum of bounded head-range and center-translation deficit authorities
falsification: reject if early closure disappears, the progress signs disagree systematically, reserve authority persists during useful translation, or capture, score-distance, route directness, terminal alignment, actuator/load class, reflection symmetry, or top-down/oblique wake coherence regresses

## Lightweight validation

- The material-guidance check passes after removing a duplicated assigned-parent
  marker from the rendered workspace `README.md`; no evidence or parent choice
  was changed.
- The non-CFD Julia contract check loads the candidate, materializes every
  parameter, and returns two finite joint accelerations. The repository
  boundary check also passes with only `candidate_target_policy.jl` changed in
  `solver/`.
- On mirrored synthetic body-frame states, the new target-projected translation
  deficit is identical and its sign distinguishes target-directed from receding
  motion. The inherited controller is not globally reflection-equivariant
  because its evaluated positive/negative turn allocation is asymmetric, so
  held-out reflection remains a falsification test rather than a claimed
  property of this candidate.
