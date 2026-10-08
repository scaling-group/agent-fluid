# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  still-water initialization, zero cylinders and no prewarm. Three are exact
  evaluations of the prefilled v31 candidate and reproduce its
  `18.0125T` capture and `-0.064000433` score; the fourth is the v26
  slip-synchronous posterior-feathering capture at the same sampled arrival
  step and `-0.064149483`.
- In both combined keyframe sheets, the top-down row shows target-directed
  self-propulsion and a strong alternating wake from release through capture;
  the oblique Lambda2 row shows coherent three-dimensional body/caudal
  structures without breakup or numerical instability. The v31 and v26 sheets
  are visually almost indistinguishable at the sampled frames. There is no
  sampled non-capture image in this worker's evidence, so v26 is the most
  informative contrasting finite result rather than a failure termination.
- The trajectory resolves the terminal difference hidden by those similar
  images. At v31 capture, center speed is `0.8806U`, but only `0.1143U` is
  radial toward the target while `0.8732U` is target-normal; absolute yaw is
  `0.8077 rad/T`, both final acceleration commands are at `1800 deg/T^2`, and
  near posterior acceleration-ceiling residence is `75.89%`. V26 modestly
  improves radial/target-normal speed to `0.1490/0.8493U`, yaw to
  `0.6545 rad/T`, and posterior residence to `74.11%`, but slightly worsens
  observed distance integral and score. Thus the remaining issue is terminal
  carrier energy and cross-course motion, not missing transit propulsion, wake
  coherence, curvature polarity, or another steering-sign correction.
- The inherited optimizer logs add only capture scores for the unsampled
  follow-ups, including `-0.06516244`; without their policies or trajectories
  they cannot identify a mechanism and do not override the sampled physical
  comparison.

## One candidate

Preserve v31's route request, odd mean-curvature map, posterior lag, terminal
mean-bend allocation, posterior envelope, and course-consensus duty primitive.
Add one phase-invariant terminal carrier mechanism: inside the established
`2.10L` approach only, use the magnitude of target-normal body velocity,
course misalignment, and observed motion to lower the anterior oscillator's
energy-envelope amplitude continuously. The resulting smaller anterior wave
is inherited by the lagged posterior target, so this is whole-carrier relief,
not a new mean bend or a half-cycle steering redistribution. On the recorded
v31 trace the proposed gate is exactly zero before approach, is active on
`313/394` approach samples, gives mean amplitude scale `0.921`, and reaches
`0.820` at capture; it therefore has material replay authority without
changing transit.

Expected result: retain the coherent traveling wake and capture while reducing
late target-normal speed, yaw, and joint-ceiling residence. The current CFD
outcome is intentionally not claimed here because it will be evaluated only
after this worker exits.

bookshelf_consulted: true
source_domain: biological and robotic undulatory locomotion with closed-loop rhythm-envelope modulation
source_mechanism: preserve the traveling bend for propulsion, then continuously relieve carrier amplitude during an observed high-energy terminal approach
transferable_invariant: state feedback may reduce a propulsive rhythm's envelope near a target without changing its phase direction, mean steering sign, or posterior lag
nontransferable_details: published amplitudes and gains, clock-driven CPG phase, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: use only normalized body-frame target-normal velocity, target distance, course alignment, and speed to gate the anterior phase-plane amplitude; let the existing two-joint posterior lag inherit the reduced carrier
falsification: reject if transit changes before 2.10L, capture or coherent wake is lost, arrival or distance integral regresses materially, or yaw and non-migrating actuator-limit residence do not improve together
