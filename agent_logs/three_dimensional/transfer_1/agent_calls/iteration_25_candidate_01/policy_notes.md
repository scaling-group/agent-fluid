# Response-released posterior launch replication candidate

## Completed evidence and visual diagnosis before editing

- The four current sampled rollouts are finite captures from direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  Two byte-identical v38 baselines capture at `18.23249 T`, score
  `-0.12650`, total/observed distance integrals `2.01298/1.39980 L`, mean/max
  speed `0.7032/0.9519 L/T`, acceleration-limit residence `41.54%`, and peak
  normalized planar force/moment `0.03068/0.01579`.
- I inspected the v38 and v41 sheets from release through capture.  The v38
  top-down row and oblique body/Lambda2 row show self-propulsion on a smooth
  target-signed arc, with compact startup structures developing into a
  coherent alternating posterior wake; there is no passive advection, route
  reversal, collision, wake collapse, domain exit, or visible instability.
  V41 preserves the same organized target-directed top-down street while
  visibly closing sooner, but its entire oblique sheet is black.  That is an
  evidence-contract failure, so no v41-specific three-dimensional wake benefit
  is claimed and a readable replication remains necessary.
- The v41 response-released posterior launch is the strongest completed
  trajectory.  It captures at `17.91900 T`, score `-0.09321`, and improves
  total/observed integrals to `1.97941/1.36531 L`.  Relative to v38 it is
  closer by `0.0227/0.0767/0.1045/0.3625/0.3160 L` near
  `2/4/8/12/16 T`; its advantage therefore persists well after the launch gate
  releases rather than coming from terminal sample depth alone.  The tradeoff
  is bounded but real: mean/max speed rises to `0.7128/0.9675 L/T`, limit
  residence to `43.92%`, and peak force/moment to `0.03182/0.01608`.
- The v39 response-arbitrated reverse spillover captures at `18.19399 T` and
  only slightly improves v38's total/observed integrals to
  `2.01039/1.39913 L`; its trace is identical to v38 through `8 T` and does not
  approach the broad v41 lead.  Inherited v40 load-confidence extensions are
  the informative completed mechanism regressions: response gating and raw-
  crossflow-dropout bridging retain capture but worsen it to
  `18.30949/18.25449 T` and worsen total integrals to `2.01911/2.01679 L`.
  The earlier whole-wave route-rate projection remains the termination failure
  boundary: it turned with the wrong sign, exited at `8.4755 T`, and produced
  roughly tenfold planar load peaks.  These results argue against stacking a
  sensor-magnitude union, route-rate projection, or reverse steering recovery
  onto the current best launch mechanism without a new closed-loop comparator.

## One-candidate policy hypothesis

Materialize the completed v41 policy byte-for-byte as the single candidate.
It preserves v38's state-feedback carrier, posterior lag, body-frame route
geometry, crossflow band-pass pose rejection, and componentwise allocation.
Its only added mechanism scales the zero-mean posterior traveling-wave target
while normalized body speed is low, productive closing has not appeared, the
target remains far, and turn load is modest.  Body speed and observed closing
release the boost continuously; route and redirect means are unchanged, so the
mechanism is neither a clocked launch stage nor extra steering authority.

The evaluation should reproduce capture no later than `17.93 T`, observed
integral no greater than `1.37 L`, and broad checkpoint leads over v38 while
keeping maximum speed, limit residence, normalized force, and moment near the
completed `0.968 L/T`, `43.9%`, `0.03182`, and `0.01608` envelope.  It must
also produce a readable oblique row before the wake interpretation is treated
as complete.  Falsify the mechanism if the route-wide lead or capture does not
reproduce, if the posterior boost changes mean curvature or becomes persistent,
if the alternating wake degrades, or if the physical envelope materially
worsens.  Formal CFD runs only after this worker exits; none of those future
outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: retain a stable traveling-wave carrier, emphasize posterior wave motion when propulsive response is weak, and release the modulation when the desired response appears
transferable_invariant: bounded posterior emphasis can build reactive thrust without changing carrier phase or route curvature, and measured response can release that emphasis without a clock
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body amplitude envelopes, exact vortex phases, and task-specific routes
policy_translation: multiply only the zero-mean posterior tail-wave target by a bounded gate formed from normalized body-frame speed, normalized closing response, normalized turn load, and normalized target-distance authority; preserve the two-joint state-feedback carrier and all route and redirect means
falsification: reject if the broad checkpoint lead or capture fails to reproduce, the posterior action becomes persistently saturated, the readable two-view wake loses coherence, or speed, normalized force, or yaw moment materially exceeds the completed v41 envelope
```

## Evidence boundary

All numerical and visual outcome claims above come from completed sampled CFD,
the assigned parent guidance, and inherited optimizer logs.  The current
candidate is an evidence-backed replication, not a same-worker CFD result.

## No-CFD implementation audit

- The single candidate has SHA-256
  `5befc2299e4455d6d62bd677fe394601b84e486df2b85cebacf063429fbf60db`
  and is byte-identical to the completed v41 sampled policy.
- All `63` direct `params.FIELD` references resolve against the `65` fields
  returned by `target_policy_params()`.  The material-guidance check, the
  lightweight Julia policy contract, and the solver editable-boundary check
  pass.
- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account; its three prescribed
  checks were therefore run locally and separately.  No formal CFD was run.
