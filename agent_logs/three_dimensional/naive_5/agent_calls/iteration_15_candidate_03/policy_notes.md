# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts report `uniform_direct` initialization with
  `U_infinity=(0,0,0)`, so their translation and wakes are self-generated.
  In both the top-down vorticity row and the oblique Lambda2 row, the assigned
  `solver_b3b6be8f076f` parent sustains a coherent alternating wake before
  curving upward and leaving the virtual domain. It reaches `4.278496L` at
  `22.7865T` but its joints and commands are almost settled there
  (`phi=(-0.3085,-0.2918)`, `phi_ddot=(-0.0509,-0.1261)`), then it exits at
  `(8.132,15.202)L`. This is loss of translational-intercept authority after
  redirect release, not loss of propulsion or a moving-window artifact.
- The posterior-asymmetry sample `solver_b6ed3f84ab58` retains the coherent
  wake but bends sharply toward the upper boundary, touches the joint-angle
  limit, and reaches about `0.211/0.0968` peak planar force/yaw moment. Its
  `5.386122L` minimum and upper-boundary exit reject added posterior
  asymmetry/headroom as a safe terminal fix.
- The strongest sampled trajectory, `solver_fe5535fc7da1`, preserves a clean
  wake and reaches `0.870635L` at `27.4120T`, but crosses the target station
  rather than capturing and later exits the left boundary. At closest
  approach it still travels at `0.633L/T`, predicts a `0.809L` projected miss,
  and actively commands a terminal phase-lagged wave
  (`phi_ddot=(1.231,11.683) rad/T^2`). Its speed is already `0.648L/T` when
  the `1.75L` approach gate is crossed and remains `0.628--0.653L/T` through
  `1.0L`; the wave restored joint motion but did not measurably brake the
  approach.
- Inherited guidance and sampled optimizer logs put the fixed miss-veto near
  `0.829828L` and several deeper-bend, closing-gated, isolated-joint, recoil,
  counter-sweep, and later recovery variants in `0.827823--0.875770L`, all
  with `left_domain` termination. Three or more completed iterations therefore
  lack a semantic improvement. Another threshold, mean-curvature depth, or
  same-direction recovery wave is not an evidence-backed architecture change.

## Policy hypothesis

Keep the sampled far carrier, calibrated steering side, same-sign two-joint
redirect, and terminal miss veto. In the near field only, replace the tested
same-direction terminal wave with a bounded counter-propulsive wave: retain an
anterior oscillator about the calibrated C-bend but reverse the sign of the
posterior velocity-lag term, reversing joint-to-joint wave propagation. Gate
this maneuver continuously with normalized head distance, projected miss,
geometric closing speed, and translational speed. It must vanish on the far
route, on a non-closing trajectory, after speed has fallen, and near the joint
soft limit. The intended effect is axial momentum reduction before the target
station, buying time for the existing C-bend to rotate velocity rather than
merely rotating the body.

bookshelf_consulted: true
source_domain: classical reactive fish swimming (Taylor/Lighthill) with closed-loop robotic-fish CPG modulation
source_mechanism: traveling-wave direction sets the direction of reactive momentum transfer, while sensed task state can gate a rhythmic mode change
transferable_invariant: reverse joint-to-joint wave propagation, not just wave magnitude, to oppose an excessive approach velocity; engage and release from observed geometry and motion
nontransferable_details: published gains, dimensional frequencies, species envelopes, full-body waveforms, exact wake phase, and prescribed routes
policy_translation: when normalized body-frame distance and projected miss indicate a fast closing pass, oscillate joint 1 about the calibrated redirect bend and reverse the posterior phase-lag sign; blend back to the settled redirect as closing speed or speed falls
falsification: reject if pre-station speed does not fall below the sampled roughly 0.63L/T approach, minimum distance does not beat 0.827823L or capture, the wake loses coherence, or loads/limit residence approach the posterior-asymmetry failure
