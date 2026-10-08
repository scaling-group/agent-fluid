# Wake-policy candidate notes

## Visual diagnosis and inherited evidence

- All four sampled diagnostics satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion
  and wakes are policy-generated rather than ambient advection.
- The combined sheets agree on the useful mechanism. During broad approach,
  the top-down rows show a coherent alternating vorticity street and the
  oblique rows show persistent three-dimensional Lambda2 structures. The
  closest sampled redirects (`solver_bf09617243bd` and
  `solver_e496ee6f6139`) reach `2.999L` and `2.989L`, respectively, at about
  `17.7T`, after self-propelling near `1.0U` with local flow only about
  `0.02U` streamwise and `0.01U` laterally.
- The same sheets show the common failure. After passing about `3L` high, the
  path and wake rotate into an upper hook. The carrier-wide hold settles near
  `(0,-12) deg`, the static redirect near `(-10,-12) deg`, and the
  response-released redirect near `(0,-12) deg`; all keep coasting around
  `0.7--0.8U` and terminate at the upper boundary. Removing rhythmic work or
  gating a bend with beat-contaminated instantaneous yaw therefore did not
  create course recovery.
- The latest anterior half-cycle stiffness policy
  (`solver_eaa778e34ed6`) is a distinct negative result. It remains rhythmic
  and visibly sheds an alternating 3D wake, but descends less than the
  redirects, reaches only `4.859L`, and exits through the same upper boundary.
  Relative to the sampled response-released redirect, peak speed falls from
  `1.032U` to `0.947U` and applied acceleration-limit occupancy rises from
  about `34/45%` to `53/64%`. Phase awareness alone is insufficient when it
  reshapes anterior restoring stiffness and burdens the already expensive
  carrier.
- Phase-resolved evidence in the unchanged broad-approach carrier gives a
  sign hypothesis for a posterior alternative: over `4--12T`, negative
  anterior-angle halves coincide with negative mean yaw moment, while positive
  halves coincide with positive mean yaw moment. A target-signed modulation
  can therefore favor the requested half without an anterior center shift,
  carrier hold, clock, or world-frame route.

## Policy hypothesis

Restore the zero-centered anterior oscillator and retain the full-quadrant
bearing-minus-slip mean tail curvature. Add one new mechanism at the posterior
joint: when body-frame angular error leaves the broad-approach corridor,
smoothly increase posterior phase lag on the anterior-angle half associated
with requested yaw and decrease it on the counter half. The modulation is
reflection equivariant because target sign and joint side reverse together;
it remains a traveling bend, and it releases continuously with alignment.

This should exactly preserve the evidenced approach carrier at small error,
keep active alternating work after the target passes behind, and shift the
cycle-resolved yaw impulse without the static joints of prior redirects or the
anterior effort penalty of stiffness asymmetry. Falsify it if the broad wake
or progress changes, posterior angle/rate/acceleration occupancy rises
materially, closest approach does not beat `2.960L`, or the same upper exit
recurs without a distinct bearing-recovery arc.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning combined with classical posterior traveling-wave propulsion
source_mechanism: sensor-modulated half-cycle phase-lag asymmetry within an otherwise unchanged propulsive rhythm
transferable_invariant: preserve the traveling carrier while shifting posterior wave timing toward the joint-state half-cycle that supplies the requested yaw, and remove the shift as body-frame alignment recovers
nontransferable_details: published gains, duty ratios, clock phase, species-specific kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: map normalized full-quadrant target geometry minus bounded body slip to a turn request; infer beat side from anterior joint angle; smoothly modulate the coefficient of the observed anterior joint-rate lag with a bounded target-sign-by-beat-side product
falsification: reject if alternating 3D shedding or broad approach degrades, actuator-limit occupancy rises materially, closest distance fails to beat 2.960L, or bearing and upper-boundary termination topology do not improve
