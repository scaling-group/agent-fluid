# Candidate wake-policy notes

## Visual and numerical diagnosis before candidate selection

- All four sampled rollouts satisfy the released contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm snapshot, finite `capture` termination, and no reported numerical
  instability. The complete top-down sheets show continuous curved translation
  toward the target behind an alternating red/blue caudal street, so the fish
  is self-propelled rather than advected. The complete oblique sheets for the
  phase-qualified parent and broad-relief comparison retain discrete
  three-dimensional Lambda2 structures through capture rather than terminal
  wake collapse. Blank oblique rows in two replicated/variant evaluations are
  render artifacts and are not counted as independent 3D-wake evidence.
- The response-plus-anterior-stroke schedule is the strongest finite sample and
  is reproduced exactly by `solver_43e27134a723` and `solver_c85ef8d2aea3`:
  capture at `24.310009T` in 4,420 steps, crossing at `0.749162L`, score-metric
  mean distance `2.223959L`, and score `-0.325172`. An inherited third
  evaluation of the unmodified schedule reproduces those values exactly. The
  broad closing-deficit relief is weaker at `24.326511T`, `0.749329L`, and
  `2.224097L`; normalized translation-alignment relief is also weaker at
  `24.343010T`, `0.749221L`, and `2.224020L`.
- The inherited optimizer logs bracket the phase mechanism rather than merely
  supplying more scalar comparisons. Requiring a modeled posterior
  carrier/rudder-reinforcement intersection regresses to `24.326511T` and
  `2.224136L`. Extending relief with the lagging posterior joint's observed
  target-side stroke retains the `24.310009T` crossing step but worsens the
  crossing to `0.749469L`, mean distance to `2.224193L`, and score to
  `-0.325466`; its oblique row is blank. Narrowing or broadening the evidenced
  anterior phase interval therefore removes useful authority. Earlier
  whole-stroke rudder boost, recent-yaw unloading, and translation/bearing
  response substitutions are negative controls against adding tail load,
  suppressing the carrier, or replacing the beat-scale response solely for
  smoothness.
- Peak normalized planar force and yaw moment remain about
  `0.031649/0.016385` across the relevant phase schedules, and the best
  candidate's complete two-view sheet preserves the established wake class.
  The fixed-pose gains are only a few control steps and do not establish
  robustness to changed pose or hydrodynamics.

## One candidate hypothesis

Use the prefilled response-plus-anterior-stroke policy unchanged as the single
downstream candidate. Preserve its joint-state traveling carrier, anterior
redirect, target-gated opposite-sign posterior reactive rudder, one-step
closing-deficit response, tested 20% relief ceiling, and smooth target-side
anterior half-cycle qualification. The evidence now supports selection rather
than another architecture change: whole-stroke relief, two normalized
translation-alignment replacements, a narrower inferred carrier intersection,
and a broader lag-aware two-joint phase union all retain capture but are weaker.
The selected law is bounded and reflection equivariant because target-side sign
and anterior joint-rate sign reverse together, and it uses neither time nor
world coordinates.

Falsify continued reuse if a subsequent evaluation fails to reproduce capture
near `24.310009T`, raises mean distance above `2.223959L`, changes the route
before the terminal deficit gate activates, or materially worsens the coherent
wake, saturation, near-target effort, peak force, or peak moment. Further
fixed-pose terminal phase/sensor refinements should be avoided unless a new
measured actuator or hydrodynamic response distinguishes them from the tested
narrowing and broadening failures; changed-pose or hydrodynamic evaluation is
the more informative next axis.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and half-cycle asymmetric flapping
source_mechanism: preserve a rhythmic propulsive carrier while sensory feedback allocates a bounded steering offset by observed stroke phase
transferable_invariant: separate propulsion from steering and relieve competing posterior mean load only on the measured joint-state half-cycle that improves terminal approach
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional frequencies, duty ratios, prescribed maneuver timing, exact vortex phases, world-frame routes, and fixed-pose performance
policy_translation: retain the normalized closing-deficit gate multiplied by the reflection-equivariant product of target-side sign and anterior joint velocity; do not extend it through inferred or lagging phases that regressed in CFD
falsification: reject reuse if capture is later than 24.310009T or lost, mean distance exceeds 2.223959L, early behavior changes, or wake, saturation, effort, force, or moment envelopes worsen
