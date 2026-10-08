# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver rollouts are finite captures from the required
  direct-uniform still-water initialization: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and no numerical instability. The assigned
  parent and two executable-equivalent copies reproduce `23.331013T`,
  `0.749672L` crossing distance, `2.135772L` scored mean distance, and
  `-0.239045` score. This establishes a deterministic fixed-pose baseline,
  not robustness to other poses or hydrodynamic conditions.
- The strongest sampled policy changes the parent's posterior speed-recovery
  share from whole-carrier amplitude to velocity-quadrature phase lag. It
  captures in `23.122009T`, lowers mean distance to `2.133413L`, shortens the
  head path from `14.0351L` to `13.9533L`, and improves score to `-0.237071`.
  Peak normalized force/moment also fall from `0.030861/0.016213` to
  `0.030360/0.015861`, although mean action rises from `59.044` to `60.062`
  and anterior/posterior rate-cap occupancy rises from `11.34/6.27%` to
  `11.92/7.06%`.
- This phase-lag result is not an early-propulsion gain. Its distance at
  `2/4/6T` is `12.207/11.450/10.242L`, behind the assigned parent's
  `12.156/11.300/10.066L`; it recovers later through a shorter trajectory.
  The top-down sheets show both policies self-propel on the same broad
  S-shaped approach with an attached alternating red/blue caudal street and
  no collision, exit, or wake collapse before capture. The best phase-lag
  sample's oblique row is a black render artifact, so it adds no 3D-wake
  claim. A matched parent copy supplies the valid comparison: its oblique row
  shows discrete three-dimensional Lambda2 structures behind the posterior
  body from `4T` through capture.
- The inherited joint-work qualification is the informative mechanism
  failure. Suppressing whole-carrier recovery when its instantaneous target
  and tail velocity have opposite sign still preserves a complete two-view
  wake and lowers effort/load, but delays capture to `23.782021T`, raises mean
  distance to `2.145171L`, lengthens the path to `14.2406L`, and worsens score
  to `-0.247507`. Instantaneous target-work sign is therefore not a useful
  proxy for which posterior phase should be retained.
- Across the inherited course-only, assigned-parent, sampled phase-lag, and
  joint-work-qualified traces during `4--20T`, measured lateral sideslip has
  `-0.901` to `-0.907` correlation with normalized anterior joint velocity.
  Its regression coefficient is consistently `-0.3866` to `-0.4056 U` per
  unit `qd1/(omega*amp)`. The present course angle therefore treats a large,
  repeatable carrier-synchronous sway component as slow route error; this is
  a distinct observation problem rather than evidence for another scalar
  course gain.

## One candidate hypothesis

Use the sampled phase-lag controller as the base. Before forming its slow
through-water course angle, subtract only the evidenced carrier-synchronous
part of lateral sideslip by adding `0.40U * qd1/(omega*amp)` to the measured
body-frame signal, with the normalized carrier velocity bounded by the
existing phase-velocity limit. Preserve the full measured residual, including
persistent sideslip and local-flow disturbances that are not synchronous with
the joint-state carrier. Leave target geometry, anterior oscillator recovery,
posterior phase-lag recovery, redirect, reactive rudder, and terminal relief
unchanged. This is a carrier-demodulated course observation, not a course-gain
edit, a prescribed phase, a clocked stage, or a memorized route.

Falsify the mechanism if capture is lost or later than `23.122009T`, scored
mean distance exceeds `2.133413L`, score falls below `-0.237071`, or the
`13.9533L` path and broad approach do not improve. Also reject it if the
alternating top-down wake changes adversely, mean action materially exceeds
`60.062`, anterior/posterior rate-cap occupancy leaves the approximately
`11.92/7.06%` class, or peak normalized force/moment materially exceed
`0.030360/0.015861`. A missing oblique render cannot establish 3D preservation;
any valid oblique row must retain the parent's discrete Lambda2 wake. A
fixed-pose still-water win would establish only course-demodulation
compatibility, not robustness to imposed wakes or changed poses.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and wake-interaction control
source_mechanism: preserve the joint-state traveling carrier while separating slow target-course correction from fast rhythmic lateral motion
transferable_invariant: a slow body-frame route loop should act on persistent through-water course error after removing the carrier-synchronous sway it can explain, while leaving nonsynchronous local-flow disturbances observable
nontransferable_details: published gains, dimensional frequencies and speeds, robot sensor calibration, distributed-body kinematics, species-specific gaits, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: start from the sampled phase-lag recovery policy and replace raw lateral sideslip in only the course-angle observation with the residual after a bounded rollout-calibrated `qd1/(omega*amp)` carrier component is removed
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, score worsens below -0.237071, or route, valid two-view wake, action, saturation, force, or moment envelopes worsen
