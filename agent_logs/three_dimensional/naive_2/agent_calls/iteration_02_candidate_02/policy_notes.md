# Candidate wake-policy notes

## Evidence diagnosis before editing

- The assigned parent is the fresh-lineage baseline.  Its four inherited
  first-generation notes all diagnosed the drive-only seed's missing target
  feedback and independently proposed bounded mean-curvature steering.  The
  current sample supplies the evaluations that those notes could not yet use:
  the seed plus three of those curvature variants.  All four runs are valid
  direct-uniform still-water releases (`U_infinity=[0,0,0]`), not prewarmed or
  externally advected cases, and all end by crossing the upper virtual-domain
  boundary rather than by numerical instability.
- The drive-only seed (`solver_989ac6cdbb99`) is the informative uncontrolled
  failure.  Its top-down row shows a self-propelled clockwise hook with a
  coherent alternating wake, and the oblique Lambda2 row confirms an organized
  three-dimensional tail wake.  Distance improves from `12.328L` to only
  `12.078L` before ending at `12.380L` at `8.547T`; reconstructed body-frame
  bearing reaches `-1.296 rad`, body lateral speed reaches `0.385U`, both joint
  speeds reach the `260 deg/T` cap, and about one third of each raw acceleration
  history exceeds `1800 deg/T^2`.
- The two variants that recentered the anterior Van der Pol state
  (`solver_6dc885793e9d` and the prefilled `solver_0dbea11d1018`) visibly shed
  much weaker wakes before curling upward.  Their traces bound joint-1 motion
  to only `0.169 rad` and `0.157 rad`, respectively, and they finish near
  `13.45L`, worse than the seed.  This is a concrete negative result: with the
  slow inherited oscillator growth, subtracting an initially saturated
  curvature center removes most of the released joint-state energy and cannot
  be treated as propulsion-preserving steering.
- The strongest finite comparator, `solver_807c205ad607`, leaves the anterior
  oscillator uncentered and applies bounded mean tangent only to the posterior
  target.  Both visual rows retain a substantial alternating three-dimensional
  wake; the fish moves about `1.75L` left and improves mean/final distance to
  `11.567L`/`11.518L`.  That useful carrier-plus-tail separation survives the
  evidence.  It is not target control yet: the fish still exits upward at
  `9.823T`, bearing is `-1.022 rad`, body lateral speed is `+0.562U`, and the
  tail reaches `0.722 rad` while both joint speeds touch their hard limit.
  The target-bearing term remains saturated while the delayed yaw response
  changes sign, so static posterior offset supplies progress but does not shed
  steering authority early enough to prevent overshoot and lateral slip.

## Policy hypothesis

Preserve `solver_807c205ad607`'s untouched anterior state-feedback oscillator,
posterior phase lag, and smooth acceleration envelope, but replace its static
posterior mean-tangent offset with one new turning mechanism: phase-gated
half-cycle amplitude asymmetry.  A bounded body-frame bearing request, reduced
when observed recent yaw already has the requested sign, strengthens the
posterior target on the requested half-cycle and weakens the opposite half.
Because the asymmetry tends continuously to zero at each base-tail crossing,
it should retain the traveling bend without holding the tail at a large static
curvature through alignment.

The first semantic test is remaining inside the upper boundary beyond
`9.823T` while beating `11.512L` closest distance and reducing the large
terminal bearing/lateral slip.  Falsify the mechanism if its initial yaw sign
is wrong, if it attenuates the anterior carrier like the two recentered
variants, if posterior angle/speed residence worsens, or if the same
upper-boundary hook persists without better distance progress.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping or duty-ratio modulation, combined with sensor-driven direction tracking
source_mechanism: retain the propulsive oscillator while selectively strengthening the turn-producing half-cycle and releasing asymmetry when the measured yaw response develops
transferable_invariant: persistent normalized body-frame target error may bias alternating posterior effort without moving the anterior oscillator center or prescribing an external phase
nontransferable_details: published gains, species-specific amplitudes, clocked CPG phase, dimensional beat frequency, exact vortex phase, and task-specific routes
policy_translation: infer posterior beat side from the state-derived lag target, multiply its amplitude by a bounded odd bearing/yaw request, and keep the two-joint carrier and actuator envelope unchanged
falsification: reject if target progress does not beat the tail-bias comparator, the coherent wake collapses, yaw initially moves away from the target, or joint-limit residence and lateral boundary exit persist
