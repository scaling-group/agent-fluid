# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet establishes only the common initial condition: the
  fish remains held at the upper-right release pose while the four staggered
  vortex streets develop and interact around the target. It gives no
  candidate-specific control credit.
- All four current solver samples are byte-identical gain-`1.7`, split-`0.40`
  policies with identical rollouts. The released sheet shows active
  self-propulsion rather than passive advection: after an early heading
  correction, the fish leaves a dense alternating tail trail, travels
  diagonally left and down into the developed wake corridor, and crosses the
  `0.75L` target ring without collision, domain exit, or instability. The
  metric cross-check is capture at `39.710`, mean/final distance
  `1.874/0.749L`, relative-crossflow RMS `0.2265`, force/moment RMS
  `38.40/618.59`, power proxy `4092.5`, total command energy `54703.2`, and
  maximum anterior/posterior angles `0.507/0.528` rad.
- The inherited split-`0.45` rollout is the most informative failure to
  improve; no locally packaged sampled rollout is a semantic failure. Its
  released sheet retains the same broad self-propelled diagonal route and
  eventual capture, but the visibly vigorous late wake interaction does not
  buy a better approach. It reaches only at `43.323`, raises mean distance to
  `2.025L`, relative-crossflow RMS to `0.2456`, force/moment RMS to
  `41.96/709.54`, power to `4557.0`, and total command energy to `60174.8`.
  Both joint peaks increase to `0.544/0.562` rad even though the change was
  intended to transfer steering bias forward. Rate and acceleration peaks
  remain at the same caps. Thus moving the split toward equal steering centers
  did not relieve the posterior joint and should not be repeated or locally
  interpolated as a load-reduction mechanism from this evidence.
- The inherited gain-`1.725` and gain-`1.9` regressions independently rule out
  another bearing-gain sub-step. The inherited multi-signal instability at
  `2.807` is an outer safety boundary rather than a visual comparator because
  its keyframe artifact is not packaged here; it argues against confounding
  this candidate with new velocity, force, moment, or propulsion feedback.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator, gain-`1.7`
bounded-bearing law, split `0.40`, posterior lag gain `0.8`, and 12-degree
steering bound. Increase only the existing posterior `tail_damping` from
`0.65` to `0.70`. This directly tests whether modestly attenuating the
posterior joint response can address the measured posterior excursion and
moment load after forward redistribution failed, without adding an unscaled
observation or changing the successful target mapping and propulsive phase.

The later CFD rollout should preserve target capture and reduce at least one of
the `0.528`-rad posterior peak, `0.2265` crossflow RMS, `618.59` moment RMS, or
effort envelope without transferring the excess to the anterior joint. Loss of
capture, a material arrival/mean-distance regression without compensating load
or effort reduction, or larger anterior/posterior excursions falsifies the
probe and should restore damping `0.65`. The current worker cannot claim the
new damping value as an improvement until that later evaluation exists.
