# Multi-wake candidate diagnosis

## Evidence read before the policy edit

- The sampled held-fish prewarm sheets are byte-identical and show the fish at
  the common upper-right release pose while the four staggered-cylinder vortex
  streets develop and merge around the second-row target. This is shared
  initial-condition evidence, not support for a memorized coordinate, route,
  wake phase, or clock command.
- Three current samples are executable replications of
  `tail_steering_gain=0.70`. Their released sheets and physical diagnostics are
  identical: the fish turns down-left, sustains a productive lateral beat,
  crosses into the developed wake, passes just below the target, and bends into
  the `0.75L` capture circle without looping, colliding, exiting, or becoming
  unstable. Capture takes `72.457` release units with `2.4541L` mean distance.
  Mean fish/local-flow x velocities `-0.15005/-0.08386` give `0.06620` mean
  upstream-relative x speed, so the visible diagonal advance is materially
  self-propelled rather than passive advection.
- The distinct current `tail_steering_gain=0.60` sample follows the same broad
  topology but closes slightly later and less compactly: `73.859` release
  units, `2.4800L` mean distance, and `0.06565` upstream-relative x speed.
  Its `51797` command energy and `24.94/410.68` RMS force/moment compare with
  `51842` and `23.85/408.89` for the replicated `0.70` result. Both variants
  touch the common `28/28 rad/time^2` acceleration guard while keeping joint
  angles and speeds within the task envelope.
- The assigned-parent logs supply the intervening isolated `0.65` result. It
  reached in `72.160` units with `2.4638L` mean distance and `0.06732`
  upstream-relative x speed, but RMS force/moment rose to `25.32/420.32`.
  Thus increasing posterior share from `0.60` through `0.70` consistently
  tightened mean distance on this snapshot, while arrival, propulsion, effort,
  and loads were non-monotone. The three exact `0.70` replications establish
  deterministic reproducibility only; they do not add held-out wake evidence.
- No current sampled rollout is a semantic failure. To satisfy the visual
  negative comparison without inventing an unavailable failure, I inspected
  the inherited normalized high-speed-damping result as the most informative
  available failed optimization hypothesis. Its sheet visibly takes a deeper,
  kinked lower route before capture; metrics corroborate the regression at
  `77.291` arrival, `2.6304L` mean distance, `53167` energy, and
  `22.76/398.31` RMS force/moment. This finite result, together with the
  inherited restoration-gain and guard branches, bounds any continuation:
  small static changes can redirect the wake route even when loads do not rise.

## Single-candidate hypothesis

Preserve the replicated `0.70` controller's `0.75` period, `22 deg` oscillator,
static `2.1` energy restoration, bounded positive-bearing `0.75/10 deg`
anterior steering, `0.55` posterior lag, `0.65` damping, and common
`28/28 rad/time^2` guard. Change only `tail_steering_gain` from `0.70` to
`0.75`. At saturated anterior steering this equal step adds at most `0.5 deg`
of bounded posterior mean-curvature target; it leaves the oscillatory target,
propulsive authority, observations, and command limits unchanged.

The falsifiable expectation is finite capture through the same compact
diagonal corridor with mean distance below the replicated `2.4541L` anchor.
Do not assume arrival, relative propulsion, effort, or load will improve
monotonically: reject the continuation if it selects a deeper lower route,
loses capture, materially reduces the `0.06620` upstream-relative x speed, or
raises effort/force/moment without corroborating closure. Even a positive
same-snapshot result remains unproven under held-out wake phase, inflow,
geometry, and target placement. No CFD outcome for this candidate is claimed.
