# Multiplicative response-consensus target-ray candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and capture termination. Two independently evaluated
  moment-only policies reproduce score `-0.19997658`, mean distance
  `2.08507586L`, crossing distance `0.74382418L`, and `16.93206T`
  capture. The prefilled minimum-of-responses policy changes that result only
  narrowly to `-0.19997473/2.08507437L/0.74382240L`.
- I inspected both rows of the combined keyframe sheets for the strongest
  sampled product-consensus policy and the informative moment-only response
  projection. In both, the top-down row shows continuous target-directed
  translation with a coherent alternating red/blue street, while the oblique
  row retains compact caudal Lambda2 structures through the capture sphere.
  Neither exhibits held-joint coasting, passive advection, collision, domain
  exit, wake collapse, or instability. Their metrics support the visual
  diagnosis: peak fish speed is `1.39123U` while peak sampled local flow is
  only `0.03270U`.
- The product-consensus sample is the strongest finite result. It preserves
  the same `16.93205T` arrival and whole-trace maxima for joint angles, joint
  speeds, actions, yaw moment, fish speed, and local flow, but improves score,
  mean distance, and crossing distance to
  `-0.19994654/2.08505160L/0.74379522L`. Peak normalized lateral force also
  falls from `0.0302559` to `0.0302096`. This is a small terminal allocation
  improvement, not evidence for stronger propulsion or a new route.
- The sampled policy differences constrain the response-consensus law. The
  moment-only candidate admits the target-compatible,
  posterior-positive-work increment according to adverse yaw response. The
  prefill takes the minimum of yaw and lateral-force gates and gains only
  `0.00000185` score. The product candidate compounds the two normalized
  response fractions and gains `0.00003004` over moment-only while leaving the
  broad route and mechanical maxima unchanged. It also uses a `0.020` force
  full-response scale instead of the prefill's `0.012`, so these samples
  support the evaluated product-plus-scale package but do not separately
  identify the operator and scale effects. On this trace, treating independent
  partial responses as joint confidence is the strongest tested choice.
- The inherited symmetric target-ray and carrier-relief continuations remain
  the larger negative controls: despite coherent wakes and slightly earlier
  arrivals, they regressed to approximately
  `-0.204430/2.08866L/0.74814L` and
  `-0.206188/2.09007L/0.74984L`. Therefore the evidence supports releasing
  only optional target-ray work; it does not support suppressing the full
  velocity-course request or carrier.

## Single-candidate policy hypothesis

Materialize the evaluated strongest sampled architecture as the sole
candidate. Preserve the zero-centered anterior oscillator, lagged posterior
carrier, full body-frame velocity-course loop, one-sided point-consistent
target-ray correction, posterior-positive-work phase selector, posterior
acceleration reserve, C1 command envelope, high-onset positive-power speed
guards, signed work reallocation, receiver taper, and posterior stopping-risk
projection. Change only the response-consensus operator for the optional
terminal target-ray increment: multiply the smooth adverse-yaw and adverse
body-lateral-force gates. Keep the force scale in normalized `force_body_L`
units and in the parameter schema. Favorable response on either axis then
releases the residual continuously without weakening base course steering or
the traveling carrier.

This is an evidence-backed selection and mechanism replication, not a claim
about this worker's unevaluated CFD. Expect capture, the inherited broad route,
coherent alternating three-dimensional shedding, sublimit joint speeds, and
the sampled distance/load advantage. Falsify the mechanism if it does not
reproduce the product sample's distance quality, loses capture, changes any
state at or beyond the `2.25L` terminal boundary, suppresses the established
high-value target-ray bursts, touches a joint limit, exceeds `0.5993 rad`
posterior excursion or `0.0370/0.0184` force/moment bounds, or disrupts the
alternating wake. Because the gain is small and confined to one fixed
still-water approach, do not generalize product consensus to other response
channels until it survives a meaningfully different trajectory.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and asymmetric flapping
source_mechanism: sensor feedback schedules target-compatible work on a useful propulsive half-cycle and releases it as measured directional response develops
transferable_invariant: preserve the coupled traveling rhythm while allocating bounded corrective work only during a joint-state phase that performs useful work and only to the degree that independent normalized body responses remain adverse
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, duty ratios, full-body oscillator networks, exact vortex phases, force thresholds, capture radius, and task-specific routes
policy_translation: retain the body-frame velocity-course loop and one-sided target-ray increment; multiply its posterior-positive-work adverse-yaw and adverse-lateral-force response gates before the existing two-joint allocation and mechanical-safety layers
falsification: reject if broad-route equivalence, capture, sublimit joints, or alternating three-dimensional shedding is lost; if useful response-compatible bursts are suppressed; or if distance quality and lateral load do not reproduce the sampled advantage without another semantic or mechanical benefit
```

No formal CFD is run in this worker. The candidate rollout becomes evidence
only after this worker exits.
