# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned examples satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. Three are
  executable-identical half-cycle envelope-redistribution policies. They
  capture at `18.6505--18.8815T`; two reproduce the best sampled mean-distance
  band (`2.08855--2.08896L`), while the third reaches `2.09222L`. The only
  architectural variant is a rearward-route multiplier whose reconstructed
  forward target fraction stays positive, so its new branch is dormant and
  establishes only non-interference.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the strongest assigned capture, the fastest executable-identical
  capture, the dormant-branch capture, and the inherited direct-composition
  failure. The assigned captures form energetic alternating streets from
  quiescent water, bend those streets toward the target, and retain compact
  alternating caudal Lambda2 structures through first crossing. Their motion
  is coherent self-propulsion, not imposed-flow advection. The inherited
  failure retains the same energetic two-view wake class but bends below and
  away after about `16T`, reaches only `1.90495L`, and exits left at
  `31.1905T` and `9.45478L`; wake coherence therefore does not establish
  correct route allocation.
- The three identical current captures retain the established high-demand
  class: anterior/posterior acceleration contact is about
  `60.85--61.00%`/`72.97--73.27%`, rate contact is
  `11.01--11.07%`/`14.88--15.07%`, peak planar force is
  `0.03066--0.03217`, and peak yaw moment is `0.01603--0.01663`. The lower
  integral is not actuator relief. Their route realizations differ
  materially: two enter `|target_body_y|/distance >= 0.55` near
  `17.35--17.40T` and finish strongly broadside, while the fastest capture
  never exceeds `0.4402` and finishes nearly forward-aligned. Capture across
  both topologies supports the simple carrier but cautions against adding
  another late geometry branch.
- The inherited complementary cruise-to-redirect handoff has now completed.
  It preserves capture at `19.2060T`, both coherent wake rows, and the usual
  terminal distance, but its mean distance is `2.09986L`, worse than the
  isolated redistribution band and no better than prior handoffs/reserves.
  Thus weighting envelope redistribution by either an axis-to-onset gate or
  the reserve's actual broadside gate prevents catastrophic superposition but
  discards the isolated integral benefit. Do not stack another broadside,
  distance, alignment, response-release, or posterior-allocation modifier.
- A narrower unresolved attribution remains inside the strongest carrier.
  Earlier displacement-only half-cycle *curvature* steering captured at
  `18.8815--19.0520T` but had mean distance `2.09874--2.10234L`, worse than
  both the geometry-scheduled carrier and the later envelope-redistribution
  carrier. The current policy applies that curvature modulation and envelope
  redistribution simultaneously. Removing only curvature modulation tests
  whether observed beat phase should allocate the common propulsive envelope
  without also varying the target-owned mean bend.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological traveling-wave turning
source_mechanism: beat-side asymmetry redistributes rhythmic effort while a target-directed mean bend supplies route curvature
transferable_invariant: preserve posterior-lagged propulsion and let observed displacement phase allocate the common rhythmic envelope without making persistent target curvature alternate in strength
nontransferable_details: published duty ratios and gains, robot geometry, species-specific kinematics, dimensional cadence, prescribed clock phase, exact vortex phase, and task-specific routes
policy_translation: retain target-lateral mean curvature, correcting-yaw release, posterior lag, and displacement-phase common-envelope redistribution, but remove displacement-phase scaling from both mean-curvature shares
falsification: reject if capture or either coherent wake row is lost, the inherited left-exit topology returns, mean distance leaves the isolated redistribution band without a distinct semantic benefit, or actuator/load contact materially exceeds the sampled carrier class
```

## Single-candidate policy hypothesis

Produce exactly one phase-separated allocation candidate from the prefilled
redistribution carrier. Target geometry and the non-inverting response gate
set constant anterior/posterior mean-curvature shares at each observation;
observed anterior displacement phase continues to redistribute only the common
rhythmic-amplitude relief. Preserve the oscillator, posterior lag and damping,
`4/10 deg` curvature limits, and exact final acceleration projection.

This is a one-mechanism architecture ablation, not scalar gain tuning. It adds
no clock, world coordinate, target identity, memorized route, velocity-phase
predictor, flow residual, terminal schedule, posterior-only allocation, rate
barrier, or competing geometry modifier. Formal CFD runs only after this
worker exits. Accept the separation only if capture and both wake views
survive; credit it further only if the lower `2.08855--2.08896L` mean-distance
band repeats or the route becomes usefully more robust without worse demand.
