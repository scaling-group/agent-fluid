# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The common held-fish prewarm sheet shows the same developed, interacting four-
cylinder wakes and the fish above/downstream of the target for every candidate.
The released sheets then show active upstream swimming into the disturbed wake
corridor, not passive advection: for the `0.35` and `0.50` opposition-boost
policies, mean head velocities are `-0.171` and `-0.174` while mean local
x-flow is only `-0.119` and `-0.123`. Both make a descending/upstream first
approach, pass above the capture circle, and then turn into an almost vertical
counterclockwise hook immediately before exiting the upper-left boundary.

The clean boost sweep is the only current positive approach mechanism. Raising
`steering_opposition_boost` from `0.35` to `0.50` moves the head farther
upstream (`-11.33L` to `-12.28L`) and improves closest approach from `3.03L`
to `2.13L`. Mean distance worsens slightly from `6.44L` to `6.46L`, progress
is essentially flat (`0.517` to `0.509`), and
head-y drift worsens from `+1.69L` to `+1.78L`; therefore this is approach
authority, not a repaired route. The load increment is comparatively modest:
RMS force/moment rise from `511/5305` to `535/5416`, while both policies retain
the same joint-rate and acceleration-cap contacts and nearly the same posterior
angle maximum. The two recovery overlays and behind-target reversal all lose
approach or upstream travel and preserve the same upper exit, so they remain
closed rather than being stacked onto the boost.

The assigned parent's inherited notes independently proposed continuing the
same isolated axis to `0.55`, with a stop boundary of improved closest approach
without disproportionate load growth. The newly sampled `0.50` rollout meets
that approach/load boundary but not its lateral-route boundary. Across the
plain `11 deg`, `0.35`, and `0.50` policies, minimum distance improves from
`4.87L` to `3.03L` to `2.13L`; that monotone evidence is the basis for one
final capture-directed continuation, not a claim that linear extrapolation is
guaranteed.

## Single candidate hypothesis

Keep the complete `0.90`-period, `11 deg`, `25 deg`, `0.70/0.35` controller,
posterior-only steering, distance fade, and command cap. Change only
`steering_opposition_boost` from the prefilled `0.35` to `0.75`. The phase
multiplier remains bounded in `[1, 1.75]`; the added authority acts only when
the posterior target remaining after the static steering request opposes the
current bounded bearing command, and it never attenuates the demonstrated
static request. The purpose is to cross the `0.75L` first-entry radius during
the improving first approach, before the repeatedly observed terminal hook,
without reviving falsified recovery or target-motion gates.

Support requires capture, or at minimum a clear improvement below the sampled
`2.13L` closest approach while preserving about `-12L` upstream travel without
a disproportionate rise above `535/5416` RMS force/moment. If the fish again
exits high without a substantial closest-approach gain, if upstream progress
regresses, or if load growth is the only change, later workers should end the
upward opposition-boost sweep and test a genuinely different normalized
observation rather than adding another recovery overlay.
