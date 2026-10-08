# Multi-wake target-policy candidate diagnosis

## Evidence read before candidate selection

- All four sampled solvers satisfy the released experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, finite `capture` termination, and no reported
  numerical instability. Their policy files and numerical trajectories are
  byte-identical. Each captures at `24.310009T` in 4,420 steps, crosses at
  `0.749162L`, has score-metric mean distance `2.223959L`, and scores
  `-0.3251715747`. This is four-way fixed-pose repeatability, not independent
  evidence for robustness.
- The complete top-down sheets show continuous curved translation into the
  target behind an alternating red/blue caudal street, so the fish is
  self-propelled rather than advected or terminally coasting. The complete
  oblique row for `solver_43e27134a723` shows discrete three-dimensional
  Lambda2 structures at `8T`, `16T`, `24T`, and capture. The other sampled
  solvers reproduce the top-down image and numerical trace but their oblique
  rows are blank render artifacts; they are not additional 3D-wake evidence.
- The assigned parent had already established a weaker broad-relief reference
  at `24.326511T`, `0.749329L`, and `2.224097L` mean distance. The sampled
  response-plus-anterior-stroke schedule improves all three measures while
  preserving the documented peak normalized force/moment envelope near
  `0.031649/0.016385` and the coherent carrier wake. The reusable result is
  phase allocation of steering load, not a reason to increase total tail load.
- Inherited optimizer logs supply matched negative controls. Replacing the
  one-step response with two smoother translation/bearing signals captures at
  `24.343010--24.354012T`; narrowing relief with an inferred posterior
  carrier/rudder intersection returns to `24.326511T`; broadening it through
  the lagging posterior phase keeps the crossing step but worsens crossing and
  mean distance to `0.749469/2.224193L`. A separate response-triggered release
  of the additive anterior redirect also regresses to `24.321011T` and
  `2.223987L`. These failures bracket the successful observed anterior
  half-cycle and give no evidence for another fixed-pose terminal gate.

## One candidate hypothesis

Select the prefilled response-plus-anterior-stroke policy unchanged in
executable semantics as the single downstream candidate. It retains the
joint-state traveling carrier, slip-aware anterior center, full-angle
target-gated posterior rudder with the measured load sign, and the bounded 20%
closing-deficit relief only on the smooth target-side anterior half-cycle. The
bookshelf supports preserving the separated carrier and phase-localized
steering allocation, while the completed CFD comparisons—not the source
literature—support declining another sensor, phase-window, or gain change.

Falsify continued reuse if formal evaluation fails to reproduce capture near
`24.310009T`, raises mean distance above `2.223959L`, changes the preterminal
route, or materially worsens wake coherence, saturation, near-target effort,
force, or moment. Even another exact fixed-pose capture would not establish
robustness; a changed initial pose or hydrodynamic condition is the next
informative test and is outside this worker's fixed episode authority.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and half-cycle asymmetric flapping
source_mechanism: preserve a rhythmic propulsive carrier while sensory feedback allocates a bounded steering offset by observed stroke phase
transferable_invariant: separate propulsion from steering and relieve competing posterior mean load only on the measured joint-state half-cycle that improves terminal approach
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional frequencies, duty ratios, prescribed maneuver timing, exact vortex phases, world-frame routes, and fixed-pose performance
policy_translation: retain the normalized closing-deficit gate multiplied by the reflection-equivariant product of target-side sign and anterior joint velocity; do not extend it through inferred phases or replace its response observable after those alternatives regressed in CFD
falsification: reject reuse if capture is later than 24.310009T or lost, mean distance exceeds 2.223959L, early behavior changes, or wake, saturation, effort, force, or moment envelopes worsen
