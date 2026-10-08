# Terminal slip-to-yaw response handoff candidate

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the Phase 2 contract: direct uniform
  still-water initialization with `U_infinity=[0,0,0]`, no cylinders or
  prewarm, finite dynamics, capture at `16.054375T`, 2,919 steps, and 239
  moving-window shifts. There is no failed termination in this allocation, so
  the informative negative boundary is the repeated assigned-parent terminal
  response rather than an exit or instability.
- I inspected both rows of the combined keyframe sheets for the strongest
  finite sample (`solver_ddf99a38d49e`) and the repeated assigned-parent
  contrast (`solver_1b92eb34e2e6`/`solver_c317ab85985a`). The top-down rows
  show the same self-propelled target-directed arc and coherent alternating
  vorticity street; the oblique rows show compact three-dimensional Lambda2
  structures through capture. There is no passive advection, standing wiggle,
  wake breakup, collision, boundary exit, or out-of-plane instability. The
  carrier, route steering, wave relief, and actuator allocation should remain
  unchanged.
- The parent copies are exactly repeatable at final distance `0.745943L`,
  distance integral `1.929921L`, and score `-0.047001`. The moment-led yaw
  predictor changes only trace-scale geometry (`0.745938L`, `1.929917L`,
  `-0.046995`), while the distinct translational line-of-sight slip damper is
  the strongest sample at `0.745869L`, `1.929859L`, and `-0.046924`. Every
  `8/6/4/2/1.25/0.9L` milestone, joint excursion, speed/acceleration-limit
  residence, and peak force/moment remains unchanged, so the positive evidence
  is terminal response shaping rather than a new route or semantic success.
- The strongest trace also exposes an allocation cost. From `0.788L` through
  capture, its body-frame translational target-line rate falls from `0.825` to
  `0.787 rad/T`, but measured yaw grows from `1.112` to `2.109 rad/T`; against
  the parent, the final line rate is `0.00243 rad/T` lower while target-signed
  yaw is `0.01705 rad/T` higher and bearing reopens slightly farther
  (`0.183914` versus `0.183324 rad`). Thus posterior slip curvature improves
  distance geometry but begins to compete with the already active yaw brake.
  Tuning its magnitude alone would not test that observed coupling.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: preserve rhythmic propulsion while normalized sensory feedback schedules distinct bounded endpoint response corrections
transferable_invariant: separate the productive traveling-wave carrier from translational-slip and rotational-yaw response, and hand authority between corrections when the measured response changes regime
nontransferable_details: published gains, clock-driven CPG phase, species-specific kinematics, dimensional frequencies, exact vortex phases, morphology-specific envelopes, and task-specific routes
policy_translation: inherit the best sampled body-frame line-of-sight slip damper, carrier, redirect handoff, and yaw brake; multiply only the terminal slip correction by the complement of the existing normalized target-signed yaw-response gate so slip acts before yaw correction takes over and continuously releases as measured yaw becomes aiding
falsification: reject if pre-corridor milestones or the coherent two-view wake change, capture is delayed or lost, distance integral or final crossing regresses to the parent, target-signed yaw/bearing reopening is not reduced versus the ungated slip sample, or actuator/load maxima rise materially

## One candidate hypothesis

Use the strongest sampled slip-damped controller as the base and add one
response-allocation mechanism: a smooth slip-to-yaw authority handoff. The
translational slip correction remains confined to the established closing
capture corridor and retains its reflection-equivariant body-frame sign, but
its magnitude fades with the existing `yaw_aiding_gate`. The proven yaw damper
then owns the late response once normalized measured yaw is target-signed.
This changes feasible posterior mean curvature only in the terminal overlap;
it does not alter the oscillator, target-directed route command, posterior
wave, approach behavior, or hard-limit projection. Expected evidence is the
same arrival and wake with the slip sample's distance benefit but less late
yaw/bearing reopening. The new CFD outcome is not available to this worker.

## Non-CFD verification after editing

- Candidate SHA-256:
  `08333105fd1f88f51b2b8bfa30aaa4f9ae19feb99731f882a0d278038520b3f8`.
- The prescribed check runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three declared commands were run
  directly and separately instead: the material guidance/notes check, Julia
  policy contract, and solver editable-boundary check all pass. The rendered
  workspace README repeated the same assigned-parent marker twice; the exact
  duplicate was removed so the prescribed guidance checker could resolve the
  unchanged parent.
- The deterministic schema guard matches all 50 direct `params.FIELD`
  references to the 50 fields returned by `target_policy_params()`.
- A deterministic 8,640-state sweep spanning reflected target side, joint
  state, lateral velocity, bearing, and yaw response returned finite commands
  within `31.416 rad/T^2`, zero reflection-equivariance error, a finite
  non-finite-observation fallback, and no outward command at the exact joint-
  speed boundary.
- Counterfactual replay on the strongest sampled trace changes only 16
  posterior commands, from `0.836132L` through capture, relative to the
  ungated slip damper. The maximum difference is `1.897843 rad/T^2`. This
  verifies bounded terminal action support only; it is not a substitute for
  the later formal CFD evaluation.
