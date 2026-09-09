# Multi-wake target-policy candidate notes

## Evidence-led visual diagnosis

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting vortex streets; it is initial-condition evidence,
  not a policy difference.
- The assigned parent (`solver_9bde72287e13`) and the amplitude-taper and
  half-cycle-timing samples (`solver_43a9991337b7` and
  `solver_e28b1debb291`) all show the same broad redirect/dogleg before entering
  the useful wake region. They reach in `92.99--93.03` released time with mean
  distance about `4.03L`, mean command effort about `972`, and RMS lateral
  force/moment about `95.5/1147`. Their joint-rate and acceleration maxima all
  reach the hard limits. Bearing-rate lead, terminal amplitude taper, and
  anterior half-cycle timing therefore did not create a useful trajectory
  difference on this carrier.
- The strongest sample (`solver_09b5b834b2ae`) instead turns onto a direct
  targetward diagonal during the first keyframes, carries a coherent posterior
  body wake, enters the interacting-wake corridor, and reaches in `43.9505`
  time. Its mean velocity `(-0.2471,-0.1020)` versus mean local flow
  `(-0.1342,-0.1556)` retains a substantial self-propelled upstream component,
  so the shorter route is not passive advection alone. It also lowers total
  command energy from about `9.05e4` to `5.31e4` and RMS force/moment to
  `49.4/701`, despite higher mean command effort and continued rate/acceleration
  clipping.

There is no failed sampled solver at this generation, so the comparison uses
the best finite success against the slowest informative success and inherited
failed-rollout summaries. The inherited logs additionally show that global
carrier reductions and increased static bias can exit the domain in under
`18` time, while several terminal schedules preserve the slow route.

## Policy hypothesis

The only actuator-distribution mechanism unique to the fast sample is
target-favored half-cycle posterior steering. Its always-on posterior share is
reduced from `0.65` to `0.40`, and the removed mean share is restored on one
joint-state-defined half-cycle: at a saturated turn request the cycle-average
tail bias remains approximately `0.40*8 + 0.5*4 = 5.2 deg`, equal to
`0.65*8 deg`. This changes when tail steering is applied without increasing
average curvature or replacing the demonstrated traveling-bend carrier.

The candidate is a clean ablation: retain that phase-gated posterior mechanism
but remove the near-target amplitude taper, since the taper alone left the
`93`-time topology and aggregate diagnostics unchanged. Expected evidence is a
direct early redirect, arrival materially below `93` time, and lateral
force/moment closer to the fast sample than the assigned parent. Reject the
ablation if it loses capture, restores the broad dogleg, produces worse load or
clipping, or shows that the amplitude taper was unexpectedly necessary for the
fast topology.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric CPG turning and elongated-body reactive propulsion
source_mechanism: redistribute a bounded turn request onto the target-favored posterior half-cycle while retaining a lagged traveling bend
transferable_invariant: steering asymmetry can preserve cycle-average curvature and posterior wave thrust when its sign comes from target geometry and its phase comes from observed joint state
nontransferable_details: published gains, dimensional frequencies, species envelopes, exact duty ratios, vortex phase, and source-task routes
policy_translation: map normalized body-frame bearing through tanh, infer the preferred half-cycle from centered anterior bend, and add the bounded residual only to the posterior bias under the two-joint state-feedback contract
falsification: reject if the clean ablation returns to the roughly 93-time dogleg, loses target capture, raises load materially, or fails to change the action and trajectory topology relative to the parent
