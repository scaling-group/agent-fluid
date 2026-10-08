# Carrier-demodulated line-of-sight response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no prewarm
  or cylinders, finite dynamics, and capture at `16.054375T` after 2,919 steps
  and 239 moving-window shifts. Their progress is self-propelled rather than
  imposed-flow advection.
- I inspected the combined keyframe sheets for the highest-scoring finite
  sample (`solver_8474fe870fa5`) and the most informative relative failure
  (`solver_a03406b458eb`) from release through termination, including both the
  top-down vorticity and oblique body/Lambda2 rows. Both show a smooth
  target-directed arc, a coherent alternating reverse-street wake, and compact
  three-dimensional caudal structures through capture. Neither shows a
  reciprocal standing wiggle, collision, domain exit, wake breakup, or
  out-of-plane instability. The sheets are visually indistinguishable at
  their diagnostic scale, so the carrier, posterior traveling bend, and
  established cruise route should remain intact.
- The four policies differ only in terminal response structure and all retain
  the same capture step. The net measured line-of-sight-rate damper is best at
  final distance `0.745854L`, distance integral `1.929846L`, and score
  `-0.046908`. Separate translational-slip mean damping and slip-conditioned
  half-cycle relief are effectively tied at `0.745869/0.745867L`,
  `1.929859/1.929858L`, and `-0.046924/-0.046923`. Directly attenuating a
  bearing-rate-reinforcing posterior lobe regresses to `0.745940L`,
  `1.929919L`, and `-0.046998`. Observed pre-capture distance integrals differ
  by less than `2.4e-8L`; these are terminal crossing-shape effects, not new
  routes or arrival improvements.
- Reconstructing normalized body-frame bearing rate from every 2,919-row
  trace shows that the already evidenced anterior-phase yaw model
  `0.03*q1_norm - 0.43*qd1_norm` explains `98.12%` of its variance in each of
  the four samples (residual RMS about `0.029` carrier-frequency units). Raw
  line-of-sight rate is therefore mostly repeatable carrier motion outside the
  tight terminal gate. The remaining testable capability is a bounded
  middle-approach response that removes this joint-phase component before
  deciding whether alignment is persistently reopening.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and wake-interaction control
source_mechanism: separate slow persistent target response from fast alternating locomotor or wake response, then apply a bounded residual correction without suppressing the propulsive carrier
transferable_invariant: do not spend steering authority cancelling a repeatable joint-phase yaw; subtract the evidenced carrier component and correct only residual target-line reopening under reliable target-directed translation
nontransferable_details: published gains, clock-defined CPG phase, dimensional frequencies, species-specific envelopes, exact vortex phases, morphology, and task-specific routes
policy_translation: start from the strongest sampled two-joint controller; retain its raw net line-of-sight damper below `0.90L`, and before that handoff subtract the existing normalized anterior-phase response model from measured bearing rate, applying the same bounded posterior mean-curvature envelope only when proximity, positive closing, a safe predicted miss, and residual reopening agree
falsification: reject if the residual branch alters the proven far-field route, fights a carrier half-cycle, changes the coherent two-view wake, delays or loses capture, raises limiting or loads materially, or fails to improve an earlier distance milestone or the observed distance integral rather than only the held terminal score

## One candidate hypothesis

Use the strongest sampled net line-of-sight controller as the base and add one
staged response mechanism. In the middle approach, predict the carrier-scale
part of normalized bearing rate from the same anterior joint phase model that
already supports yaw-opposition steering. Subtract that prediction, form a
smooth reopening gate from bearing times the residual, and oppose only that
residual through posterior mean curvature. The new branch shares the sampled
three-degree response envelope and fades out as the existing below-`0.90L`
net line-of-sight damper fades in, so the two corrections never stack. It is
also identically inactive without approach closing, course reliability, and a
safe straight-course intercept.

Expected evidence is unchanged far-field milestones and alternating 3D wake,
but a measurable improvement before the terminal hold interval, followed by
the already strongest raw line-of-sight response at capture. This worker does
not claim the unevaluated CFD outcome.

## Non-CFD verification after the edit

- Candidate SHA-256:
  `650a2d0d74c0edd84a42a13119a7df8a6eafbe4dbed2b73256434fb2dbb2e6e2`.
  The deterministic schema guard finds all 48 directly referenced parameter
  names among the 48 fields returned by `target_policy_params()`.
- A deterministic sweep of 1,360,800 paired normalized body-frame states
  returns finite commands inside the `31.416 rad/T^2` envelope, has zero
  numerical lateral-reflection error, removes outward action at the exact
  joint-speed boundary, and retains a finite fallback for non-finite task
  observations.
- Counterfactual evaluation on the strongest sampled trajectory leaves every
  anterior command and the sampled terminal controller unchanged. The new
  middle-response branch changes four posterior commands from `1.518L` to
  `1.259L`, with a maximum difference of `0.669 rad/T^2`. This establishes
  feasible pre-terminal action support, not a closed-loop CFD result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three prescribed checks were
  therefore run directly and separately: the material guidance/notes check,
  lightweight Julia policy contract with parameter-schema guard, and solver
  editable-boundary check all pass. The material checker required removing
  one duplicate assigned-parent marker from the rendered workspace `README.md`;
  that metadata repair does not alter solver or guidance behavior.
