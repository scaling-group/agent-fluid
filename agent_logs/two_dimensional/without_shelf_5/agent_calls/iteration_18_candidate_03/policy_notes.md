# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four current shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the staggered cylinder streets
  develop and merge through the target region. This is common initial-condition
  evidence, not a controller discriminator.
- Three current policies are byte-identical `1700 deg/time^2` posterior-cap
  replicas and produce byte-identical released sheets and physical metrics.
  The fish turns left and down under a dense alternating propulsive trail,
  traverses the merged wake without collision, exit, or instability, and
  crosses the target ring at `34.331`. Mean fish velocity
  `(-0.3164,-0.1322)` versus mean local flow `(-0.1782,-0.1839)` confirms
  active leftward propulsion rather than passive advection. Each replica has
  score `0.159531`, mean distance `1.714L`, energy/power `45153/3390`,
  posterior excursion `0.509` rad, relative-crossflow RMS `0.2312`, and
  force/moment RMS `54.48/766.14`. The candidate cap is active at
  `29.671 rad/time^2`; anterior acceleration and both joint-rate maxima still
  touch their episode envelopes.
- The isolated `1750 deg/time^2` comparator follows the same visible safe,
  self-propelled topology but reaches later at `35.750`. Its score, mean
  distance, energy, and power regress to `0.133441`, `1.741L`, `48243`, and
  `3614`; mean leftward velocity weakens to `-0.3038`. It also has lower
  crossflow and force/moment RMS (`0.2257`, `47.39/694.77`). Together with the
  inherited uncapped `1800` anchor (`38.049`, `1.802L`, `52895/3965`), the
  equal 50-degree cap steps support a local navigation/effort trend from
  `1800` through `1750` to the replicated `1700`, but also a clear increasing-
  load tradeoff. They do not prove a globally monotonic cap response.
- The assigned parent's higher-damping `0.70` control hypothesis is the most
  informative inherited failure. Its keyframes visibly fall behind along the
  same route; diagnostics regress to `46.910/2.067L`, `66607/5051`, and mean
  velocity `(-0.2316,-0.0967)`. Lower `33.13/581.31` loads are bought by weak
  traverse, while posterior excursion rises to `0.569` rad and cap contact
  remains. Thus damping is not a substitute for the cap mechanism. Inherited
  lag, allocation, bearing-gain, amplitude, and damping tests already bracket
  those axes, and unscaled mixed feedback was unstable; they remain fixed.
  No omitted shelf, neighboring configuration, external artifact, or
  repository history was consulted.

## Candidate hypothesis

Preserve the `0.55`-period, 28-degree oscillator, lag `0.75`, damping `0.65`,
gain-`1.7` bounded body-frame bearing law, 12-degree steering bound,
fraction-`0.35` allocation, and existing observation set. Change only the
candidate-owned symmetric posterior acceleration ceiling from `1700` to
`1650 deg/time^2`. This is one equal-sized continuation of the measured
`1800 -> 1750 -> 1700` local trend, testing whether limiting only the posterior
command can further improve active traverse and effort without weakening the
anterior oscillator or changing the route.

The later CFD rollout supports the candidate only if it preserves the visible
turn-then-diagonal capture without collision, exit, or instability and improves
at least one navigation/effort measure beyond the replicated `1700` anchor:
arrival below `34.331`, mean distance below `1.714L`, energy below `45153`, or
power below `3390`, without material regression in the others. Because load
already rises as the cap tightens, crossflow or force/moment materially above
`0.24` or `60/840`, posterior excursion above `0.521` rad, arrival at or beyond
the `1750` comparator's `35.750`, a changed route, or loss of capture rejects
the continuation even if one scalar improves. A positive result applies only
to this certified wake phase and start pose until held-out conditions test it;
a negative result closes further cap tightening below `1700` until a separate
mechanism changes the load tradeoff.
