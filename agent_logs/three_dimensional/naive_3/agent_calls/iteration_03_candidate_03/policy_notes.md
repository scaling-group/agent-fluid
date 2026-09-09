# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance and inherited first-worker note establish that
  the naive joint-state oscillator/posterior-lag carrier self-propels in valid
  direct-uniform still water, but it has no route control: bearing crossed the
  body centerline while clockwise yaw persisted, and the seed exited the upper
  boundary. All four current samples are also finite, direct-uniform
  `U_infinity=(0,0,0)` rollouts with no prewarm snapshot, so their controller
  differences are usable evidence.
- Both the top-down vorticity and oblique Lambda2 rows were inspected for all
  four current samples. The assigned `14 deg` split-curvature parent has a
  short, weak wake and almost no target progress (`12.291L` minimum, upper exit
  at `9.663T`). The restrained `7 deg` carrier instead produces a long coherent
  alternating wake. Its ungated form reaches `4.067L`; state-phased half-cycle
  authority reaches `3.587L` but caps both commands in about three quarters of
  recorded rows; alignment-gated posterior propulsion is the strongest
  sampled mechanism, reaching `2.443L` and surviving to `31.097T`.
- The strongest trajectory is a powered cross-track near miss, not advection,
  wake collapse, a moving-window jump, or a load instability. It passes below
  the target, then exits the lower boundary at `9.193L`. At closest approach
  (`17.869T`) its head is `(10.705,7.750)L`, body-frame bearing is `1.421 rad`,
  world velocity is `(-0.628,-0.272)L/T`, and instantaneous heading rate is
  `+2.037 rad/T`; the target is nearly lateral while the fish still has
  substantial speed. Local flow, force, and yaw moment remain modest there
  (`(-0.019,-0.001)U`, `(0.000,-0.008)`, and `-0.004` respectively), while
  both joint speeds have touched the `260 deg/T` envelope. The failure is
  therefore steering-response semantics under a preserved carrier, not a
  missing wake-rejection term or a reason to increase scalar drive.
- The strongest policy computes `bearing - k*heading_rate`, although positive
  mean curvature produces negative yaw in this spine convention. That sign is
  anti-damping: correct negative yaw increases the bend request, while wrong
  positive yaw reduces it. For example, at `14T`, bearing `0.536` and heading
  rate `+2.595` nearly cancel its request precisely when the target is moving
  off axis. The assigned parent's correct response sign did not rescue its
  excessive `14 deg`/weak-carrier topology, so the supported translation is to
  repair the sign on the sampled `7 deg` posterior-gated carrier, not revive
  the failed high-curvature split.

## Policy hypothesis

Retain the strongest sample's bounded `7 deg` mean-curvature carrier,
misalignment-gated posterior wave, and acceleration reserve. Replace its
anti-damped instantaneous yaw term with bounded recent-turn-response damping:
because positive curvature creates negative yaw, use `bearing + k*turn_rate`.
Correct negative yaw then releases curvature, and wrong positive yaw increases
the counter-turn, without adding time, world coordinates, a route, or another
actuator primitive. Expected evidence is the same coherent left/down approach
and sub-`4.067L` progress, followed by smaller lateral bearing, a closest
approach below `2.443L`, and no repeated lower-boundary overshoot. Reject the
translation if the early wake/progress collapses, yaw oscillation grows, the
same powered bottom-exit topology remains, or command/rate-limit residence or
loads worsen.

```text
bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG direction tracking and biological burst-redirect turning
source_mechanism: target error biases mean bend while observed turn response releases or reverses that bias without stopping the propulsive rhythm
transferable_invariant: signed body-frame route error and measured yaw response must form damping under the actuator-to-yaw sign, preserving the traveling carrier
nontransferable_details: published gains, clocked CPG phases, robot geometry, species-specific burst kinematics, dimensional turn rates, exact vortex phases, and task-specific routes
policy_translation: preserve the sampled bounded 7 deg posterior-gated joint-state carrier and change its response term to bearing plus bounded recent turn rate because positive curvature produces negative yaw
falsification: reject if coherent early propulsion or sub-4.067L progress is lost, closest approach does not improve below 2.443L, the powered lower-boundary overshoot persists, or actuator-limit residence and loads worsen
```
