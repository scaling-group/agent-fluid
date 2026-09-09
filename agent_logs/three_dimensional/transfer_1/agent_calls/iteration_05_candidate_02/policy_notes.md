# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations are direct uniform still-water releases with
  `U_infinity=[0,0,0]`, so the observed translation is self-propulsion rather
  than imposed-flow advection. Every rollout remains finite but terminates
  `left_domain`; none supplies a success claim for this worker.
- The assigned parent (`solver_a8af0d71b0de`) is the strongest sampled
  near-pass: `1.2669L` at `18.6945T`, compared with `2.7390L` for the smooth
  half-cycle/cadence-relief failure and `3.0031L`/`3.1135L` for the two
  rate-loop failures. Its top-down and oblique sheets show a coherent,
  alternating self-propelled wake through the broad approach, followed by
  little new terminal wake structure. The trace agrees: speed is still
  `0.7766L/T` at closest approach, while joint motion and commands collapse
  from repeated carrier-scale values near the acceleration bound before
  approach to only order `1--7 rad/T^2` after the miss. It therefore coasts
  below the target and exits the lower boundary, rather than losing the route
  because of a numerical instability or a pre-warm artifact.
- The informative `solver_9cc71cad0aa3` failure retains a visible alternating
  wake and roughly `0.83L/T` translation through its `2.7390L` pass, but the
  distance-conditioned cadence relief and smooth half-cycle bias produce the
  same below-target/lower-exit topology. The higher scalar-score
  `solver_5c5f9d80447b` similarly keeps a coherent wake yet never gets closer
  than `3.0031L`. These comparisons support preserving the carrier and changing
  the terminal steering realization, not another cadence or route-gain edit.

## Policy hypothesis

Retain the parent's normalized, body-frame target-versus-achieved-course servo
and far-field shared-acceleration steering. Replace terminal opposing-half
carrier attenuation with a smooth distance blend into bounded posterior mean
curvature. The posterior target keeps the same joint-state lagged traveling
bend and adds only an odd, target-conditioned mean tangent, so reflection
equivariance is preserved. This should keep generating wake while applying
terminal yaw authority, rather than leaving a fast inertial coast after the
near pass.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning through rhythm offset / mean-curvature modulation
source_mechanism: separate the propulsive rhythm from a bounded slow mean bend used for turning
transferable_invariant: preserve the traveling wave while an observed route error sets an odd bounded mean curvature, then release it continuously as the achieved course aligns
nontransferable_details: published CPG gains, clock phases, robot geometry, species kinematics, dimensional cadence, and task-specific routes
policy_translation: blend the normalized body-frame course residual from shared acceleration into a bounded posterior tail-tangent target inside the evidenced terminal regime; retain the state-feedback carrier and its posterior lag
falsification: reject if the alternating terminal wake still collapses, early distance closure weakens, joint speed or acceleration saturation grows, closest approach does not beat 1.2669L, or the same below-target left_domain topology survives
