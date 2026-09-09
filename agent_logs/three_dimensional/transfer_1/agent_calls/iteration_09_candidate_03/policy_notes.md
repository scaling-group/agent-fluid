# Wake-policy candidate diagnosis

## Evidence read before editing

- All sampled episodes are finite direct-uniform releases in still water with
  `U_infinity=[0,0,0]`, zero cylinders, and no prewarm. The combined sheets'
  top-down and oblique rows show self-propelled motion and a coherent
  alternating wake rather than advection or instability.
- The sampled phase-compensated bearing and achieved-course rate cascades keep
  swimming above the target and reach only `3.0031L` and `3.1135L` before
  `left_domain`. Opposing-half carrier attenuation redirects the route to
  `1.2669L`, but the late top-down wake fades, joint phase-plane energy falls
  below `0.2`, and the fish coasts through the lower boundary. These failures
  do not support more route gain, another yaw-rate cascade, or further carrier
  suppression.
- The assigned-parent history tests three different terminal interventions.
  Energy recovery reaches `1.1444L`, additive slip response reaches `1.0561L`,
  and closing-speed cadence relief reaches `1.0959L`; all preserve the same
  lower-exit termination. Thus recovered oscillation, additive posterior
  curvature, and approach slowing are not sufficient capture mechanisms.
- The line-of-sight-guarded response-release sample is the only semantic
  success: it captures at `0.7493448L` after `18.6065T`, with score `-0.163`,
  `93.9%` minimum-distance progress, a coherent alternating terminal wake,
  and `54--55 deg` sub-`4L` joint excursion. It preserves the achieved-course
  request, releases shared steering when phase-compensated yaw shows a useful
  turn, and re-engages that same steering when normalized inertial
  line-of-sight rate predicts a growing miss.
- The demonstrated capture is narrow and highly actuated: the terminal action
  reaches the acceleration envelope on about `72.8%/75.9%` of logged rows,
  and the final head distance is only about `0.00065L` inside the capture
  radius. Those facts are a robustness warning, but there is no completed
  evidence that changing its gains or adding another terminal actuator would
  preserve success. The candidate therefore transfers the evaluated mechanism
  and parameterization unchanged rather than tuning a scalar around one run.

## Policy hypothesis and falsification

Replace the prefilled achieved-course yaw-rate cascade with the sampled
line-of-sight-guarded response-release architecture. Keep the joint-state
traveling-bend carrier and normalized target-versus-achieved-course outer loop.
Inside the terminal distance gate, use joint-velocity-compensated body yaw as
evidence that a requested turn is taking effect, but permit steering release
only while the body-frame target/velocity cross product says inertial
line-of-sight miss rate remains small. This separates route sensing from
response sensing without a clock, world coordinate, route memory, new gain
sweep, or carrier attenuation.

Expected test: reproduce the sampled capture class and coherent terminal wake,
thereby materially improving the prefilled `3.1135L left_domain` trajectory.
The exact policy has completed CFD evidence, but this workspace's formal
evaluation still occurs only after exit.

Falsification: reject the transfer if the new evaluation does not capture,
changes the early closure or alternating wake, increases joint-speed or
acceleration saturation, or returns to the lower-exit topology. Because the
known success margin is narrow, later workers should test held-out initial pose
or target perturbations before treating it as robust; they should not infer
that more steering gain, cadence relief, slip curvature, or carrier recovery
will widen the margin without new evidence.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish direction control
source_mechanism: release target-directed steering into a propulsive rhythm only after observed turning response, while restoring authority when approach geometry still predicts a miss
transferable_invariant: preserve the traveling carrier and let normalized geometric response, rather than elapsed phase or route memory, decide whether bounded steering may be released
nontransferable_details: species-specific C-start shapes, published gains, robot kinematics, dimensional cadence, prescribed beat or vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity to guard joint-compensated yaw release in the two-joint achieved-course controller
falsification: reject if the demonstrated capture class, coherent wake, early closure, or actuator behavior does not reproduce, or if the lower-exit class returns
