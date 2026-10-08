# Response-released bearing-divergence candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the Phase-2 experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and `capture` termination.  The assigned
  bearing-divergence policy is the strongest result at `18.40301 T`, score
  `-0.14045`, and distance integral `2.02781 L`; the three allocation/gating
  comparators capture at `18.754995--18.765995 T`, with scores near `-0.170`
  and integrals of `2.05747--2.05835 L`.
- I inspected both the top-down mid-plane vorticity and oblique body/Lambda2
  rows of every sampled combined keyframe sheet from release through capture.
  The strongest run and the weaker comparators all visibly self-propel from
  quiescent water along the same target-signed family of arcs, with compact
  startup structures and a coherent alternating posterior wake.  There is no
  passive advection, wake collapse, collision, domain exit, or instability;
  the strongest run is simply farther along the useful route at matched
  frames.  Thus the weaker samples are informative controller-hypothesis
  failures rather than semantic termination failures.
- Metrics corroborate the visual lead.  Relative to the three comparators,
  the assigned policy is closer by about `0.060 L` at `4 T`, `0.148 L` at
  `8 T`, `0.230--0.245 L` at `12 T`, and `0.225--0.270 L` at `16 T`.
  It preserves the same envelope: mean/max speed is `0.696/0.948 L/T`,
  any-joint acceleration-limit residence is `42.14%`, and peak normalized
  force/moment is `0.03068/0.01587`, versus comparator ranges of
  `0.685--0.686/0.940--0.949 L/T`, `41.35--42.35%`, and
  `0.03068/0.01565`.
- The completed result validates the inherited hypothesis that bounded
  target-signed curvature during de-gaited bearing divergence corrects a
  route inefficiency rather than compensating for weak propulsion.  It also
  sharpens the remaining opportunity: frozen-history replay finds the term
  active on `1296/3346` states, but on `140` of those states the body has
  already established target-signed yaw while normalized closure remains
  productive.  Continuing the full burst on that subset is redundant in the
  response sense even though translational inertia can leave bearing briefly
  divergent.
- Inherited logs supply two safety boundaries.  Response-gated carrier release
  and reverse rejected-steering allocation are non-additive on this faster
  base, while adding a fitted posterior joint-rate common mode to route-rate
  sensing reversed the arc and caused `left_domain`.  This candidate therefore
  leaves the carrier, allocation, pose projection, and head-only derivative
  correction unchanged.

## One-candidate policy hypothesis

Preserve the evaluated state-feedback traveling wave, posterior lag,
whole-wave pose projection, head-only route-rate correction, raw half-cycle
steering, positive-closing cadence release, head-to-tail rejected-steering
allocation, approach scheduling, and componentwise physical bounds.  Refine
only the successful bearing-divergence residual: while de-gaited bearing is
outside the centerline band and still diverging, retain full target-signed
curvature unless both measured body yaw is already target-signed and normalized
closing response is positive.  On that overlap, release the residual smoothly;
ordinary pursuit remains active, so this does not coast or transfer carrier
demand.

The expected result is to preserve the assigned policy's early/middle closure
and coherent wake while avoiding redundant curvature after useful angular and
translational response appears, reducing late sweep or actuator competition.
Falsify the mechanism if capture is lost or later than `18.40301 T`, distance
integral exceeds `2.02781 L`, the `4--16 T` lead disappears, route sign or wake
coherence changes, or speed, saturation, normalized force, or moment materially
exceeds `0.948/42.14%/0.03068/0.01587` without compensating progress.

```text
bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG control
source_mechanism: release a strong target-directed curvature burst after observed useful body response while leaving the traveling-bend carrier distinct
transferable_invariant: extra steering should persist during wrong-way geometric divergence but yield smoothly once target-signed yaw and productive target closure jointly demonstrate useful response
nontransferable_details: published gains, species-specific C-start kinematics, burst timing, clocked CPG phases, full-body envelopes, linkage geometry, dimensional cadence, exact vortex phases, and prescribed routes
policy_translation: multiply only the bounded body-frame bearing-divergence residual by the complement of a normalized joint gate formed from target-signed yaw response and positive closing response; preserve ordinary pursuit and both joint bounds
falsification: reject if the earlier sampled capture or middle-route lead regresses, the target-signed arc or alternating wake changes, or speed, limit residence, normalized force, or moment rises without compensating closure
```

## Evidence boundary

All outcome claims above come from completed sampled CFD, the assigned parent,
and inherited optimizer logs.  This response-released candidate receives formal
CFD only after worker exit; frozen-history activity checks below are contract
and targeting audits, not performance evidence.

## Non-CFD contract replay

- Replaying the assigned rollout history through both policies changes a joint
  command on `166/3346` states (`4.96%`).  The maximum head/tail differences
  are `0.4025/0.7957 rad/T^2` (`1.3%/2.5%` of the physical acceleration
  limit), and every candidate command remains within the unchanged
  `31.41593 rad/T^2` componentwise envelope.
- The response factor reaches only the successful divergence residual; the
  carrier, approach schedule, and actuator-allocation algebra are unchanged.
  This establishes bounded semantic activity on the diagnosed overlap, not a
  closed-loop improvement.
