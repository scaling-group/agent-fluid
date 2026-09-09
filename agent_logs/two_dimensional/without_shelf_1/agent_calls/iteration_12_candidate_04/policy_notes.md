# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet is common initial-condition evidence: the held fish is
above and downstream of four interacting wakes, not already aligned with the
target corridor. In the released sheets, every sampled controller produces real
upstream motion rather than passive advection, but each still climbs into the
same upper envelope before leaving the domain. The strongest static `11 deg`
controller is the best finite anchor we have: mean head velocity x `-0.141`
against mean local flow x `-0.099`, travel `-7.89L`, closest approach `4.87L`,
and progress `0.424`. It still ends in the same broad counterclockwise upper
hook, exits with `+1.792L` head-y displacement, and hits the posterior angle
and joint-rate / command ceilings with RMS force/moment `406/4113`.

The sampled and inherited repairs split into two clear negative classes:

- Static weakening of the `11 deg` request below `6L` gives up the best
  upstream reach (`-7.19L`) and progress (`0.393`) while keeping the same
  `+1.782L` drift and upper exit. This is a propulsion loss, not a steering
  fix.
- Projection, rate, slip, and lateral-velocity gates all fail to change the
  route topology. The best of those alternatives still exit high with roughly
  the same `+1.77L` to `+1.80L` head-y drift, while the lateral-velocity
  versions add either posterior-limit contact or worse load spikes. None of
  them demonstrates that the upper hook is caused by simple body-slip or
  bearing-threshold attenuation.

## Single candidate hypothesis

Keep the full `11 deg`, `25 deg`, `0.70/0.35` anchor and preserve the
posterior traveling-wave lag, direct body-rate damping, and acceleration cap.
The only new hypothesis is a bounded `0.35` phase-headroom boost that acts when
the complete posterior target remaining after the static request still opposes
the current steering direction. The extra term therefore moves that residual
target toward zero; reinforcing or already-unloaded phases retain exactly the
static request. This uses remaining phase headroom for lateral correction
without weakening the propulsive anchor required for upstream travel.

The next CFD evaluation supports this candidate only if it preserves the
static-anchor level of upstream approach while reducing the upper drift or
changing the terminal curl. It is falsified if upstream travel regresses toward
the weakened tests, if the same upper exit remains, or if loads rise without a
clear route change. That is the concrete failure boundary for later workers.
