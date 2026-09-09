# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm,
  and no cylinders. The combined top-down vorticity and oblique Lambda2 rows
  were inspected for the naive seed, the strongest finite trajectory, and the
  two alternative curvature failures.
- The naive seed is self-propelled rather than advected. Its initially compact
  tail structures grow into an alternating three-dimensional wake, but the
  unguided path curls upward and exits at `8.602T`; distance improves only from
  `12.3277L` to `12.0701L` before ending at `12.3677L`.
- The `10 deg` bearing/yaw/slip candidate and the `14 deg` posterior-heavy
  curvature candidate do not turn that propulsion into progress. Their early
  top-down and oblique frames show little sustained traveling wake, followed
  by broad turns away from the target; they reach only `12.3238L` and
  `12.2908L` respectively and exit after `12.221T` and `9.663T`.
- The `7 deg` distributed mean-curvature candidate is qualitatively different.
  Both views show a coherent alternating wake and sustained self-propulsion
  toward the lower-left target. It reduces distance to `4.0671L` at `14.911T`
  and survives to `24.893T`, but crosses below the target and exits the bottom
  boundary at final distance `9.1287L`.
- Its response term has a sign-semantic defect. Positive mean curvature causes
  negative yaw in this fish, yet `bearing - k*heading_rate` reinforces the
  positive curvature when the observed negative yaw is already the requested
  response. Target bearing first crosses zero at `0.957T` with heading rate
  `-0.819 rad/T`; the controller therefore delays its counter-bend. Increasing
  static curvature is not supported: the two higher-curvature samples lose
  progress and wake quality, while the useful run already reaches both joint
  velocity limits in roughly 13 percent of recorded rows.

## Policy hypothesis

Preserve the only sampled joint distribution that retains a traveling wake:
the seed carrier centered on at most `7 deg` anterior mean curvature with an
`0.8` posterior share. Replace the sign-defective raw yaw term with bounded
turn-response tracking. Body-frame bearing requests a desired yaw rate of the
opposite sign; the error between that request and measured recent yaw maps to
mean curvature with the empirically established inverse curvature/yaw sign.
Thus a correct yaw response releases the bend and excessive yaw commands a
counter-bend without time, world coordinates, flow phase, or route memory.

Expected evidence is retention of the coherent alternating wake and early
distance progress, but with yaw already arrested after the first bearing-zero
crossing, a trajectory that remains near the target line, and survival without
the prior bottom exit. Falsify the translation if the first turn has the wrong
sign, bearing/yaw form a growing oscillation, closest approach is not below
`4.0671L`, the wake collapses toward either high-curvature failure, or
joint-limit residence/load spikes materially worsen.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG direction tracking and biological burst-redirect turning
source_mechanism: target error requests bounded mean bend and observed heading response releases or reverses that bend while the propulsive rhythm continues
transferable_invariant: compare a body-frame target-requested turn response with measured body turn, so correct response reduces steering bias and overshoot produces a counter-bend
nontransferable_details: published gains, dimensional turn rates, clocked CPG phase, robot geometry, species kinematics, exact vortex phases, and task-specific routes
policy_translation: map bounded body-frame bearing to desired normalized yaw rate, map recent yaw-rate error through the evidenced inverse yaw/curvature sign to a bounded mean curvature, and retain the sampled propulsive two-joint distribution
falsification: reject if yaw is not arrested after bearing crosses zero, the coherent wake or sub-4.0671L progress is lost, bottom-exit topology persists, or actuator-limit residence worsens
