# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held above and downstream of the target while the four staggered-cylinder
  vortex streets develop and overlap around the second-row target corridor.
  Every released sheet inspected remains above and to the right of that
  corridor. The present failure is therefore far-field course retention, not
  wake exploitation or tight-radius capture.
- The assigned combined rearward-damping prefill is actively self-propelled on
  its useful leg: mean x velocity/local flow are `-0.0675/-0.0444`, and its
  sheet shows sustained leftward translation before the nose pitches upward.
  It never reaches the useful wake region and exits at head travel
  `(-4.15,+1.80)L`; minimum/mean/final range are `6.57/9.68/9.67L`, progress
  is `0.222`, and lifetime is `67.24`. The finite RMS force/moment are
  `69.2/967`, while anterior speed reaches the hard `260 deg/time` cap.
- The strongest sampled finite policy isolates a signed fore/aft gate and
  retains `-0.25` of the existing bearing contribution after the target is
  behind, with fixed `0.04` turn-rate damping. It improves on both the assigned
  prefill and the matched zero-behind-bearing policy: head-x travel is
  `-4.44L`, minimum/mean/final range are `6.63/9.45/9.43L`, progress is
  `0.241`, and lifetime is `74.48`. Mean x velocity `-0.0627` remains more
  upstream than local flow `-0.0454`, confirming active propulsion rather than
  passive advection. Its sheet still shows the same late upper return; loads
  rise to `76.8/1030`, and anterior speed remains high at about
  `254 deg/time`.
- The assigned parent's inherited `-0.50` continuation closes the assumption
  that more reversal is monotonically better. Its sheet loses leftward travel
  before the same nose-up exit: versus `-0.25`, head-x travel falls from
  `-4.44` to `-3.49L`, minimum range worsens from `6.63` to `6.76L`, progress
  falls from `0.241` to `0.180`, mean/final range worsen from `9.45/9.43` to
  `10.12/10.18L`, and lifetime falls from `74.48` to `65.44`. Lower RMS loads
  `65.5/901` reflect the shortened useful leg, not a recovered route.
- The other inherited terminal test increases overspeed damping from `6` to
  `18` only after the target passes abeam. It does reduce anterior peak speed
  from about `254` to `250 deg/time` and moment RMS from `1030` to `925`, but
  the visible upper exit remains while head-x travel falls to `-3.71L`,
  progress to `0.194`, and mean/final range worsen to `9.94/10.01L`.
  Terminal cap proximity is therefore correlated with the failure but is not
  an independently supported recovery control.

## Candidate hypothesis

Start from the strongest sampled finite policy and change exactly one control
parameter: set `behind_bearing_fraction=-0.125`, midway between the matched
zero-authority control and the `-0.25` finite best. Keep its oscillator, joint
guards, `0.60` bearing gain, `12 deg` steering ceiling, `0.35/0.65` curvature
allocation, fixed `0.04` recent-turn damping, and evaluated `0.5L` fore/aft
transition unchanged. The three evaluated rearward fractions bracket a
non-monotone response: `0 -> -0.25` gives a small consistent gain, whereas
`-0.25 -> -0.50` sharply damages every navigation metric. Refining the
supported side of that bracket tests whether a smaller bounded reversal can
retain the approach and terminal lifetime while avoiding part of the load rise
at `-0.25`; it does not introduce another observation or coupled factor.

The hypothesis is supported only if the rollout remains finite, retains at
least roughly `-4.36L` upstream head travel and a `6.7L` or better approach,
and improves lifetime or mean/final range without exceeding the sampled
`77/1030` RMS force/moment scale. It is falsified if it merely repeats the
upper exit with metrics no better than the zero-authority control, loses the
useful leg, rides the anterior hard-speed cap, or makes a lower full return.
The candidate uses only normalized body-frame target geometry and existing
joint/turn state; it contains no coordinate, clock, route, prescribed inflow,
remote probe, target-station signal, or omitted-shelf dependency. Its CFD
result is deferred to EvE and is not claimed as current evidence.
