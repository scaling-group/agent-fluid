# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
  instability. The motion is self-propelled. Both rows of every combined sheet
  show the same long lower-going trajectory, a coherent alternating top-down
  wake, and discrete three-dimensional caudal Lambda2 structures through the
  approach rather than passive advection.
- The inherited `8 deg` anterior center with bearing-gated posterior relief
  remains the useful base. `solver_c039fddba4d9` reaches `4.233L`, survives to
  `31.87T`, and limits posterior rate-cap occupancy to about `5.0%`, but at its
  `19.25T` closest approach bearing is still `1.405 rad`; it then repeats the
  lower exit. Relief preserves the wake and slows the miss but does not create
  net target-side yaw.
- The assigned prefill's anterior phase-selective residual without posterior
  relief (`solver_50aa935965df`) is an informative failure: it reaches only
  `4.859L`, exits at `28.74T`, and raises posterior rate-cap occupancy to about
  `12.5%`. An anterior redirect is therefore not a substitute for the sampled
  tail relief.
- Combining the anterior residual with relief in `solver_5f29dca2aca2`
  improves the base's minimum distance to `4.018L` and closest-approach bearing
  to `1.333 rad`, with approximately `10.7/5.0%` anterior/posterior rate-cap
  occupancy. This is a narrow orientation benefit, but the large bearing and
  lower-exit topology survive.
- Independently, posterior half-stroke authority redistribution in
  `solver_0d28b65847a0` produces the best minimum distance, `3.909L`, and the
  longest survival, `32.64T`, while retaining the coherent wake and roughly
  `11.3/4.9%` rate-cap occupancy. Its closest-approach bearing is nevertheless
  `1.410 rad`, essentially unchanged from symmetric relief. It improves where
  the fish passes but not where it points.
- The sampled effects are complementary: anterior phase selection improves
  orientation, while posterior phase selection improves closest approach.
  Neither result supports another scalar-only change to curvature, slip, or
  relief, and inherited logs already falsify shared/tail-biased static means
  and direct recent-yaw unloading.

## One candidate hypothesis

Start from the best-distance posterior half-stroke policy and add the sampled
anterior phase-selective residual under the same large-bearing gate. Use
geometric bearing for the slow, reflection-equivariant turn sign and normalized
anterior joint speed as the only phase signal. On the target-producing stroke,
the anterior residual adds work and the tail retains more of its traveling
carrier; on the cancelling return stroke, the anterior residual brakes while
the tail carrier is almost fully relieved. Small bearing continuously restores
the symmetric propulsive gait.

This is one unified whole-body half-cycle authority mechanism rather than a
new mean curvature or gain-only probe. The falsifiable expectation is to retain
the early alternating wake and the `3.909L` approach while reducing bearing
before the miss more than the anterior-only descendant did. Reject it if it
does not beat `3.909L`, closest-approach bearing remains above `1.333 rad`, the
lower-exit topology survives without earlier bearing reduction, either rate-cap
fraction materially exceeds the sampled `10.7/5.0%` envelope, loads spike, or
the coherent three-dimensional wake collapses.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish turning by asymmetric flapping and biological burst redirection
source_mechanism: persistent target error redistributes actuation toward the turn-producing half-cycle while unloading the cancelling half-cycle
transferable_invariant: use observed gait phase and target-relative geometry to make the desired-yaw stroke hydrodynamically stronger than its return stroke, then restore symmetric propulsion on alignment
nontransferable_details: published gains, clock-driven CPG phase, robot linkage geometry, species-specific kinematics, prescribed burst timing, exact vortex phase, and task-specific routes
policy_translation: geometric body-frame bearing gates a target-signed anterior acceleration residual and posterior carrier redistribution; normalized anterior joint rate identifies the two half-strokes
falsification: reject if closest approach fails to beat 3.909L, bearing fails to fall below 1.333 rad before the miss, the lower exit and large-bearing topology persist, saturation or loads worsen, or the alternating wake loses coherence
