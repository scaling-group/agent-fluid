# Far-field alignment yaw-brake candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=(0,0,0)` and no prewarm. Their displacement and wakes are
  self-generated, not imposed advection.
- Three sampled copies of the completion-gated redirect are identical and
  reproduce the same semantic success. In both the top-down vorticity and
  oblique Lambda2 rows, the fish keeps a coherent alternating three-dimensional
  wake through a smooth target-directed arc and enters the capture circle at
  `26.411 T`, with final distance `0.7496 L`, mean/max speed
  `0.501/0.667 L/T`, and no instability. This repeated result supports
  preserving its posterior-lag carrier, distributed redirect, and geometric
  completion gate.
- The trajectory contains one avoidable far-field alignment excursion. Target
  bearing begins at `+0.155 rad` and crosses approximately zero near `4 T`, but
  residual same-sign rotation carries it to about `-0.85 rad` near `10 T` while
  center `y` remains near `14.2 L`; the controller then spends the middle of the
  rollout bending back toward the target. The existing centerline yaw brake is
  already bounded by body-frame bearing and lateral-target windows, but a
  `close_gate` disables it whenever range exceeds `2.1 L`, including this first
  crossing.
- The speed-envelope projection is an informative negative comparison, not a
  better route. Its visual topology and coherent wake remain nearly unchanged,
  and it still captures, but reducing joint-speed-bound occupancy from about
  `11.4%` to `1.7%` slows capture to `26.813 T`, increases mean distance from
  `2.6134 L` to `2.6382 L`, and lowers score from `-0.7105` to `-0.7343`.
  Therefore this candidate does not stack another command-boundary projection
  onto the captured controller.

## Policy hypothesis

Preserve the evaluated completion-gated redirect unchanged except for one
feedback-semantic extension: add a far-field branch to its existing
geometry-windowed centerline yaw brake. The original close-range schedule is
retained exactly; beyond the existing `2.1 L` approach band, complementary
brake authority ramps in over one more approach-band length and is fully
available at the first alignment crossing. The brake remains zero for large
bearing or lateral target offset and opposes only observed yaw near alignment,
so it should arrest that crossing without weakening the large-angle redirect,
changing terminal capture behavior, or changing the propulsive carrier. This
is a normalized body-frame response-release mechanism, not a world-frame route
or scalar-only gain tune.

Expected result: retain the coherent wake and capture class while reducing the
early bearing overshoot and shortening the middle correction arc. Falsify the
candidate if it loses capture, weakens early closing, suppresses the alternating
wake, reverses the established turn sign, or fails to improve the sampled
`26.411 T` / `2.6134 L` capture result. No same-worker CFD result is claimed.

bookshelf_consulted: true
source_domain: biological burst-turn recovery and sensor-modulated robotic-fish CPG direction control
source_mechanism: release a target-directed curvature maneuver into cruise with bounded response damping once geometric alignment appears
transferable_invariant: when normalized target-relative alignment contracts, residual yaw should be opposed by geometry-gated feedback in the far field as well as the terminal regime, while large-error curvature and the posterior propulsive wave remain available
nontransferable_details: species-specific recovery shapes, published gains, clocked CPG phase, dimensional beat timing, robot geometry, exact vortex phase, and prescribed routes
policy_translation: retain the two-joint posterior-lag carrier, completion-gated redirect, and evaluated terminal brake schedule; add a complementary far-range gate to the existing body-frame centerline yaw brake while preserving its bearing and lateral-target windows
falsification: reject if the first alignment crossing still opens into the prior large bearing excursion, capture is lost or delayed, early closing or wake coherence degrades, or speed and load envelopes materially worsen
