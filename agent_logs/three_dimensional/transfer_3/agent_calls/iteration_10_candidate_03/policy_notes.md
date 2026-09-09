# Line-of-sight-response distributed-curvature candidate

## Evidence diagnosis recorded before the policy edit

- All sampled diagnostics report direct uniform initialization in still water
  (`U_infinity=(0,0,0)`), no cylinders, and no prewarm. Translation and the
  alternating wakes are therefore self-generated rather than advection or a
  moving-window artifact.
- Both top-down vorticity and oblique Lambda2 sheets were inspected for the
  long line-of-sight-rate near miss (`solver_3b6bd84298a5`), the inherited
  range-damped child (`solver_cf44a7c3b1a7`), and the short upper-exit failure
  (`solver_adc862529891`). The LOS-rate rollout retains a coherent alternating
  street and compact three-dimensional vortex structures through `30.12T`;
  the upper-exit policy generates a coherent but shorter street before leaving
  at `16.77T`. This is a route-control failure, not wake collapse or numerical
  instability.
- The inherited range schedule is a clean negative result. Relative to its
  LOS-rate parent it lowers closest-approach speed from `0.878U` to `0.820U`,
  anterior raw acceleration-envelope occupancy from `57.7%` to `34.2%`,
  force RMS from `0.01488` to `0.01258`, and moment RMS from `0.00770` to
  `0.00659`. Its late top-down street also visibly contracts. Nevertheless it
  slightly worsens closest approach from `3.369L` to `3.392L` and target-line
  crossing from `y=12.893L` to `12.985L`, then repeats the left exit. More
  scalar approach damping is therefore not supported as the missing fix.
- The LOS-rate parent remains the strongest route mechanism: it improves the
  projected-course sample's `4.128L` closest approach to `3.369L`, with local-
  flow RMS only `0.0202U`. But it crosses the target station still about
  `3.39L` high and its posterior command exceeds the raw acceleration envelope
  in `74.0%` of rows. Raising the same posterior curvature limit would mainly
  increase clipping; the remaining hypothesis is actuator allocation.
- Inherited logs also reject response-damped half-cycle strength (tight upper
  curl, `12.072L` minimum) and delayed same-sign C-bends (`4.467L` minimum).
  They identify opposite joint-coordinate yaw polarities: the anterior mean
  bend must oppose the posterior mean bend for both contributions to support
  the same requested yaw.

## Policy hypothesis recorded before editing

Preserve the sampled `28 degree`, `0.55T` state-feedback traveling bend and
the normalized bearing plus rotation-invariant line-of-sight-rate response.
Remove the ineffective range-only damping. Change one mechanism: distribute
the phase-conditioned bounded curvature residual across both oscillator
centers, with a small opposite-sign anterior share and a reduced same-sign
posterior share. The carrier is unchanged at zero residual, while measured yaw
can reverse both shares continuously without a clock, route, or mutable state.

This tests whether the more proximal joint supplies useful yaw authority
before the fish reaches the target station, rather than asking the already
clipped posterior actuator for more curvature.
Expected evidence is the same long coherent wake with a target-line crossing
below `12.893L`, a closest approach below `3.369L`, or a better termination
class. Reject the mechanism if it returns the short upper curl, weakens
propulsion, increases envelope occupancy materially, or repeats the more-than-
`3L` high left pass.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking with mean-curvature steering
source_mechanism: a sensory route residual distributes bounded mean bending across the joints of a persistent rhythmic carrier
transferable_invariant: preserve the traveling wave while allocating reversible steering across available joints according to their observed yaw polarities
nontransferable_details: published gains, robot linkage geometry, dimensional frequency, clock phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame bearing and inertial line-of-sight rotation, then express their phase-conditioned yaw residual as opposite-sign anterior and posterior centers in the two-joint state-feedback oscillator
falsification: reject if the short upper-exit topology returns, wake coherence or propulsion degrades, saturation rises materially, or target crossing and the `3.369L` minimum do not improve
