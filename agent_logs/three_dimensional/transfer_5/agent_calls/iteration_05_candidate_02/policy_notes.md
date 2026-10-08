# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations used direct uniform still-water initialization
  (`U_infinity=0`) and captured. Three behaviorally equivalent v21 candidates
  produced the same 4341-step trajectory, `23.8755T` arrival, `2.435715L` mean
  scoring distance, and `0.748994L` terminal distance despite byte differences
  in comments/version text. They are one physical result, not three independent
  mechanisms.
- The strongest finite sample, `solver_f2d961b95010`, adds terminal excess-yaw
  amplitude relief. It preserves capture and slightly improves score from
  `-0.53776266` to `-0.53746247` and mean scoring distance from `2.435715L` to
  `2.435490L`, but arrives one integration step later (`23.8810T`) and leaves
  peak yaw essentially unchanged (`2.9486` versus `2.9489 rad/T`). Posterior
  speed-limit exposure is likewise effectively unchanged (`9.35%` versus
  `9.38%`). This is useful but weak evidence for retaining amplitude relief,
  not evidence that terminal course control is solved.
- The combined top-down/oblique sheets for `solver_f2d961b95010` and the
  informative v21 comparator `solver_dab3c6aa150e` show self-propelled motion,
  a coherent alternating vortex train, and the same smooth target-directed arc.
  No advection source or prewarm artifact is present. The v22 terminal change is
  smaller than keyframe resolution and does not visibly disrupt the carrier.
- Trajectory cross-check exposes a more specific residual: for v22, mean
  absolute velocity-to-line-of-sight angle grows from `0.316 rad` inside `3L`
  to `0.481 rad` inside `1L`; corresponding mean absolute target-transverse
  speed grows from `0.246` to `0.343 U`, while mean radial closing speed remains
  positive (`0.689` and `0.644 U`). Thus the fish is still making useful
  progress, but its inertial course becomes increasingly oblique near capture.

## Policy hypothesis

Use the sampled v22 controller as the carrier and add one small terminal course
residual. Compute signed transverse velocity relative to the instantaneous
head-to-target line from `target_body_L` and `velocity_body_U`; apply a smooth,
speed-gated, distance-gated countersteer to the existing target request. This
preserves the evaluated traveling wave, same-sign redirect, response release,
smooth acceleration envelope, and terminal amplitude relief. It adds no clock,
route state, world coordinate, target identity, or scalar-only gain probe.

Expected result: retain capture and coherent alternating wake while reducing
late course-angle/transverse-speed error, with earlier or lower-integral target
approach than v22. Reject the mechanism if capture time/mean distance do not
improve materially, if the alternating wake or path topology degrades, or if
posterior speed-limit exposure, peak yaw, command, lateral load, or yaw moment
worsens relative to the v22 baseline.

```text
bookshelf_consulted: true
source_domain: sensor-feedback direction tracking in robotic-fish CPG control
source_mechanism: bounded direction-error feedback modulates a stable rhythmic carrier
transferable_invariant: preserve the propulsive oscillator and correct persistent target-relative course error with a bounded observation-driven residual
nontransferable_details: published gains, dimensional beat settings, robot linkage kinematics, explicit oscillator phase, species envelopes, and prescribed routes
policy_translation: body-frame target and inertial velocity define signed line-of-sight transverse speed; a smooth terminal proximity and speed gate adds bounded countersteer to the two-joint target request
falsification: reject if v22 capture/directness does not improve or wake coherence, joint limits, yaw, commands, or load histories regress
```
