# Measured-yaw-cancelled target-line response candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evaluation contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no prewarm
  or cylinders, finite dynamics, and capture after 2,919 steps and 239
  moving-window shifts. The motion is self-propelled rather than imposed-flow
  advection.
- I inspected the combined keyframe sheets for the strongest finite sample
  (`solver_b8f061aba429`) and the most informative relative failure
  (`solver_a03406b458eb`) from release through capture, including both the
  top-down vorticity and oblique body/Lambda2 views. Both show the same smooth
  target-directed arc, a coherent alternating wake behind the traveling bend,
  and compact three-dimensional caudal structures. Neither shows wake breakup,
  standing reciprocal motion, collision, boundary exit, or out-of-plane
  instability. The successful carrier and established route should therefore
  remain unchanged.
- The assigned parent's carrier-phase-demodulated middle response is the best
  sample at score `-0.046899933`, final distance `0.745845616L`, and distance
  integral `1.929839552L`; the sampled raw terminal net-rate controller reaches
  `-0.046908385`, `0.745853782L`, and `1.929846378L`. Both cross every
  `8/6/4/2/1.5/1.25/0.9/0.8/0.75L` milestone at the same logged step. Their
  observed pre-capture integrals are `1.303734757414L` and
  `1.303734757135L`, respectively, so the parent's intended middle-route gain
  did not materialize; its small advantage comes from terminal hold/crossing
  geometry. It also slightly lowers whole-rollout posterior acceleration-limit
  residence from `21.857%` to `21.788%` and mean absolute posterior command
  from `24.586` to `24.585 rad/T^2`, without changing peak force, moment, joint
  excursion, or speed-limit residence.
- The relative failure that attenuates a bearing-rate-reinforcing wave lobe has
  the same wake and arrival step but regresses to `0.745940L` and
  `-0.046998`; this rules out another phase-lobe relief edit. The unresolved
  hypothesis is narrower: the middle branch used a learned anterior-phase yaw
  proxy even though measured normalized heading rate is directly available.
  On the strongest trace, subtracting measured heading rate from bearing rate
  reduces residual RMS from about `0.0291` to `0.0137` carrier-frequency units
  and removes the repeatable rigid-body yaw contribution without changing the
  terminal raw-rate controller.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and residual-command path following
source_mechanism: keep rhythmic propulsion as the carrier while using measured body response to form a separate bounded navigation correction
transferable_invariant: separate repeatable locomotor yaw from target-line motion before spending mean-curvature authority, while leaving the traveling bend intact
nontransferable_details: published CPG gains, dimensional frequencies, clock phase, species-specific kinematics, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: start from the strongest sampled two-joint controller; retain its carrier, redirect law, and below-0.90L raw net bearing-rate damper, but in the middle handoff replace joint-phase-predicted yaw with measured normalized heading rate and oppose only target-line reopening under the existing closing safe-intercept gate
falsification: reject if the branch changes far-field milestones or the coherent two-view wake, delays or loses capture, raises limiting or loads materially, or again changes only terminal hold without improving an earlier observed distance integral or useful trajectory state

## One candidate hypothesis

Use `solver_b8f061aba429` as the evidenced base. Preserve its cruise carrier,
response-gated redirect, terminal line-of-sight damper, approach settling, and
hard-limit projection. Change only the middle-approach residual: compute it as
normalized measured bearing rate minus normalized measured heading rate. This
reflection-odd difference cancels rigid-body yaw using current body-frame state
instead of a fitted joint-phase surrogate. Feed it through the same bounded
reopening gate and shared three-degree curvature envelope, fading continuously
into the existing raw net-rate response below `0.90L`; the corrections still
cannot stack.

Expected evaluation evidence is the same capture class, far-field milestones,
joint envelope, and coherent alternating 3D wake, with feasible action appearing
earlier in the closing corridor and reducing observed distance integral before
the terminal hold. This worker does not claim an unevaluated CFD result.

## Non-CFD verification after the edit

- Candidate SHA-256:
  `790ebaaa4ac9d39d70dacc7da85abe5cc78291a2a4bc5ac1cbb14d65b1b99011`.
  The deterministic schema guard finds all 48 directly referenced parameter
  names among the 48 fields returned by `target_policy_params()`.
- A deterministic sweep of 17,578,125 paired normalized body-frame states
  returns finite commands inside the `31.416 rad/T^2` envelope with zero
  numerical lateral-reflection error. A non-finite task-observation probe also
  returns finite fallback commands.
- On reconstructed states from the strongest sampled trace, the new controller
  differs from its assigned-parent base on 18 feasible posterior commands. The
  first difference is at `1.518L`, one changed command lies above `0.90L`, 17
  lie in the continuous handoff to the terminal response, and the maximum
  command difference is `1.135 rad/T^2`. This establishes distinct feasible
  action support, not a closed-loop CFD benefit.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its prescribed material guidance/notes,
  Julia policy-contract, and solver editable-boundary checks were then run
  directly and all pass. The material checker required removing one duplicate
  assigned-parent marker from the rendered workspace `README.md`; that metadata
  repair does not change solver or guidance behavior.
