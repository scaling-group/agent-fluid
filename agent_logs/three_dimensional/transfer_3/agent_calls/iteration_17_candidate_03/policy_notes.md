# Candidate diagnosis: capture-point intercept corridor

## Evidence read before architecture

- All four sampled episodes are valid direct-uniform still-water rollouts
  (`U_infinity=[0,0,0]`) and capture at `25.1185226 T` after 4567 steps. The
  highest-scoring intercept-corridor policy is reproduced exactly by
  `solver_d9fcfebfb5a0` and `solver_dccfc80981c7`: score `-0.5280772274`, mean
  distance `2.429087214 L`, and final distance `0.746135294 L`.
- In both combined sheets the top-down row shows self-propelled target motion,
  a coherent alternating wake through the broad curved approach, and a quiet
  terminal glide rather than advection, a loop, or a last-beat lunge. The
  oblique Lambda2 row shows the same attached/body-following three-dimensional
  vortex sequence and no visible out-of-plane instability. The sheets for the
  best finite sample and the lowest-scoring sampled regression are visually
  indistinguishable at their keyframe resolution.
- The adverse-force veto does not improve that topology. The force-vetoed
  intercept variant (`solver_b46ae5737e6e`) keeps the capture step but regresses
  slightly to `-0.5280778498`; the force-vetoed raw-course variant
  (`solver_b102cbd60615`) regresses further to `-0.5280861775`. Their inside-
  `1.6 L` lateral-force maxima change only from about `0.0020942` to `0.0020905`
  and `0.0020832`, while mean/final distance worsen. Instantaneous force is
  therefore a poor veto for this already coherent terminal release.
- The retained corridor is geometrically meaningful but uses center velocity
  even though capture is a head crossing. On the reproduced best trace, at
  about `1.60 L` the center-velocity ray predicts a miss near `0.685 L`, whereas
  the head displacement over the observation window predicts about `0.441 L`.
  At the final sample those estimates are about `0.228 L` and `0.091 L`, with
  center and head course errors about `0.310` and `0.122 rad`. The growing yaw
  rate moves the head toward the target while the center-course estimator
  delays the optional release.

## Policy hypothesis

Replace only the optional intercept-support observation with a capture-point
estimate. In body-frame kinematics, the inertial line-of-sight rate is recent
body turn rate minus body-frame bearing rate. Combining its tangential speed
`distance * abs(LOS rate)` with measured closing speed gives a bounded
constant-velocity miss estimate for the head without a clock, world
coordinates, a morphology lever arm, or target identity. Keep the inherited
miss bands, maximum `3.5%` paired carrier release, settled/closure/crossflow
support, shared mean curvature, carrier phase, and joint roles unchanged.

Expected result: the same compact outer trajectory and coherent two-view wake,
with the existing small paired release admitted earlier only when the actual
capture point is converging inside the intercept corridor. Reject the
candidate if the outer trace changes, capture is delayed or lost, mean/final
distance fails to beat the reproduced `-0.5280772274` baseline, or terminal
oscillation, `|action|>30`, joint-stop dwell, force/moment growth, instability,
or wake degradation appears.

bookshelf_consulted: true
source_domain: terminal capture control for biological and robotic fish
source_mechanism: separate the near-target regime and schedule bounded drive allocation from distance, closure, and measured yaw/slip response
transferable_invariant: preserve proven broad propulsion while making terminal authority depend on the motion of the target-relevant capture point
nontransferable_details: published gains, species kinematics, exact vortex phase, the fixed capture radius, and the article-specific route
policy_translation: infer inertial head line-of-sight rate from normalized body-frame bearing rate and recent turn rate, combine it with normalized range closure, and use the resulting head-miss corridor only for the inherited paired release
falsification: reject on changed outer motion, delayed or lost capture, worse mean or final distance, renewed terminal oscillation or clipping, load growth, instability, or loss of coherent wake
