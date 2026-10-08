# Net target-line response handoff for supplemental yaw rejection

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 release contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture.
  There is no failed termination in this allocation, so the weaker finite
  captures and the inherited response-hold/phase-allocation regressions are
  the informative negative controls.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the replicated sampled best (`solver_1a8c73736b49` and
  `solver_e4b4c0604a5d`) and the weakest sampled finite control
  (`solver_502dfb1f0223`) from release through termination. In both views the
  fish moves from rest, grows a compact release transient into a coherent
  alternating caudal wake by about `4T`, and self-propels along the same smooth
  target-directed arc. The oblique row retains bounded alternating 3D
  structures without advection, wake collapse, collision, boundary exit, or
  out-of-plane instability. The sheets are effectively indistinguishable at
  their sampling resolution, so trajectory, response, and actuator histories
  rather than vortex prominence distinguish the mechanisms.
- Direct target-line translational opposition inside the existing error-opened
  `2 deg` posterior-curvature envelope is replicated at `15.686007T`,
  `0.743392L`, distance integral `1.916135L`, 226 shifts, and score
  `-0.033442`. The assigned solver instead releases that mean correction when
  carrier-demodulated yaw becomes aiding and reaches only `15.713508T`,
  `0.743858L`, integral `1.917987L`, and `-0.035331`. The sampled controller
  that keeps the mean bend but lets the same aiding-yaw signal restore the
  target-opposing wave lobe also regresses every recorded milestone, reaching
  `15.708008T`, `0.743744L`, integral `1.918172L`, 231 shifts, and
  `-0.035505`. Thus realized body yaw is too early a handoff signal for either
  useful mean curvature or the redirect wave relief.
- The assigned-parent optimizer logs add two boundaries. Letting adverse
  translation hold curvature independently after the raw error gate closes
  lengthens the route to `15.730008T` and integral `1.920874L`, while allocating
  a low-speed wave increment by requested-turn half-cycle reaches only
  `15.735508T`, `0.745761L`, and integral `1.922135L`. Preserve the raw
  error-opened steering envelope, the one-sided relief scaffold, and the
  response-gated traveling carrier; do not add independent steering duty or
  another phase selector.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and wake-interaction swimming
source_mechanism: measured route response releases supplemental turn correction, and useful target-directed motion is preserved instead of cancelling every adverse component response
transferable_invariant: preserve the traveling carrier and target-defined base bend, but release supplemental rotational rejection whenever normalized net target-line error is already closing
nontransferable_details: published gains, dimensional rates, species-specific burst shapes, exact tail or vortex phase, clock-defined maneuver stages, world coordinates, and task-specific routes
policy_translation: start from the replicated best body-frame controller; retain its carrier, wave shaping, base redirect, and shared moment/translation correction, and use the reflection-even product of body-frame bearing and normalized net bearing rate to retain supplemental yaw-rejection curvature only while absolute target-line error is reopening; evaluate closing and reopening endpoints through the same allocator and accept the handoff only when its feasible action is no larger
falsification: reject if capture or any established distance milestone regresses, distance integral or final crossing worsens, the coherent two-view wake is lost, limiting or force/moment loads rise without route benefit, or replay shows negligible or clamp-equivalent action support

## Static falsification and revised final candidate hypothesis

The first implementation applied target-aiding translation to the extra
redirect wave-relief increment. Counterfactual replay on all 2,852 states of
the replicated-best trace changed only 76 posterior actions between
`0.2035-2.3980T`; the mean and maximum feasible differences were only
`0.000015` and `0.000115 rad/T^2`, with the same 640 acceleration-ceiling
outputs. This fails the stated non-negligible-action falsification boundary, so
that implementation was rejected before CFD and is not the final candidate.

The next placement of the same response handoff released the anticipatory
moment-residual component. Replay changed only 61 posterior actions between
`0.2035-2.3980T`, with mean and maximum differences of `0.000006` and
`0.000047 rad/T^2` and no ceiling change. Moment opposition and target-aiding
translation therefore lack material overlapping support on this trace; that
placement was also rejected before CFD.

The third placement used target-aiding translation to veto supplemental yaw
rejection, but replay found zero changed actions: whenever that yaw branch was
active, center translation was itself target-opposing. This is a useful
kinematic exclusion, but not a candidate mechanism.

The final candidate starts from the replicated sampled-best
translational-response controller, not the weaker assigned solver. Preserve
its anterior state-feedback oscillator, posterior traveling bend and wave
relief, target/course steering, carrier-demodulated route and load residuals,
direct translational mean correction, approach and terminal shaping,
axial-force response allocation, mean-first posterior tracking, and exact
actuator projection. Add one response handoff to supplemental yaw-rejection
curvature: retain it only while the reflection-even product of body-frame
bearing and normalized net bearing rate says absolute target-line error is
reopening. When the measured line is already closing, release only that
supplemental correction; all base redirect and shared moment/translation
curvature remains unchanged, and reopening continuously restores yaw
rejection. This translates the shelf boundary that useful target-directed
motion should not be cancelled merely because one component response is
adverse, without repeating the failed yaw release, independent response hold,
phase allocation, or the inert placements. On the replicated-best trace,
about half of the 1,101 materially active yaw-response states are closing and
therefore provide distinct response support. A first curvature-only replay
changed 459 posterior actions over `2.7280-15.6475T`, but mean/wave
cancellation made 349 commands larger and added 37 acceleration-ceiling
outputs. The final implementation therefore evaluates the proven and
handed-off mean-curvature endpoints through the unchanged wave,
force-response, and mean-first allocator, then accepts the response handoff
only when its feasible acceleration magnitude is no larger than the proven
endpoint. This reflection-equivariant action guard prevents a target-level
release from manufacturing extra demand; it does not soften the carrier or
alter the actuator limit. The falsifiable expectation is earlier route
milestones or a lower distance integral with capture and wake coherence
preserved, and lower effort alone is insufficient. Formal CFD remains
post-exit evidence, so no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `965ec7dd1798d7ef12bf4bd44388bcca17bf5f40d9c381e5fa88b90c7b8b1491`.
  Static schema validation resolves exactly 57 direct `params.FIELD`
  references against the same 57 fields returned by
  `target_policy_params()`, with no missing or unused field.
- The prescribed lightweight Julia contract returns two finite accelerations.
  A deterministic 5,000-pair sweep across mirrored normalized body-frame
  target geometry, translation, force, moment, joint phase, bearing rate, and
  yaw response stays inside the declared acceleration envelope with exactly
  zero reflection error. Non-finite target, velocity, force, moment, bearing,
  bearing-rate, and yaw inputs also select finite bounded fallbacks.
- Counterfactual replay on all 2,852 replicated-best trace states changes 110
  posterior actions and no anterior action over `2.7280-14.5970T`. Mean and
  maximum changed-command magnitudes are `0.335752` and
  `2.130219 rad/T^2`; every changed action has no larger magnitude than the
  replicated-best action, and the 640 replayed posterior
  acceleration-ceiling outputs are unchanged. This establishes material,
  feasible, non-clamp-equivalent response support without predicting the
  unevaluated closed-loop CFD result.
- Guidance materiality, the Julia contract, parameter schema, and solver
  editable-boundary checks pass. Exactly one
  `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl` exists and
  no formal CFD was run. The configured `.codex/agents/check-runner.toml` was
  invoked as required, but its pinned `gpt-5.4-mini` model is unavailable for
  this account, matching the inherited limitation; its three prescribed
  checks were therefore run directly and pass. The duplicate assigned-parent
  marker in the rendered workspace `README.md` was removed to let the guidance
  checker identify exactly one parent.
