# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts are valid direct-uniform still-water evaluations
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their top-down
  rows show body-connected alternating vortex streets, and their oblique rows
  show coherent three-dimensional Lambda2 structures through cruise. The
  motion is self-propelled and numerically stable; the repeated boundary exits
  are navigation failures rather than missing thrust or passive advection.
- The sampled near-miss mechanisms preserve useful translation but do not
  correct the high approach. The target-plane hold reaches `2.703L` at
  `17.434T`, with its head still at `(9.086,12.202)L`, then pins both joints
  beyond `40 deg` for `5.349T` and curls toward the upper boundary. The
  mean-bend release reaches `2.664L` at `18.004T` with the head at
  `(8.496,12.116)L`; it eliminates simultaneous two-joint pinning but leaves
  the posterior joint beyond `40 deg` for `6.352T` and produces the same sharp
  post-pass return arc.
- Posterior-bend burst release improves joint reserve without improving the
  trajectory. It reduces posterior `>40 deg` dwell to `0.929T` and
  simultaneous dwell to `0.016T`, but regresses closest approach to `3.312L`
  and raises peak planar force/moment to `0.890/0.414`, compared with
  `0.488/0.220` for the mean-bend release. This falsifies another release-gate
  edit as the next step: actuator relief alone does not fix course direction.
- The assigned parent's phase-separated target angle is also a concrete
  negative result. It exits high earlier at `20.034T`, reaches only `4.650L`,
  holds the posterior joint beyond `40 deg` for `5.081T`, and has
  `0.620/0.261` peak planar force/moment. A joint-rate predictor can remove
  beat yaw from measured yaw rate, but integrating the same coefficients into
  an instantaneous target-angle correction does not preserve geometric
  approach quality.
- The common missing signal is visible in the trajectory. Around `14T`, the
  target-bearing signal ranges from `-0.21` to `+0.02 rad` in three sampled
  candidates while their measured velocity points `+0.74` to `+1.04 rad`
  across the body-forward axis; the corresponding target-versus-course
  residual remains a correct-side `-1.10` to `-1.21 rad`. Unlike raw bearing
  or a joint-angle yaw estimate, the signed angle between target vector and
  velocity is invariant to instantaneous body yaw because both vectors rotate
  through the same body frame.

## Single candidate hypothesis

Preserve the evidenced state-feedback traveling bend, posterior lag, and
bounded shared-joint half-cycle steering, but remove the failed approach
carrier relief and joint-angle target correction. Compute a signed course
residual from normalized `target_body_L` and `velocity_body_U`; blend from raw
full-circle pursuit only at low translational speed, where course is undefined.
Use the residual both as the turn request and as the gate from cruise to the
stronger half-cycle asymmetry. This is one response-feedback mechanism: it
asks whether the actual translation is aimed at the target, while the carrier
remains fully available for propulsion.

The candidate is falsified if it loses the coherent alternating cruise wake,
fails to retain at least the sampled `2.664L` approach, repeats an upper exit
without a visibly lower target-directed course, or worsens joint-rate/action
occupancy and the `0.488/0.220` load reference. Beating the inherited `2.319L`
near miss, capture, or a better termination class is stronger support. A score
change without improved geometry and load quality is not support.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual CPG path following
source_mechanism: preserve a rhythmic propulsive carrier while measured motion-to-goal error modulates a bounded steering channel
transferable_invariant: directional feedback should act on the mismatch between actual translational course and target line while leaving the propulsive rhythm available
nontransferable_details: published gains, robot linkage geometry, oscillator timing, species kinematics, dimensional speeds, exact vortex phases, and task-specific routes
policy_translation: form a reflection-equivariant signed course residual from normalized body-frame target and velocity vectors, blend to pursuit only when speed is too small to define course, and use it for bounded shared-joint half-cycle steering without carrier relief
falsification: reject if closest approach exceeds 2.664L, the high upper-exit topology persists, cruise wake or translation degrades, or joint limits, action saturation, force, or moment worsen

## Dry validation only

The prescribed guidance-materiality, lightweight Julia contract, parameter
schema, and editable-boundary checks pass; no CFD was run. A `32,400`-state
grid over joint angles/rates, fore/aft and lateral target geometry, and
translational velocity produced finite commands within the smooth
`30 rad/T^2` envelope and exact left/right reflection (maximum error `0.0`).
The grid exposed and then verified the singular antiparallel case: when course
and target are exactly opposed, their cross product cannot select a side, so
the controller uses the reflection-equivariant body-relative pursuit side only
at that singularity. These checks establish contract safety, boundedness, and
signal symmetry only; the later CFD evaluation must decide every physical
falsifier above.
