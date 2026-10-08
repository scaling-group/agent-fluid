# Target-signed wrong-way-yaw burst redirect candidate

## Visual diagnosis and completed evidence

- Every sampled and inherited rollout inspected here reports direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Translation and wake development are therefore controller-generated
  rather than ambient advection or moving-window transport.
- The sampled `2.989L` response-released rollout is the strongest approach in
  the current four-solver sample. Its top-down row shows a coherent alternating
  vorticity street and its oblique row shows persistent three-dimensional
  Lambda2 structures while peak speed reaches `1.032U`; peak local flow is only
  `0.032U`. At closest approach speed remains about `0.77U`, but the joints
  settle toward a held posterior bend and the path hooks away. The sampled
  `4.859L` anterior-stiffness failure retains alternating shedding in both rows,
  but peak speed falls to `0.947U` and raw acceleration-envelope exceedance
  rises to about `53/64%` for the two joints. This continues to reject a global
  anterior stiffness asymmetry.
- The assigned-parent history establishes raw body-frame target-ray versus
  measured velocity-course feedback as the only observation change that made a
  semantic improvement: it retained the coherent traveling wake, reached
  `0.857L`, and replaced the repeated upper hook with a left exit. Static
  posterior-curvature and anterior-center continuations only reached
  `0.832--0.866L`, so more mean bend is not supported.
- The inherited moment-aligned anterior half-cycle continuation reached
  `0.834L`, versus `0.857L` for the course controller. It reduced the wrong-way
  yaw rate at closest approach from about `-1.06` to `-0.50 rad/T`, but did not
  capture, recover, lower command exceedance, or change the left-exit topology;
  raw exceedance remained about `58/68%`. Correct phase sign is therefore
  useful but insufficient when applied only through restoring-stiffness
  asymmetry.
- The prefilled phase-sway-compensated course rollout is a strong negative
  observation result. Both visual rows still show a self-propelled alternating
  wake, but closest distance degrades from the inherited `0.857L` to `4.459L`,
  peak speed falls to `0.902U`, and raw acceleration exceedance remains about
  `54/66%`. The offline joint-rate regression removed locomotor sway that the
  closed loop evidently needed; do not retain that compensation.

## Policy hypothesis written before the solver edit

Return to the demonstrated raw velocity-course controller and preserve its
full-quadrant target ray, speed blend, zero-centered anterior Van der Pol
carrier, complete posterior lag, damping, and `12 deg` mean-curvature cap.
Replace all prior terminal overlays with one response-gated burst redirect.
Inside `4L`, and only while wrapped course error is large and measured yaw is
moving opposite the requested turn, smoothly blend the anterior acceleration
toward a damped, bounded angle target whose sign is opposite the turn request.
Completed traces show anterior-angle sign follows yaw-moment sign while desired
yaw has sign opposite the turn request, so this is the target-useful direction.
Clamp the burst acceleration below the actuator envelope and leave the full
posterior traveling target active. Correct-sign yaw immediately removes the
response gate and restores the unshifted oscillator without a clock or hidden
mode.

The expected signature is the inherited broad sub-`1L` approach followed by a
brief correct-moment bend when terminal yaw is wrong-way, then renewed rhythmic
propulsion after response. This differs from failed static center shifts and
the earlier bearing/slip response gate: it uses the demonstrated velocity-course
observation, the rollout-calibrated opposite-sign anterior target, and bounded
PD redirection instead of persistently moving the oscillator center. Falsify
the mechanism if it loses the sub-`1L` approach or alternating 3D wake, raises
limit occupancy, cannot produce correct-sign yaw near the closest pass, or
repeats the left exit without capture or a distinct recovery arc.

```text
bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit a bounded large-error body bend, then release it into the propulsive rhythm when measured heading response appears
transferable_invariant: persistent large direction error combined with wrong-way yaw can gate a transient correct-moment redirect, while observed corrective response should continuously restore the cruise carrier
nontransferable_details: species-specific C-start shape and timing, published gains, robot linkage geometry, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame target-ray versus raw velocity-course steering; inside a normalized distance-and-error gate use measured heading rate to blend the anterior oscillator toward an opposite-turn-request bend, cap its acceleration, and preserve the complete posterior lagged target
falsification: reject if broad sub-1L approach or alternating 3D shedding is lost, acceleration occupancy rises, terminal yaw remains wrong-way, or capture and termination topology do not improve
```
