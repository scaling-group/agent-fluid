# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held at the upper-right release pose while the staggered four-cylinder
  streets develop, merge, and pass through the target region. This is a common
  initial condition, not evidence for one policy over another.
- Three sampled `28`-degree, lag-`0.75`, damping-`0.65`, fraction-`0.35`
  policies are byte-identical replicas. Their released sheets show an active
  left-and-down turn followed by a self-propelled diagonal traverse into the
  merged wake and through the target ring. Mean fish velocity
  `(-0.2853,-0.1198)` versus mean local flow `(-0.1687,-0.1692)` confirms that
  the leftward progress is not passive advection. Each reaches safely at
  `38.049`, with score `0.073801`, mean distance `1.802L`, command
  energy/power `52895/3965`, relative-crossflow RMS `0.2249`, force/moment RMS
  `42.01/653.13`, and joint peaks `0.496/0.521` rad. Both joints touch the
  episode's `4.538/31.416` rate/acceleration limits.
- The best sampled policy changes only the posterior acceleration envelope to
  `1700 deg/time^2`. Its five-frame released sheet preserves the same visible
  turn-then-diagonal topology but advances through it faster and terminates
  before the baseline's sixth frame. The metrics agree: it reaches at
  `34.331`, improves score and mean distance to `0.159531/1.714L`, raises mean
  leftward speed to `-0.3164`, and lowers command energy/power to `45153/3390`.
  The candidate ceiling is active (`29.671 rad/time^2` posterior maximum), and
  posterior peak angle falls to `0.509` rad, while anterior rate and
  acceleration and posterior rate still touch their episode limits.
- The ceiling is not an unloading result. Relative-crossflow RMS rises to
  `0.2312`, and force/moment RMS rise sharply to `54.48/766.14`; the sheet also
  shows a visibly denser disturbed trail late in the traverse. Thus the
  improved scalar, distance, arrival, and effort reflect a faster closed-loop
  trajectory, not uniformly gentler wake interaction.
- The assigned parent's isolated amplitude reduction from `28` to `27` degrees
  is a concrete negative result. It keeps the safe route and lowers
  force/moment RMS to `40.03/630.70`, but score, arrival, mean distance, and
  energy/power regress to `0.063788`, `38.214`, `1.812L`, and `53078/3978`;
  both joints still hit the episode rate and acceleration caps. Weakening the
  oscillator is therefore not equivalent to the useful posterior ceiling.
- No sampled rollout is a semantic failure. The inherited
  `tail_damping=0.675` rollout is the clearest failed control hypothesis with
  available metrics and a sheet: it visibly falls behind on the same route,
  reaches only at `41.591`, and regresses to score `-0.023082` and mean
  distance `1.901L` despite lower `40.10/637.97` loads. Inherited lag,
  allocation, steering-gain, and damping tests already bracket those axes, and
  the older mixed-feedback policy became unstable. No omitted shelf,
  neighboring configuration, external artifact, or repository history was
  consulted.

## Candidate hypothesis

Materialize the best sampled controller exactly: preserve its `0.55`-period,
`28`-degree oscillator, lag `0.75`, damping `0.65`, bounded body-frame bearing
gain `1.7`, 12-degree steering bound, fraction-`0.35` allocation, and existing
observation set, and apply the candidate-owned symmetric `1700 deg/time^2`
ceiling only to raw posterior acceleration. This chooses the strongest
available navigation/effort evidence instead of spending the only candidate on
an unsupported finer ceiling. It also tests whether the single evaluated
ceiling outcome replicates from the certified common prewarm state.

The later CFD rollout supports the candidate if it preserves the visible safe
turn-then-diagonal capture and remains near the sampled ceiling result:
arrival below `35.0`, mean distance below `1.75L`, command energy below
`47000`, and posterior peak below the baseline's `0.521` rad. Arrival at or
beyond the baseline's `38.049`, mean distance at or above `1.802L`, loss of
capture, route change, collision, exit, or instability falsifies repeatability.
Force/moment near `54.48/766.14` is an accepted measured tradeoff, not evidence
of unloading; materially higher loads or crossflow would reject even a fast
capture as an uncontrolled extrapolation. Any replicated benefit remains
limited to this wake phase and start pose until held-out evidence is available.
