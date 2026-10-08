# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held at the upper-right release pose while the staggered cylinder
  streets develop and merge through the target region. This is a common
  initial condition, not candidate-specific credit.
- All four sampled released sheets and candidates are also byte-identical
  `tail_damping=0.65`, `tail_lag_gain=0.75`, fraction-`0.35` replicas. The
  fish turns left and down under a dense alternating propulsive trail, enters
  the merged wake corridor, and crosses the target ring without collision,
  exit, or instability. Mean fish velocity `(-0.2853,-0.1198)` versus local
  flow `(-0.1687,-0.1692)` confirms useful self-propulsion rather than passive
  advection. Every repeat reaches at `38.049`, with score `0.073801`, mean
  distance `1.802L`, command energy/power `52895/3965`, relative-crossflow
  RMS `0.2249`, force/moment RMS `42.01/653.13`, and joint peaks
  `0.496/0.521` rad. Both joints touch the same rate and acceleration caps.
- The inherited `tail_damping=0.675` sheet is the clearest failed policy
  hypothesis on this response axis. It preserves the safe route but is visibly
  behind at the matched middle and late frames. Mean velocity weakens to
  `(-0.2611,-0.1095)`, arrival/mean distance regress to `41.591/1.901L`,
  energy/power rise to `58328/4400`, and score falls to `-0.023082`. Its
  modestly lower force/moment `40.10/637.97` does not demonstrate controlled
  posterior tracking: both joint peaks instead rise to `0.508/0.551` rad and
  both joints still hit the rate and acceleration caps.
- The opposite inherited `tail_damping=0.625` sheet reaches in only five
  sampled frames and visibly leaves a larger-amplitude disturbed trail. It
  improves arrival to `37.339`, command energy/power to `52247/3947`, and
  mean leftward velocity to `-0.2908`, but mean distance is slightly worse at
  `1.803L`, score is slightly lower at `0.071866`, crossflow rises to `0.2461`,
  force/moment to `47.26/710.38`, and joint peaks to `0.516/0.565` rad. Thus
  lowering damping exposes useful propulsive response and a severe load/
  excursion tradeoff; it is not a clean improvement and does not justify
  extrapolation below `0.625`.
- The remaining inherited brackets should stay closed for this candidate:
  allocation `0.35` outperforms `0.30/0.40/0.45`, exact steering gain `1.7`
  outperforms nearby `1.725/1.9`, and exact tail lag `0.75` outperforms
  `0.70/0.7675/0.80`. The older unscaled mixed-feedback controller became
  unstable at `2.807`, so no auxiliary signal or second axis is added here.

## Candidate hypothesis

Preserve the measured `0.55`-period, 28-degree oscillator,
`tail_lag_gain=0.75`, gain-`1.7` bounded body-frame bearing law, 12-degree
steering bound, fraction-`0.35` allocation, and observation set. Change only
`tail_damping` from `0.65` to `0.6375`, the midpoint of the finite
`[0.625,0.65]` bracket. This is one bounded bracket-resolution test, not a
claim that the response is smooth: it asks whether part of the earlier-arrival
and lower-effort behavior at `0.625` can be retained before the visible wake,
crossflow, load, and joint-excursion penalty becomes dominant.

The later CFD rollout supports this candidate only if it reaches the target
without collision, exit, or instability, preserves the same turn-then-diagonal
route, and exceeds the `0.073801` anchor score through a real navigation/effort
gain. Arrival should be below `38.049` or energy/power below `52895/3965`, while
mean distance must not exceed `1.802L` materially and crossflow, force/moment,
and joint peaks must remain materially below the `0.625` negative envelope
`0.2461/47.26/710.38/0.516/0.565`. Regression past the `0.65` navigation
anchor, unchanged cap contact combined with near-`0.625` loads, or a different
route falsifies the interpolation. Any positive result remains specific to
this certified wake phase and start pose until held-out conditions test it.
