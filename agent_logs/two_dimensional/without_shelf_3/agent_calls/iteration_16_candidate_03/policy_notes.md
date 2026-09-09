# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the held fish above and downstream of the
  target while the four staggered-cylinder streets develop through the target
  corridor. In every released sheet the fish remains above and to the right of
  that corridor. It makes an active diagonal upstream leg, then pitches
  nose-up and exits the upper boundary without wake or target entry. For the
  strongest sample, mean head x velocity is `-0.07075L/time` versus local flow
  `-0.04945`, while mean y velocity is `+0.01712` versus local flow
  `-0.00064`; the closing leg is partly self-propelled, and the terminal upward
  departure is controlled motion rather than passive crossflow advection.
- The current dual-rate-gated anterior-unloading sample is the best finite
  result in the sampled set. Against two identical evaluations of the
  `behind_bearing_fraction=-0.125`, fixed `0.35` anterior-allocation baseline,
  it improves score from `-11.241` to `-11.149`, head-x travel from `-4.555L`
  to `-4.676L`, mean/final range from `9.415/9.360L` to `9.342/9.266L`, and
  progress from `0.247` to `0.254`, while preserving the `6.609L` minimum.
  RMS force/moment fall from `75.9/1004` to `75.6/985`; anterior angle and
  speed maxima fall from about `34.24 deg` and `259.90 deg/time` to
  `33.23 deg` and `251.35 deg/time`. Because the posterior extrema are
  effectively unchanged, this is evidence for the localized terminal
  allocation change, although both sheets still show the same upper exit.
- A raw rearward-bearing interpolation to `-0.15625` also repeats the visible
  upper exit. It lowers RMS force/moment to `69.8/949`, but is weaker in the
  navigation measures than the gated-unloading sample: score `-11.197`,
  head-x travel `-4.640L`, minimum/mean/final range
  `6.637/9.384/9.290L`, and progress `0.252`. Inherited logs already show that
  zero, stronger, delayed, and full-circle rearward bearing, added turn
  damping, conditional overspeed damping, opening-only attenuation, and
  always-active lateral-velocity feedback fail to remove the return. The
  positive evidence is therefore specific to a deeply rearward, simultaneous
  instantaneous-and-windowed opening trigger acting on anterior allocation;
  it does not reopen those broader mechanisms.

## Candidate hypothesis

Preserve the best sampled policy's oscillator, `-0.125` rearward bearing,
`0.60` bearing gain, `12 deg` steering ceiling, fixed `0.04` recent-turn
damping, posterior `0.65` steering bias, joint guards, soft acceleration
limit, and strict terminal trigger. Change only
`terminal_anterior_steering_fraction` from `0.10` to `0.0`, completing the
anterior steering unload when the target is more than `1L` rearward and both
normalized range-rate measures exceed the `0.02L/time` opening threshold.
This is a bounded continuation of the one sampled terminal mechanism that
improved both navigation and loads; it remains inactive during the
demonstrated closing leg and never reverses the anterior steering bias.

The candidate is supported only if it retains approximately `-4.68L`
upstream head travel and the `6.61L` approach, further reduces the current
`251 deg/time` anterior excursion or `985` RMS moment, and improves final or
mean range without raising loads. It is falsified if stronger unloading
damages the closing leg, produces a lower return, repeats the upper exit with
worse navigation, or transfers the excursion to the posterior joint. Even if
the finite metrics improve, another upper-domain exit would bound the lesson
to terminal load/navigation shaping rather than wake entry or target capture.
The policy uses only normalized body-frame target projection and range rates,
joint state, and measured recent turn; it contains no coordinate, clock,
route, prescribed inflow, remote probe, target-station signal, or omitted-shelf
dependency. Its CFD result is deferred to EvE and is not claimed here.
