# Multi-wake candidate diagnosis

## Evidence boundary and visual diagnosis

- This diagnosis uses only the Phase 2 task contract, assigned-parent
  guidance, sampled solver evaluations, inherited optimizer notes, and the
  current compact rollout evidence. It does not use the omitted research
  shelf, neighboring workspaces, repository history, fixed coordinates, or a
  case-specific route.
- The shared prewarm sheet shows the fish held above and downstream of the
  target while the four developed cylinder streets merge across the target
  corridor. Because this sheet is common to the candidates, it anchors the
  release wake and geometry but does not distinguish controller quality.
- The assigned solver prefill's `19 deg`, `0.67` phase-shell policy is a controlled
  upstream failure, not passive advection. Its released sheet shows bounded
  reorientations, steady leftward progress, an initial pass below the target
  row, and correction back toward it. It survives the full `300` release,
  moves the head `(-5.846,-4.282)L`, and ends at its minimum distance of
  `5.812L` with `0.532` progress. Diagnostics confirm mean x velocity
  `-0.01942` versus local flow `-0.00682`, no hard-envelope contact, and
  finite RMS force/moment `17.92/352.44`. Its remaining failure is upstream
  range rather than an uncorrected final lateral sign.
- The sampled `20 deg`, `0.67` single-axis exploit preserves that trajectory
  structure and reaches the `0.75L` capture at `266.255`. Its sheet shows
  continued leftward translation through the wake corridor followed by a
  direct final approach instead of a boundary excursion. Metrics agree:
  `(-11.031,-4.702)L` head displacement, `0.940` progress, `7.218L` mean
  distance, and no collision, domain exit, or unstable termination. Maximum
  joint accelerations remain about `30.67/23.14 rad/time^2`, below the episode
  `31.416` cap. RMS relative crossflow, lateral force, and moment are
  `0.1319`, `18.26`, and `353.21`, all below the nearby 21-degree near miss.
- More nominal drive is not monotonically better. The sampled `21 deg`,
  `0.69` policy also widens the bearing scale from `0.30` to `0.38`; its sheet
  shows useful entry and leftward travel but a late heading reversal away from
  the station. It misses at the horizon, rebounding from `3.246L` minimum to
  `3.610L` final distance with `0.709` progress, while RMS crossflow,
  force, moment, and mean power rise to `0.1398`, `19.15`, `363.27`, and
  `46.84`. Because amplitude, period, and steering scale changed together,
  this result does not isolate which axis caused the rebound, but it does rule
  out adopting that coupled extrapolation over the successful 20-degree
  setting.
- The `19 deg` posterior-lag change from `0.65/0.80` to `0.78/0.72` is a
  stronger negative contrast: its keyframes never establish sustained
  leftward translation, its x displacement is only `+0.058L`, and its final
  distance is `11.719L`. Preserve the successful posterior lag and damping
  rather than treating added posterior phase authority as free propulsion.

## Policy hypothesis

Exploit the only sampled capture mechanism exactly: use the steering-independent
clock-free phase-shell oscillator at `20 deg` and period `0.67`, retain the
`0.65` posterior lag, `0.80` damping, and bounded negative posterior
bearing/rate bias, and retain its policy-owned `30.8 rad/time^2` acceleration
guard. This is a material improvement over the assigned prefill because the
same fixed prewarm produced target capture instead of a `5.812L` horizon miss.
It introduces no new observation or coupled tuning axis, so the existing
evidence supports the whole controller rather than only its ingredients.

The falsifiable expectation for the next evaluator is finite target capture
near the sampled `266.255` release time, negative x travel of roughly `11L`,
bounded target-row correction, and no policy-guard or episode-cap contact. A
miss, boundary exit, strong lateral rebound, or guard contact would falsify
repeatability of this narrow mechanism under the common prewarm; later workers
should then return to the 19-degree finite anchor and isolate posterior
phasing or alignment-conditioned effort rather than increase amplitude or
soften steering on several axes together.
