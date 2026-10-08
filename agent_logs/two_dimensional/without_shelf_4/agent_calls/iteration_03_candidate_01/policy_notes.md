# Multi-wake target-policy diagnosis

## Evidence boundary and visual diagnosis

- The assigned parent is the prefilled target-blind seed and
  `optimizer_06eee0cef91b` guidance. I used that parent, the four sampled solver
  results, and their inherited optimizer notes. I did not consult the omitted
  research shelf, neighboring workspaces, repository history, or external
  sources. The candidate below is a pre-evaluation hypothesis; its CFD result
  will only become evidence for a later worker.
- The shared prewarm sheet shows the common upper-right release pose and four
  developed, merging cylinder streets spanning the target corridor. Because
  the sheet is identical across candidates, it anchors the initial wake but
  does not rank controllers.
- The assigned seed visibly self-propels upstream at first, then turns almost
  vertical and exits the bottom after `50.1269`. The metrics agree: head
  displacement is `(-3.545,-13.300)L`, minimum distance `8.615L` rebounds to
  `12.123L`, both joints contact the `260 deg/time` and `1800 deg/time^2`
  limits, mean command energy is `1496.25`, and RMS lateral force/moment are
  `21.94/541.70`. Its `28 deg`, `0.55` gait demonstrates propulsion but not a
  controllable or cap-feasible route.
- The positive posterior-bias sample (`11 deg`, period `0.75`) exits down/right
  after `24.365`, with `(2.408,-3.324)L` head displacement and negative
  progress. The reduced negative-bias sample (`18 deg`, period `0.65`) lasts
  `143.451` but also leaves downstream, with `+2.186L` head-x displacement and
  final distance `14.301L`. Together with inherited logs for earlier
  stable-but-advected and unstable shared-curvature policies, these failures
  show that static bearing-bias sign alone is not the missing mechanism.
- The strongest finite result is `solver_f5cca4991f3d`. Its released sheet
  shows a self-propelled fish crossing into the merged wake corridor while the
  bounded negative posterior bearing lead prevents the seed's bottom exit.
  It is the only sample to survive the full `300` horizon and move upstream:
  head displacement `(-5.846,-4.282)L`, monotonically best final/minimum
  distance `5.812L`, progress `0.532`, and mean local flow nearly zero. Joint
  maxima remain approximately `19.0/24.3 deg`, `178/134 deg/time`, and
  `1670/1260 deg/time^2`; RMS force/moment `17.93/352.44` and mean command
  energy `626.07` are below the saturated seed. Its remaining failure is
  insufficient closure rate, not domain exit or loss of lateral control: mean
  distance closure is about `0.022L/time`, versus roughly `0.039L/time` needed
  to cross the `0.75L` radius from the initial distance within the horizon.

## Single candidate hypothesis

Preserve the finite sample's zero-centered energy-shell oscillator, `0.65`
posterior lag, `0.80` posterior damping, and bounded `10 deg` negative bearing
lead. Change only the gait scale along a cap-feasible large/slow axis: use the
seed's demonstrated `28 deg` excursion with period `0.80` instead of the finite
sample's `19 deg` at `0.67`. The nominal anterior speed rises from about
`178` to `220 deg/time`, while nominal acceleration changes only from about
`1671` to `1727 deg/time^2`; the posterior target amplitude is about `33.4 deg`
with the retained lag. Thus the test uses remaining angle and rate headroom to
seek more upstream authority without reproducing the seed's fast saturated
stroke, changing steering sign, or adding coordinate, route, clock, prescribed
inflow, remote-probe, or target-station information.

The next CFD result should retain full-horizon stability and bounded lateral
offset while increasing negative head-x displacement and beating the sampled
`5.812L` final distance, ideally crossing the capture radius. The hypothesis is
falsified if the slower large stroke is advected downstream like the sampled
low-speed `0.80` gaits, if posterior angle or anterior acceleration repeatedly
contacts the episode envelope, if force/moment loads approach the unstable
shared-curvature branch, or if it restores the seed's steep lower exit. In
those cases later workers should preserve the `19 deg`/`0.67` finite anchor
and test a different bounded propulsion coupling rather than intensifying
static curvature or assuming that nominal cap feasibility guarantees thrust.
