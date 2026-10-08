# Candidate diagnosis and hypothesis

## Inherited evidence

- All four sampled evaluations are valid direct-uniform still-water rollouts
  with no cylinders, and all capture. The strongest policy is byte-identical
  in `solver_89a97c83567b`, `solver_f2153a8a313f`, and
  `solver_b79884a946b7`: score `-0.5283387731`, capture at `25.1185 T`, mean
  distance `2.4292938 L`, and final distance `0.7464102 L`.
- `solver_6a46e49f8216` is the informative semantic failure rather than a
  termination failure. Its standalone departure-half-cycle allocator crosses
  one integration step earlier, but regresses score to `-0.5283756345`, mean
  distance to `2.4292984 L`, and final distance to `0.7465166 L`. The inherited
  optimizer logs also show that stacking this phase gate with the supported
  response release regressed further (`-0.530990`) and that releasing only the
  posterior joint regressed to `-0.530288`.
- The top-down sheets show the same useful topology: self-propulsion from a
  coherent alternating wake, broad target-directed travel, then a smooth
  terminal arc into the capture circle. There is no visual sign of passive
  advection in the zero-flow initialization. The strongest rollout's oblique
  frames show a compact three-dimensional Lambda2 wake during approach and a
  continuous curved trajectory into capture. The standalone phase candidate's
  post-release oblique frames are blank, so they cannot support a claim of a
  better 3D wake.
- For the repeated strongest rollout, the terminal band begins at `19.6240 T`.
  Its reconstructed body-frame bearing falls from `1.1677` to `0.7125 rad`
  while distance falls from `4 L` to `0.7464 L`; after distance is below `3 L`,
  the short-window bearing trend has the converging sign on about `95.1%` of
  samples. Terminal force-norm and yaw-moment maxima remain about
  `0.01548/0.00800`, and both joints remain below the `45 deg` stop. Thus the
  residual opportunity is not more static curvature or split joint authority;
  it is a cautious response-conditioned handoff toward propulsion after both
  the shared bend and useful target-relative response are observed.

## Policy hypothesis

Start from the three-times-repeated paired-release policy, not the prefilled
standalone phase allocator. Preserve the outer carrier, closure preview,
shared two-joint terminal curvature equilibrium, and its curvature-error
settlement release exactly. Add one compact target-response mechanism: only
inside the existing terminal reallocation gate, and only after both joints
settle, use the reflection-invariant sign of
`redirect_angle * bearing_window_rate` to recognize decreasing bearing
magnitude and restore a small additional fraction of the same paired carrier.
The signal and its scale are normalized by the existing body-frame angle and
rate scales. It has no clock, route, coordinate, target identity, or new joint
role.

Falsification: reject the mechanism if the rollout differs before the terminal
band, loses capture, delays or stalls the established compact approach,
increases mean/final distance, revives joint-stop dwell or command clipping,
raises terminal force/moment loads materially, or if the short-window response
gate chatters enough to degrade the coherent wake. In particular, do not
interpret an earlier crossing alone as improvement.

bookshelf_consulted: true
source_domain: biological C-start or burst redirect and robotic-fish closed-loop CPG modulation
source_mechanism: release a bounded redirect toward a posterior-lag propulsive rhythm after observed heading response
transferable_invariant: geometry initiates the bend, while joint settlement and target-relative response continuously gate the handoff back to propulsion
nontransferable_details: species kinematics, published gains, dimensional timing, exact vortex phase, open-loop CPG phase, and task-specific routes
policy_translation: within the existing closure-previewed terminal gate, combine normalized two-joint curvature settlement with signed body-frame bearing convergence to restore a small paired carrier fraction
falsification: reject if pre-terminal motion changes, compact capture regresses, response switching grows, saturation or loads return, or the trajectory develops a stall or loop
