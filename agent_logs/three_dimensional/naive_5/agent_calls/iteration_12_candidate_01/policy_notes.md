# Biased terminal traveling-wave recovery candidate

## Visual and trace diagnosis before the edit

- All four sampled solver evaluations and both inherited step-11 evaluations
  are contract-valid direct-uniform still-water rollouts (`U_infinity=(0,0,0)`,
  no cylinders, no prewarm). In every combined sheet, the top-down row shows a
  body-attached alternating vorticity wake and the oblique row shows a
  genuinely three-dimensional Lambda2 trail translating behind the fish.
  Their motion is self-propelled rather than imposed advection or a
  moving-window artifact.
- The `solver_b3b6be8f076f` intercept-qualified redirect and
  `solver_b6ed3f84ab58` posterior redistribution are informative failures:
  both remain in the high corridor and exit the upper margin at minima of
  `4.2785L` and `5.3861L`; the latter touches the `45 deg` joint boundary and
  raises peak planar force/yaw moment to about `0.2124/0.0968`. Their coherent
  wakes do not rescue the wrong trajectory, and the high-load result rules out
  globally adding posterior half-cycle authority.
- The assigned `solver_4f3d51f38935` parent follows the useful broad downward
  route and passes above the target, but the miss-gated deeper C-bend reaches
  only `0.832836L` before `left_domain`. From `2.0L` to its minimum, speed stays
  near `0.65--0.66L/T`; at closest approach its course still projects an
  approximately `0.806L` miss while body/course slip has grown to about
  `0.757 rad`. Both joints have nearly settled at about `(-24.1,-25.0) deg`
  and their commands have decayed to approximately `(0.16,0.01) rad/T^2`.
  Thus added curvature rotated the body but did not maintain the dynamic
  target-side impulse needed to rotate velocity.
- The inherited slip-gated posterior S-bend and bearing-divergence anterior
  reflex preserve the same paired visual wake and pass-by topology. They reach
  `0.846679L` and `0.831781L`, respectively, still terminate `left_domain`, and
  retain terminal speeds around `0.665L/T`. At their minima, projected misses
  remain `0.831L` and `0.809L`. Together with inherited predictive entry
  (`0.926872L`), posterior recovery (`0.895724L`), posterior damping
  (`1.111481L`), and static-depth variants (`0.832836L` and `0.827823L`), this
  rejects another threshold, static-depth, tail-only, damping, or small
  additive terminal-reflex edit.

## Policy hypothesis

Preserve the evidenced far-field traveling carrier, calibrated turn side,
bearing-based redirect entry, yaw/joint-response release, and projected-miss
qualification. When the measured course still misses during a closing
middle/terminal approach, replace the settling static redirect tracker
continuously with a bounded traveling bend around a same-sign mean curvature.
The anterior state-feedback oscillator supplies persistent motion rather than
a scalar-deeper posture, and the posterior target remains a damped lagged
follower so the mechanism produces a directional body wave. Distance,
projected miss, positive closing speed, and existing redirect authority gate
the mechanism; it vanishes at range, on a safe intercept, or after closest
approach.

The falsifiable expectation is the same broad downward route and coherent 3D
wake, followed by course rotation before the target station and a first
crossing inside `0.75L`; beating `0.827823L` with a reduced projected miss is
the weaker threshold. Reject the mechanism if it merely increases body yaw or
joint oscillation, repeats the `0.83--0.85L` pass-by, changes the far route,
touches the angle boundary, approaches the posterior-redistribution load
scale, or materially increases speed/acceleration-limit residence.

bookshelf_consulted: true
source_domain: biological C-start recovery and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a bounded turn bend is released into a directionally biased traveling wave when sensed response shows that a static posture no longer changes the route
transferable_invariant: when mean curvature has settled but the measured intercept is still unsafe, preserve its turn-side bias while restoring state-feedback wave motion and posterior lag to generate continued lateral impulse
nontransferable_details: published gains, dimensional frequencies, full-body C-start sequences, species-specific envelopes, robot linkage geometry, clocked CPG phase, exact vortex phases, world coordinates, and task-specific routes
policy_translation: blend the response-qualified two-joint redirect into a bounded oscillator about body-frame turn-side mean bends, with a lagged posterior target, using only normalized target distance, projected miss, closing speed, joint state, and existing redirect authority
falsification: reject if the rollout does not beat `0.827823L`, does not rotate velocity toward the target before closest approach, repeats the settled near-miss topology, or worsens far-field trajectory, wake coherence, angle clearance, loads, or actuator-limit residence

## Non-CFD implementation audit

Replaying the candidate and assigned parent algebra on all `7234` frozen
`solver_4f3d51f38935` observations changes `1004` commands, confined to the
`0.832836--2.498895L` approach range; there are zero changes at or beyond
`2.5L`. The largest frozen-state L1 acceleration change is
`21.05 rad/T^2`, while acceleration-clamp incidence is unchanged at `2687`
samples for both policies. The candidate is finite on the contract state and
negates both accelerations exactly when lateral target, velocity, yaw, and
joint states are reflected. The prescribed semantic-guidance, Julia contract,
and repository-boundary checks pass. These checks establish material
activation, locality, schema coverage, boundedness, and reflection equivariance
only; they do not predict the unevaluated CFD response.
