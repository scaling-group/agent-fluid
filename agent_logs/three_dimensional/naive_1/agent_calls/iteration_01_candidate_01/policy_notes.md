# Candidate wake-policy notes

## Evidence diagnosis

- The only sampled rollout, `solver_0718f4efab03`, is the common naive seed
  and is both the best finite sample and the informative failure available in
  this fresh lineage. It uses direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), no prewarm, and no cylinders.
- No inherited `logs/optimize/` tree was present in this first-step workspace;
  the assigned parent guidance and sampled solver rollout are therefore the
  complete inherited evidence used here.
- In the combined keyframe sheet, the top-down row develops a clear alternating
  near-body wake while the fish bends into a large off-route arc; the oblique
  Lambda2 row confirms a three-dimensional coherent wake rather than passive
  advection. Thus the carrier produces propulsion, but the target-blind policy
  supplies no mean route authority.
- The scalar and trajectory evidence agree with the images. Distance improves
  only from `12.3277L` to `12.0638L` at `6.364T`, then worsens to `12.3510L`.
  The center moves about `0.95L` left but `1.20L` upward, heading spans
  `-1.171` to `0.602 rad`, and the head leaves the upper virtual boundary at
  `8.613T`. This is self-propelled wrong-way curvature, not inflow advection or
  numerical instability.
- The carrier already uses substantial authority: no angle-limit contact is
  visible in the sampled trace, but the posterior rate reaches its hard limit
  and roughly one third of raw acceleration samples exceed the episode's
  acceleration envelope before runtime clipping. Steering should therefore be
  expressed as a bounded equilibrium shift, not as a large independent
  additive acceleration or a harder scalar carrier.

## Policy hypothesis

Preserve the seed's state-feedback oscillator and lagged posterior wave, but
center both joints on a small bounded mean curvature computed from normalized
body-frame target bearing. Add only soft body-frame lateral-slip damping inside
that same turn request, because the failure accumulates large cross-track
motion. The target remains nearly ahead initially, so the bias should be modest;
as the uncontrolled yaw grows, the bounded request should reverse sign and
restore route authority without erasing the alternating wake.

Falsify this candidate if it retains the upper-boundary exit topology, if the
turn sign moves the target farther off the body centerline, if the coherent
propulsive wake collapses, or if joint angle/rate saturation becomes more
persistent. A later rollout should compare semantic termination and trajectory
topology first, then minimum/final distance and load/effort histories.

bookshelf_consulted: true
source_domain: robotic-fish turning and closed-loop CPG modulation
source_mechanism: target-feedback modulation of the mean bend of a propulsive rhythm
transferable_invariant: persistent body-frame target error can command a bounded mean curvature while the phase-lagged propulsive rhythm remains intact
nontransferable_details: published gains, clock-driven CPG phase, species-specific amplitudes, full-body kinematics, and prescribed routes
policy_translation: map bounded body-frame bearing with soft lateral-slip damping to a shared two-joint equilibrium bias inside the existing state-feedback oscillator
falsification: reject if target bearing does not contract, the upper-boundary exit persists, propulsion collapses, or actuator saturation materially increases
