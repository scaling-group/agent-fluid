# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the inherited completed evaluations report
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. I inspected the combined sheets for the assigned
  parent's anterior duty-asymmetry policy, the strongest sampled
  response-selected posterior brake, the response-released S-bend failure,
  the inherited differential-course failure, and the inherited target-behind
  hold. In both top-down vorticity and oblique body/Lambda2 rows, each fish
  self-propels along the same diagonal inbound path, sheds a sustained
  alternating planar wake with compact three-dimensional vortices, passes
  below the target, and remains powered on a near-vertical lower-boundary exit.
  There is no passive advection, collision, wake collapse, or numerical
  instability; post-miss recovery remains the missing capability.
- The assigned parent's course-selected anterior duty asymmetry fails its own
  test. It reaches `2.433L`, versus `2.385L` for the unmodified
  response-selected brake, and retains the same `left_domain` termination near
  `31T`. At minimum distance it is still moving at `0.691U`; its anterior and
  posterior clamp residence is about `0.747/0.352`, essentially the carrier's
  already high `0.747/0.356`. A persistent course-error selector therefore did
  not become effective merely by changing anterior half-cycle dwell.
- Inherited logs also close off course-triggered differential equilibrium
  bending (`2.469L`) and geometry-persistent posterior counterbending
  (`2.484L`) on the inbound leg. More importantly, the target-behind anterior
  damping hold reached a better `2.293L` minimum but did not create its claimed
  return behavior: mean distance worsened to `6.816L` from the brake's
  `6.772L`, the fish still exited low, and it did so earlier at `29.76T` rather
  than `31.21T`. After overshoot its speed rose from about `0.68U` at `18T` to
  `0.74U` at `24T`, whereas the brake fell to `0.61U`; reducing anterior clamp
  residence from `0.747` to `0.615` was not a translational brake while the
  posterior lagged wave remained active. Thus another anterior damping scalar
  is contradicted by the completed flow response.

## Policy hypothesis

Start from the strongest sampled response-selected posterior brake and keep
its oscillator, bearing/yaw cruise curvature, alignment-gated posterior lag,
wrong-way-yaw half-cycle brake, and command reserve exactly on the inbound
leg. Add one target-behind recovery mechanism. Normalized longitudinal target
geometry and proximity identify an actual overshoot; full signed body-frame
target direction then adds bounded anterior recovery curvature and an
opposite-sign posterior equilibrium to form an S-shaped redirect while the
oscillatory posterior wave is attenuated directly. A static representative
overshoot probe rejected a same-sign posterior recovery because it immediately
clamped the posterior command; the opposite-sign allocation both avoids that
new clamp in the probe and follows the inherited favorable actuator polarity.
Bringing the target ahead continuously releases the
recovery bend and restores the unchanged traveling wave. This translates a
burst redirect into state feedback without a clock, stage variable, world
coordinate, fixed route, or scalar-only gait tuning.

Support requires the preserved inbound path and wake followed by capture, a
new finite termination class, or a visibly returning second approach. It is
falsified by degraded inbound closest approach, a short tight curl, lost wake
coherence, greater actuator/load residence, failure to bring the target ahead,
or the same powered lower exit. Because formal CFD occurs only after this
worker exits, static checks can validate only locality, symmetry, schema,
bounds, and activation semantics.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: a large observed directional error invokes a bounded differential body-curvature redirect while propulsive wave authority is reduced, then geometric recovery releases the bend and restores the traveling wave
transferable_invariant: separate the post-overshoot redirect from cruise using normalized target geometry, allocate bounded curvature across the body without destroying the traveling-wave carrier, and restore propulsion only as target-directed orientation recovers
nontransferable_details: species-specific C-start kinematics, published gains, dimensional frequency, robot geometry, clocked phase, fixed burst duration, exact vortex phase, approach radius, and task-specific route
policy_translation: normalized body-frame longitudinal target fraction and distance gate a full-direction, reflection-equivariant anterior recovery bend, opposite-sign posterior counterbend, and attenuation of only the oscillatory posterior lag; the two-joint state-feedback carrier is unchanged when the target is ahead
falsification: reject if inbound progress changes, a tight curl or higher actuator/load residence appears, wake coherence is lost, the target never returns ahead, or the powered lower-exit topology persists
```

## Evaluation boundary

The candidate receives formal coupled CFD only after this worker exits. The
checks below do not establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate implements only the target-behind differential burst redirect
described above. A representative target-ahead state changes the two brake
commands by less than `1.1e-10 rad/T^2`; placing the same state behind at
`2.53L` changes the commands from `(-6.41, 22.38)` to `(13.32, 18.55)
rad/T^2`, establishing the intended anterior redirect, posterior counterbend,
and avoidance of a new tail clamp. At `8.00L` the command differences fall to
`(0.015, 0.006) rad/T^2`. Mirroring target geometry, joint state, bearing, and
yaw negates both commands with zero floating-point residual. Extreme finite
state probes remain finite and within the `+/-28 rad/T^2` command reserve.
These are controller-semantic checks, not coupled-flow predictions.

The mandated material-guidance check, lightweight Julia policy contract and
parameter-schema guard, and solver editable-boundary audit all pass after
removing one duplicated assigned-parent marker from the rendered workspace
`README.md`. Formal CFD was not run.
