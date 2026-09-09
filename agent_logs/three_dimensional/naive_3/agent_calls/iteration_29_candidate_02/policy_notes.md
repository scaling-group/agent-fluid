# Wake-policy diagnosis and hypothesis

## Evidence diagnosis

- All four sampled evaluations report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, finite `horizon` termination, and no
  capture. The motion is therefore self-propulsion rather than advection.
- In both the top-down vorticity sheets and oblique Lambda2 sheets, the lagged
  two-joint carrier produces a coherent three-dimensional wake through the
  repeated turns. The later sheets show broad powered loops around the target,
  not a stalled body or a wake-coherence loss. This agrees with sampled speed
  near closest approach (`0.65--0.68 U`) and similar 99th-percentile force and
  moment tails across the four traces.
- The response-held C-turn scaffold is useful: the sampled base reserve reaches
  `1.314/4.056/3.077L` minimum/mean/final distance. A broad terminal course
  hold improves minimum/final distance to `1.241/2.082L` but worsens mean
  distance to `4.158L`; the assigned narrow bridge reaches
  `1.282/4.119/2.862L`. Both retain the same coherent noncapturing orbit, so
  more static-curvature persistence or gate tuning is not a new remedy.
- The broad hold's best `1.241L` pass remains almost tangential: speed is
  about `0.669 U`, absolute course error about `1.69 rad`, target-ray sweep
  about `0.535 rad/T`, and useful requested-sign yaw only about `0.13 rad/T`.
  The assigned bridge has the same response mismatch at its `1.282L` pass
  (`0.517` versus about `0.26 rad/T`). The visible miss is thus consistent
  with insufficient turn response relative to the moving target ray after the
  target is behind, rather than insufficient carrier thrust.
- A terminal anterior equilibrium burst regresses to
  `2.125/3.901/3.601L`, and inherited guidance records similarly harmful
  dynamic residuals when they act across both sides of the target crossing.
  Any new response feedback must be negligible on the initial ahead-side pass
  and must not be justified by a frozen replay alone.

## Policy hypothesis

Preserve the assigned carrier, target-behind C-turn, response reserve, and
narrow terminal bridge. Add one small response mechanism only inside the
existing target-behind recovery: estimate inertial target-ray angular rate
from normalized target/course geometry and `speed / distance`, compare its
requested-sign magnitude with measured yaw rate, and add bounded same-sign
mean curvature only for the positive deficit. This is identically suppressed
on the initial `~2.44L` ahead-side pass, grows when the body is turning more
slowly than the target ray sweeps, and continuously releases when yaw catches
the ray. It changes the regulated response rather than retuning distance,
phase, carrier amplitude, or a static curvature gate.

bookshelf_consulted: true
source_domain: biological C-start/burst redirects and sensor-feedback robotic-fish direction tracking
source_mechanism: bounded nonsteady turn authority released when observed heading response appears
transferable_invariant: persistent large direction error with inadequate measured turn response warrants a bounded transient redirect while the propulsive traveling wave is preserved
nontransferable_details: published gains, species-specific C-start kinematics, clocked maneuver phases, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: behind-target body-frame geometry gates a smooth curvature residual; target/velocity cross product and speed-over-distance give normalized target-ray sweep, measured yaw gives turn response, and the two-joint equilibrium receives only the positive requested-sign deficit
falsification: reject if the protected first approach changes materially, anterior/posterior clamp or load tails rise, wake coherence degrades, or the repeated 1.2--1.7L tangential orbit does not contract to capture
