# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts use the required direct uniform still-water
  initialization (`U_infinity=(0,0,0)`), no cylinders, and no prewarm. The
  motion in both the top-down vorticity and oblique Lambda2 rows is therefore
  self-propelled rather than advection. Each policy develops a coherent curved
  posterior wake and then exits the upper virtual boundary; none captures the
  target or changes the termination class.
- The target-blind seed improves distance from `12.3277L` to `12.0694L`, then
  exits at `8.5965T` with final distance `12.3647L`. Its bearing crosses from
  `+0.155 rad` to about `-1.26 rad`, and both joint rates reach the
  `260 deg/T` limit. The inherited parent correctly identifies a useful
  traveling-bend carrier but missing route control.
- The three target-curvature descendants falsify mean bias as a sufficient
  architecture. Additive two-joint acceleration bias reaches only `12.2349L`
  and exits at `8.7285T`; equal curvature centering damps both joint rhythms
  almost to static `-0.174 rad` bends and worsens final distance to `13.4234L`;
  posterior-only mean curvature is the best scalar result (`12.0564L`
  minimum, `12.2073L` final) but still exits at `9.1465T`.
- In that best posterior-only rollout, the combined sheets retain an
  alternating 3D wake and somewhat more targetward translation, but the body
  still turns away before drawing materially closer. The trace explains why:
  instantaneous heading rate spans roughly `-2.82` to `+2.17 rad/T`, dominates
  `bearing + 0.30*heading_rate`, and drives both joint rates to their limits.
  This is stroke-scale yaw chatter inside a nominal mean-turn command, not
  evidence of a stable yaw-release signal. By contrast, body-relative
  crossflow changes sign consistently with developing lateral slip: around
  `3.95T`, bearing is still `+0.060 rad` while relative crossflow is about
  `-0.219U`, providing an earlier continuous release cue before the bearing
  crosses.

## Single candidate hypothesis

Restore the seed's unchanged anterior oscillator and zero-mean posterior lag,
then replace static curvature with one bounded posterior half-cycle asymmetry.
Body-frame bearing requests the turn, while soft relative-crossflow feedback
releases or reverses it as lateral slip develops. The requested side of the
posterior wave is amplified and the opposite side weakened by the same bounded
fraction, so propulsion retains its joint-state phase and traveling direction
without a fixed curvature equilibrium or raw heading-rate chatter.

The candidate is falsified if it repeats the upper-boundary exit without
improving both `12.0564L` closest approach and `9.1465T` survival, if its
bearing does not recover after the first sign crossing, or if posterior
asymmetry destroys the alternating wake or maintains the same joint-rate-limit
occupancy. Relative-crossflow release is also falsified if held-out nonzero
inflow turns it into a route bias rather than a slip cue.

bookshelf_consulted: true
source_domain: sensor-closed robotic-fish CPG turning by asymmetric flapping
source_mechanism: body-relative direction error strengthens one propulsive half-cycle and weakens the other while measured response releases the turn
transferable_invariant: preserve the traveling-wave carrier and create bounded signed curvature through observation-gated half-cycle asymmetry rather than a static bend
nontransferable_details: published gains, duty ratios, clocked oscillator phase, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame bearing plus soft relative crossflow into a bounded turn request, infer posterior beat side from the lagged joint-state target, and oppositely scale its two half-cycles
falsification: reject if closest approach and boundary survival do not both improve, bearing keeps diverging after crossing zero, wake coherence is lost, or joint saturation remains persistent

## Dry validation, not rollout evidence

The public contract and parameter-schema checks pass, and a 5,832-state sweep
including non-finite bearing/crossflow inputs returns finite commands. Exact
left/right reflection of bearing, crossflow, joint angles, and joint rates
reflects both accelerations. In a clamped 10T joint-only probe, the unchanged
carrier has the same anterior trajectory for all requests; an initial
`bearing=+0.155`, `relative_crossflow=+0.06` shifts posterior mean angle from
about `-0.016 rad` at zero command to `+0.104 rad`, while the reflected request
shifts it to `-0.135 rad`. A developing release cue of
`relative_crossflow=-0.22` nearly removes that shift. This only verifies the
intended phase-selective sign and bounded actuator construction; post-worker
CFD must decide the distance, termination, wake, and saturation falsifiers.
