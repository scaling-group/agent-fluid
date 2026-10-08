# Velocity-headroom capture candidate

## Evidence and visual diagnosis recorded before the policy edit

- All four sampled rollouts use direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot, and all end in
  capture. The useful contrast is therefore semantic and mechanical rather
  than termination alone. The strongest finite sample is the soft-enveloped
  continuous-barrier policy (`solver_bb2a1c7cb2a0`): it captures at
  `0.747108L` and `16.943T`, versus `0.748232L` and `18.271T` for the prefilled
  fixed-width guard, and improves score from `-0.247735` to `-0.205386`.
- Both combined keyframe sheets show self-propelled target approach. Their
  top-down rows retain an alternating vorticity street through capture, and
  their oblique rows show compact three-dimensional Lambda2 structures shed
  behind the caudal region. Peak local-flow speed is only about `0.032U`,
  compared with peak fish speeds of `1.393U` for the soft envelope and
  `1.329U` for the fixed-width guard, so the faster approach is not ambient
  advection.
- The fixed-width guard is the informative mechanical failure despite its
  capture: posterior angle reaches exactly `-45 deg`, raw acceleration exceeds
  the envelope in `51.3/46.4%` of anterior/posterior samples, and peak planar
  force/yaw-moment coefficients are `0.17183/0.07699`. The sampled continuous
  stopping-risk policy removes angle contact and lowers those peaks to about
  `0.03716/0.01907`, but retains the same raw exceedance burden.
- The soft C1 acceleration shoulder plus the same stopping-risk projection is
  the completed positive result. It keeps posterior angle in
  `[-31.25,33.85] deg`, bounds returned acceleration below about
  `1710 deg/T^2`, and lowers force/moment peaks to `0.03609/0.01766`, while
  capturing sooner. This sharply overturns the inherited failure of the
  aggressive `0.30`-knee demand compressor, which lost thrust and exited left:
  preserve an identity region through `0.80` of the acceleration envelope.
- One hard-envelope interaction remains: anterior/posterior speeds still
  touch `260 deg/T` in about `3.80/3.57%` of samples. On static replay of the
  sampled states, a normalized velocity-headroom projection beginning at
  `0.85` changes only outward acceleration near the speed boundary
  (`8.08/7.17%` of samples) and reduces mean absolute requested acceleration
  by about `3.3/3.8%`; inward recovery, target-course steering, and posterior
  angle braking are unchanged. This replay selects a conservative mechanism
  but is not claimed as new CFD evidence.

## Policy hypothesis

Use the demonstrated soft-envelope capture policy as the carrier, including
its wrapped body-frame target-ray/velocity-course observation, zero-centered
anterior oscillator, posterior lag, terminal steering reserve, and continuous
posterior stopping-risk projection. Add one target-independent velocity
viability layer after ordinary acceleration softening: for each joint, measure
absolute joint speed as a fraction of its owned speed limit and smoothly lower
only the admissible acceleration in the current direction of motion as speed
headroom closes. Apply the posterior angle-margin projection last so it retains
full authority to brake an approaching angle boundary.

The expected signature is capture no later than roughly `17T`, continued
alternating three-dimensional shedding, no angle contact, force/moment peaks no
worse than `0.0361/0.0177`, and materially less occupancy of the `260 deg/T`
joint-speed boundary than the sampled soft-envelope result. Falsify the new
layer if capture, score, or the broad route materially worsens; if speed-limit
occupancy does not fall; if acceleration or angle contact returns; or if wake
coherence or the established load ceiling is lost.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and actuator-constrained rhythmic locomotion
source_mechanism: preserve a low-dimensional propulsive rhythm while bounded sensor feedback modulates only commands that approach an actuator-state boundary
transferable_invariant: retain the evidenced traveling bend and continuously reduce only boundary-directed work as normalized joint-state headroom vanishes, releasing the constraint for inward recovery
nontransferable_details: published gains, species-specific kinematics, dimensional cadence, linkage geometry, clock phase, exact vortex phase, and task-specific routes
policy_translation: keep the sampled two-joint carrier and body-frame course residual; form joint-speed fractions from phi_dot and the owned velocity limit; smoothly cap acceleration in the velocity direction near that limit; leave inward commands and the downstream posterior angle-margin brake intact
falsification: reject if capture or alternating shedding is lost, speed-limit occupancy does not improve, posterior contact returns, or force and yaw-moment peaks exceed the sampled soft-envelope baseline
```
