# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis

- The shared prewarm sheet shows the common held fish at the upper-right
  release pose above four developed, interacting staggered wakes. This is the
  same initial condition for every sampled controller and is not policy credit.
- The assigned-parent candidate is the strongest finite comparator. Its
  unchanged `0.55`-period, 28-degree propulsion oscillator plus a smooth,
  positive bearing-centered bend drives a direct diagonal traverse into the
  target ring in `41.316` release-time units. The released keyframes show a
  dense self-propelled trail, an early heading adjustment, and then sustained
  motion toward the wake corridor rather than passive advection. The metrics
  support that reading: head displacement is `(-10.910,-4.251)L`, progress is
  `0.9397`, and mean/final distance is `1.919/0.750L`.
- The target-blind seed uses the same propulsion settings but turns down and
  exits after `50.127`, with displacement `(-3.545,-13.300)L`, only `0.0243`
  progress, and final distance `12.123L`. This isolates bounded target-bearing
  curvature as the demonstrated missing capability more cleanly than gait
  vigor alone.
- The inherited parent log proposed exactly that minimal capability while
  preserving the seed oscillator; its now-sampled successful rollout upgrades
  the log's hypothesis to evaluated evidence. The other inherited notes
  proposed slower, reduced gaits with different steering structures, whose
  sampled failures do not validate their expected actuation-headroom benefit.
- The two reduced/slower sampled policies do not supply evidence for weakening
  the successful gait. The `0.95`-period, 15-degree posterior-bias controller
  moves downstream, exits after `76.692`, and has negative progress; the
  `1.1`-period controller with opposite-sign bearing plus lateral-velocity and
  moment terms becomes unstable at `2.807` with force/moment spikes. Because
  those policies also change steering sign, bend distribution, and auxiliary
  feedback, their lower effort does not establish that slowing the successful
  controller is beneficial.
- The successful comparator still reaches both rate and acceleration caps and
  has mean command energy `1404.94`, but energy has zero score weight and the
  available results do not separate saturation from the propulsion required
  for capture. Its force and moment RMS (`41.98`, `660.23`) remain finite and
  far below the unstable comparator. This candidate therefore does not trade
  away proven propulsion or introduce unscaled wake/load feedback.

## Candidate hypothesis

Preserve the successful oscillator, posterior phase lag, positive curvature
sign, two-joint steering distribution, and 12-degree steering bound. Increase
only the smooth bearing gain from `1.5` to `1.7`. The released success sheet
shows an early heading correction before the trajectory settles onto the
target diagonal; a modestly steeper near-zero bearing response should complete
that alignment sooner while `tanh` retains the same worst-case bend and joint
state continues to encode propulsion phase.

The post-worker CFD evaluation should falsify this local refinement if capture
is later than `41.316`, if mean distance exceeds `1.919L`, if the fish develops
a larger lateral arc or misses the `0.75L` ring, or if finite force/moment loads
turn into instability. If so, later workers should restore `1.5` and probe a
small decrease or a separately bounded turn-rate damping term rather than
changing propulsion and steering together.
