# Smooth carrier-envelope candidate

## Evidence and visual diagnosis

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and capture at about
  `18.27T`. In both the best-scalar fixed-width-brake sheet
  (`solver_3991cf23285f`) and the continuous-barrier sheets, the top-down row
  shows a target-directed arc with regular alternating vorticity through
  approach; the oblique row retains compact three-dimensional Lambda2
  structures at `12T`, `16T`, and capture. Peak body speed is `1.329U` while
  peak local flow is only `0.03154U`, so the visible motion is self-propelled.
  Preserve the target-ray/velocity-course observation, zero-centered anterior
  oscillator, posterior lag, terminal acceleration allocation, and posterior
  stopping-risk projection.
- Scalar rank alone is misleading. The fixed `8 deg` guard has the best sampled
  score (`-0.247735`) but is the informative mechanical failure: posterior
  angle reaches exactly `-45 deg`, and force/moment peak at
  `0.17183/0.07699`. The continuous stopping-risk family scores
  `-0.248133`, remains near `-43.00 deg`, and holds those peaks to
  `0.03716/0.01907`. The combined sheets cannot resolve the one-step contact;
  aligned joint and load telemetry determines which mechanism is viable.
- The remaining defect is persistent acceleration clipping. The prefilled
  continuous policy requests up to `59.87/88.41 rad/T^2`, versus the owned
  `31.42 rad/T^2` envelope, and downstream applied commands occupy that limit
  for about `51.28/46.40%` of the trace. The sampled in-policy hard-clamp
  variant has the identical score, route, joint extrema, and loads: mirroring
  the downstream clamp makes the public command feasible but does not change
  the physical trajectory or reduce bang-bang occupancy.

## Policy hypothesis written before the solver edit

Retain the complete captured steering and viability structure. Add one
actuator mechanism: a differentiable superelliptic projection of the anterior
oscillator command and the broad-route, unallocated posterior carrier into the
owned acceleration envelope. Leave the already soft-allocated posterior
terminal command unchanged, then apply the existing stopping-risk projection
after the carrier projection so safety braking is not weakened. A final hard
projection remains only as a numerical contract guard.

On the sampled continuous trace, a fourth-order static replay reduces pairwise
acceleration RMS from `36.0657` to `33.9192 rad/T^2` and changes the action by
`4.0436 rad/T^2` RMS. It reduces samples above `99%` of the envelope from
`51.46/47.16%` to `0.00/11.44%`; this replay is only a fixed-state prediction,
not a claim about the unevaluated CFD trajectory. The expected rollout keeps
capture, coherent alternating shedding, the sub-`0.75L` crossing, and the
continuous barrier's load ceiling while reducing exact acceleration-limit
occupancy. Falsify the mechanism if capture or coherent shedding is lost,
arrival or mean distance materially worsens, either joint touches its angle
limit, force/moment exceeds `0.0372/0.0191`, or acceleration occupancy is not
meaningfully below the hard-clipped continuous reference.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG and residual-command control
source_mechanism: retain a low-dimensional propulsive rhythm while bounded feedback shapes only the actuator channel that violates a physical constraint
transferable_invariant: preserve the evidenced traveling carrier and continuously project excessive requested actuation into a feasible envelope instead of replacing the rhythm or relying on persistent downstream clipping
nontransferable_details: published gains, dimensional cadence, CPG clock phase, species-specific envelopes, linkage geometry, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: keep normalized target_body_L and velocity_body_U course feedback plus joint-state phase; smoothly bound the anterior and broad-route posterior carrier commands by the owned acceleration limit, retain terminal posterior reserve allocation, and apply the velocity-conditioned joint barrier afterward
falsification: reject if capture or alternating three-dimensional shedding is lost, distance performance materially worsens, joint contact or prior load spikes return, or applied acceleration-limit occupancy does not fall relative to the sampled hard-clipped continuous controller
```
