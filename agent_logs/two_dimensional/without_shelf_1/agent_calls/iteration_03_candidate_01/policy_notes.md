# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet shows the fish held at the upper-right while four
  mature, interacting vortex streets fill the route to the target. This is a
  common initial condition, so it does not distinguish candidates.
- The target-blind `0.55`-period seed is self-propelled upstream, but the
  released keyframes show an almost monotone dive to the lower boundary rather
  than target-directed travel. The metrics agree: head displacement was
  `(-3.55,-13.30)L`, minimum distance was `8.61L`, both joint rates and both
  accelerations reached their hard limits, and the run ended after `50.13`.
- The best finite sample uses a `0.90`-period oscillator and positive,
  posterior-only bearing bias. Its keyframes show an initial targetward turn
  and upstream traversal followed by a broad upward loop and upper-boundary
  exit. It survived `73.39`, moved `-2.73L` upstream, improved progress to
  `0.132`, and reduced minimum distance to `6.34L`; near-zero mean local flow
  while moving upstream supports self-propulsion rather than favorable
  advection. The loop was not benign: posterior angle reached `45 deg`, both
  rates reached `260 deg/time`, command reached `1650 deg/time^2`, and RMS
  force/moment rose to `196/2014`.
- The slower `1.10`-period, `14 deg` sample stayed at much lower loads
  (`15/387`) but the keyframes show little targetward translation before it was
  advected downstream and out after `19.22`; its head moved
  `(+2.45,-2.14)L` and progress was `-0.149`. Thus load reduction alone is not
  useful if it removes upstream authority. An inherited finite result likewise
  moved only `+0.08L` in x, had progress `-0.062`, and raised loads to
  `329/5141`, so its broader alteration is not a better anchor.
- Shifting bearing and rate feedback into the anterior oscillator is an
  immediate negative boundary. That sampled policy became unstable after
  `1.52`, with relative-crossflow RMS `3.95` and RMS force/moment above
  `6e4/6e5`; its two keyframes contain no meaningful route evidence.

## Candidate hypothesis

Retain the best finite sample's propulsion parameters, positive steering sign,
posterior-only mean-tangent bias, distance fade, and acceleration cap. Replace
its instantaneous proportional bearing input with a bounded predicted bearing
`bearing + 0.35*bearing_window_rate`. The look-ahead is shorter than half of
the `0.90` control period, and the existing `tanh` plus `10 deg` bias limit
bounds even a wake-driven rate spike. When bearing is closing, this term should
remove tail bias before zero crossing and arrest the visible loop; when bearing
is opening, it should add corrective bias without displacing the propulsion
oscillator.

The hypothesis is supported only if the next rollout retains upstream head
motion while surviving longer than `73.39`, reduces the large late loop and
joint/load saturation, and improves on `6.34L` minimum distance or `0.132`
progress. It is falsified if rate lead removes upstream authority, reverses the
useful initial turn, or produces rate-driven switching/load spikes; a later
worker should then reduce or remove look-ahead independently before changing
gait strength or steering sign.
