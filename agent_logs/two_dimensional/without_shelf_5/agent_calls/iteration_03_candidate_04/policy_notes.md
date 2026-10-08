# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The common prewarm sheet shows the fish held at the upper-right release pose
  while the four staggered-cylinder wakes develop across the release-to-target
  corridor. This flow state is shared by every candidate, so only released
  motion is policy evidence.
- The assigned `steering_gain=1.5` parent is already a finite, self-propelled
  success. Its keyframes show an early turn from the release heading followed
  by a direct diagonal traverse into the developed wake and target ring. The
  trail remains tail-scale rather than becoming a broad lateral escape, and
  the metrics confirm useful propulsion rather than passive advection: mean
  fish velocity in x is `-0.263` versus mean local flow `-0.160`, head
  displacement is `(-10.910,-4.251)L`, and capture occurs at `41.316` with
  mean/final distance `1.919/0.750L`.
- The strongest current sampled result changes only the smooth bearing gain
  from `1.5` to `1.7`. Its sheet follows the same collision-free topology but
  aligns onto the leftward target traverse slightly earlier and finishes at
  `39.710`. Cross-checked metrics all move in the useful direction: mean
  distance falls to `1.874L`, mean command energy to `1377.57`, RMS relative
  crossflow to `0.2265`, and RMS force/moment to `38.40/618.59`, versus
  `1404.94`, `0.2364`, and `41.98/660.23` for the parent. Maximum joint
  excursions also decrease, although both policies still touch the rate and
  acceleration caps. This supports a steeper near-zero bearing response, not
  more steering authority, because the `tanh` command remains bounded at the
  same 12 degrees.
- The inherited multi-signal failure is a useful boundary. Its two-frame sheet
  ends before any wake entry or target-directed traverse, and the metrics show
  instability at `2.807`, negligible head displacement, negative progress,
  relative-crossflow RMS `3.67`, and force/moment RMS above
  `5.3e4/6.8e5`. Because that policy simultaneously slowed propulsion,
  reversed bearing curvature, and added velocity/moment feedback, it supplies
  no reason to disturb the successful oscillator or add those channels.

## Candidate policy hypothesis

Produce exactly one candidate by retaining the successful `0.55`-period,
28-degree oscillator, positive curvature sign, two-joint steering
distribution, and 12-degree bound, while increasing only `steering_gain` from
the sampled `1.7` to `1.9`. The evaluated `1.5 -> 1.7` change improved arrival,
distance, effort, relative crossflow, and loads without changing the maximum
steering command. Repeating that small local step should reduce residual early
bearing error and shorten the diagonal approach while preserving boundedness.

The post-worker CFD result must falsify this extrapolation if it loses capture,
arrives later than `39.710`, raises mean distance above `1.874L`, develops a
larger lateral arc, or reverses the sampled reductions in mean effort and
force/moment RMS. A failure at `1.9` would establish a local bracket: later
workers should return to the evaluated `1.7` anchor and test between `1.7` and
`1.9`, rather than changing propulsion or adding wake/load channels in the
same candidate.
