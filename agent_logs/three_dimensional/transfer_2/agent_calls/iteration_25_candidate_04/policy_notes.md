# Candidate diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled episodes satisfy the direct-quiescent contract: uniform
  `U_infinity=(0,0,0)`, no cylinders or prewarm, and capture from the common
  `12.328L` release. The top-down sheets show self-propulsion rather than
  advection: a strong alternating reverse-von-Karman-like wake grows behind the
  tail while distance decreases monotonically. The oblique Lambda2 sheets
  confirm coherent three-dimensional vortex loops/tubes through the cruise and
  final turn rather than a planar rendering artifact.
- The strongest finite sample is the response-aware handoff plus joint-rate
  guard. It captures at `18.755T` (score `-0.15214`) and reaches `10/8/6/4/2L`
  at `6.760/9.416/11.979/14.564/17.166T`. The unguarded response-aware sample
  captures at `19.162T` (score `-0.18047`) with corresponding milestones
  `6.897/9.658/12.210/14.889/17.561T`. Thus the guard improves the whole
  trajectory, not only the capture crossing.
- The guard also lowers mean absolute anterior/posterior command from
  `18.46/17.56` to `17.87/17.07 rad/T^2`, posterior command residence above
  90% of the smooth bound from `33.96%` to `30.65%`, and posterior joint-rate
  residence above 99% of the hard envelope from `4.36%` to `3.28%`. It retains
  the coherent wake and ample angle margin (`30.38/32.92 deg` peaks).
- Its unresolved cost is trajectory/load allocation: head path is `12.421L`
  versus `12.309L` for the unguarded response-aware sample, and peak planar
  force/yaw-moment coefficients rise from `0.02537/0.01357` to
  `0.02686/0.01397`. Both keyframe sets show the same productive cruise and
  late upward hook, so another terminal curvature or slip gate is not supported.
  The weakest relative sample releases half-cycle steering with yaw response;
  it retains the same wake but captures at `19.404T`, showing that removing
  route authority during the handoff is counterproductive.

## Policy hypothesis

Use the strongest sampled response-aware handoff and its normalized joint-rate
proximity guard. Decompose each joint acceleration into a traveling-wave
carrier and a bounded target-steering residual before the final soft limit.
Apply the existing outward-motion guard only to the carrier, while leaving the
steering residual available. This is a structural actuator-allocation test, not
a scalar gain change: it should preserve the guard's early milestones and rate
headroom while recovering some of the unguarded parent's shorter path. Reject
it if capture or any early milestone falls outside the unguarded response-aware
envelope, if path does not improve on `12.421L`, if posterior rate residence
returns toward `4.36%`, or if peaks exceed the sampled `0.02686/0.01397` load
boundary without a compensating semantic improvement.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a directed anterior-to-posterior traveling bend while layering bounded closed-loop route modulation over the rhythmic carrier
transferable_invariant: regulate the propulsion carrier as a coherent interjoint wave, while keeping target-derived steering distinguishable from carrier authority
nontransferable_details: published gains, dimensional frequencies, species envelopes, full-body splines, exact vortex phases, and source-task routes
policy_translation: split the two joint accelerations into carrier and steering terms; gate only outward carrier work using joint rate normalized by the owned hard-envelope scale, while steering remains driven by normalized body-frame target geometry and measured yaw response
falsification: reject if early progress, capture, joint-rate headroom, path length, load class, angle margin, or either coherent wake view regresses beyond the sampled boundaries
