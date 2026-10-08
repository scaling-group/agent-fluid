# Receding-gated anterior counterstroke brake

## Visual diagnosis and inherited evidence

- All four sampled rollouts and the assigned parent's four completed rollouts
  use direct uniform `U_infinity=(0,0,0)` initialization, with no cylinders or
  prewarm. Their motion and wakes are controller-generated rather than ambient
  advection.
- The sampled `2.989L` response-released carrier gives the strongest useful
  sampled approach. Its top-down row shows a coherent alternating vorticity
  street, its oblique row shows persistent three-dimensional Lambda2 shedding,
  and speed reaches `1.032U` while local flow stays near only `0.02U`. After
  the pass, the anterior rhythm collapses toward zero, the posterior joint
  settles near `-12 deg`, and the fish coasts into the upper boundary instead
  of producing a recovery turn.
- The sampled anterior stiffness-asymmetry rollout is the clearest phase-aware
  failure. It remains visibly rhythmic in both rows, but closest approach
  worsens to `4.859L`, peak speed falls to `0.947U`, and raw acceleration-limit
  occupancy rises to about `54/65%` from the response-released carrier's
  `35/46%`. Its restoring law relaxes the anterior side having the same sign
  as the turn request and stiffens the opposite side. The inherited broad-
  approach calibration associates anterior-joint sign with yaw-moment sign,
  while required yaw has sign opposite the turn request, so that implementation
  favored the measured counter-moment side.
- The assigned parent's later posterior phase-lag, counterstroke-relief,
  receding-coil, and response-gated posterior-allocation rollouts all retain
  the upper-boundary exit. The latest allocation preserves a rhythmic wake and
  the roughly `3L` approach, but final distance worsens to `7.027L`, raw
  acceleration-limit occupancy rises to about `57/67%`, and the post-pass yaw
  rate continues alternating without a net recovery arc. Indirect posterior
  relief therefore does not suppress the anterior counter-moment half-cycle;
  receding motion remains useful only as a detector of the failed pass.

## Policy hypothesis

Preserve the zero-centered anterior oscillator, bounded full-quadrant
bearing-minus-slip mean tail curvature, and complete posterior lag while the
fish is target-closing. When large angular error and body-frame radial
recession coincide, use the sign of observed anterior velocity to identify
motion entering the anterior side that shares the turn-request sign. Apply a
bounded dissipative term only near the oscillator center on that entering
counter-moment stroke. The opposite, measured useful stroke and the posterior
traveling carrier remain unchanged. This should create cycle-resolved yaw
asymmetry without a held bend, a clock, or increased carrier energy, and all
gates release continuously when target closing or alignment returns.

Expected evidence is the unchanged broad-approach wake and roughly `3L`
closest point, followed by smaller counter-moment anterior excursions,
sustained posterior shedding, and a distinct turn that restores radial
closing. Reject the mechanism if it alters early progress, raises limit
occupancy materially, loses the alternating wake, or repeats the upper exit
without a bearing-recovery arc.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: sensor-gated unequal work across the two propulsive half-cycles
transferable_invariant: reduce work on the cycle-resolved side that produces yaw opposite the requested turn while preserving the useful side and the traveling wave
nontransferable_details: published gains, duty ratios, clock phase, linkage geometry, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: derive turn sign from normalized full-quadrant target geometry minus bounded body slip; use body-frame radial closing to isolate the failed pass; use observed anterior joint velocity to damp only motion entering the rollout-calibrated counter-moment side near the joint center
falsification: reject if broad-approach progress or the alternating 3D wake degrades, actuator-limit occupancy rises, or the post-pass bearing and upper-boundary termination topology do not improve
```
