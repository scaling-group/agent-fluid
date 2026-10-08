# Phase-confidence yaw-feedback candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no prewarm, no cylinders) and capture. Three
  are byte-identical repeats of the assigned signed-curvature rate governor and
  reproduce `23.3640T`, mean score-distance `2.409486L`, and score
  `-0.51274776`; the ungoverned cadence contrast captures one step earlier but
  has a longer `13.4189L` path, larger `1.5749 rad/T` RMS yaw, and worse
  `-0.51527750` score. No sampled semantic-failure sheet exists, so the weaker
  capture and inherited regressions are the informative adverse cases.
- I inspected the combined sheets for the best governor, the weaker cadence
  capture, the inherited joint-load carrier gate, and the inherited
  gait-projected-yaw controller. The top-down rows all show self-propulsion
  from quiescent water, a coherent alternating street, and a broad closing
  turn. Their oblique Lambda2 rows confirm compact three-dimensional posterior
  structures through capture, without passive advection, collision, wake
  breakup, or instability. The adverse controllers therefore failed by route
  efficiency or actuation use, not by losing the basic traveling wake.
- Inherited evaluations now falsify the previous suggestion to keep withdrawing
  carrier energy. The shared angle/rate load gate reduced acceleration-ceiling
  residence from `69.61/50.68%` to `66.08/38.24%` and RMS yaw to
  `1.5077 rad/T`, but delayed capture to `24.8380T`, raised mean score-distance
  to `2.521632L`, lengthened path to `13.4430L`, and worsened score to
  `-0.62156406`. This agrees with three earlier cadence, positive-power, and
  velocity-damping regressions: lower saturation alone is not useful when
  forward progress is withdrawn.
- The one-coordinate gait-yaw projection also fails its intended separation.
  Relative to the rate governor, it delays capture to `24.4090T`, raises mean
  score-distance to `2.522887L`, lengthens path to `14.8232L`, raises RMS yaw
  to `1.6874 rad/T`, and raises posterior `96%` rate residence from `3.58%` to
  `13.86%`, producing score `-0.62376654`. A strong correlation between yaw
  and anterior joint rate did not justify subtracting a fixed signed proxy
  from the route observer.

## One policy hypothesis

Preserve the captured odd body-frame target-to-curvature map, continuous
geometry and bearing-trend feedback, traveling-wave carrier, posterior lag,
half-cycle steering, terminal cadence, and direction-selective output rate
governor. Change only the confidence applied to instantaneous yaw-rate
correction: infer beat phase from anterior joint speed normalized by the owned
rate envelope, retain full yaw feedback near stroke reversal, and smoothly
reduce it to a nonzero floor during fast mid-stroke. This avoids fitting or
subtracting a signed recoil amplitude, does not alter propulsion, and leaves
some yaw damping throughout the beat.

The intended effect is fewer gait-synchronous steering reversals and a shorter,
less oscillatory route without the thrust loss of carrier attenuation or the
bias of the failed linear yaw projection. Falsify the mechanism if capture is
lost; arrival, mean distance, path, yaw, force/moment, or rate residence worsens
materially; the rate correction remains dominated by gait phase; or either
visual row loses the coherent posterior traveling wake. A reflected target or
pose should retain a reflected mean course response.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and adaptive wake-interaction control
source_mechanism: separate fast gait-synchronous body motion from slow persistent route correction using observed oscillator state
transferable_invariant: trust route-rate feedback most when observed joint phase carries little propulsive recoil while keeping target geometry continuous
nontransferable_details: published CPG gains, dimensional cadence, species kinematics, fitted recoil amplitudes, exact vortex phases, and task routes
policy_translation: gate only the yaw-rate correction by bounded anterior joint speed normalized with the policy-owned rate limit; keep a nonzero mid-stroke floor and preserve the evidenced odd body-frame steering and carrier
falsification: reject if capture, reflected polarity, distance integral, path, arrival, yaw, actuator residence, loads, or top-down and oblique wake coherence worsen relative to the sampled rate governor
