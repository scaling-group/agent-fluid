# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the common upper-right release pose while the four staggered cylinder
  streets develop and merge through the target region. This is common
  initial-condition evidence, not a controller difference.
- No sampled rollout is a semantic failure: the `1600`, two exact `1650`, and
  `1675 deg/time^2` posterior-bound policies all capture without collision,
  domain exit, horizon miss, or instability. The useful adverse comparator is
  therefore the weaker successful `1675` continuation, while the two exact
  `1650` records establish repeatability at the adjacent anchor. The inherited
  logs supply stronger mechanism boundaries: weakening amplitude to 27 degrees
  fell behind, gain/allocation/lag/damping refinements were non-monotonic, and
  auxiliary mixed feedback became unstable at release time `2.807`.
- The released sheets show the same safe topology: an initial target-facing
  turn, vigorous periodic self-propulsion down and left, late entry into the
  merged wake corridor, and first-crossing capture without approaching a
  cylinder. At matched intermediate frames the `1600` fish is farther along
  this route than the `1650` and `1675` fish. Its mean velocity
  `(-0.3380,-0.1396)` differs materially from mean local flow
  `(-0.1822,-0.1953)`, especially in useful leftward progress, and its dense
  alternating trail persists through approach; the motion is not passive
  advection and the lateral oscillation remains productive.
- With all other policy fields fixed, sampled `1600` improves on the two exact
  `1650` records: score `0.217528` versus `0.189303`, arrival `32.202` versus
  `33.027`, mean distance `1.6541L` versus `1.6831L`, energy/power
  `40126/3010` versus `42310/3183`, and posterior excursion `0.474` versus
  `0.495` rad. The posterior acceleration maxima equal their respective caps
  (`27.925` and `28.798 rad/time^2`), so the tested parameter remains active.
- Crucially, the assigned-parent warning against `1600` is falsified by the
  current rollout. Rather than disproportionate load growth beyond the `1650`
  `0.2358/63.93/859.31` crossflow/force/moment envelope, `1600` measures
  `0.2321/64.77/860.25`: crossflow decreases and force/moment are nearly flat
  while navigation, effort, and both joint excursions improve. This does not
  prove a general tighter-is-better law or robustness beyond the certified
  wake phase.

## Single-candidate hypothesis

Continue only the active posterior acceleration-bound axis by one equal
`50 deg/time^2` step, from `1600` to `1550 deg/time^2`. Preserve the
`0.55`-period, 28-degree oscillator, lag `0.75`, damping `0.65`, bounded
body-frame bearing gain `1.7`, 12-degree steering limit, fraction-`0.35`
allocation, and existing observations. The candidate tests whether the
navigation/effort improvement persists for one more isolated step after the
load tradeoff flattened; it does not add a route, clock, coordinate, or
unscaled wake-specific signal.

The later CFD rollout supports `1550` only if it preserves the visible safe,
self-propelled turn-then-diagonal capture and improves arrival, mean distance,
or effort beyond the `1600` anchor without material regression in the other
navigation measures. Loss of capture or route, collision, exit, instability,
posterior excursion above the `1650` value `0.495` rad, relative crossflow above
`0.25`, force RMS above `75`, or moment RMS above `1000` rejects further
tightening. Even a positive result remains limited to the certified wake phase
and start pose until a held-out wake or geometry evaluation exists; no
current-worker CFD result is assumed.
