# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled episodes are valid direct-uniform still-water rollouts with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion is therefore
  self-propulsion rather than ambient advection. All terminate finitely by
  leaving the virtual domain; none is a numerical instability.
- The combined visual sheets were inspected in both rows. In every sample the
  top-down row shows an alternating vortex street and the oblique row shows
  compact three-dimensional Lambda2 structures behind an intact swimmer. The
  `0.55T`, `28 deg` joint-state oscillator and posterior lag are consequently
  worth preserving. The main failure is route control, not absent thrust or a
  collapsed wake.
- The achieved-course shared-acceleration servo
  `solver_39c7e6e70772` is the informative near miss. It bends the green route
  toward the target before sweeping below and leaving through the lower
  boundary. It reaches `1.5424L` head distance at `18.43T`, versus `3.0031L`
  for the phase-compensated bearing-rate policy, but raw joint acceleration
  reaches `100.66 rad/T^2`, exceeds the `31.416 rad/T^2` envelope on `68.1%`
  of joint-action samples, and joint speed reaches its hard limit on `9.5%`
  of joint-state samples. The route signal is useful; that actuator is not.
- The assigned-parent notes proposed routing the same achieved-course error
  through phase-compensated yaw-rate feedback and posterior mean curvature.
  That proposal has now been evaluated as `solver_95d1e880b3e5`. It reaches
  only `3.1135L` and visually repeats the upper, nearly horizontal left-exit
  topology of `solver_5c5f9d80447b` (`3.0031L`). Its actions sit at the
  acceleration envelope on `63.7%` of joint-action samples. Thus the cascade
  failed its inherited test: it discarded the direct course servo's useful
  trajectory and did not cure persistent saturation.
- The inherited yaw-brake controller `solver_cd1c5b66daaa` keeps a coherent
  wake but turns steeply down, reaches only `5.3228L`, and exits below at
  `26.02T`; its raw action exceeds the acceleration envelope on `72.5%` of
  joint-action samples. This is further evidence against adding another
  mean-bend or scalar yaw-brake adjustment.
- Across the traces, peak planar force and yaw moment remain comparable
  (`0.031--0.037` and `0.016--0.018` in logged coefficients), so the closest
  approach is not bought by a unique load spike. The compact wake sheets and
  small local-flow values support changing steering realization while leaving
  wake-flow rejection out of this still-water candidate.

## One candidate mechanism

Use the sampled near-miss's normalized body-frame target-versus-achieved-course
error directly, but translate it into joint-state-gated half-cycle steering.
Observed tail bend and tail motion modulate a bounded shared acceleration so
the requested turn is stronger on the favorable beat side and weaker on the
opposite side. A smooth per-joint limiter owns the physical acceleration
envelope and avoids returning the hidden-clipped raw actions of the near miss.
No yaw-rate cascade or static mean-tail target remains.

Expected test: preserve early leftward propulsion and the direct course
servo's downward redirect, then release or reverse the asymmetric half-cycle
forcing as achieved course crosses the target course. The target sheet should
show a route closer than the `3.1135L` cascade without repeating its upper
exit, while the alternating wake remains coherent and every returned command
stays strictly within the acceleration envelope.

Falsification: reject the primitive if it repeats the upper/left route, the
lower overshoot, or the `>3.11L` miss; if the coherent alternating wake or
early closure is lost; if joint angle/rate saturation grows; or if smooth
limiting leaves steering too weak to preserve the direct servo's redirect.
Only later evidence, not this worker, can establish capture or improved loads.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and bounded fish turning
source_mechanism: half-cycle amplitude asymmetry superposed on a propulsive rhythm
transferable_invariant: preserve the traveling posterior-lag bend while observed beat side gates the strength of target-directed steering
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, clock phase, duty ratios, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target-versus-achieved-course error for turn direction and observed joint bend plus velocity for a reflection-equivariant bounded half-cycle gate on the two accelerations
falsification: reject if the route repeats either sampled exit topology, closest approach does not beat 3.1135L, wake coherence or early closure degrades, or joint saturation grows
