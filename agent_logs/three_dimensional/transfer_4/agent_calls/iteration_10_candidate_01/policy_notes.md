# Error-qualified route-feedback candidate

## Visual and quantitative diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase-2 flow contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm snapshot,
  no cylinders, and capture termination. I inspected both the top-down
  vorticity and oblique Lambda2 rows of every combined keyframe sheet. Each
  fish self-propels from rest and retains a coherent alternating wake with
  compact three-dimensional posterior structures through capture. There is no
  passive advection, collision, wake breakup, or out-of-plane instability, so
  route geometry and terminal state—not wake existence—separate the policies.
- The assigned mean-curvature-only line-of-sight parent captures at
  `18.6175T`, score `-0.09127794`, mean distance `1.978602L`, center path
  `13.6033L`, and maximum straight-line cross-track `0.7700L`. Its route
  residual remains influential during approach: cross-track is `-0.4116L` at
  `2.1L`, approach mean course alignment is `0.5755`, and capture occurs with
  negative alignment `-0.5301` and yaw rate `-2.5557 rad/T`. The coherent wake
  therefore does not rescue an over-persistent route correction.
- The unqualified line-of-sight sample and its terminal course-handoff child
  capture at `17.8750T` and `17.8805T`, but score only `-0.08710319` and
  `-0.08868138`. Their essentially identical `12.966L` paths, `0.545L`
  cross-track, roughly `0.813` approach alignment, and roughly `0.11` capture
  alignment show that adding near-course feedback did not repair the route
  residual's late handoff. This agrees with inherited logs in which three
  terminal-only changes marginally improved alignment but worsened the
  distance objective.
- The error-qualified line-of-sight sample is the strongest available finite
  policy. It captures at `17.7265T`, improves score to `-0.08139542` and mean
  distance to `1.967391L`, shortens center path to `12.8468L`, limits maximum
  cross-track to `0.5120L`, and reaches the `2.1L` boundary with only
  `0.0183L` cross-track. Approach/final course alignment rise to
  `0.8993/0.6010`, while final yaw magnitude falls to `0.9008 rad/T`. Its
  `69.69/64.82%` acceleration-ceiling residence is essentially the same load
  class as the other posterior-priority samples, so the improvement comes from
  feedback qualification rather than carrier attenuation.

## One policy hypothesis

Replace the assigned parent's mean-curvature-only route residual with the
sampled error-qualified architecture as one candidate. Preserve the anterior
phase-plane oscillator, posterior lag and emphasis, odd curvature map,
half-cycle steering, cadence scheduling, and reversal-preserving rate
governor. Compute inertial line-of-sight drift from the co-windowed difference
between recent body turn rate and bearing rate, but multiply its bounded odd
correction by current normalized body-frame target error and a smooth
far/middle distance gate. Feed that qualified residual through the ordinary
two-joint steering path and make it identically zero throughout the validated
`2.1L` approach regime. This is an observation-to-feedback architecture
transfer, not scalar-only gain tuning, and uses no time, coordinates, case
identity, mutable state, or memorized route.

Expected evidence is retention of the sampled `17.73T` capture scale,
sub-`0.55L` cross-track, high approach alignment, and coherent two-view wake.
Falsify the candidate if formal rerun evidence loses capture, returns to the
parent's late route crossing or negative terminal alignment, materially
worsens distance/path/load, leaves route authority active after target error
centers or inside `2.1L`, or loses the posteriorly lagged wake.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical far/middle/near swimming control decomposition
source_mechanism: preserve a propulsive traveling-wave carrier while qualifying a bounded target-route correction by observable direction error and releasing it before terminal capture
transferable_invariant: route feedback should act only while normalized body-frame target error persists and should hand off continuously to a separately validated near controller without attenuating propulsion
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, evidence-specific distances, and prescribed routes
policy_translation: multiply co-windowed line-of-sight drift by body-frame bearing/vector-error and smooth far-distance gates, pass the result through the existing odd two-joint curvature and half-cycle path, and make it zero throughout approach
falsification: reject if capture, distance integral, route directness, approach alignment, actuator-load class, reflection symmetry, or top-down and oblique wake coherence regress
