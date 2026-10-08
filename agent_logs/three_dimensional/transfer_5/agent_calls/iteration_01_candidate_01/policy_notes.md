# Candidate diagnosis and hypothesis

## Evidence diagnosis

- The only sampled rollout is both the strongest available finite example and
  the informative failure; no inherited optimization log or second evaluated
  solver is present for a cross-candidate visual comparison.
- The evidence is contract-valid: `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. The top-down
  row and oblique Lambda2 row show genuine self-propulsion with a coherent,
  alternating three-dimensional wake rather than passive advection.
- The transferred 2D oscillator is useful in 3D. It reduces head-target
  distance from `12.3277L` to `4.7800L` by `17.85T`; the visible wake remains
  organized while the fish advances.
- The failure is course control after the initial advance. As the target moves
  from a small body-frame bearing to broadside, the fish continues descending,
  regresses to `9.7089L`, and exits the lower virtual boundary at `27.49T`.
  The joints already reach about `27.5/36.3 deg`, and both joint velocities hit
  the `260 deg/T` cap, so more cadence or a scalar drive gain is not supported.
- This rollout does not prove an actuator-sign inversion: the initial
  correct-sign steering transient exists. It instead shows that the existing
  posterior mean-tangent bias plus acceleration-level half-cycle steering does
  not redirect the 3D trajectory soon enough once bearing becomes large.

## Policy hypothesis

Add one smooth, state-triggered C-bend redirect to the retained traveling-wave
oscillator. A normalized body-frame bearing envelope will shift the anterior
oscillator center and posterior tail-tangent target into compatible same-sign
curvature, while reducing oscillatory amplitude during large-error redirect.
As alignment returns, the envelope continuously releases back to the unchanged
propulsive gait. This gives persistent geometric error posture-level authority
without a clock, stage counter, world route, or scalar-only propulsion tuning.

Falsification: reject the mechanism if the evaluated candidate loses the
coherent propulsive wake, reaches joint limits more persistently, fails to
improve the `left_domain` termination/closest approach, or merely delays the
same lower-boundary trajectory without a meaningfully earlier turn toward the
target.

bookshelf_consulted: true
source_domain: biological C-start redirect and robotic-fish mean-curvature steering
source_mechanism: large observed heading error produces bounded body curvature, then releases continuously into the propulsive rhythm as alignment returns
transferable_invariant: persistent direction error needs posture-level curvature authority distinct from the traveling-wave carrier
nontransferable_details: species kinematics, published gains, dimensional frequencies, exact vortex phases, and prescribed maneuver timing
policy_translation: use only normalized body-frame bearing and observed two-joint state to blend the state-feedback oscillator toward a bounded same-sign C-bend with temporary drive-amplitude relief
falsification: reject if progress, termination class, wake coherence, or joint-limit behavior does not improve relative to the sampled direct-still-water seed
