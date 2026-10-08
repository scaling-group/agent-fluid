# Joint-speed viability candidate

## Evidence and visual diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot, and all
  terminate in capture. In the combined sheets for the strongest finite
  example `solver_bb2a1c7cb2a0` and the informative hard-stop example
  `solver_3991cf23285f`, the top-down rows show a target-directed arc with a
  sustained alternating vorticity street. Their oblique rows show compact
  three-dimensional Lambda2 structures shed from the caudal region through
  approach. Peak local flow is only `0.0325U` while the strongest fish reaches
  `1.393U`, so the visible translation is self-propelled rather than ambient
  advection. The inherited `solver_e90ba1ded0d9` sheet is the useful actual
  failure contrast: its alternating wake survives a broad smooth command
  compression, but the route misses the target and exits left after reaching
  only `5.621L`; wake coherence alone does not establish route authority.
- The prefilled high-knee exponential shoulder is a completed improvement over
  the sampled global stopping-risk controller, not an unevaluated idea. It
  preserves capture while advancing arrival from `18.276T` to `16.943T`,
  lowering mean distance from `2.1350L` to `2.0899L`, and increasing peak
  speed from `1.329U` to `1.393U`. It also keeps returned acceleration peaks at
  `29.845 rad/T^2`, below the owned `31.416 rad/T^2` envelope, instead of the
  baseline's `59.87/88.41 rad/T^2` requests.
- The shoulder retains the inherited mechanical improvement. Posterior angle
  stays in `[-31.25,+33.85] deg`, rather than approaching `-43.00 deg`, and
  peak planar-force/yaw-moment coefficients are `0.03609/0.01766`, no worse
  than the continuous stopping-risk baseline's `0.03716/0.01907`. It should
  therefore remain the carrier, course-steering, acceleration-allocation, and
  angle-safety baseline for this candidate.
- The remaining hard-envelope signature is joint velocity. Both joints still
  reach exactly `260 deg/T`; joint 1 is at at least 95/99 percent of the speed
  limit for `9.83/5.68%` of samples and at the cap for `3.73%`, while joint 2
  occupies those bands for `8.37/5.00%` and `3.54%`. Thus acceleration command
  feasibility did not remove velocity clipping. The reusable issue is
  repeated acceleration in the current motion direction near a measured
  joint-speed boundary, not insufficient propulsion gain.

## Policy hypothesis

Preserve the complete prefilled target-ray/velocity-course controller, its
zero-centered anterior oscillator, posterior acceleration reserve, high-knee
soft shoulder, and posterior stopping-risk barrier. Add one actuator-state
mechanism after angle protection: a continuous joint-speed viability
projection for both joints. From each measured joint velocity, compute the
signed acceleration ceiling proportional to buffered remaining speed margin;
only acceleration along the current motion direction is lowered, while
natural reversal, steering braking, and angle-safety braking pass unchanged.
The limit, fractional buffer, and dimensionless response gain are owned by
`target_policy_params`.

A fixed-state replay on the successful trace with a two-percent speed buffer
and a response rate of four carrier frequencies changes `10.13/8.96%` of
joint-1/joint-2 commands with RMS deltas `3.93/4.80 rad/T^2`; this calibrates a
localized test but is not a CFD outcome. The expected rollout preserves
capture, the alternating three-dimensional wake, the sub-`17T` approach, and
the `0.0361/0.0177` load ceiling while reducing exact speed-cap residence and
outward work at the cap. Falsify the mechanism if capture is lost, arrival or
mean distance materially regresses toward the `18.276T/2.135L` baseline, the
wake or course topology changes, either load ceiling increases, a joint limit
is contacted, or speed-limit residence is not reduced.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and classical elongated-body propulsion
source_mechanism: sensor feedback modulates only the constraint-violating part of a low-dimensional traveling-wave carrier while retaining posterior propulsive emphasis
transferable_invariant: preserve the evidenced traveling bend and continuously project only joint motion that approaches a measured mechanical boundary, releasing the correction with velocity reversal
nontransferable_details: published gains, dimensional frequencies, duty ratios, species-specific kinematics, linkage geometry, exact vortex phases, source actuator ratings, and task-specific routes
policy_translation: retain body-frame target/course feedback and joint-state carrier phase; use each normalized joint speed and the owned speed/acceleration envelopes to cap only acceleration along motion near a buffered velocity boundary
falsification: reject if capture, the sub-17T useful trajectory, alternating shedding, angle clearance, or the sampled load ceiling is lost, or if exact joint-speed-limit residence does not fall
```
