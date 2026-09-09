# Candidate diagnosis and hypothesis

## Assigned evidence

- The sampled rollout satisfies the experiment contract: direct uniform
  initialization, `U_infinity=(0,0,0)`, no cylinders, and no prewarm. It is
  therefore self-propelled rather than advected.
- The top-down row shows a coherent alternating wake and sustained translation,
  so the joint-state traveling-wave carrier is useful. The oblique Lambda2 row
  likewise shows compact alternating structures persisting through the turn;
  there is no visible wake collapse or numerical instability before exit.
- The best finite segment reaches `6.138L` at `t=16.505T`, versus `12.328L`
  initially. At that point the reconstructed normalized body-frame target has
  bearing `+1.070 rad`, while heading has increased from `0.506` to `0.747 rad`.
  The informative failure segment then continues the same wrong-side rotation:
  heading reaches `1.383 rad`, the target is behind and on the positive body
  side, distance regresses to `10.460L`, and the fish exits the lower virtual
  boundary at `t=26.147T`. The local flow remains small near closest approach
  (`(-0.0218,0.0012)U`), so crossflow does not explain the route loss.
- This is a semantic sign/architecture mismatch in the imported 2D steering
  stack: the target stays on the positive body side while positive heading and
  yaw rate accumulate away from it. Scalar cadence tuning would preserve that
  failure topology.

## Policy hypothesis

Preserve the evidenced state-feedback oscillator and posterior phase lag, but
replace the imported multi-branch steering law with one reflection-equivariant
mean-curvature rate loop. Compute line-of-sight error only from normalized
`target_body_L`; request a bounded heading rate of the sign that reduces that
error; compare it with measured `turn_rate_recent`; and translate the rate
error into a bounded posterior mean curvature. For the observed convention, a
positive body-side target requires negative heading rate and negative mean
curvature. This should keep the coherent carrier while arresting the early
wrong-side rotation and making the initially favorable trajectory converge
rather than cross below the target.

Falsification: reject the mechanism if a positive initial body-frame bearing
still produces increasing heading, if minimum distance does not improve beyond
`6.138L`, or if the posterior bias destroys the alternating wake, causes
persistent joint-limit operation, or replaces `left_domain` with instability.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and mean-curvature turning
source_mechanism: bounded target-dependent mean bend superposed on a propulsive joint-state rhythm
transferable_invariant: use persistent body-frame target error and observed yaw response to set a bounded average curvature while preserving the traveling bend
nontransferable_details: published CPG gains, dimensional beat rates, species kinematics, exact vortex phase, and task-specific routes
policy_translation: normalized target-body line of sight sets desired yaw rate; recent yaw-rate error sets only the posterior mean-curvature offset in the two-joint state-feedback carrier
falsification: wrong-sign initial yaw, no improvement over the 6.138L closest approach, lost wake coherence, persistent saturation, or instability rejects the transfer
