# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts are valid direct-uniform still-water evaluations
  (`U_infinity=0`) and terminate in capture. Their top-down sheets show
  self-propelled translation, not passive advection: the fish advances through
  a coherent alternating reverse-street-like mid-plane wake from release to
  the target. The oblique Lambda2 views show compact three-dimensional
  structures shed behind the posterior body without an instability or loss of
  the body wave. There is no failed termination in the assigned sample, so the
  informative contrast is trajectory/actuation quality among captures.
- The response-conditioned terminal-relief sample is the strongest sampled
  finite reference: capture at `16.049T`, score `-0.056774`, observed distance
  integral `1.313958L`, total distance integral `1.939780L`, and final distance
  `0.745461L`. It preserves the earlier `8/6/4/2L` crossings at
  `9.202/11.154/13.013/14.905T`.
- The assigned parent adds a predicted-miss corridor that releases posterior
  mean curvature only when the replacement acceleration is pointwise relief.
  It preserves those milestones and the `16.049T` capture, and slightly lowers
  mean posterior command (`24.901` versus `24.923 rad/T^2`), but does not change
  the observed distance integral and slightly regresses score to `-0.056973`.
  Its terminal heading rate still rises to `3.256 rad/T` while the projected
  translational miss is already inside the capture neighborhood. Thus the
  corridor is a useful geometric guard, but the pointwise command fallback is
  too weak to dissipate the measured yaw response.
- The two posterior wave speed-headroom samples remain coherent captures, but
  finish later (`16.071T` and `16.077T`) with worse total distance integrals
  (`1.940194L` and `1.941101L`). Their posterior acceleration-limit residence
  remains `22.38%` and `22.75%`, close to the response-conditioned reference's
  `22.89%`; pre-clamp wave attenuation near `0.96` of the velocity limit is
  therefore not an evidenced route or saturation improvement on this carrier.

## Policy hypothesis

Retain the response-conditioned carrier, carrier-phase residual selector,
one-sided wave relief, mean-first posterior allocator, and exact-boundary
anti-windup. Retain the parent's normalized predicted-miss corridor only as a
terminal safety gate. Inside that gate, subtract a small bounded posterior
mean-curvature term proportional to the measured recent yaw rate. This changes
feasible action rather than merely filtering rejected acceleration, remains
reflection-equivariant, and releases automatically if closing or the predicted
crossing becomes unsafe. The expected effect is unchanged pre-approach
milestones and coherent wake, with smaller terminal yaw growth and no loss of
capture. Falsify the candidate if any pre-`1.75L` trajectory changes, capture
is delayed or lost, posterior limiting/load grows, or the correction reverses
target-directed turning outside a safe closing corridor.

bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG control
source_mechanism: release a bounded burst redirect when measured turning response appears, then return continuously to the propulsive carrier
transferable_invariant: strong steering authority should yield to measured response only under an observation-defined safe approach condition
nontransferable_details: published gains, species-specific C-start shapes, clocked CPG phases, dimensional frequencies, and prescribed routes
policy_translation: use normalized body-frame target and velocity to define a closing predicted-miss corridor, then apply a bounded reflection-odd recent-yaw-rate brake through posterior mean curvature
falsification: reject if the coherent wake or early milestones change, capture is delayed or lost, the safe-corridor gate fails to reopen steering, or terminal load and saturation increase
