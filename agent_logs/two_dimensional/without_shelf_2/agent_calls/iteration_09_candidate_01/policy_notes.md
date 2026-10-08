# Wake-policy candidate notes

## Evidence diagnosis

- The four sampled examples share the same prewarm sheet and therefore the
  same held fish, asymmetric cylinder layout, and fully developed interacting
  vortex streets at release. Three examples are exact numerical duplicates of
  the prefilled `0.75`-period, `22 deg`, gain-`0.75`, guard-`28` anchor; their
  released sheets show an actively beating fish turning from the upper-right,
  then swimming upstream-left through the wake to first capture rather than
  merely following the local flow. The diagnostics agree: mean x velocity is
  `-0.14682` versus mean local flow `-0.08249`, leaving `0.06433` upstream
  relative speed, and capture occurs at `74.23` with finite RMS force/moment
  `22.39/393.08`.
- No hard failure is present among the current sampled keyframe sheets. The
  most informative sampled regression is the otherwise identical `28/27`
  anterior/posterior cap probe. Its sheet takes a visibly deeper lower turn on
  the late approach before capture. The numerical evidence rejects the scalar
  score as a sufficient endorsement: although score rises from `-0.66170` to
  `-0.65442` and mean distance falls slightly from `2.5613L` to `2.5554L`,
  arrival slows to `76.44`, upstream-relative x speed falls to `0.06199`,
  command energy rises from `50940` to `53200`, and RMS force/moment rise to
  `24.69/417.71`. The inherited hard failure remains the text-documented
  negative-sign, `30 deg` coiling instability; no corresponding sampled
  keyframe is available here, so no new visual claim is made about it.
- The parent and inherited logs add two useful boundaries: increasing the
  common acceleration guard to `29` also deepened the route and raised loads,
  while amplitude and pure-bearing-gain probes around the anchor were
  non-smooth same-snapshot regressions. Those results argue against another
  authority, amplitude, or steering-gain interpolation.

## Candidate hypothesis

Retain the duplicated anchor's propulsion, bearing map, and independent
`28 rad/time^2` authority on both joints. Add a posterior-only jerk bound using
the passive `previous_action` and `history_dt` observations. For the retained
gait, `omega^3 * amplitude` is about `226 rad/time^3`; the posterior traveling
bend has about `sqrt(1 + 0.55^2)` times that nominal phase-space scale, or
roughly `258 rad/time^3`. A candidate-owned `260 rad/time^3` limit should
therefore pass the nominal cycle while smoothing only abrupt posterior command
changes and hard-cap switching.

The falsifiable expectation is that this retains capture and approximately the
anchor's `0.0643` upstream-relative x speed while lowering command effort and
RMS force/moment without reproducing the deeper late route of the static
`27` cap. It is falsified if arrival or mean-distance topology regresses, the
posterior still sits at the acceleration guard without lower loads, or useful
relative propulsion falls. This is a single-snapshot mechanism probe, not a
claim of wake-phase robustness.
