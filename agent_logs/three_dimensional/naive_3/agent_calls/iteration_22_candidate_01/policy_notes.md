# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the assigned parent's completed evaluation
  satisfy the direct-uniform still-water contract: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite dynamics, and moving-window operation. I
  inspected the combined sheets for the best sampled phase-lag case
  (`2.326L` minimum), the sampled differential S-bend failure (`2.469L`), the
  assigned parent's forming-miss phase failure (`2.684L`), and the inherited
  posterior half-cycle attenuation failure (`2.738L`). In both top-down
  vorticity and oblique body/Lambda2 views, the fish self-propels from rest,
  sheds a long coherent alternating three-dimensional wake, passes below the
  target, and remains powered to the lower boundary near `31T`. The repeated
  failure is controlled terminal course loss, not advection, collision, wake
  collapse, or numerical instability.
- The sampled fixed-proximity posterior phase action remains the strongest
  current scaffold at `2.326L`, versus `2.385L` for the yaw-selected brake,
  `2.433L` for anterior duty asymmetry, and `2.469L` for differential
  equilibrium curvature. At its minimum the fish still travels at `0.687U`,
  the target-ray/course error is `1.088 rad`, and local flow is only about
  `(-0.018,-0.001)U`; its anterior/posterior command clamps occupy about
  `0.749/0.355` of samples. The assigned parent's earlier forming-miss selector
  worsened minimum distance to `2.684L`, and the inherited same-envelope
  posterior half-cycle attenuation worsened it to `2.738L`; both retained the
  lower-exit topology. This closes another proximity/gate refinement and
  direct half-cycle authority reduction rather than supporting scalar tuning.
- A distinct measured signal is calibrated consistently across the four
  sampled trajectories: normalized yaw moment correlates `0.956--0.959` with
  next-step yaw acceleration inside `4L` (and about `0.963` over each full
  rollout). In the best trace, typical absolute moment is about `0.0047` and
  approach peaks are about `0.012`. Moment therefore supplies an anticipatory
  hydrodynamic yaw-load residual, whereas raw yaw is already known to be a
  beat-locked response and target-ray/course error supplies the persistent
  route sign.

## Policy hypothesis

Start from the sampled `2.326L` fixed-proximity phase-lag controller and
preserve its oscillator, mean-curvature carrier, alignment envelope,
response-selected posterior brake, localized lag modulation, and command
reserve. Add one new feedback mechanism: when the slow signed target-ray/course
error and the fast measured yaw moment agree that the current load will
accelerate the miss, let that moment residual activate the existing bounded
posterior-wave brake. A smooth union with the yaw-response selector cannot
brake below the already tested posterior floor, cannot boost a half-cycle, and
vanishes during far-field cruise. This tests anticipatory load rejection
without another equilibrium bend, phase gate, scalar drive increase, or route.

Support requires retained coherent inbound propulsion plus capture, a return
leg, a useful new termination class, or a material improvement below `2.326L`
without worse mean distance or clamp/load residence. Reject the mechanism if
the same lower exit remains with only a small scalar shift, if moment feedback
suppresses both useful and harmful beat phases, or if wake coherence, inbound
progress, or actuator/load residence worsens. Formal coupled CFD runs only
after this worker exits; the moment correlation and controller probes are
diagnostic support, not evidence of a new trajectory.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and hydrodynamic load feedback
source_mechanism: slow directional error selects a bounded response to fast measured yaw-producing load while the traveling-wave carrier remains active
transferable_invariant: separate persistent route error from alternating load response, and reject only load whose sign increases the route error
nontransferable_details: published gains, clock phases, robot geometry, species kinematics, dimensional moments, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target and velocity directions provide the slow sign; normalized measured yaw moment gates the existing posterior-wave brake under the two-joint state-feedback contract
falsification: reject if capture, recovery, termination class, or a material improvement below 2.326L does not occur, or if cruise wake, progress, loads, or clamp residence degrade
```

## Controller-only audit

Replaying the selector on the completed `2.326L` trajectory, without
integrating new dynamics, gives a mean additional posterior-authority reduction
of only `2.8e-7` during the first `2T` (maximum `3.9e-6`). Inside `3.6L`, the
moment brake is above `0.05` on about `42%` of samples and reduces posterior
authority by `0.036` on average, with a bounded maximum of `0.229`; inside
`3L` the mean reduction is `0.043`. This verifies a negligible release change
and a material but non-dominant approach action, not a hydrodynamic outcome.

All `29` direct `params.FIELD` references are declared by
`target_policy_params()`. Representative approach, mirrored, stopped, cruise,
and extreme finite-state probes return finite actions within `+/-28 rad/T^2`;
the mirrored action residual is below `1e-12`. These checks establish schema,
symmetry, and bounds only. No CFD was run in this workspace.
