# Bidirectional rejected-steering allocation candidate

## Evidence and visual diagnosis before editing

- All four current solver examples satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and semantic `capture`.  Two v29
  variants reproduce capture at `19.3105 T`, score `-0.21058`, and distance
  integral `2.09959 L`; the inherited v31 carrier-centered half-cycle policy
  captures at `19.0355 T`, `-0.20185`, and `2.08993 L`; and the strongest v30
  whole-wave pose projection captures at `18.9970 T`, `-0.18597`, and
  `2.07455 L`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for v30, the slower reproduced v29 capture, and the inherited
  whole-wave-rate failure from release through termination.  V30 and v29 are
  visibly self-propelled along smooth target-signed arcs, leaving compact
  startup structures followed by coherent alternating posterior wakes; v30 is
  subtly farther along the same useful trajectory.  The rate-projection
  failure instead turns upward and then nearly vertical away from the target,
  despite forming a wake, and exits the upper boundary at `8.4755 T`.  None of
  these sheets indicates background advection or a prewarm artifact.
- Metrics agree with the successful visual comparison.  Relative to v29, v30
  leads by `0.024/0.154/0.149/0.174 L` at `4/8/12/16 T`, raises mean speed only
  from `0.665` to `0.676 L/T`, lowers maximum speed from `0.931` to `0.927
  L/T`, and retains the `0.0307/0.0154` peak normalized force/moment envelope.
  Its any-joint acceleration-limit residence is `43.43%`, so further progress
  should recover target authority already discarded at componentwise bounds,
  not increase global carrier or steering gains.
- The inherited v31 half-cycle-centering hypothesis is now a completed mild
  negative result: subtracting commanded mean curvature from beat-side
  detection retains capture but delays it by `0.0385 T`, increases the
  distance integral by `0.01538 L`, loses `0.118/0.124 L` of closure at
  `8/12 T`, raises maximum speed to `0.948 L/T`, and raises limit residence to
  `44.21%`.  Raw tail tangent therefore remains the better sampled actuator
  phase detector even though mean-preserving centering is useful in the route
  observation.
- The inherited whole-wave derivative projection is a much stronger negative
  boundary.  Adding `0.16*(qdot1+qdot2)` to route-rate rejection, despite an
  offline residual correlation of `-0.925`, changes capture into
  `left_domain`, achieves only `12.2107 L` minimum distance, finishes at
  `12.7296 L`, and raises peak normalized force/moment to `0.3025/0.1347`.
  This candidate therefore preserves v30's head-only rate correction and does
  not infer causality from frozen-trajectory correlation.
- V30's completed action trace exposes a separate allocation opportunity:
  the anterior acceleration reaches its bound on `34.97%` of states, the
  posterior on `8.51%`, but both do so together on only `0.058%`.  The tail is
  at its bound while the head is not on `8.45%` of states.  The already
  validated head-to-tail spillover uses one side of this complementary
  headroom; returning only a posterior-rejected target residual supplies the
  missing symmetric path without moving either rhythmic carrier.

## One-candidate policy hypothesis

Use the evaluated v30 whole-wave pose projection as the base, including its
state-feedback oscillator, posterior lag, raw completion-gated redirect,
head-only derivative correction, raw half-cycle detector, carrier-first
projection, head-to-tail rejected-steering spillover, and physical bound.  Add
one conservative reverse allocation: after the posterior carrier and its
target-derived residual (including anterior spillover) are composed, measure
only the signed steering residual that the posterior projection would reject
and add half of it to the anterior target residual before the final projection.
Carrier demand is never transferred, and simultaneous saturation cannot
expand the envelope.

The expected result is to preserve v30 capture and wake coherence while using
otherwise idle anterior headroom during posterior clipping, improving middle
or late closure without a global gain increase.  Falsify the mechanism if
capture is lost or later than `18.9970 T`, the distance integral exceeds
`2.07455 L`, the `8-16 T` lead disappears, the target-signed arc or alternating
wake changes qualitatively, or acceleration-limit residence, maximum speed,
peak normalized force, or yaw moment materially exceed
`43.43%/0.927/0.03068/0.01541`.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric turning layered on a traveling-bend carrier
source_mechanism: distribute bounded target-derived steering across available joints while preserving the rhythmic carrier and posterior lag
transferable_invariant: target steering rejected at one actuator bound may use complementary authority at the other joint, but propulsive carrier demand must remain local to preserve wave direction and lag
nontransferable_details: published joint shares, gains, linkage geometry, clocked CPG phases, species-specific kinematics, dimensional cadence, exact vortex phases, and prescribed routes
policy_translation: in the v30 normalized body-frame controller, detect only the signed posterior target residual lost after carrier-first composition and return a bounded fraction to anterior headroom before the existing two-joint projection
falsification: reject if capture or middle/late closure regresses, the coherent target-signed wake changes, or saturation, speed, normalized force, or yaw moment rises without compensating progress

## Evidence boundary

All outcome claims above come from completed sampled CFD, the assigned parent,
and inherited optimizer logs.  The new reverse-allocation candidate receives
formal CFD only after this worker exits, so no same-worker improvement is
claimed.

## No-CFD implementation audit

- Reconstructing the candidate observation on `3447` usable states from the
  completed v30 trace activates reverse allocation on `293` states (`8.50%`),
  including `95` states after `16 T`.  On those frozen states the anterior
  command changes by mean/max `0.389/1.239 rad/T^2`, while the posterior output
  is bit-identical to v30.  This confirms that the structural path targets the
  diagnosed posterior-only clipping set; it is not closed-loop evidence.
- A separate deterministic `37500`-state grid finds finite, envelope-bounded
  commands throughout.  Every v32/v30 difference occurs with the v30 tail at
  its acceleration bound, and the tail output remains identical.  Formal CFD
  is still required to decide whether the recovered steering improves the
  route without disrupting the carrier.
