# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned alignment-gated parent, all four sampled solver results, and
  the inherited step-9 rollouts use direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Their
  translation is self-propulsion rather than advection or initialization
  contamination.
- I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows for the assigned parent (`2.443L` minimum), the sampled posterior
  counter-bend (`2.187L`), the inherited target-ray course residual
  (`2.011L`), and the inherited persistent geometry counter-bend (`2.477L`).
  Every rollout retains an alternating planar street and compact 3D wake
  structures through approach, then passes below the target and remains
  powered to a lower-boundary exit. This is not wake collapse or numerical
  instability; the persistent defect is terminal reorientation while the
  carrier continues to inject cross-track momentum.
- The completed step-9 evidence sharpens the limit of posterior equilibrium
  steering. Adding a terminal target-ray velocity residual improved minimum
  distance from the counter-bend's `2.187L` to `2.011L`, but worsened score
  from `-10.238` to `-10.639`, final distance from `9.281L` to `9.836L`, and
  still exited low. Replacing its velocity gate with persistent target
  geometry regressed to `2.477L` and the same exit. Thus the counter-bend sign
  can move the near pass, but stacking or persisting more posterior equilibrium
  bias has not supplied the missing redirect.
- On the parent trace, target direction is only `0.095/0.119 rad` off the body
  axis at the inbound `8L/6L` crossings and closure is about `0.74/0.76 L/T`.
  At `3L`, `2.5L`, and the `2.443L` minimum, full direction error grows to
  `0.704/1.042/1.421 rad` while closure falls to about
  `0.59/0.32/0.01 L/T`; speed at the minimum remains `0.685U`, dominated by
  target-ray cross velocity. Scalar distance relief, return-half-cycle
  braking, stronger additive curvature, posterior asymmetry, and slip-gated
  phase rotation already failed to change this lower-exit topology.

## Policy hypothesis

Preserve the evidenced alignment-gated carrier in the far and middle approach.
Add one actuator-mode mechanism: a continuous terminal C-bend redirect. Only
when normalized body-frame full direction error is large, distance is near,
and measured closure has collapsed, smoothly replace the traveling-wave
accelerations with damped tracking of a bounded same-sign two-joint bend. The
joint-bias sign follows the target side and the mode releases continuously as
target geometry realigns, without a clock, stage counter, world coordinate, or
memorized route.

Replaying the proposed observation gate on the completed parent trace, without
claiming a new hydrodynamic result, gives weights below `0.001` at `8L`, `6L`,
and `4L`, then about `0.46/0.93/0.95` at `3L`, `2.5L`, and closest approach.
This preserves the established cruise route while changing the actuator
topology exactly where the target is lateral and closure is lost. Expected
evidence is an intact far-field wake followed by a decisive target-side yaw,
capture or at least a different terminal trajectory, and no increase in the
existing acceleration envelope. Falsify on altered release, early propulsion
loss, a short-wake curl, limit trapping, failure to beat `2.011L`, or another
powered lower exit.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish direction tracking
source_mechanism: a large observed direction error invokes bounded whole-body curvature, then measured geometric response releases back to the propulsive rhythm
transferable_invariant: separate a transient redirect actuation mode from the cruise traveling wave and gate it only by normalized target geometry and measured closure
nontransferable_details: species-specific C-start shapes, published gains, dimensional frequencies, burst durations, exact vortex phases, robot geometry, and task-specific routes
policy_translation: blend the inherited two-joint state-feedback carrier into a target-signed damped same-sign joint equilibrium when distance_L, full target_body_L direction, and closing_speed_L jointly indicate a terminal stalled approach
falsification: reject on changed far-field motion, wake collapse or tight curl, actuator trapping, no improvement beyond 2.011L, or persistence of the powered lower exit
```

## Implemented candidate and pre-CFD checks

The candidate retains the parent carrier unchanged whenever the redirect gate
is zero and adds only the continuous terminal C-bend mode described above. All
`23` active fields referenced by the policy are returned by
`target_policy_params`; the joint acceleration clamp remains `28 rad/T^2`.

The guidance semantic check, lightweight Julia contract, solver edit-boundary
check, exact reflection probe, extreme finite-input command-bound probe, and
all `324` repository non-CFD assertions pass. The duplicate, identical parent
marker in the rendered workspace `README.md` was removed so the mandated
guidance checker can identify its single assigned parent. Formal CFD remains
deferred to the downstream evaluator.
