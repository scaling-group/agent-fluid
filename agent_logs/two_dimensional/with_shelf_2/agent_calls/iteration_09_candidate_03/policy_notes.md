# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while the four cylinder streets develop and merge around the
  target. The released comparisons therefore start from the same mature wake,
  not candidate-specific flow initialization.
- All four sampled candidates are semantic successes with a coherent
  body-generated traveling wake and a continuous diagonal down-left capture
  route. The best sampled child is the prefilled closure-efficiency envelope:
  its released sheet retains the established route and crosses the `0.75L`
  circle at `45.48`, with `1.724L` mean distance and `-10.97/-4.59L` head
  displacement. Metrics confirm that this is active upstream propulsion, not
  passive downstream advection: mean body velocity exceeds the local flow in
  the upstream direction (`-0.240` versus `-0.177`).
- The sibling comparison separates feedback structure from amplitude alone.
  Fixed aligned posterior emphasis reaches at `46.80` with force/moment RMS
  `441/4259`; signed absolute-closing modulation reaches at `46.66` with
  `453/4371`; progress-deficit emphasis reaches at `46.31` with `393/3878`;
  and body-speed-normalized closure efficiency reaches earliest at `45.48`
  with `405/4029`. Its total command energy also falls to `47033` from
  `47931` for the fixed-emphasis parent, although mean command energy rises
  because the episode is shorter. The best result therefore supports
  response-conditioned posterior wave shaping, but not a scalar-only increase.
- Every sampled success touches the `4.538` rad/time hard rate limit on both
  joints. The best candidate already reaches `0.677` rad posterior angle and
  `28.42` rad/time-squared posterior acceleration, so further amplitude is a
  weakly isolated test. No failure keyframe is present among the current
  sampled solver sheets. The inherited notes supply the relevant negative
  contrast: a propulsive-priority headroom allocator traveled farther but
  passed below the circle and collided with the lower second-row cylinder at
  `58.93`, with `1.872L` closest approach and `537/4995` force/moment RMS.
  Preserve the complete route-steering composition and yaw-load gate.

## Candidate hypothesis

Preserve the successful oscillator, predicted-bearing route request,
yaw-moment steering gate, distributed half-cycle steering, smooth limiter,
and closure-efficient posterior envelope. Add one compact wave-timing
mechanism: only while predicted body-frame bearing is aligned and normalized
windowed closure is efficient, increase posterior phase lag slightly. Apply
an analytic amplitude compensation relative to the baseline lag, so the new
term rotates the ideal posterior harmonic rather than disguising another
posterior-amplitude gain. When alignment or useful closure disappears, the
policy continuously becomes the exact prefilled controller.

The next CFD rollout falsifies this candidate if it loses `target_reached`,
does not improve the `45.48` arrival or `1.724L` mean-distance baseline,
returns an upper/lower exit or collision topology, or increases joint-limit
residence or hydrodynamic load without useful progress. A positive result in
the fixed snapshot would still not establish robustness to changed wake phase,
inflow, geometry, or target.

bookshelf_consulted: true
source_domain: Lighthill-style elongated-body propulsion and sensor-modulated robotic-fish rhythmic control
source_mechanism: posterior wave timing contributes reactive thrust while body-frame task feedback modulates a preserved rhythmic generator
transferable_invariant: after a traveling bend and route control work, adjust posterior phase lag only during aligned efficient closure while preserving the baseline wave and separating phase from amplitude
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot linkage geometry, exact vortex phases, and task-specific routes
policy_translation: use bounded predicted-bearing alignment and windowed closing speed normalized by body speed to schedule a small posterior lag shift, with analytic harmonic-amplitude compensation and no change to the two-joint steering law
falsification: reject if capture, arrival, mean distance, or route topology regresses, or if rate-limit contact and force/moment load rise without compensating progress
