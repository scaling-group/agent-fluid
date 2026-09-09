# Terminal response-gated anterior C-turn candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts and the latest inherited rollout satisfy the
  frozen Phase 2 contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and
  `horizon` termination at `100T`. I inspected the combined top-down
  mid-plane-vorticity and oblique body/Lambda2 sheets for the assigned parent
  (`2.439L` minimum), the strongest sampled minimum (`2.215L`), and the latest
  inherited posterior-energy result (`2.173L`). Each fish visibly
  self-propels, maintains a coherent curved planar wake with compact 3D
  structures, and executes a broad return loop. Passive advection, wake
  collapse, collision, domain exit, and numerical instability do not explain
  the miss.
- The sampled cluster is a controlled but parked terminal topology. The
  assigned parent's posterior turn-response phase reaches
  `2.439/3.861/3.310L` minimum/mean/final distance; the joint-state release,
  fixed restart, and posterior-energy sample reach respectively
  `2.215/3.859/3.416L`, `2.369/3.869/3.455L`, and
  `2.320/3.868/3.443L`. At their representative minima, speed remains about
  `0.68U`, but the joints share a negative C-bend and have velocities of only
  roughly `0.00004--0.0027 rad/T`. Thus these are powered tangential loops
  around a nearly static control equilibrium, not low-speed terminal holds.
- The assigned parent's posterior phase correction is additionally
  phase-dependent: at its `2.439L` minimum the joint velocities are only
  `-0.00053/+0.00179 rad/T`, so its lag residual is almost absent exactly at
  the parked state. The latest inherited two-sided posterior energy law
  closes the complementary tail anti-parking hypothesis. It improves the
  minimum only to `2.173L`, worsens final distance to `3.547L`, and at that
  minimum still has only `+0.00096/+0.00265 rad/T` joint velocity with small
  actions (`0.0418/0.0247 rad/T^2`). Its body-frame velocity is approximately
  `(-0.449,+0.512)U`; course remains nearly tangential to the target ray while
  measured heading rate is only `-0.258 rad/T`.
- Inherited logs identify the completed symmetric anterior phase-balanced
  carrier as the surviving scaffold: it reached `1.175L`, stayed within
  `1.25L` for about `2.35T`, and retained mean anterior/posterior speed near
  `0.775/0.360 rad/T` inside `2L`. Static equilibrium changes, a fixed-sign
  restart, one-half-cycle pulses or duty bias, stronger scalar anterior
  energy, posterior thrust attenuation, posterior phase response, paired
  counterphase bursts, and now posterior phase-plane energy all fail their
  stated boundaries. The common limitation of the recent phase/energy
  additions is that their incremental action vanishes with measured joint
  velocity even though the body still has a large unresolved turn-rate
  deficit.

## Policy hypothesis

Restore the completed `1.175L` phase-balanced carrier, including its bearing
curvature, target-behind C-turn, continuous course hold, moving joint
equilibria, symmetric two-sided anterior energy law, posterior lag, wave
authority, brake, and command reserve. Remove the completed harmful posterior
phase and posterior-energy additions. Add one distinct response mechanism:
inside the existing target-behind terminal gate, compute the instantaneous
target-ray angular rate from normalized body-frame target and velocity, add a
bounded course-closing component, and compare that desired turn rate with
measured heading rate. Apply the bounded signed deficit directly to anterior
joint acceleration. Unlike the failed velocity-odd restarts, this feedback is
nonzero at a parked bend; unlike a static curvature shift, it releases when
the observed body response satisfies the terminal turn demand.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a materially tighter final return while preserving the coherent
first approach, active traveling wave, and clamp/load margins. Reject the
mechanism if it changes the first return, reinforces a static C-bend, creates
persistent command saturation or wake broadening, gives the wrong yaw sign,
or fails to improve closest approach, near-target residence, mean distance,
and final distance over the phase-balanced scaffold.

```text
bookshelf_consulted: true
source_domain: biological C-start turning and sensor-modulated closed-loop robotic-fish rhythm control
source_mechanism: a strong curvature response is triggered by large observed directional error and released when measured heading response appears, while the propulsive rhythm remains the carrier
transferable_invariant: terminal turning authority should depend on the mismatch between demanded and measured body response and should remain available when joint phase-plane velocity is near zero
nontransferable_details: published gains, dimensional maneuver duration, species-specific C-start kinematics, clocked CPG phase, body-joint count, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target ray and translational course define a bounded desired yaw rate; measured heading rate closes the response loop; the existing body-frame terminal selector gates one bounded anterior acceleration residual without changing the moving equilibria or posterior traveling-wave target
falsification: reject if cruise or the first return changes, the yaw response has the wrong sign, either joint parks or saturates, wake coherence/load margins worsen, or closest approach, near-target residence, mean distance, and final distance do not improve over the 1.175L phase-balanced scaffold
```

## Evaluation boundary

The new coupled CFD outcome becomes evidence only after this worker exits.
Deterministic policy probes may establish schema ownership, finite bounds,
reflection equivariance, terminal locality, and nonzero action at a parked
state; they cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate restores the completed phase-balanced carrier and removes the
assigned parent's terminal posterior-lag residual. Its sole new controller
role is the bounded anterior turn-response acceleration described above; four
owned parameters define the desired terminal yaw response and its reserve.
No equilibrium, posterior target, oscillator, wave authority, brake, command
limit, morphology, environment, or scoring code changes. The policy uses no
elapsed time, step count, hidden or mutable state, world coordinates, target
identity, route, randomness, or file access.

Frozen evaluation over every state in the assigned-parent, strongest sampled,
and latest inherited traces keeps the new term terminal-local: beyond `3L`
its mean absolute contribution is `0.00032--0.00041 rad/T^2` and its maximum
is below `0.00232 rad/T^2`. At their parked minima it requests the same
evidence-consistent negative turn sign, with contributions of approximately
`-0.021`, `-0.066`, and `-0.082 rad/T^2`; the small values are expected because
none of those completed failures enters the `1.8L` terminal gate. A synthetic
reflection-paired state using the inherited `1.175L` distance, `0.683U` speed,
`1.682 rad` course error, `-0.061 rad/T` heading rate, and zero joint velocity
produces a nonzero `-1.05 rad/T^2` response with exactly zero reflection
residual. Across all three full traces, candidate actions remain finite and
within the declared `+/-28 rad/T^2` reserve, and lateral reflection negates
both outputs with zero observed residual. All `52` direct parameter references
name the `52` fields returned by `target_policy_params()`.

The mandated material-guidance, lightweight Julia contract, and solver
editable-boundary checks pass. These dry probes establish implementation
semantics and bounds only; no formal CFD was run.
