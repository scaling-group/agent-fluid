# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet shows the common held-fish initial condition above and
downstream of four developed, interacting vortex streets. The released sheets
show that all four sampled policies self-propel upstream into the wake field,
rather than merely following the local flow, but every one ends in the same
broad upper hook and `left_domain` termination.

- The static `11 deg`, `0.70/0.35` controller travels `-7.89L`, reaches
  `4.87L`, and produces `0.424` progress. Its mean head x velocity is more
  upstream than the mean local x flow (`-0.141` versus `-0.099`), confirming a
  useful propulsive gait, but it exits after about `+1.79L` head-y drift and
  hits both joint rate and command caps.
- The `0.35` phase-headroom boost is the strongest finite sample: it extends
  upstream travel to `-11.33L`, improves closest approach to `3.03L`, progress
  to `0.517`, and mean distance to `6.44L`. The visual sheet nevertheless shows
  the same upper hook, head-y drift remains `+1.69L`, posterior angle reaches
  `0.780 rad`, and RMS force/moment rise to `511/5305`. It is a useful
  approach/propulsion mechanism, not a demonstrated lateral steering repair.
- Reversing `1.5` times the bearing drive whenever windowed distance recedes
  reaches the best sampled `2.67L` minimum and lowers RMS force/moment to
  `367/3880`, but cuts upstream travel to `-7.45L`, worsens mean/final distance
  to `7.59/7.39L`, and still exits high after `+1.78L` drift. Temporary
  far-field receding is therefore too ambiguous to switch the steering sign.
- Instantaneous normalized yaw-moment rejection likewise keeps the same exit,
  worsens closest approach to `4.99L`, and raises loads over the static anchor
  to `439/4516`. Inherited logs also show that absolute and speed-normalized
  lateral-velocity damping retain about `+1.8L` drift while losing upstream
  reach. These load/slip channels are not supported as the next route signal.

The control contract exposes a more direct discriminator that none of those
repairs used. `state.bearing` is formed with the absolute forward separation,
so it preserves lateral sign but cannot distinguish a target ahead from the
same lateral target after longitudinal overshoot. In contrast,
`-state.target_body_L[1]` retains that body-frame forward sign. The strongest
sample travels nearly the full `12L` initial x separation before its terminal
hook, so loss of the ahead/behind distinction is consistent with the visible
late failure while not explaining away the established far-field propulsion.

## Single candidate hypothesis

Restore the sampled `0.35` phase-headroom policy unchanged as the finite
approach anchor. Multiply only its geometric bearing drive by a smooth signed
forward-projection gate, `tanh(forward_distance_L / 0.75)`. A target more than
about one body length ahead leaves the sampled policy essentially unchanged;
the mean posterior request fades as the fish crosses the target's longitudinal
plane and reverses only when the target is aft. Direct heading-rate damping,
the anterior oscillator, traveling-wave lag, distance fade, phase-headroom
allocation, and command ceiling remain unchanged. This uses normalized
body-frame target geometry, not fixed coordinates, global direction, time, or
a case-specific route.

The candidate is supported only if it preserves the phase-boost sample's early
upstream approach, then reduces the terminal upper hook or head-y exit after
longitudinal alignment. It is falsified if the gate disrupts approach before
the target is abeam, closest approach regresses materially from `3.03L`, or
the same upper exit and saturation survive. In that case later workers should
restore the phase-headroom anchor and distrust forward-sign reversal as a cure
for the remaining lateral miss.
