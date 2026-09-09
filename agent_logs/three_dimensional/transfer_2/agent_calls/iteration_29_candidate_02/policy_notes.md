# Response-gated redirect-priority carrier candidate

## Evidence diagnosis written before the policy edit

- All four sampled evaluations satisfy the frozen release contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, and `capture` termination. There is no semantic
  failure in this batch; the lowest-scoring capture is therefore the
  informative regression rather than evidence for inventing a new route.
- Both rows of all four combined keyframe sheets were inspected from release to
  capture, with `solver_3fdd63b3fbda` as the strongest finite example and
  `solver_b505efd9ced6` as the most informative lower-performing example. Each
  top-down row shows motion beginning in blank still water, followed by a
  compact alternating caudal wake and a continuous target-directed arc. Each
  oblique row shows coherent three-dimensional Lambda2 structures shed behind
  the body through capture. The fish are self-propelled rather than advected;
  there is no visible collision, wake collapse, domain exit, or instability.
- The response-gated redirect-priority sample is materially better than the
  prefilled predictive-rate parent. It advances the `10/8/6/4/2/1L`
  milestones from `6.331/8.591/10.752/13.101/15.780/17.094T` to
  `5.863/7.838/9.779/11.726/14.201/15.604T`, captures at `16.044T` instead of
  `17.418T`, and reduces the distance integral from `1.93044L` to `1.82409L`.
  Its score improves from `-0.04522` to `0.05824`, well beyond a terminal
  radius artifact, while both wake views remain in the same coherent class.
- That progress has an actuator/load boundary. Relative to the predictive
  parent, redirect priority lengthens head path from `12.528L` to `13.178L`,
  raises peak planar-force/yaw-moment coefficients from `0.03001/0.01495` to
  `0.03579/0.01770`, and raises anterior/posterior residence above 90% joint
  rate from `15.03/0.73%` to `17.76/8.12%`. Neither policy resides above 90% of
  the angle limit, and the redirect wake remains coherent, so the supported
  conclusion is to retain the mechanism while continuing to treat load and
  rate residence as falsification boundaries.
- The sampled attempts to protect that boundary do not justify further gain
  tuning. Positive-work-only decomposition regresses to
  `17.413T/1.94829L` and raises mean commands to `18.81/17.12 rad/T^2`.
  Adding normalized force/moment load feedback preserves early progress but
  captures at `16.258T/1.83377L`, lengthens path slightly to `13.191L`, and
  lowers the redirect sample's peak force/moment by only about `2.2%/0.9%`;
  greater-than-90%-rate residence changes only from `17.76/8.12%` to
  `17.49/7.85%`. This fails the inherited log's requirement for a material
  load/path benefit and supports restoring the plain redirect-priority
  governor rather than tuning the load thresholds.
- The assigned parent guidance and inherited notes support preserving the
  corrected-sign target vector, distance/closing relief, half-cycle steering,
  posterior handoff, and carrier/steering decomposition. The new candidate
  changes only the tested rate-barrier architecture: a body-frame course
  redirect receives priority until measured signed yaw response is aligned,
  while one bounded common scale preserves the two-joint traveling carrier and
  leaves target-conditioned steering available.

## One-candidate hypothesis and falsification

Materialize the evaluated response-gated redirect-priority controller as the
single candidate. This is a mechanism selection, not scalar-only gain tuning:
an observed unfulfilled velocity-course redirect augments the positive-work
carrier guard, then releases continuously when measured yaw follows the
body-frame route request. Expected signature: reproduce the earlier milestone,
capture, distance-integral, and coherent two-view wake class while preserving
angle margin. Falsify or replace it if a repeat loses capture, capture/integral
regress beyond repeat variation, either wake loses its alternating traveling
structure, or path, joint-rate residence, peak load, terminal yaw/slip, or mean
command grows beyond the sampled redirect-priority boundary. A later
mechanism should address load only if it yields a material joint/load/path
improvement without sacrificing the redirect trajectory; do not retune the
failed instantaneous load gate in isolation.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG control, and Lighthill-style reactive traveling-wave propulsion
source_mechanism: temporarily prioritize a large direction correction, release it from measured directional response, and preserve the posterior-lag propulsive wave
transferable_invariant: gate a bounded redirect by normalized body-frame course error and measured signed yaw response while keeping the two-joint traveling carrier phase coupled
nontransferable_details: published gains, species-specific burst kinematics, dimensional cadence, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: form an unfulfilled redirect from normalized body-frame velocity-course error, target request, and recent yaw response; use it only to request a common carrier-energy scale while target-conditioned two-joint steering residuals pass unchanged
falsification: reject if repeat capture and distance integral regress, coherent top-down or oblique wake structure is lost, or path, joint-rate residence, force/moment peaks, terminal yaw/slip, angle margin, or mean commands exceed the sampled redirect-priority class
