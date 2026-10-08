# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis before editing

- The assigned parent is the target-blind `0.55`-period, 28-degree
  joint-state oscillator. The common prewarm sheet shows the held fish at the
  upper-right release pose and four developed, interacting staggered vortex
  streets; that flow is identical initial-condition evidence for all sampled
  candidates.
- The parent seed visibly self-propels upstream at first, but it yaws sharply
  downward before entering the target corridor and leaves the lower boundary
  after `50.1269/300`. Its `(-3.545,-13.300)L` head displacement, distance
  rebound from `8.615L` to `12.123L`, and mean local/fish vertical velocities
  of `-0.241/-0.263` agree that its brief upstream motion is not controlled
  navigation. Both joint-rate and acceleration caps are reached and mean
  command energy is `1496.25`.
- The strong finite comparator adds only bounded body-frame bearing steering
  to that propulsion mechanism. Its keyframes show an initial corrective turn,
  followed by a nearly horizontal leftward traverse that enters the developed
  wake and crosses the `0.75L` target radius. It reaches the target at
  `41.316`, with `0.940` progress, mean/final distance `1.919/0.750L`, and
  head displacement `(-10.910,-4.251)L`. Its finite RMS force/moment
  (`41.98/660.23`) are far below the multi-signal instability, although it
  still reaches the rate and acceleration envelopes.
- The negative comparisons constrain the mechanism. A moderated `0.60`/24
  degree oscillator with the opposite bearing-curvature sign turns toward the
  nearby right boundary and exits after `11.335`; the `0.95`/15 degree
  posterior-only negative bias never improves on the initial distance and
  exits downward after `76.692`; and adding bounded lateral-velocity and moment
  terms to a slower oscillator produces instability at `2.807`, with RMS
  force/moment `5.33e4/6.88e5`. These outcomes do not support reversing the
  demonstrated sign, slowing propulsion, or mixing extra feedback into the
  first promoted anchor.

## Candidate policy hypothesis

Promote the successful sampled structure and parameter values as one candidate:
retain the state-encoded `0.55`-period, 28-degree traveling-bend oscillator;
map clamped body-frame bearing smoothly to at most 12 degrees of steering;
place 40 percent of that command at the anterior oscillator center; and center
the total posterior tangent on the full steering command. This is a single
target-aware architecture change from the assigned parent and uses no global
coordinates, elapsed time, route, cylinder identity, or unavailable flow
probe. Every active gain and bound remains owned by `target_policy_params()`.

The prior rollout predicts target crossing near `41.3` with the visible
turn-then-leftward trajectory. The new evaluation must still falsify the
candidate if it fails to capture, turns toward a boundary, becomes unstable,
or loses most upstream progress. Because the successful comparator contacted
the joint-rate and acceleration envelopes, exact capture is the promotion
criterion here; a later worker should tune one propulsion parameter at a time
against this anchor and require capture plus reduced cap contact before
claiming an efficiency improvement.
