# Posterior phase-lag terminal-steering candidate

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable finite dynamics, and
  capture. The strongest current score is the direction-consensus policy
  `solver_3b3fa6c1a86f` (`-0.5357785`), while the approach allocator
  `solver_8c3d920cc8a5` is the informative weak sample (`-0.5367836`).
- In both combined sheets, the top-down row shows self-propelled progress and a
  coherent alternating vortex street by roughly `4T`; the oblique row retains
  paired three-dimensional Lambda2 structures through the gradual target turn
  and capture. Their final routes and wakes are visually indistinguishable at
  keyframe resolution. There is no advection, wake collapse, boundary contact,
  collision, or instability to repair, so the useful carrier must be preserved.
- The highest-scoring consensus candidate improves the scalar over the
  phase-demodulated prefill by only `1.6e-5`; it arrives later (`23.8590T`
  versus `23.8315T`) and has essentially unchanged mean terminal yaw and load
  (`1.683` versus `1.684 rad/T`, `0.01177` versus `0.01180` lateral force).
  Its reconstructed Boolean cue agreement switches 15 times inside `3L` and
  holds for only `41.2%` of samples inside `1L`, so the tiny score gain is not
  evidence that binary terminal arbitration is a reusable improvement.
- The dissipative-yaw variant also preserves capture but scores `-0.5359187`
  without reducing terminal mean yaw, cross-track speed, or lateral load. The
  inherited consensus half-cycle direct-acceleration rollout likewise retains
  the same visible wake yet regresses to `-0.5362622`, `23.9085T`, and mean
  scoring distance `2.434617L`; although its terminal yaw and cross-track means
  fall to `1.614 rad/T` and `0.222U`, both joint commands remain above 95% of
  the acceleration envelope for about `58%` of terminal samples. Directly
  adding another terminal acceleration therefore trades progress for modest
  cleanup without relieving high-command exposure.
- The approach allocator is cleaner (`1.585 rad/T` terminal mean yaw and about
  `46/40%` high-command exposure), but is the slowest current capture at
  `23.9250T` with mean scoring distance `2.435081L`. Together these results
  reject further command-reserve tuning, binary cue gating, or additive direct
  acceleration as the default next terminal mechanism.

## Policy hypothesis

Use the evaluated phase-demodulated prefill as the sole carrier because it has
the fastest current capture and best current mean scoring distance. Preserve
its target geometry, response-released same-sign C-bend, state-feedback
oscillator, posterior emphasis, and smooth final projection. Keep its bounded,
normalized body-frame terminal course/yaw cue, but remove the cue's independent
anterior and posterior oscillator-center offsets. Instead, use the cue and the
observed normalized anterior joint velocity to make posterior lag slightly
larger on one half-cycle and smaller on the other. This wave-shape modulation
creates the requested mean steering through the moving carrier, rather than by
adding static curvature or a separate acceleration residual.

The expected result is retained capture and alternating-wake coherence with
arrival and mean distance near the prefill, but less persistent terminal bend
and lower terminal yaw/load or acceleration exposure. Falsify the mechanism if
capture or wake coherence is lost; if arrival exceeds `23.93T` or mean scoring
distance exceeds `2.4351L` without a material load/saturation benefit; if the
same terminal yaw/cross-track tradeoff persists; or if the asymmetric lag
causes posterior speed, angle, or acceleration exposure to rise. Because the
carrier-phase proxy is gait-specific, re-estimate or remove it if a changed
carrier leaves the residual beat-periodic.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical traveling-wave swimming
source_mechanism: steer a stable propulsive rhythm by bounded half-cycle phase-lag or wave-shape asymmetry while retaining posteriorly emphasized propulsion
transferable_invariant: preserve the coherent traveling-wave carrier and express a small directional correction through observed-phase posterior wave shape rather than an independent static bend or raw acceleration residual
nontransferable_details: published gains, dimensional cadence, robot linkage geometry, species-specific envelopes, exact vortex phase, and prescribed source-task routes
policy_translation: use the normalized body-frame carrier-rejected terminal course cue with normalized anterior joint velocity to modulate posterior lag oppositely across observed half-cycles under the existing two-joint state-feedback contract
falsification: reject if capture or alternating-wake coherence is lost, or if progress, terminal yaw/course, loads, and joint-limit histories do not jointly improve over the phase-demodulated, consensus, direct-acceleration, and allocator boundaries

## Worker-side verification boundary

The candidate's CFD result is unavailable to this worker and will not be
claimed as evidence. Only schema, syntax/contract, symmetry, boundedness, and
material activation checks are performed here; formal CFD remains downstream.

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Running its prescribed
  checks directly gives PASS for the material reusable-guidance update and
  PASS for the solver editable-boundary check.
- Julia is not installed, so the exact include/contract probe cannot execute.
  The deterministic fallback finds one `target_policy_params` definition, one
  `target_policy` definition, `68` returned parameter fields, `66` referenced
  fields, no missing field, balanced delimiters/blocks, a nonempty candidate,
  and no clock, step, randomness, file-I/O, mutable-global, cylinder-coordinate,
  or target-identity token.
- The new terminal lag multiplier is in `[0.70,1.30]` for the returned owned
  parameters because both the course request and observed phase are in
  `[-1,1]`; it is exactly one outside the inherited `3L` proximity gate. The
  inherited smooth projection still bounds both final joint accelerations.
- Under lateral reflection, target/course, yaw, joint angle, and joint velocity
  signs reverse. The course request and phase motion therefore both reverse,
  leaving their lag multiplier invariant while the resulting joint targets and
  accelerations reverse. This is an algebraic equivariance check, not a rollout
  or fluid-dynamic claim.
