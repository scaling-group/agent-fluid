# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the workspace contract and assigned parent guidance, all four current
sampled solver scores, observations, compact metrics, nested wake diagnostics,
and policies, plus the available inherited optimizer notes and their evaluated
descendants, before writing this hypothesis. Following the wake-visual-signals
procedure, I inspected the common held-fish prewarm sheet first, then the
released sheets for the current split-guard prefill, the triplicated functional
`28/28` guard anchor, and the inherited `0.745`-gain and `22.25 deg` amplitude
underperformers. Every accessible current rollout is a finite target reach, so
there is no current collision, exit, or instability sheet to compare; the
older reversed-sign instability is retained only as an inherited logged safety
boundary and is not presented as freshly inspected visual evidence. No omitted
Bookshelf material, neighboring configuration, repository history, coordinate
route, clock, or external research was used.

The common prewarm frames show the held fish above and downstream of four
developed interacting vortex streets, with the target in the second-row wake
overlap. This is identical initial-condition evidence for all candidates, not
support for a memorized route or a claim of wake-phase robustness.

The three functionally identical gain-`0.75`, `22 deg`, `28/28` guard samples
reproduce the same metrics and visually compact route. The fish makes a bounded
down-left turn, self-propels through the developed wake, enters the target from
the right, and reaches in `74.23` release units without collision or boundary
excursion. Mean world/local-flow x velocities are `-0.14682/-0.08249`, hence
the `0.06433` upstream-relative component is material rather than passive
advection. Mean distance is `2.56125L`, total command energy is `50940`, RMS
relative crossflow is `0.12919`, and RMS force/moment are `22.39/393.08`.
Joint angles and speeds remain below the hard envelope, while both action maxima
touch their candidate guards at `28 rad/time^2`.

The current prefill changes only the posterior guard from `28` to
`27 rad/time^2`. It still reaches and is the best scalar sample: score improves
from `-0.661705` to `-0.654416`, and mean distance falls slightly from
`2.56125L` to `2.55543L`. The rest of the evidence rejects its intended
load-suppression mechanism. Arrival slows by `2.22` units to `76.44`,
upstream-relative x speed falls to `0.06199`, total command energy rises to
`53200`, and RMS relative crossflow, force, and moment rise to
`0.13246/24.69/417.71`. The tail acceleration reaches the new `27` guard.
Its sheet also shows a deeper final downward correction: center y displacement
grows in magnitude from `-4.268L` to `-4.612L`, consistent with the load and
propulsion regressions rather than a cleaner tail transient. The scalar/mean-
distance improvement is therefore a route tradeoff, not evidence that harder
posterior clipping reduces actuation load.

The inherited `0.745`-gain rollout remains the most informative accessible
underperforming sheet: it passes visibly below the direct corridor and returns
from underneath, reaching only at `86.99` with `0.05865` upstream-relative x
speed and RMS force/moment `39.84/540.72`. The inherited `22.25 deg` amplitude
probe similarly raises load and slows arrival. Together with the current A/B,
these comparisons favor preserving the exact positive-bearing gait and
changing only how the posterior response is damped.

## Single candidate hypothesis

Restore the posterior acceleration guard to the triplicated anchor's
`28 rad/time^2` and increase only `tail_damping` from `0.65` to `0.67`. Retain
the `0.75` positive-bearing gain, `10 deg` steering cap, `0.75` period,
`22 deg` state-energy oscillator, energy gain, posterior target, lag, and
anterior guard. This is one posterior-transient mechanism: the slightly larger
velocity term acts before the hard guard, while restoring the guard avoids the
longer clipped response observed at `27`. It adds no new observation, clock,
coordinate, route, or unavailable flow dependence.

Later CFD should preserve finite target capture and material upstream-relative
propulsion while reducing posterior guard contact or RMS force/moment without
the split-guard rollout's deeper lower correction. Treat the probe as improved
only if it preserves the anchor's compact approach and improves load or route
metrics without a disproportionate energy cost. Reject it if capture slows or
fails, mean distance rises, upstream-relative x speed falls materially below
the anchor, or damping erases the useful traveling bend. Even a same-snapshot
win must be falsified across held-out wake phase, inflow, cylinder geometry,
and target placement. No outcome for this unevaluated workspace candidate is
claimed.
