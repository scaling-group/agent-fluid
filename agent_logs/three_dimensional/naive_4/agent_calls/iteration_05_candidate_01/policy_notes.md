# Exact-course wave-relief candidate notes

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the Phase 2 flow contract: direct
  uniform initialization in still water at `U_infinity=(0,0,0)`, without
  cylinders or a prewarm snapshot. Their motion is self-propelled. Both rows
  of every combined sheet show a caudal wake growing from rest: alternating
  red/blue mid-plane vorticity above and coherent three-dimensional Lambda2
  structures below. None captures the target, and every trajectory eventually
  turns toward positive world y and leaves through the upper virtual boundary.
- The strongest finite sample is `solver_324d10ed189d`. Its one-sided
  posterior wave-relief policy preserves the long alternating 3D wake through
  `18.975T`, reaches `5.144L` at `15.312T`, and reduces posterior acceleration
  clamp residence to about `35.9%`. This is a material improvement over its
  otherwise matching fixed-course-mixture parent `solver_ab59732b5ad0`, which
  reaches only `6.218L`, exits at `16.879T`, and clamps the posterior request in
  about `60.8%` of samples. The inherited log's prediction that one-sided
  relief would preserve the useful carrier while freeing authority therefore
  survives the sampled CFD evidence.
- The improvement is incomplete. The strong sample reaches its closest point
  near world y=`13.515L`, then loses `1.153L` of distance and exits at
  y=`15.203L`; its top-down path and oblique wake both show the late upward
  sweep. At `10T`, reconstructed body-frame bearing is about `+0.118 rad`
  while lateral course angle is `+0.509 rad`, so the fixed `0.55` course weight
  still under-represents the impending course overshoot before the later
  correction saturates.
- The assigned exact-course prefill `solver_270f6c358fd0` and the related
  speed-reliable exact-course sample `solver_87b1054daf2c` do not establish an
  adequate actuator translation by themselves. They retain coherent wakes but
  exit at `14.058T` and `13.178T`, reach only `7.558L` and `8.515L`, and clamp
  posterior acceleration about `56.1%` and `55.8%` of the time. Their course
  observation is therefore retained as a hypothesis, while their unrelieved
  posterior carrier is the evidenced limitation addressed here.

## Policy hypothesis

Keep the prefilled speed-gated exact body-frame velocity-to-target steering,
unchanged anterior Van der Pol carrier, posterior lag, curvature ceiling, and
physical acceleration envelope. Add the sampled one-sided state-phase
mechanism only: when the posterior wave points against the requested turn,
smoothly attenuate that wave component before adding mean curvature; never
amplify the aiding half-cycle. This separates propulsive oscillation from
steering headroom without adding a world route, external clock, or larger
actuator limit.

Expected downstream evidence is preservation of the coherent alternating wake,
posterior clamp residence below the prefill's `56.1%`, and either a closest
approach below `5.144L` or a better termination class. Falsify the transfer if
the exact-course loop still produces the same early upper exit, if wake or
forward progress collapses, or if the posterior clamp fraction remains near
the unrelieved exact-course samples.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop direction tracking
source_mechanism: target-directed half-cycle modulation superposed on a traveling-bend carrier
transferable_invariant: preserve the propulsive rhythm while reducing only the oscillatory component that opposes a bounded directional request
nontransferable_details: published gains and duty ratios, clocked CPG phase, species-specific kinematics, dimensional speed thresholds, exact vortex phases, and task-specific routes
policy_translation: derive a bounded turn request from normalized body-frame target and velocity observations, infer the posterior wave side from two-joint state, and smoothly relieve only the counter-turn wave component within the existing limits
falsification: reject if coherent wake or target progress weakens, posterior clamp residence does not fall below the unrelieved exact-course policies, or closest approach and upper-exit topology fail to improve

The new candidate has no same-worker CFD result; these are falsifiable
expectations for the downstream evaluation.

## Non-CFD verification

- The guidance-provenance check, lightweight policy contract, deterministic
  parameter-schema audit, and editable-boundary check pass. No CFD was run.
- Mock states return finite bounded accelerations and simultaneous reflection
  of lateral target/velocity, bearing, joint angles, and joint rates reverses
  both commands to numerical tolerance.
- As a counterfactual signal audit only, applying the new formula to the
  recorded prefill states reduces posterior over-envelope requests from about
  `56.2%` to `51.1%`, with mean wave relief `0.284` and minimum wave scale
  `0.35`. This does not predict closed-loop behavior because the new policy
  will generate different states.
