# Response-gated, moment-aligned posterior half-cycle candidate

## Visual diagnosis and inherited evidence

- All four sampled rollouts and the assigned parent's three completed
  rollouts satisfy the frozen experiment contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm. Their
  trajectories and wakes are controller-generated rather than ambient
  advection.
- The `2.989L` sampled prefill is the strongest informative sampled approach.
  Its top-down row shows a coherent alternating vorticity street through the
  approach, and its oblique row shows persistent three-dimensional Lambda2
  structures while speed reaches `1.032U`. Local flow stays near only
  `0.02U`, so the later climb is not passive transport. At the `17.66T`
  closest point, full-quadrant bearing is about `-1.23 rad`; by `22T` it has
  diverged to about `-2.67 rad`, the joints are settling near `(0,-12) deg`,
  and the trajectory hooks into the upper boundary.
- The anterior stiffness-asymmetry rollout is the most informative sampled
  phase-aware failure. Both visual rows retain alternating wake structures,
  but closest approach worsens to `4.859L`, peak speed falls to `0.947U`, and
  raw acceleration-limit occupancy rises to about `53/64%` from the prefill's
  `34/45%`. Continued oscillation alone is therefore not useful when phase
  shaping burdens the anterior carrier and weakens approach.
- The assigned parent's posterior lag modulation, posterior counterstroke
  relief, and receding-gated distributed coil reach `3.532L`, `2.978L`, and
  `2.959L`, respectively, but all retain the upper-boundary termination. The
  latest coil gives a slightly better closest point without semantic recovery:
  at `20--24T` its bearing still diverges from roughly `-1.72` to `-2.71 rad`,
  its joints settle near `(-14,-20) deg`, yaw moment approaches zero, and the
  visible wake diminishes as it climbs out. Target-receding state is a useful
  failure detector, but a held bend is not corrective work.
- The broad-approach traces provide an actuator-sign calibration. Over
  `4--12T`, negative anterior-angle halves have mean yaw moment about
  `-0.0077`, while positive halves have mean yaw moment about `+0.0078`. In
  this convention a positive target turn request needs negative yaw and a
  negative request needs positive yaw. Thus the moment-producing anterior
  half that supports recovery has sign opposite the turn request. The failed
  large-error head offsets instead use the same sign as the request; after the
  high pass they initially allocate curvature toward the measured wrong-way
  yaw and then collapse into nearly static, zero-moment shapes.

## Policy hypothesis

Preserve the zero-centered anterior oscillator, the bounded
bearing-minus-slip mean tail curvature, and the complete lagged carrier during
the evidenced target-closing approach. When large full-quadrant error and
wrong-way measured yaw coincide, use anterior joint angle only as an observed
beat-side marker. Attenuate the posterior traveling component on the half-cycle
whose empirically associated yaw-moment sign matches the turn request (and is
therefore opposite the needed yaw); leave the useful half-cycle at full
strength. This is a posterior-only cyclic allocation: it adds no static head
center, no clock, no hidden mode, and no higher carrier peak. Alignment or a
correct-sign yaw response restores the symmetric traveling wave continuously.

The falsifiable expectation is the same early wake and roughly `3L` approach,
followed by sustained rhythmic shedding and a distinct recovery arc instead
of a held-bend upper hook. Reject the mechanism if early progress changes,
posterior limit occupancy rises materially, alternating shedding collapses,
or bearing still diverges into the rear quadrant without a better termination
class.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: sensor-gated unequal work across the two propulsive half-cycles
transferable_invariant: retain the traveling carrier while reducing only the cycle-resolved work whose measured moment direction opposes the requested yaw, and restore symmetry when yaw response is correct
nontransferable_details: published gains, duty ratios, clock phase, linkage geometry, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: derive turn sign from normalized full-quadrant target geometry minus bounded body slip; derive wrong-way response from body yaw rate; use observed anterior joint angle and rollout-calibrated yaw-moment sign to attenuate only the posterior counter-moment half-cycle
falsification: reject if broad-approach progress or the alternating 3D wake degrades, actuator-limit occupancy rises, or bearing and upper-boundary termination topology do not improve
```
