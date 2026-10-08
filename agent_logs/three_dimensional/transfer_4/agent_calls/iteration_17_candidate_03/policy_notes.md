# Differential-bend posterior-work candidate

## Evidence and visual diagnosis before editing

- I read the assigned parent guidance, all four sampled solver policies and
  evaluations, the inherited optimizer notes and completed rollout artifacts,
  and the formal policy observation adapter. Every sampled rollout satisfies
  the frozen experiment contract: direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, stable planar
  dynamics, and `capture` termination. Thus the lower-scoring captures are
  mechanism-level negative controls rather than literal termination failures.
- I inspected the combined top-down vorticity and oblique 3D Lambda2 rows for
  the sampled score leader, the assigned prefill, and the inherited
  steering-priority negative control. All three fish self-propel from rest,
  establish a coherent alternating mid-plane wake by about `4T`, and retain
  compact posterior three-dimensional structures through capture. There is no
  passive advection, collision, wake breakup, or visible numerical instability.
  The near-identical wake class supports preserving the established carrier;
  trajectory and controller-state evidence must distinguish the mechanisms.
- The sampled phase-consistent posterior-work guard is the strongest completed
  result: it improves score/mean distance from the unguarded work controller's
  `-0.072146/1.958037L` to `-0.064599/1.950823L`, while retaining its first-`3T`
  mean distance/speed (`12.214593L/0.2519U` versus
  `12.214522L/0.2519U`) and slightly lower peak planar force/yaw-moment class
  (`0.0391/0.0195`). This is positive evidence for the local one-sided
  consistency test against the current posterior target.
- The same leader exposes a route boundary. Relative to the unguarded work
  controller, capture moves from `17.8695T` to `18.0125T`, center path from
  `13.0071L` to `13.2330L`, maximum head cross-track from `0.6102L` to
  `0.7417L`, and mean near-target course alignment from `0.787` to `0.664`.
  The coherent wake and unchanged force/moment class do not support weakening
  the base carrier or adding load suppression.
- An inherited steering-priority work gate is a completed negative result. It
  repaired route geometry to `12.9241L` path, `0.5003L` cross-track, and
  `0.415` final course alignment, but lost the early propulsion benefit
  (`12.221291L/0.2443U` over the first `3T`) and regressed score to
  `-0.095199`. Therefore absolute turn demand is too broad a reason to remove
  recovery work. The response-energy gate also regressed to `-0.082282`, so
  achieved orbit magnitude is not a supported release certificate either.
- In two-joint command coordinates the phase-consistent tail-only reserve
  `[0,p]` decomposes exactly into a mean tail-tangent command
  `[p/2,p/2]` and a differential-bend command `[-p/2,p/2]`. The former changes
  the acceleration of `phi1+phi2`, the same tail-tangent coordinate used by
  beat-synchronous steering, even though the reserve was introduced only to
  establish posterior propulsive work. This supplies a local actuator-allocation
  explanation for retaining the early benefit while avoiding a global
  steering-demand gate.

## One policy hypothesis

Start from the sampled-best phase-consistent posterior-work controller and
preserve its anterior phase-plane carrier, lagged posterior target, odd
mean-curvature and half-cycle steering, error-qualified far-route observer,
ordinary approach controller, cadence schedule, closure qualifier, one-sided
tracking-work guard, and reversal-preserving rate governor. Project only the
extra posterior-work residual from `[0,p]` onto `[-p/2,p/2]` before the joint
envelopes. This keeps its differential-bend acceleration exactly `p`, removes
its direct pre-envelope contribution to the steering coordinate
`phi1+phi2`, and does not gate the proven reserve by turn magnitude, elapsed
time, coordinates, target identity, or a prescribed phase.

Expected evidence is retention of the phase guard's first-`3T` speed/distance
and mean-distance advantage, with capture time, path, cross-track, and
near/final alignment moving toward the unguarded or steering-priority route
class. Falsify the mechanism if early closure or score-distance regresses, the
wider route remains, capture is lost or delayed materially, force/moment or
limit residence rises to a worse class, the downstream independent envelopes
destroy the intended allocation, or either visual wake row loses coherent
traveling structure. This candidate has not received CFD evaluation; these are
predictions, not same-worker evidence.

bookshelf_consulted: true
source_domain: Lighthill posterior reactive propulsion and robotic-fish mean-curvature or asymmetric-flapping steering
source_mechanism: posterior wave work generates propulsion while average bend and beat asymmetry provide separable steering coordinates
transferable_invariant: allocate extra recovery work to the observed traveling-shape coordinate without injecting a direct mean-curvature command, while preserving the proven carrier and target feedback
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body modal shapes, exact vortex phases, and task-specific routes
policy_translation: retain the closure- and phase-consistent posterior work magnitude, but project its two-joint acceleration from a tail-only residual onto the zero-sum differential-bend vector `[-p/2,p/2]`
falsification: reject if early closure or mean-distance gains disappear, route and alignment metrics do not improve, actuator or load class worsens, independent envelope clipping defeats the allocation, or top-down and oblique wake coherence degrades
