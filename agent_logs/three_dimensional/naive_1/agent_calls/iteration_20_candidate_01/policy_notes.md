# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts and the assigned parent's completed rollout satisfy
  the frozen evidence contract: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and capture. I inspected both rows of the combined sheets for the
  current prefill `solver_8687829e1d01`, the best sampled candidate
  `solver_649d7e789a5a`, and the assigned parent's informative release failure
  `solver_811bb25c1cd3`, then cross-checked them against diagnostics,
  trajectories, executable policy differences, inherited guidance, and the
  parent's optimization notes.
- The top-down rows show genuine self-propulsion rather than advection: from a
  quiescent release, body-attached alternating vorticity grows into a coherent,
  target-bending street. The oblique rows retain compact alternating caudal
  Lambda2 structures through first crossing. There is no visible wake collapse,
  collision, domain exit, or numerical instability in the three compared
  runs, so their small performance differences should be attributed to route
  and beat allocation rather than a topology change.
- The prefill architecture has three executable replications. They capture at
  `18.6505--18.7550T`, score between `-0.20743` and `-0.20578`, and have mean
  distance `2.09340--2.09542L`. The sampled half-cycle envelope redistribution is the
  one supported improvement: it reaches `10L`, `5L`, and `2L` at `7.4140T`,
  `13.6290T`, and `17.1490T`, earlier than the prefill's `7.4745T`,
  `13.7335T`, and `17.2150T`; it lowers mean distance to `2.08855L` and
  improves score to `-0.20041`, while retaining capture and both wake views.
- This improvement is route allocation rather than demand relief. Its
  anterior/posterior acceleration-contact fractions are `60.85%/73.27%`,
  rate-contact fractions are `11.07%/14.93%`, mean planar force magnitude is
  `0.01314`, and mean absolute yaw moment is `0.00677`, all effectively inside
  the prefill band. Arrival is slightly later at `18.8265T`, and terminal
  target geometry is strongly lateral (`forward=0.461`, `lateral=0.887`), so
  the mechanism is qualified by route-integral improvement rather than a claim
  of terminal alignment or actuator relief.
- The assigned parent tested the natural release hypothesis: smoothly remove
  only the added redistribution as forward target alignment falls from `0.90`
  to `0.75`. It retained the coherent two-view wake and captured at
  `18.7880T`, but reached `10L`, `5L`, and `2L` later (`7.4800T`, `13.7775T`,
  `17.3030T`), worsened mean distance to `2.09961L`, and scored `-0.21153`.
  Its loads and saturation remained essentially unchanged. Together with the
  inherited distance-only release that lost capture, this rejects releasing
  the additional allocation before first crossing, even when release uses
  normalized body-frame longitudinal geometry.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and biological traveling-wave propulsion
source_mechanism: sensor-conditioned half-cycle amplitude asymmetry superposed on a persistent target-signed mean turn
transferable_invariant: redistribute a fixed mean rhythmic envelope between observed beat halves while preserving target-owned turn sign, mean curvature, posterior lag, and the traveling bend
nontransferable_details: published gains, dimensional frequency and amplitude, clock phase, species-specific body envelopes, full-body waveforms, exact vortex phases, and world-frame routes
policy_translation: retain the captured body-frame differential-curvature carrier and use normalized anterior-joint displacement phase to reduce geometric amplitude relief on the target-aligned half-cycle and increase it on the opposed half-cycle, without changing its mean or releasing it before capture
falsification: reject if capture or either coherent wake view is lost, mean distance and `2--10L` threshold progress fail to remain outside the three-replication prefill band, the route repeats a release-gated regression, or demand and planar loads materially exceed the established band

## Single-candidate policy hypothesis

Materialize the evaluated half-cycle envelope-redistribution mechanism as the
single candidate. Add one parameter-owned redistribution fraction to the
prefill. Compute displacement-only `phase_alignment` from the same bounded
body-frame target sign and anterior joint state already used for half-cycle
curvature, then redistribute the existing geometry-owned amplitude relief by
`1 - redistribution * phase_alignment`. This keeps the average redirect-to-
cruise envelope, both target-signed curvature shares, response release,
posterior lag, and final acceleration projection unchanged.

This deliberately omits the parent's longitudinal-alignment gate. Completed
evidence supports persistent common redistribution through first crossing and
shows that both distance-only and normalized-alignment release can erase its
route advantage. The new CFD result is not available to this worker; accept
this candidate only if it reproduces capture, the coherent top-down and
oblique wake structures, and the sampled route/mean-distance band without a
material demand or load regression.
