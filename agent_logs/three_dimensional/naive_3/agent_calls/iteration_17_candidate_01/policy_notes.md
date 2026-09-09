# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected
  the combined keyframe sheets for the strongest sampled response-selected
  posterior brake (`solver_563a0d75514e`) and the informative gait-yaw
  residual failure (`solver_6820bbc602a7`), including both the top-down
  mid-plane vorticity row and oblique body/Lambda2 row from release through
  termination. Both fish self-propel along the same diagonal approach, shed a
  sustained alternating planar wake and compact three-dimensional vortex
  chain, turn nearly vertically below the target, and remain powered to a
  lower-boundary exit near `31T`. Neither trace shows passive advection, wake
  collapse, collision, or numerical instability.
- The measured-yaw-selected posterior brake remains the strongest sampled
  terminal action: it reaches `2.385L`, versus `2.443L` for the alignment-gated
  carrier, `2.541L` for gait-yaw residualization, and `2.536L` for the
  response-released posterior S-bend. At the brake's minimum near `17.87T`,
  speed remains `0.705U`, closure is about `0.014 L/T`, local-flow magnitude
  is only `0.018U`, full target-direction error is about `1.38 rad`, and the
  translational course remains about `1.15 rad` away from the target ray.
  Thus the miss is powered cross-track transit, not weak drive or ambient
  advection.
- The assigned-parent guidance and inherited notes show that raw yaw is
  beat-locked to anterior joint velocity inside `3L` (`|r|=0.992--0.998`).
  They also record completed regressions for a posterior counterstroke
  (`2.585L`), smoother posterior polarity reallocation (`2.406L`), and an
  anterior phase brake (`2.628L`), all retaining the lower exit. Those results
  reject another yaw-selected damping, polarity, equilibrium, or scalar-gain
  edit. In contrast, inherited analysis finds a persistent body-frame angle
  between the target ray and translational course: median magnitude is about
  `1.53--1.54 rad` for every sampled trace inside `3L` at speed above `0.2U`.
  This geometric signal is not the oscillatory yaw proxy and directly states
  which way the actual trajectory must rotate.

## Policy hypothesis

Start from the sampled `2.385L` response-selected posterior brake and preserve
its oscillator, bounded target-bearing curvature, posterior lag, alignment
envelope, response selector, command reserve, and far-field scaffold.
Add one continuous course-to-curvature redirect: only on approach and at
nontrivial speed, compare the normalized body-frame target ray with the
normalized body-frame translational course and add bounded mean curvature in
the signed direction that closes that angle. The redirect continuously
releases as course aligns, speed vanishes, or distance grows. This is a
geometric burst redirect, not another posterior reallocation, yaw-phase edit,
or scalar tuning of the established brake.

The expected evidence is unchanged diagonal cruise and coherent wake followed
by an earlier rotation of translational course toward the target inside about
`4L`. Capture, a useful termination-class change, or a minimum materially
below `2.385L` with retained broad progress supports the mechanism. It is
falsified by changed far-field motion, a short tight curl, lost wake coherence,
materially greater actuator/load residence, or the same powered lower exit
without a better minimum.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and biological burst redirect
source_mechanism: large observed course error requests bounded curvature while the traveling-wave carrier continues, then measured course alignment releases the redirect
transferable_invariant: preserve coherent propulsion and apply extra turning authority only while the observed body-frame translational course remains misaligned with the target ray
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species-specific kinematics, dimensional frequencies, prescribed burst timing, exact vortex phases, and task routes
policy_translation: normalized target_body_L and velocity_body_U define a reflection-equivariant signed course error; normalized distance and speed smoothly gate bounded added mean curvature within the two-joint state-feedback carrier
falsification: reject if far-field progress or wake coherence changes, a tight curl or greater actuator/load residence appears, or closest approach and the lower-exit class do not improve over the 2.385L response brake
```

## Evaluation boundary

The candidate receives formal coupled CFD only after this worker exits. Static
contract, symmetry, locality, and bound checks can validate implementation
properties but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD checks

The candidate implements only the approach-localized course-to-curvature
redirect described above. Target and velocity directions are formed from
normalized body-frame observations; distance, speed, angular activation, and
the additional `4 deg` curvature bound are all owned by
`target_policy_params()`. Zero target or zero speed releases the redirect, and
no time, world coordinate, route, flow phase, force, or hidden state enters.

At a state reconstructed from the strongest sampled brake near its minimum,
the course redirect changes the anterior/posterior commands by about
`(+7.904,+7.919) rad/T^2`. Moving the same joint state, directions, speed, and
yaw to `8L` changes them by only `(+0.0077,+0.0102) rad/T^2`, confirming the
intended far-field locality. These are static action probes, not a coupled-flow
prediction.

The required guidance-semantic check, lightweight Julia policy contract,
deterministic parameter-schema guard, and solver-boundary audit pass. A
deterministic `37,500`-state sweep spanning target/course directions,
distances, speeds, bearings, yaw rates, and joint phases produced finite
commands within the configured `28 rad/T^2` reserve and exact reflection
equivariance to numerical tolerance. All `324` repository non-CFD assertions
pass. Formal CFD was not run.
