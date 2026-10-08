# Terminal moment-aligned anterior half-cycle candidate

## Visual diagnosis and completed evidence

- Every sampled and inherited rollout used direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Motion and wake development are therefore controller-generated rather than
  ambient advection or moving-window transport.
- In the strongest sampled broad approach (`2.989L`), the top-down row shows a
  coherent alternating vorticity street and the oblique row shows persistent
  three-dimensional Lambda2 shedding while the fish reaches `1.032U`; peak
  local flow is only `0.032U`. The rhythm then fades toward nearly fixed
  joints and the path hooks into the upper boundary. Raw acceleration-envelope
  exceedance is about `34/45%` for the anterior/posterior joints.
- The sampled `4.859L` anterior-stiffness failure remains visibly
  self-propelled and alternating in both rows, but peak speed falls to
  `0.947U` and raw acceleration exceedance rises to about `53/64%`. Its policy
  formula relaxes anterior restoring stiffness when `q1` shares the
  turn-request sign and strengthens the opposite side. Completed `4--12T`
  traces instead associate yaw-moment sign with `q1` sign (means near
  `-0.0078/+0.0079`), while requested yaw has sign opposite the turn request;
  the sampled implementation therefore prolonged the measured counter-moment
  side rather than testing moment-aligned allocation.
- The inherited body-frame target-ray/velocity-course controller is the only
  observation change to produce a semantic improvement: its two visual rows
  retain a coherent 3D traveling wake, it reaches `0.857L`, and it changes the
  upper hook to a left exit. At closest approach it is still moving at
  `0.845U` with about `1.42 rad` wrapped course error, so the remaining miss is
  active terminal course authority rather than passive advection or coasting.
- The assigned parent's terminal posterior counter-half relief preserves the
  same visual approach and reduces posterior raw acceleration exceedance from
  about `67.6%` to `63.5%`, but closest-pass speed falls to `0.792U`, wrapped
  course error remains about `1.42 rad`, closest distance worsens to `0.867L`,
  final distance worsens to `9.510L`, and termination remains a left exit.
  Attenuating the lagged posterior carrier therefore traded some effort for
  speed without producing the required net yaw.

## Policy hypothesis written before the solver edit

Start from the demonstrated velocity-course controller and preserve its
normalized full-quadrant target ray, speed blend, bounded posterior mean
curvature, complete lagged posterior carrier, damping, and zero-centered
anterior oscillator. Replace the failed posterior relief with one terminal
moment-aligned half-cycle mechanism. When distance is below `4L` and wrapped
course error is materially nonzero, use observed anterior angle as the
rollout-calibrated phase signal. Since desired yaw has sign opposite the turn
request, lower anterior restoring stiffness on the `q1 * turn_request < 0`
useful-moment side and raise it on the `q1 * turn_request > 0` counter-moment
side. This lengthens only the useful dwell and shortens the counter dwell;
there is no static joint center, carrier attenuation, clock phase, or route.

The broad approach should remain identical outside the terminal gate. Inside
it, the expected signature is a target-signed anterior moment imbalance with
the complete posterior traveling wake retained, moving the inherited tangent
pass through the `0.75L` capture radius. Falsify the mechanism if the broad
sub-`1L` approach or alternating 3D wake is lost, closest distance does not
beat `0.857L`, the left-exit topology repeats without a distinct recovery arc,
or anterior acceleration/angle occupancy materially exceeds the inherited
course controller.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping, constrained by classical posterior traveling-wave propulsion
source_mechanism: allocate anterior half-cycle duration and restoring work asymmetrically while preserving the lagged propulsive carrier
transferable_invariant: use observed joint phase to shorten the half-cycle whose measured moment opposes the requested yaw and retain or lengthen the useful half-cycle without imposing a static bend
nontransferable_details: published gains and duty ratios, robot linkage geometry, species-specific kinematics, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame target-ray versus measured-course steering; use anterior angle as the evidenced phase signal; only near the target and at large wrapped course error, decrease anterior restoring stiffness when q1 moment is target-useful and increase it when q1 moment is counter-target
falsification: reject if the broad sub-1L approach or alternating 3D shedding is lost, actuator occupancy rises materially, closest distance does not beat 0.857L, or capture/termination topology does not improve
```
