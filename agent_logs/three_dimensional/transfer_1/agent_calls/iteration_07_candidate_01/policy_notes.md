# Candidate diagnosis and hypothesis

All four sampled rollouts satisfy the direct-uniform still-water contract
(`U_infinity=0`) and capture.  The two identical completion-gated parents
capture at `26.4110 T`, score `-0.71050`, and show the same coherent alternating
top-down vorticity sheet and compact three-dimensional Lambda2 chain.  The
aligned cadence residual retains that wake topology but captures later at
`26.5430 T`, increases the force/moment extrema to `0.0319/0.0159`, and does
not improve the slow first two periods.  The progress-gated posterior-lag
residual is the strongest finite sample: the combined top-down/oblique sheet
still shows self-propulsion, a coherent posterior wake, continuous targetward
turning, and no visible instability before capture.  Metrics agree: it captures
at `26.0425 T`, lowers mean distance from `2.61340 L` to `2.59751 L`, raises
mean/max speed from `0.5013/0.6669` to `0.5081/0.7170 L/T`, and leaves sampled
force/moment extrema at `0.0297/0.0148`.  Its `12.2663 L` distance at `2 T` is
slightly worse than the parent's `12.2625 L`, so the evidence supports improved
whole-route posterior thrust, not the earlier claim of improved launch.

Policy hypothesis: promote the sampled posterior-lag residual unchanged as the
single candidate mechanism.  It increases posterior traveling-bend emphasis
only while normalized closure is deficient, releases as closure establishes,
and yields continuously to large target-steering demand.  Preserve the
completion-gated redirect and the policy-side componentwise acceleration
projection.  Expect the evaluated candidate to reproduce the earlier capture,
lower distance integral, and unchanged load envelope.  Reject the mechanism as
a reusable improvement if capture is lost, arrival is not earlier than
`26.4110 T`, mean distance is not below `2.61340 L`, the alternating wake loses
coherence, or force/moment or joint-limit residence materially increases.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and carangiform two-joint gait abstraction
source_mechanism: posterior phase lag and tail-end kinematic emphasis in a traveling bend
transferable_invariant: preserve an anterior-to-posterior traveling bend and place bounded extra propulsive authority posteriorly when observed closure is deficient
nontransferable_details: published gains, species kinematics, dimensional frequencies, exact wake phase, and full-body amplitude envelopes
policy_translation: scale the posterior lag term from normalized closing response and body-frame steering load while retaining joint-state phase and the two-joint acceleration contract
falsification: reject if capture or distance integral regresses, the wake becomes incoherent, steering authority is lost, or load and saturation diagnostics worsen
