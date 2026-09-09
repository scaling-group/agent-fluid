# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the fish held in the upper-right wake tail
  while all four staggered-cylinder streets develop through and downstream of
  the target. In every released sheet the fish remains above and well to the
  right of the target/cylinder corridor. The visible control problem is still
  far-field course retention: the body wave first carries the fish diagonally
  upstream, then the nose pitches upward and the fish leaves through the upper
  boundary without collision or target entry.
- The new `behind_bearing_fraction=-0.125` sample is the strongest finite
  navigation result. Its sheet preserves the upstream leg slightly longer than
  the assigned `-0.25` parent before the same near-vertical terminal pitch.
  Head-x travel improves from `-4.442L` to `-4.555L`, minimum/mean/final range
  from `6.627/9.449/9.434L` to `6.609/9.415/9.360L`, and progress from `0.241`
  to `0.247`; score improves from `-11.286` to `-11.241`. This is active
  propulsion rather than advection: its mean x velocity is `-0.0709` against
  local flow `-0.0481`, while mean y velocity `+0.0172` against local flow
  `-0.0008` agrees with the visible controlled upward departure.
- The `-0.125` gain is modest and does not solve the route. Release lifetime
  falls from the parent's `74.48` to `69.85`, the fish never comes within
  `6.61L` of the `0.75L` capture disk, and the anterior joint reaches about
  `34.2 deg`, `260 deg/time`, and `1592 deg/time^2`. RMS force/moment remain
  finite and slightly below the parent (`75.9/1004` versus `76.8/1030`), but
  mean command effort is slightly higher (`722.5` versus `713.8`). Thus the
  score improvement is a better approach baseline, not wake exploitation,
  terminal recovery, or an actuator-margin result.
- The delayed stronger-reversal sample keeps the `-0.25` parent through the
  first body length aft, then approaches `-0.50` authority. Its sheet still
  makes the same nose-up exit. Relative to `-0.125`, it moves only `-4.318L`
  upstream, worsens minimum/mean/final range to `6.627/9.523/9.535L`, lowers
  progress to `0.232`, and raises RMS force/moment to `78.1/1072`. Its longer
  `75.88` lifetime and lower anterior speed near `250 deg/time` do not recover
  navigation. Together with inherited failures at immediate `-0.50`,
  conditional overspeed damping, full-circle bearing, opening-only
  attenuation, and always-active lateral-velocity feedback, this rules out
  another coupled or unscaled terminal correction as an evidence-based step.

## Candidate hypothesis

Replace the assigned `-0.25` parent with exactly the evaluated `-0.125`
rearward-bearing policy and retain every other oscillator, steering, guard,
and soft-limit parameter. This is a one-parameter evidence-backed exploitation
candidate: the sampled midpoint gives the best score, upstream displacement,
progress, and all three distance summaries in the current bracket, whereas
both stronger immediate and delayed reversal lose the approach. No new rate,
flow, force, or moment term is introduced because the available rollout
summaries do not establish a terminal activation scale, and inherited
attempts using broader selectors damaged the closing leg.

The hypothesis is supported only if formal reevaluation reproduces a finite
upper-exit rollout near `-4.55L` head-x travel, `6.61L` minimum range, `0.247`
progress, and the sampled `76/1004` RMS load scale while improving the assigned
parent's mean/final range. It is falsified as a reproducible baseline if those
metrics regress materially toward the delayed-reversal result, and remains
falsified as a complete task policy unless a later structural candidate changes
the upper-return topology and reaches the wake/target corridor. Future recovery
work should not interpolate rearward authority again; it needs a measured,
bounded discriminator that is inactive through this closing leg. The candidate
uses only normalized body-frame target geometry plus joint and recent-turn
state, with no coordinate, clock, route, prescribed inflow, remote probe,
target-station signal, or omitted-shelf dependency. Its new CFD result is
deferred to EvE and is not claimed here.
