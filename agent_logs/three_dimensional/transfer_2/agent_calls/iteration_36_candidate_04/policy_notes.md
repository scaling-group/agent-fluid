# Evidence-selected v41 control after repeated nominal collapse

## Visual diagnosis before candidate selection

- The four sampled solvers are one effective experiment: their candidate
  policies, `4480`-row trajectories, and combined two-view sheets are
  byte-identical.  Every rollout is a direct-uniform still-water case with
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and 284 moving-window
  shifts; every one captures at `24.640015T` and `0.748356L`, with mean
  distance `2.347937L` and score `-0.448328283`.
- I inspected the combined sheet from release through capture.  The top-down
  row shows a wake-free release, self-propelled diagonal advance with an
  orderly alternating mid-plane vortex street, and a broad transverse hook
  into the capture disk.  The oblique row shows compact three-dimensional
  Lambda2 structures persisting through the hook.  Zero background velocity
  and the developing wake distinguish propulsion from advection; neither row
  shows breakup, collision, out-of-plane escape, or instability.
- The scalar evidence agrees with the images but limits the conclusion.  The
  terminal crossing margin is only `0.001644L`; inherited diagnostics report
  terminal yaw rate `1.887 rad/T`, zero sampled joint hard-stop occupancy, low
  peak planar force/yaw-moment coefficients
  (`0.02303/0.03169/0.01559`), and `73.594%` raw acceleration-envelope
  exposure.  This is a narrow dynamic capture with a coherent self-wake, not
  a settled hold or an unsaturated controller.
- No sampled failure sheet exists in this workspace, so a current visual
  success/failure contrast cannot be claimed.  The assigned parent's
  inherited log supplies the closest controlled failure comparison: v42
  transfers rejected posterior terminal authority to the anterior joint and
  crosses one row earlier, but worsens final/mean distance and score to
  `0.749001/2.348455L/-0.448986` while increasing raw acceleration exposure to
  `74.124%`; v43 instead vetoes the anterior mate and delays capture to
  `24.656513T`, consumes margin to `0.000397L`, and worsens mean distance and
  score to `2.348909L/-0.449516`.  Neither changes the load or rate class.

## Candidate hypothesis

Keep exactly one candidate: the prefilled v41 terminal phase-allocation
policy, byte-identical in dynamics and schema to the four sampled successful
solvers.  Preserve its state-derived anterior phase anchor, lagged posterior
traveling bend, normalized body-frame projected-miss corridor, bounded
aligned-half-cycle terminal allocation, posterior stopping-stroke reserve,
and posterior rate coast.  Do not add a force, moment, crossflow, local-flow,
or cross-joint recovery branch: the replicated nominal trace contains no
distinct disturbance event that identifies its trigger, corrective sign, or
necessary phase, and both completed active cross-joint alternatives consume
capture margin.

This is a concrete negative transfer result after a semantic stall, not a
scalar-only tune and not a same-worker CFD claim.  Post-exit evaluation should
reproduce capture, the coherent two-view wake, zero position hard-stop
occupancy, and the low-load class.  Reject the selection if nominal capture
does not repeat.  Reopen an active mechanism only when a reflected,
perturbed-release, or genuinely disturbed rollout exposes a reproducible
normalized body-frame divergence; the new branch must remain null before that
event and preserve the established far route.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated robotic-fish oscillators, asymmetric turning, and wake-adaptive swimming
source_mechanism: preserve the stable anterior-to-posterior traveling bend and add bounded sensory phase modulation only for an observed persistent route or disturbance error
transferable_invariant: infer propulsion phase from joint state, retain the independent anterior phase anchor and posterior lag, and require a normalized body-frame trigger with an empirically identified corrective sign before adding residual feedback
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant predicted-miss residual, aligned-half-cycle allocation, anterior anchor, posterior stopping reserve, and posterior coast; add no unsupported wake residual, scalar retune, or cross-joint authority transfer
falsification: reject if nominal capture, far-route locality, coherent wake, zero position hard-stop occupancy, or the low-load class fails to repeat; reject a future residual if it activates before a distinct body-frame divergence or removes necessary correction on a held-out route

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The available fixed-case
replications establish determinism only; they do not establish robustness to
reflection, release-pose perturbation, imposed inflow, or an external wake.

## Pre-evaluation validation

- The sole materializable candidate remains byte-identical to all four
  sampled v41 policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  No sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account.  Its three declared no-CFD checks
  were therefore run directly and separately: reusable-guidance semantics,
  the Julia public policy contract, and the solver editable-boundary audit all
  pass.  The contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The parameter-schema audit resolves every direct `params.FIELD` reference
  against a field returned by `target_policy_params()`.  Formal CFD remains
  reserved for the post-worker evaluator.
