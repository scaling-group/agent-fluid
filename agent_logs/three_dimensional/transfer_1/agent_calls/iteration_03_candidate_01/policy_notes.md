# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled rollouts are finite, direct-uniform still-water evaluations
  with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and inertial
  moving-window transport. Their motion is self-propelled rather than ambient
  advection, and none captured the target.
- Both visual rows show that propulsion is already useful. The top-down sheets
  contain coherent alternating vorticity behind every swimmer, and the oblique
  Lambda2 sheets retain compact three-dimensional structures through each
  route. The failures are controlled-trajectory and terminal-capture failures,
  not wake collapse or numerical instability.
- The assigned-parent evidence and inherited notes show that sign inference
  from the prefill was insufficient: the prefill/course-residual family closed
  only to `6.127L`/`6.067L` before a long lower-boundary exit, while two direct
  posterior mean-curvature reversals curled almost immediately to the upper
  boundary and closed less than `0.13L`. The sampled yaw brake improves the
  scalar and retains closure to `5.323L`, but still crosses the lower boundary
  with a `9.223L` final distance. Static curvature sign or more course gain is
  therefore not an evidenced next step.
- The useful semantic change is the achieved-course servo in
  `solver_1f40fb567c74`. Its top-down route passes close to the target and its
  oblique row preserves the alternating carrier wake; closest head distance is
  `1.0435L` at `18.854T`, only `0.2935L` outside capture. At that instant it is
  still moving at `0.849L/T`, with body-frame target angle `1.241 rad`, course
  angle `-0.490 rad`, and target-versus-course error about `1.731 rad`. It then
  crosses below the target and exits the lower boundary at `34.177T`.
- The near miss is not evidence for increasing shared steering acceleration.
  Its raw combined action exceeds the `31.416 rad/T^2` acceleration envelope
  on about `96.9%` of logged samples, while the coherent carrier is already
  fast enough to reach `0.930L/T`. The phase-compensated mean-curvature example
  clamps its actions but still saturates at least one joint on about `91.3%` of
  samples and misses by `3.003L`. The terminal deficit is carrier/steering
  headroom and inertial overrun, not absent propulsion.

## One candidate mechanism

Use the evidenced achieved-course servo and joint-state traveling wave from
`solver_1f40fb567c74` as the scaffold. Add one continuous terminal-capture
allocation mechanism: inside a normalized approach region, continuously weight
oscillator-cadence relief by measured closing speed, with greatest relief
during positive closure, while retaining the full bounded course-steering
request. The relief vanishes far from the target and when the fish is reopening,
so recovery does not become an unpowered coast. Clamp the combined two-joint
command at the
owned acceleration envelope.

Expected test: retain the early alternating wake and route closure of the
achieved-course servo, but enter the `0.75L` capture circle with lower speed and
more acceleration headroom for the already-correct positive course command.
Reject the mechanism if closest approach fails to improve on `1.0435L`, the
carrier wake or early progress collapses, near-target action remains
persistently clipped, or the same below-target/lower-boundary topology remains.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal approach regulation
source_mechanism: preserve a propulsive traveling rhythm while measured proximity and closing response continuously release carrier authority for corrective steering
transferable_invariant: after target-directed motion is established, a fast near approach should reduce propulsion without discarding the body-frame feedback needed to correct cross-target motion
nontransferable_details: published CPG gains, robot geometry, dimensional cadence, species kinematics, prescribed burst timing, exact vortex phase, and any task-specific route
policy_translation: use only normalized distance and window closing speed to bound near-target oscillator-frequency relief, preserve the target-versus-body-course steering loop, and clamp the two owned joint accelerations
falsification: reject if early closure or wake coherence degrades, the `1.0435L` near miss does not improve, near-target saturation persists, or the fish repeats the lower-boundary exit

## Non-CFD checks after editing

- Static schema comparison finds every direct `params.FIELD` reference in the
  returned parameter tuple; the combined command is clamped at
  `31.416 rad/T^2` on both joints.
- Replaying only the new terminal gate on the inherited near-miss trace leaves
  its broad approach unchanged through `4.316L`. During positive closure the
  frequency multiplier is about `0.743` at `2.617L` and `0.594` at `1.232L`,
  then returns to `0.997` after distance reopens. This is a signal/gating check,
  not CFD evidence of improved capture.
- The lightweight Julia execution check could not run because neither the
  workspace shell nor its environment-module tree provides a `julia`
  executable. The independent guidance and editable-boundary checks pass.
