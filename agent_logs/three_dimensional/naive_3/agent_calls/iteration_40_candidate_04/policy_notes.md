# Terminal posterior relative-phase tracking candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and
  `horizon` termination at `100T`. I inspected the combined top-down
  mid-plane-vorticity and oblique body/Lambda2 sheets for the strongest sampled
  closest approach (`solver_a6820a0af3d7`, `2.215L`) and the best sampled score
  but weakest closest approach (`solver_fbea116ed491`, `2.439L`). Both visibly
  self-propel through coherent alternating planar wakes with compact 3D
  structures, yet settle into nearly the same broad powered return loop. Wake
  collapse, passive advection, collision, domain exit, and instability do not
  explain the miss.
- The assigned parent (`solver_a424c9172b03`) adds phase-balanced posterior
  energy but reaches only `2.320/3.868/3.443L` minimum/mean/final distance.
  At its minimum, translational speed remains about `0.679U` while anterior and
  posterior velocities are only `0.00172/0.00199 rad/T`; the added posterior
  activity regulator therefore converges to the same common negative C-bend
  rather than restoring the useful terminal trajectory.
- Inherited completed logs identify the two-sided *anterior* phase-balanced
  regulator as the surviving scaffold. It reaches
  `1.175/4.041/3.243L`, remains inside `1.25L` for about `2.35T`, and at its
  minimum retains speed `0.683U`, course error `1.682 rad`, and active joint
  velocity `(-0.394,+0.260) rad/T` with modest action
  `(5.50,0.43) rad/T^2`. Its top-down path is a materially tighter repeated
  return and its oblique wake remains compact. The miss is a tangential active
  wave, not a parked or under-powered vehicle.
- Later inherited results close the stale useful-half-cycle suggestion and
  several apparent substitutes. Requested-side anterior energy parks the wave
  (`1.702L` then `2.362L` variants); a stronger radial activity regulator
  reaches `1.366L`; a paired counterphase burst raises useful yaw but reaches
  only `1.192L`; response-triggered equilibrium release reaches `1.177L` while
  worsening mean distance; direct anterior turn-rate residual reaches
  `2.077L`; helpful-force posterior reinforcement and harmful-force damping
  regress to `2.391L` and `2.294L`. Thus energy amount, static curvature,
  course-yaw response, and instantaneous force sign are not being retuned.
- At the `1.175L` minimum the existing posterior position target is about
  `-0.378 rad` versus measured `-0.410 rad`, but the harmonic derivative of
  that moving target is about `-0.025 rad/T` while the measured posterior is
  releasing at `+0.260 rad/T`. The tracker damps absolute posterior velocity,
  not velocity relative to its moving lag target. This measured phase mismatch
  supplies a distinct, falsifiable two-joint mechanism.

## Policy hypothesis

Restore the exact completed `1.175L` phase-balanced anterior scaffold,
including its body-frame course hold, moving C-turn equilibrium, symmetric
low-activity energy law, posterior target, brake, wave envelope, and command
reserve. Add one small coupled-oscillator mechanism to joint 2: derive the
instantaneous velocity of the existing lagged posterior wave from measured
anterior displacement and velocity, compare it with measured posterior
velocity, and apply a bounded relative-velocity correction only under the
existing target-behind terminal selector. This tracks propagation rather than
adding scalar energy, moving either equilibrium, copying a clock phase, or
using force correlation. It is reflection equivariant and releases when the
measured posterior velocity matches the moving wave.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a tighter final return while preserving the coherent first return,
active joint motion, and comparable command/load residence. Reject if the
relative-phase term parks either joint, enlarges the loop, destroys the
alternating wake, changes the first approach, materially raises clamp/load
residence, or fails to improve closest, residence, mean, and final-distance
evidence over the phase-balanced scaffold.

```text
bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish CPG control and elongated-body posterior reactive propulsion
source_mechanism: preserve a directed anterior-to-posterior traveling bend by damping phase velocity relative to a moving coupled-oscillator target rather than damping the posterior joint toward zero velocity
transferable_invariant: when propulsion and anterior rhythm survive but the terminal course remains tangential, maintain measured inter-joint wave propagation with bounded relative-phase feedback while leaving slow body-frame route selection and mean bend unchanged
nontransferable_details: published gains, dimensional frequencies, robot coupling matrices, species-specific envelopes, full-body joint counts, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized anterior displacement and velocity analytically define the velocity of the existing lagged posterior wave; normalized posterior relative-velocity error drives one bounded joint-2 correction inside the existing target-behind terminal gate
falsification: reject if cruise or the first return changes, either joint parks, phase correction produces yaw without inward course rotation, the orbit or wake broadens, command/load margins worsen, or near-target and final-distance evidence fail to improve over the 1.175L phase-balanced scaffold
```

## Evaluation boundary

The new coupled CFD outcome is unavailable until this worker exits. Static
contract checks and completed-trace replay can establish parameter ownership,
boundedness, terminal locality, reflection symmetry, and correction direction,
but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate restores the completed phase-balanced policy and adds two owned
posterior relative-phase parameters. Its only new action is a bounded joint-2
correction from the difference between measured posterior velocity and the
analytic measured-state derivative of the existing lagged anterior wave. It
changes no route observation, distance/course gate, mean curvature, anterior
oscillator or energy law, posterior position target, brake, wave authority, or
`+/-28 rad/T^2` command reserve.

Exact Julia replay over all `18182` states of the completed `1.175L` scaffold
leaves anterior action bit-for-bit unchanged. The posterior delta is
`0.0644/0.785 rad/T^2` mean/maximum overall, only
`0.000087/0.00172 rad/T^2` beyond `3L`, and
`0.482/0.785 rad/T^2` inside `1.5L`. At the parent's minimum it changes the
posterior action from about `+0.282` to `-0.348 rad/T^2`, opposing the measured
positive posterior release because the moving lag wave requests a slightly
negative velocity there. Frozen clamp fractions remain exactly
`0.2264/0.1030`, all actions are finite, and full-trace lateral reflection
negates both actions with zero numerical residual. These checks establish
locality, reserve, relative-phase direction, and equivariance only; they do not
predict the coupled trajectory.
