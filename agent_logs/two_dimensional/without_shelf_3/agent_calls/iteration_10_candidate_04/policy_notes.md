# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet is byte-identical across the sampled solvers. It
  shows the held fish above and downstream of the target while four developed
  cylinder streets convect rightward, so it is shared initial-condition
  evidence rather than a controller effect. Every released sheet considered
  here remains outside the target-centered wake corridor; the current problem
  is still far-field course retention.
- The strongest finite sample is the guarded angle-only oscillator with
  bearing gain `0.60`, steering ceiling `12 deg`, and fixed opposing recent-turn
  gain `0.04`. Its sheet shows a sustained upstream leg followed by a sharp
  upward pitch and upper return. The metrics confirm active propulsion and the
  failed recovery: head travel `(-4.08,+1.80)L`, minimum/final range
  `6.71/9.73L`, progress `0.217`, mean velocity/local flow x
  `-0.0673/-0.0457`, and finite RMS force/moment `66.5/958`.
- The assigned parent's bounded body-lateral-velocity correction does not cure
  that topology. Its sheet still turns upward and exits, while upstream travel
  falls to `-2.72L`, minimum range worsens to `8.20L`, progress falls to
  `0.129`, and RMS force/moment rise to `78.6/1084`. The nearly unchanged
  `+1.80L` head-y exit displacement shows that a correction active from release
  altered the useful leg without arresting the terminal course.
- Inherited logs close the remaining local derivative interpolation. Reducing
  the anchor's recent-turn gain from `0.04` to `0.0375` produces the same visible
  upper turn but only `-0.63L` head-x travel, `9.92L` minimum range, negative
  progress, and RMS force/moment `73.2/1099`. Together with evaluated gains
  `0.0425`, `0.045`, and `0.05`, this leaves no supported adjacent derivative
  step. The sampled `10/14 deg` ceilings and the inherited static large-bearing
  rolloff likewise change when the upper loop begins rather than its outcome.

## Candidate hypothesis

Restore the strongest finite controller's gait, guards, steering distribution,
`12 deg` ceiling, and `0.04` recent-turn damping exactly. Compute that same
bounded steering command while the history-smoothed target range is closing.
Only after `state.window_closing_speed_L` becomes negative, smoothly scale the
mean steering bias toward a `0.35` floor over an opening-speed scale of
`0.02 L/time`. The anchor's minimum range followed by a worse final range proves
that an opening phase occurs; conditioning on it leaves the demonstrated early
approach untouched, unlike the failed always-active motion correction and
absolute-bearing rolloff. Reducing the already-saturated curvature only in the
opening phase should let the preserved `0.04` damping straighten the upper
pitch before it becomes a boundary exit.

This is an isolated test of progress-conditioned steering release, not a claim
of same-worker CFD improvement. It is supported only if the candidate preserves
approximately `-4.08L` early upstream travel and the `6.71L` approach while
delaying or removing the upper return. It is falsified if the early leg is
shortened, the same upper loop or a lower return persists, closest range worsens,
or joint/load extrema rise materially. The gate is bounded, uses a normalized
target-relative motion observation, and contains no coordinate, clock, route,
prescribed inflow, remote wake probe, or omitted-shelf dependency.
