# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance and inherited logs establish that the common
  joint-state oscillator is self-propelling in direct-uniform still water and
  that the restrained `7 deg` target-relative mean bend is the useful steering
  baseline. Every current rollout has `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and finite dynamics, so route differences are controller
  evidence rather than passive advection or an initialization artifact.
- Both the top-down vorticity and oblique body/Lambda2 rows were inspected for
  all four sampled solver sheets and the inherited response-redirect sheet.
  They retain coherent alternating wakes and the same long left/down arc; the
  terminal frames show powered motion after the target pass, not wake collapse
  or instability. The alignment-gated parent remains best, reducing distance
  from `12.328L` to `2.443L` before exiting the lower boundary at `31.097T`.
- Distance-only carrier relief reaches only `2.845L`, full-direction posterior
  gating `2.494L`, and anterior return-half-cycle braking `2.501L`; all recede
  and leave the lower boundary. The inherited closing-response-gated `7--12
  deg` curvature variant also preserves the topology and worsens the minimum
  to `2.729L`. Thus proximity scheduling, direction disambiguation, anterior
  braking, and more static equilibrium bend have not supplied the missing
  redirect.
- At the parent's `17.869T` closest approach, full target direction is about
  `1.42 rad`, speed is about `0.685 U`, and the target-ray closing projection
  is still beat-sensitive while anterior acceleration has spent about `75%`
  of samples at the `28 rad/T^2` candidate clamp. Adding more anterior
  equilibrium authority is poorly supported. Posterior acceleration clamps
  only about `35%` of samples, leaving a distinct state-phased steering channel
  to test without raising the command limit.

## Policy hypothesis

Preserve the parent's evidenced `7 deg` mean-curvature carrier, yaw-rate
release, alignment gate, and acceleration reserve. Replace the failed
equilibrium-redirect idea with one posterior half-cycle asymmetry mechanism.
Compute full signed target direction from normalized `target_body_L`; as its
magnitude grows, use the measured lag-wave state to strengthen the posterior
half-cycle bending toward the requested turn and weaken the opposite
half-cycle by the same bounded fraction. This changes tail-beat symmetry rather
than raising static curvature, keeps phase entirely in joint state, and tends
continuously back to the parent when the target is on-axis.

Expected evidence is the parent's coherent far-field wake and left/down
progress followed by earlier correct-sign yaw and a closest approach below
`2.443L`. Falsify the mechanism if it changes the initial route materially,
destroys the alternating wake, increases posterior rate/command-limit
residence, recreates a tight curl, or repeats the powered lower exit without a
better closest approach.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: bias the two tail-beat half-cycles to create turning moment while retaining a propulsive rhythm
transferable_invariant: persistent signed body-frame direction error may continuously bias posterior half-cycle amplitude while measured joint state supplies phase
nontransferable_details: published gains, duty ratios, clocked phase, robot geometry, species kinematics, dimensional beat settings, exact vortex phases, and task-specific routes
policy_translation: full direction from normalized target_body_L gates a bounded reflection-equivariant gain on the measured posterior lag-wave state around the evidenced two-joint carrier
falsification: reject if far-field propulsion or wake coherence changes materially, the turn sign is wrong, closest approach does not beat 2.443L, the lower exit persists, or posterior saturation and loads worsen
```
