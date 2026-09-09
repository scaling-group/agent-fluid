# Posterior phase-balanced wave-propagation candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts and the assigned-parent rollout use direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, finite dynamics, and `horizon` termination at `100T`. I inspected
  both the top-down mid-plane-vorticity and oblique body/Lambda2 rows of every
  sampled combined sheet. Each fish self-propels and leaves a coherent curved
  wake with compact three-dimensional structures through a broad return loop;
  the miss is not passive advection, wake collapse, domain exit, collision, or
  numerical instability.
- The current samples are terminal C-turn descendants. The joint-state bend
  release gives the best sampled minimum (`2.215L`), the rear selector and
  fixed-sign restart reach `2.366L` and `2.369L`, and the assigned parent's
  combination of phase-balanced anterior energy with posterior phase response
  reaches only `2.439L`. At representative minima all four retain speed near
  `0.68U` and course error near `1.70 rad`, but settle near a common negative
  C-bend with very low joint velocity. Their top-down and oblique rows agree
  with the metrics: a powered, coherent, oversized orbit replaces capture.
- The inherited `1.175L` phase-balanced anterior-energy rollout remains the
  useful scaffold. It stayed inside `1.25L` for about `2.35T`, kept mean
  anterior/posterior joint speed near `0.775/0.360 rad/T` inside `2L`, and at
  its minimum retained a moving counterphase transition rather than parking.
  The assigned-parent posterior phase addition was intended to preserve that
  activity, yet its completed rollout reaches no state inside `2L`; at its
  `2.439L` minimum the joint velocities are about
  `-0.00053/+0.00179 rad/T`. This falsifies the assumption that unsatisfied
  yaw response can be added through posterior lag without disrupting the
  phase-balanced carrier.
- The sampled and inherited traces also delimit simpler repairs. Posterior
  wave attenuation lowers near-target speed by only about `0.02U`, stronger
  anterior radial energy reaches only `1.366L`, a requested-half-cycle duty
  change falls into a `2.362L` parked loop, and a coordinated counterphase
  burst reaches `1.192L` without improving the `1.175L` minimum. More scalar
  drive, curvature, lag, threshold, or half-cycle tuning is therefore not the
  proposed mechanism.

## Policy hypothesis

Start exactly from the completed `1.175L` phase-balanced controller. Preserve
its body-frame bearing curvature, target-behind C-turn, continuous course hold,
both moving equilibria, symmetric anterior energy law, posterior lag and wave
authority, brake, wave envelope, and command limit. Add one distinct actuator
role: measure posterior phase-plane activity about the already commanded tail
mean and add bounded velocity-odd energy to joint 2 on both half-cycles only
under the existing target-behind terminal selector. This leaves posterior
phase, equilibrium, and nominal wave target unchanged, but makes a quiet tail
wave locally unstable while the anterior regulator remains responsible for
the carrier. The mechanism should release continuously as posterior activity
returns.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a materially tighter final return while preserving the coherent
first approach, active joints, and comparable clamp/load margins. Reject it if
the extra tail energy merely adds tangential thrust, changes the first return,
parks or saturates either joint, broadens the orbit/wake, or fails to improve
closest approach, residence, mean distance, and final distance over the
relevant parents.

```text
bookshelf_consulted: true
source_domain: classical elongated-body reactive propulsion and closed-loop robotic-fish traveling-wave control
source_mechanism: maintain an anterior-to-posterior traveling bend with a distinct posterior energetic role instead of steering by suppressing or phase-shifting the tail wave
transferable_invariant: preserve the measured moving equilibrium and nominal lag while bounded two-sided feedback restores deficient posterior phase-plane activity
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, full-body joint counts, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target/course geometry supplies the existing terminal gate; posterior angle relative to its commanded mean and posterior velocity measure activity; only a bounded velocity-odd joint-2 acceleration is added while all established steering geometry and lag remain unchanged
falsification: reject if the first return or coherent wake changes, either joint parks or saturates, posterior activity does not recover, or closest approach, near-target residence, mean distance, and final distance fail to improve over the phase-balanced scaffold
```

## Evaluation boundary

The new coupled CFD outcome becomes evidence only after this worker exits.
Deterministic controller probes can establish parameter ownership, boundedness,
reflection equivariance, locality, and a nonzero two-sided posterior action;
they cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed `1.175L` controller and adds four
owned posterior-energy parameters plus one joint-2 velocity-odd term. The
posterior energy uses angle relative to the existing tail mean and velocity
normalized by the existing posterior wave envelope. It changes no steering
curvature, equilibrium, lag, wave authority, brake, anterior energy, or command
limit, and it uses no elapsed time, step count, hidden state, world coordinate,
target identity, route, randomness, or file access.

Exact Julia replay over all `18182` states of the completed `1.175L` trace
leaves anterior action bit-for-bit identical. The posterior action changes by
only `2.43e-5/0.00132 rad/T^2` mean/maximum beyond `3L`, but by
`0.338/0.661 rad/T^2` inside `1.5L`; at the inherited minimum it adds
`+0.616 rad/T^2`, giving candidate action `(5.853,0.898) rad/T^2`.
Frozen anterior/posterior clamp fractions remain exactly
`0.2264/0.1030`. All actions are finite and bounded, full-trace lateral
reflection negates both actions with zero residual, and all `52` direct
parameter references name the `52` fields returned by
`target_policy_params()`. The mandated guidance, lightweight Julia contract,
and solver-boundary checks pass. No formal CFD was run.
