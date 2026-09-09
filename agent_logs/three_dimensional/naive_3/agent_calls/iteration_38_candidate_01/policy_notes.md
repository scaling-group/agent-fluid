# Course-response posterior-rhythm recovery candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected the top-down mid-plane-vorticity and oblique body/Lambda2 rows
  of every combined keyframe sheet, including the strongest finite-score
  sample (`solver_fbea116ed491`) and the informative static-equilibrium sample
  (`solver_a6820a0af3d7`). Every fish visibly self-propels and leaves a
  coherent curved planar wake with compact three-dimensional structures. The
  miss is a controlled powered orbit, not passive advection, wake collapse,
  collision, boundary exit, or instability.
- The assigned parent (`solver_a424c9172b03`) adds terminal-local,
  phase-balanced posterior energy about the moving lag target. It reaches only
  `2.320/3.868/3.443L` minimum/mean/final distance. At its minimum the vehicle
  still translates near `0.679U`, while anterior/posterior joint velocities
  are only `0.00172/0.00199 rad/T` and commands are about
  `0.0186/-0.00140 rad/T^2`. Its sheet shows the same coherent broad return
  around a nearly rigid common negative C-bend as the sampled posterior-phase,
  equilibrium-unbend, and fixed-sign-restart failures.
- An inherited sibling independently applies posterior velocity-odd energy
  about the tail mean. Its completed rollout reaches
  `2.173/3.868/3.547L`; at the minimum the joint velocities are still only
  `0.00096/0.00265 rad/T`. Thus changing the posterior reference and local
  acceleration scale does not recover the traveling wave. Together with the
  assigned parent, this closes terminal-local posterior phase-plane energy as
  a sufficient mechanism.
- Reconstructing the assigned parent's controller at its `2.320L` minimum
  explains the ineffective action without appealing to score alone. The
  posterior activity detector is fully on (`0.99995`), the target is behind,
  and target-ray/course dot is `-0.131`, but the narrow terminal response
  weight is only `0.0243`; consequently the nominal `4 rad/T^2` posterior
  reserve contributes only about `0.002 rad/T^2`. The controller correctly
  sees low rhythm but withholds useful authority because the coupled orbit no
  longer enters the `1.8L` terminal shell.
- Inherited evidence still identifies the `1.175L` symmetric anterior
  phase-balanced carrier as the strongest scaffold: it remains active inside
  `2L` and holds inside `1.25L` for about `2.35T`. Posterior attenuation,
  lag residuals, static offsets, one-sided duty, fixed-sign restarts, paired
  counterphase bursts, and both terminal-local posterior-energy variants fail.
  The next test should preserve the anterior law, mean bends, lag target, and
  command reserve while changing when the posterior receives its distinct
  energetic role.

## Policy hypothesis

Preserve the assigned parent's controller except for the selector on the
posterior phase-balanced term. Replace the narrow terminal-distance/course
gate with the already normalized target-behind, finite-speed, nonclosing-course
response gate. Retain the posterior phase-plane deficiency detector, moving
lag target, two-sided velocity-odd action, and bounded acceleration. The term
therefore remains negligible during a healthy active first pass, but it can
destabilize the evidenced quiet posterior bend throughout a poor-course return
instead of waiting for an orbit that has already failed to enter `1.8L`.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a materially tighter return while preserving the coherent wake,
active joints, first approach, and comparable clamp/load margins. Reject the
mechanism if the broadened response selector changes an active first pass,
adds tangential thrust without joint activity recovery, parks or saturates
either joint, broadens the orbit, or fails to improve closest approach,
near-target residence, mean distance, and final distance over the phase-balanced
scaffold.

```text
bookshelf_consulted: true
source_domain: classical elongated-body traveling-wave propulsion and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: keep the anterior steering oscillator and lagged posterior thrust joint rhythmic, while measured route response selects when deficient posterior motion receives bounded energy
transferable_invariant: a traveling bend needs active posterior motion; when the measured target-relative course remains nonclosing, deficient posterior rhythm should be restored without shifting mean curvature or prescribing phase
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body joint counts, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target/course geometry and speed form the existing target-behind nonclosing-response weight; measured posterior angle and velocity retain the phase-plane deficiency test, and only bounded velocity-odd joint-2 acceleration is reauthorized while mean bends, lag, and anterior energy remain unchanged
falsification: reject if cruise or the active first pass changes, either joint parks or saturates, posterior rhythm does not recover, wake/load margins worsen, or closest approach, near-target residence, mean distance, and final distance fail to improve over the 1.175L scaffold
```

## Evaluation boundary

The candidate's coupled CFD result becomes evidence only after this worker
exits. Deterministic replay and direct controller probes can establish the
selector's locality, boundedness, reflection equivariance, parameter
ownership, and nonzero response at completed parked states; they cannot
establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The single candidate preserves every assigned-parent parameter, curvature,
moving equilibrium, anterior oscillator and phase-balanced energy term,
posterior lag target, brake, wave envelope, and `+/-28 rad/T^2` command
reserve. Its sole executable change replaces `terminal_response_weight` with
`base_response_weight` in the posterior energy selector. The latter already
combines normalized body-frame target-behind geometry, distance, speed, and
nonclosing target-ray/course response; the posterior phase-plane detector and
two-sided velocity-odd action are unchanged. No elapsed time, step count,
hidden or mutable state, world coordinate, target identity, route, randomness,
or file access is introduced.

Exact replay over all `18182` assigned-parent states leaves anterior action
bit-for-bit identical. While normalized target forward projection exceeds
`0.1` (target still ahead), the posterior action change is only
`3.48e-8/1.24e-5 rad/T^2` mean/maximum. Once the target is behind, the
selector can materially change the failed return; at the parent's `2.320L`
minimum it changes replayed posterior action from about `-0.000075` to
`+0.0368 rad/T^2`, supplying negative damping along the measured positive
posterior half-cycle. Maximum posterior change on the completed trace is
`2.05 rad/T^2`, while frozen posterior clamp residence remains exactly
`0.0983` and every action stays within the declared reserve. Full-trace
lateral reflection negates both actions with zero observed residual.

After repairing a duplicated assigned-parent marker in the rendered workspace
README, the mandated material-guidance/notes check, lightweight Julia policy
contract and parameter-schema guard, and solver editable-boundary check all
pass. No formal CFD was run.
