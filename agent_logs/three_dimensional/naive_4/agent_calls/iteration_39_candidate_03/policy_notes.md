# Redirect-phase allocation of supplemental posterior recovery

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. There is no failed
  termination in this sample, so the weaker finite captures and the assigned
  parent's regression are the informative negative controls.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the sampled-best translational-response controller
  (`solver_1a8c73736b49`), the weakest-score realized-yaw handoff
  (`solver_5346e761db5a`), and the assigned parent
  (`solver_502dfb1f0223`) from release through termination. Each fish moves
  from a quiescent field, develops a compact release transient into a coherent
  alternating caudal wake by about `4T`, and self-propels along the same smooth
  target-directed arc. The oblique views retain bounded alternating 3D
  structures without advection, wake collapse, collision, boundary exit, or
  out-of-plane instability. The sheets are effectively indistinguishable at
  their sampling resolution, so trajectory, action, and load histories—not
  vortex prominence—separate the mechanisms.
- The sampled-best controller captures at `15.686007T`, has distance integral
  `1.916135L`, crosses at `0.743392L`, and reaches the
  `8/6/4/2/1.25L` milestones at
  `9.063996/10.917495/12.765504/14.569510/15.246011T`. It retains the
  target-opposing translational response inside the existing error-opened
  `2 deg` posterior mean-curvature envelope and is the candidate base.
- The assigned parent keeps that mean bend but uses carrier-demodulated aiding
  yaw to restore the target-opposing posterior-wave lobe from strong redirect
  relief toward cruise relief. It preserves capture and the coherent wake,
  but delays every milestone to
  `9.074996/10.945004/12.793005/14.591510/15.273511T`, captures at
  `15.708008T`, worsens the integral to `1.918172L`, and crosses at
  `0.743744L`. Mean posterior demand and acceleration-limit residence also
  rise slightly from `25.199` to `25.251 rad/T^2` and `22.34%` to `22.51%`.
  Thus realized aiding yaw is not evidence that the target-opposing propulsive
  lobe should be re-strengthened.
- The other handoffs support the same boundary. Releasing supplemental mean
  curvature on aiding yaw (`solver_5346e761db5a`) regresses the integral to
  `1.919504L`; removing translational persistence and releasing moment duty
  (`solver_a3ebfdcbb7c5`) reaches only `15.713508T`. Preserve the sampled-best
  mean steering, response correction, approach law, and terminal damping.
  The inherited optimizer logs also show that independent translation-based
  steering hold and component-matched yaw handoff lengthen the route, while
  the already-bounded low-speed posterior recovery is repeatably useful but
  not because it accelerates startup.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction control, constrained by classical traveling-bend propulsion
source_mechanism: allocate a bounded oscillatory amplitude increment to the turn-aiding half-cycle while retaining the underlying traveling wave
transferable_invariant: preserve the self-propulsive base traveling bend and target-defined mean curvature, but during reliable redirect duty place only supplemental posterior-wave authority on the phase whose normalized bend aligns with the requested turn
nontransferable_details: published gains and duty ratios, dimensional frequency or amplitude, species-specific envelopes, exact vortex phase, clock-defined maneuver stages, world coordinates, and task-specific routes
policy_translation: start from the sampled-best body-frame controller; use the reflection-even product of normalized requested turn and normalized posterior-wave state to keep symmetric low-speed recovery outside redirect duty and smoothly suppress only its extra amplitude on the target-opposing half-cycle, without reducing the base wave or changing steering authority
falsification: reject if an established distance milestone, integral, capture, or final crossing regresses; if the coherent two-view wake is weakened; if force, moment, joint excursion, or limiting grows without route benefit; or if replay shows clamp-equivalent or negligible feasible-action support

## One candidate hypothesis

Produce exactly one candidate from `solver_1a8c73736b49`, not from the
assigned parent's regressed wave-relief handoff. Preserve its anterior
state-feedback oscillator, posterior traveling bend, target/course steering,
carrier-demodulated route and load residuals, translational-response
correction, approach and terminal roles, mean-first allocation, force-response
selection, and exact actuator projection.

Change only allocation of the existing low-speed posterior-wave increment.
Outside reliable redirect duty it remains symmetric. During redirect duty,
normalized posterior-wave phase and the bounded steering sign form a smooth
half-cycle selector: the aiding lobe retains the full evidenced increment,
while the opposing lobe returns only to the unchanged base wave before the
existing one-sided steering relief is applied. No new gain, authority, clock,
memory, route, or exact vortex phase is introduced. The falsifiable
expectation is to preserve self-propulsion while improving the sampled-best
route or posterior limiting by avoiding the very target-opposing wave
reinforcement that regressed the assigned parent. Formal CFD remains post-exit
evidence, so no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `8a8ddaf998ded60367f452f0aed1645d073c4149316a364d9a2487b841c2bc3b`.
  Static schema validation resolves exactly 57 direct `params.FIELD`
  references against the same 57 fields returned by
  `target_policy_params()`, with no missing or unused field.
- The prescribed lightweight Julia contract returns two finite bounded
  accelerations. Non-finite target, velocity, force, moment, bearing,
  bearing-rate, and yaw observations select a finite bounded fallback.
- A deterministic 720-state paired sweep across mirrored body-frame target
  geometry, translation, joint phase, force, moment, yaw response, and
  line-of-sight rate stays inside the acceleration envelope with exactly zero
  lateral-reflection error.
- Counterfactual evaluation on reconstructed sampled-best trace states changes
  392 of 2,851 posterior commands and no anterior command over
  `0.0110-3.6520T`. Mean and maximum changed-command magnitudes are `0.01145`
  and `0.10407 rad/T^2`, with no new posterior acceleration-ceiling output.
  It differs from the assigned parent on 489 reconstructed states with maximum
  difference `1.94386 rad/T^2`. This establishes broad, feasible,
  non-clamp-equivalent action support without predicting closed-loop CFD.
- Guidance materiality, the Julia contract, parameter schema, and the solver
  editable-boundary checks pass. Exactly one
  `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl` exists and
  no formal CFD was run. The configured `.codex/agents/check-runner.toml` was
  invoked as required, but its pinned `gpt-5.4-mini` model is unsupported for
  this account, matching the inherited limitation; its three prescribed
  commands were run directly and pass.
