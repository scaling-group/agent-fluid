# Multi-wake candidate diagnosis

## Evidence read before the edit

- The assigned parent is the fresh common guidance seed; no inherited
  `logs/optimize` artifact is present. The only sampled solver is the common
  naive policy, so the useful comparison is its initially finite approach
  against its own informative terminal failure rather than a claim that a
  stronger sampled controller exists.
- The shared prewarm sheet shows a developed, interacting four-cylinder wake
  around a held fish. At release the fish begins outside the organized wake
  region, already oriented broadly toward the lower-left target.
- In the released sheet the joint wave is vigorous, but the trajectory quickly
  bends into a near-vertical downward transit and leaves the lower domain after
  only `50.1269` released time units. It never reaches the target wake region.
  The fish is not merely passively advected: its repeated body wave and curved
  path show active propulsion, but that propulsion lacks target-relative
  steering.
- Metrics agree with the pictures: head displacement is `(-3.545, -13.300)L`,
  minimum distance briefly improves to `8.615L`, yet final distance is
  `12.123L` and net progress is only `0.0243`. RMS lateral force `21.943` and
  moment `541.704` accompany the wrong-way turn. Both joint accelerations hit
  `31.416 rad/time^2` and both velocities hit `4.538 rad/time`, so the seed also
  consumes the stated hard acceleration/velocity envelope while failing to
  retain heading.

## Policy hypothesis

Retain a state-feedback traveling bend, but center its head and tail joint
motions around a bounded mean-curvature request computed from the current
body-frame target bearing. This adds the missing semantic capability—target
steering—without a clock, cylinder coordinates, or a memorized route. Use a
slower, smaller version of the same gait whose nominal angle, velocity, and
acceleration leave room for the curvature bias, because an acceleration-only
steering residual would otherwise compete with the seed's observed hard-limit
saturation.

The candidate should turn back whenever the target develops a lateral
body-frame offset while preserving alternating posterior lag. It is falsified
if the next rollout retains the same downward domain-exit topology, reverses
the required turn sign, loses upstream/targetward propulsion, persistently
saturates the joints, or trades the domain exit for collision/instability.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking
source_mechanism: sensor-driven mean-curvature tail-beat offset superimposed on a propulsive rhythm
transferable_invariant: a slow body-frame direction error can drive bounded average curvature while an alternating posterior-lagged bend continues to provide thrust
nontransferable_details: published CPG gains, dimensional frequencies, species kinematics, exact wake phase, cylinder layout, and source-task paths
policy_translation: saturate normalized body-frame bearing into joint-center biases, run the anterior state oscillator about its bias, and make the posterior joint track a biased lagged anterior wave
falsification: reject the transfer if target-bearing error does not reverse the visible wrong-way turn, if propulsion collapses, or if saturation, loads, collision, instability, or the same lower-boundary exit persist
