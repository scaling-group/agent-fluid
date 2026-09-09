# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window shifts, and capture. I inspected
  the combined top-down vorticity and oblique body/Lambda2 rows for all four,
  then contrasted them with the inherited posterior-relief `left_domain`
  failure and cross-checked the views against metrics, diagnostics,
  trajectories, executable policies, assigned-parent guidance, and inherited
  optimizer notes.
- The sampled captures are genuinely self-propelled. Their top-down rows grow
  coherent alternating streets from quiescent water and bend toward the
  capture circle; their oblique rows retain compact paired caudal structures.
  The inherited posterior-relief failure also keeps an energetic two-view wake
  but bends down and away, reaches only `3.92476L`, and exits left at
  `26.2130T`. Wake coherence therefore establishes propulsion, not correct
  route allocation.
- The prefilled additive broadside reserve captures at `18.7055T`, mean
  distance `2.09386L`, with `60.84%/73.04%` acceleration contact and
  `10.91%/14.73%` rate contact. Reconstructed normalized body-frame geometry
  shows that its reserve is active on 47 of 3401 rows, beginning at
  `1.5945L`; the smooth gate peaks at `0.1925` when forward/lateral target
  fractions are `0.7613/-0.6484`. By capture they are `0.9827/-0.1851`.
  Thus the outside-saturation reserve is capture-compatible and this trace
  re-aligns the final approach without leaving the established demand/load
  band. It does not by itself attribute that re-alignment to the reserve: the
  inherited exact redistribution carrier without a reserve also captures at
  `18.7110T` with nearly the same forward/lateral terminal fractions
  (`0.9877/-0.1562`). The prefill's mean distance remains inside the
  geometry-carrier band rather than improving the distance integral.
- Two executable-identical common half-cycle envelope-redistribution samples
  capture at `18.8265--18.8815T` and reproduce the best sampled mean-distance
  band, `2.08855--2.08896L`, with the same two-view wake and demand class.
  However, an inherited third execution of that exact policy captures at
  `18.7110T` with mean distance `2.09622L`, and assigned guidance also records
  an executable-equivalent near miss at `0.81206L`. Redistribution is therefore
  a useful bounded allocation hypothesis, not established robustness or demand
  relief.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: large observed direction error gates bounded mean curvature while observed beat side redistributes a common rhythmic envelope without breaking the posterior-lagged traveling wave
transferable_invariant: combine slow normalized body-frame target geometry with joint-displacement phase so redirect authority and useful half-cycle effort can change while the organized propulsive wave and response-based release remain intact
nontransferable_details: published gains, robot geometry, species-specific C-start kinematics, dimensional cadence, prescribed clock phase, duty ratios, exact vortex phase, and task-specific routes
policy_translation: retain the prefilled additive broadside curvature reserve and correcting-yaw release; add the sampled bounded redistribution of existing common amplitude relief between anterior-displacement half-cycles while preserving both target-signed curvature shares and the posterior lag
falsification: reject the composition if capture or either coherent wake row is lost, terminal target re-alignment disappears, mean distance does not improve beyond the geometry-carrier band, or actuator contact and planar loads materially exceed the sampled bands
```

## Single-candidate policy hypothesis

Produce exactly one composition candidate from the prefilled additive
broadside-reserve carrier. Add the parameter-owned common half-cycle relief
redistribution already evaluated in isolation: target-aligned anterior
displacement receives less of the existing rhythmic amplitude relief and the
opposed half-cycle receives more. Keep the mean relief, additive broadside
curvature, target-owned turn sign, anterior/posterior bias ratio,
displacement-only phase steering, one-sided correcting-yaw release, posterior
lag, and exact acceleration projection unchanged.

This is one small compatible mechanism combination, not a scalar carrier
retune. It tests whether the prefill's terminal re-alignment and the sampled
redistribution's far/middle allocation can coexist. No distance stage,
world-frame coordinate, clock, target identity, route memory, velocity-phase
prediction, posterior-only allocation, terminal residual, or rate barrier is
added. Formal CFD occurs only after this worker exits; no improvement is
claimed from same-worker evidence.
