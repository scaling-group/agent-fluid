# Candidate diagnosis and hypothesis

## Rollout evidence

- All sampled and assigned-parent episodes report `uniform_direct`, zero
  background velocity, and direct quiescent initialization, so their motion is
  self-propelled rather than a prewarm or imposed-advection artifact.
- The strongest assigned-parent rollout changes steering from a linear
  bearing/slip residual to body-frame velocity-course error and adds terminal
  predicted-miss counterstroke relief. It comes within `0.903L` at `18.997T`,
  only `0.153L` outside capture, while retaining an alternating wake in both
  the top-down vorticity and oblique Lambda2 sheets. It then continues away to
  `9.034L` and exits the domain at `31.697T`. At closest approach its speed is
  `0.790U`, local flow remains small (mean `0.019U`), predicted miss is
  `0.901L`, closing speed has fallen to `0.053U`, and course error is
  `-1.50 rad`: this is a controlled near miss, not passive drift or wake
  collapse.
- The inherited posterior lag-modulation rollout reaches only `3.532L` and the
  sampled anterior stiffness-asymmetry rollout only `4.859L`; both keep
  alternating three-dimensional wakes but retain the upper-exit topology.
  Broad posterior lag modulation is therefore not enough, while moving
  phase-aware work into anterior restoring dynamics degrades approach and
  raises applied acceleration-limit occupancy.
- The near-miss counterstroke classifier has a sign inconsistency. Over the
  broad-approach interval `5T` to `15T`, anterior angle and yaw moment have
  correlations of `0.90` to `0.94`, with positive angle producing positive
  mean moment and negative angle negative mean moment. Geometry establishes
  that positive turn request requires negative yaw and negative request
  positive yaw. The inherited expression
  `0.5 * (1 - turn_request * phase_side)` instead labels the same-sign
  angle/moment half as opposing: for the near miss's negative request it
  attenuates the useful positive-moment half and preserves the negative one.

## Policy hypothesis

Preserve the evidenced velocity-course controller, zero-centered anterior
oscillator, posterior lag, mean curvature, and terminal predicted-miss gates.
Change only the half-cycle classifier to
`0.5 * (1 + turn_request * phase_side)`, so relief attenuates the measured
same-sign moment that opposes the requested yaw and preserves the useful
opposite-sign moment. This is a reflection-invariant semantic correction, not
a gain change: reversing target side reverses both request and selected phase.
It should retain the `0.903L` approach and alternating wake while supplying the
missing `0.153L` of terminal lateral authority. Falsify it if closest approach
worsens materially, acceleration/velocity limit occupancy rises materially
above the inherited `58/66%` and `6/7%`, wake coherence is lost, or it again
misses capture without a distinct improvement in closest distance or recovery.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and elongated-body reactive propulsion
source_mechanism: cycle-resolved posterior counterstroke relief while the anterior oscillator sustains a traveling bend
transferable_invariant: allocate bounded target-signed corrective work by preserving the posterior half-cycle whose measured reaction has the requested yaw sign and attenuating the opposing half, then release continuously outside the terminal miss corridor
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, exact vortex phases, and experimental routes
policy_translation: use normalized body-frame velocity-course error for turn sign, observed anterior angle for beat side, the rollout-evidenced angle-to-moment sign for useful/opposing classification, and distance/closing/predicted-miss geometry for a smooth terminal gate
falsification: reject if the corrected classifier loses the near-0.903L approach, collapses the alternating three-dimensional wake, materially raises limit occupancy, or does not improve closest distance, recovery topology, or termination
