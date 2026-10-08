# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the experiment contract: direct uniform
  initialization in still water with `U_infinity=[0,0,0]`, no cylinders, no
  prewarm snapshot, and no numerical instability. Their motion is therefore
  self-propelled. In every combined sheet, the top-down row develops an
  alternating red/blue caudal street and the oblique row retains discrete
  three-dimensional Lambda2 structures through approach and lower-boundary
  exit. The controller should preserve this traveling carrier rather than
  trade it for an inertial coast.
- The four sampled mechanisms share one route topology. They travel down and
  left, pass below the target, and exit the lower virtual boundary after only
  `31.87--33.27T`. Their minima span just `3.691--4.233L` and their final
  distances are `9.176--9.294L`. The strongest finite sample is
  `solver_24724bc7bb0b`: velocity-phase anterior/posterior half-cycle steering
  reaches `3.691L` at `20.46T`, but the full head-relative error is already
  `1.364 rad`; its mean error then grows from `1.592 rad` over `20--24T` to
  `2.795 rad` near exit while mean yaw rate remains small relative to its
  beat-scale oscillation. This is insufficient net yaw, not absent thrust.
- The assigned-parent logs supply a completed negative result not yet
  distilled in the parent guidance. The rear-aware same-sign posterior
  C-bend candidate `solver_94750f47d14e` was designed to activate beyond the
  sampled miss, but its evaluation remained `left_domain`, essentially tied
  the inherited minimum at `3.692L`, ended at `9.239L`, and scored
  `-10.37585`. A persistent posterior mean offset did not create a semantic
  trajectory improvement. The sampled near-target one-sided envelope is also
  negative: `solver_237089f89ff4` reaches only `3.712L` and retains the same
  lower exit despite a coherent wake.
- The evidence supports retaining anterior-only mean separation, the
  joint-state oscillator, and a rear-aware full-angle gate. It does not
  support another gain increase, distance envelope, static posterior offset,
  or additional carrier unloading. A distinct test is to change *when* the
  posterior carrier is admitted: the inherited gait keys posterior authority
  to anterior velocity, although the desired hydrodynamic turning impulse may
  instead occur once target-signed body curvature has formed.

## One candidate hypothesis

Start from the sampled rear-aware whole-body half-cycle controller. Preserve
its anterior center, bounded phase residual, and zero-mean lagged posterior
carrier. Replace only the posterior velocity-phase selector with a smooth
curvature-phase selector: use normalized anterior carrier displacement to
retain more tail wave on the target-bent half-cycle and deepen relief on the
opposite body shape. This is a quarter-cycle semantic change in the
force-producing posterior stroke, not scalar tuning. Full normalized
body-frame target angle controls recruitment so a target behind the head is
not false alignment; folded bearing supplies a continuous left/right sign.

The candidate is falsified if it does not preserve a coherent 3D alternating
wake and roughly the `3.691L` approach, if full target error remains above
`1 rad` at closest approach, if the same lower exit is not delayed or avoided,
or if anterior/posterior rate-cap occupancy and yaw loads materially exceed
the sampled `13.7/5.5%` and approximately `0.006` RMS moment envelope.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop direction tracking
source_mechanism: target-signed body shape selects the force-producing posterior half-cycle while the propulsive rhythm remains autonomous
transferable_invariant: net turn impulse depends on coupling posterior authority to the requested curved body phase, not merely increasing mean bend or total stroke authority
nontransferable_details: published gains, dimensional beat frequency, clock-driven CPG phase, robot linkage geometry, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: full normalized body-frame target angle gates the maneuver; folded bearing gives reflection-equivariant turn sign; normalized anterior carrier displacement supplies joint-state phase for posterior carrier redistribution
falsification: reject if the 3.691L-level approach or coherent wake is lost, closest-approach error remains above 1 rad, lower exit is not delayed or avoided, or rate-cap occupancy and yaw load materially worsen
