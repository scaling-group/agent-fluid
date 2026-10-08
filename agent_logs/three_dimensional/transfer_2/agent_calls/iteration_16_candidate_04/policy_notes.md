# Terminal collision-cone candidate

## Evidence diagnosis before the policy edit

- The four assigned solver examples are byte-identical course-preview controls,
  initialized directly in uniform still water with `U_infinity=[0,0,0]`, no
  cylinders, and no prewarm. Each self-propels to capture at `24.5795T`, with
  minimum/final distance `0.746968L` and mean distance `2.36044L`; they are
  replicated evidence for one mechanism rather than four distinct trials.
- Both visual rows were inspected for the assigned capture, the inherited v32
  braking-reserve capture, and both completed v33 failures. The successful
  top-down sheets build a coherent alternating wake along the diagonal route
  and show a broad target-directed redirect before crossing the capture circle;
  their oblique sheets retain compact three-dimensional Lambda2 structures
  through termination. The v33 sheets initially retain that self-generated
  coherent wake, but curl past the circle and continue toward the upper-left
  boundary. The failures are controlled near misses, not passive advection,
  wake breakup, or numerical instability.
- The inherited v32 proprioceptive braking reserve is the strongest completed
  actuator result to preserve. It captures at `24.6290T` and `0.748702L`, has
  mean distance `2.36161L`, eliminates posterior hard-stop occupancy, and
  lowers peak absolute body-frame force/yaw-moment coefficients to
  `0.0241/0.0303/0.0149`. Its unchanged `15.163%` any-joint rate-limit
  occupancy is not sufficient evidence that the rate limiter should be
  removed from the closed-loop gait.
- Two independently written, mirror-equivariant v33 barriers provide a
  concrete negative result. Both began changing the rhythmic commands near
  `2.08T`; one drove both near-limit joints toward full inward acceleration
  and the other permitted a 20-percent inward reserve. They reduced exact
  rate-limit occupancy from `15.163%` to `0.236%` and `0%`, respectively, but
  both lost capture, reached only `0.933L` and `0.848L`, and exited left at
  `37.273T` and `36.751T`. Their wakes remain coherent while their headings
  and routes diverge materially by `8T`. Thus a final two-joint rate barrier
  is not a harmless feasibility projection; the saturated carrier is part of
  the realized route and should not be altered again without a phase-aware
  mechanism and a stronger route margin.
- The successful v32 trace isolates a smaller terminal opportunity. At about
  `24.40T` it is only `0.886L` from the target, but the instantaneous closing
  sign reverses while normalized course error is about `0.997` and the
  velocity-line miss estimate is about `0.884L`, just outside the capture
  radius. The inherited course-preview request is multiplied by the closing
  gate and therefore disappears during this within-beat reversal. By
  `24.60T`, closing resumes, predicted miss falls to about `0.697L`, and the
  fish captures. This supports a near-only course-persistence test without
  changing the evidenced far carrier.

## Policy hypothesis

Restore the evaluated v32 route, predictive tail-priority guard, and full
posterior braking reserve. Add one bounded terminal collision-cone residual to
the existing steering-priority request. Estimate signed closest-approach miss
as normalized range times the already body-frame, speed-normalized course
cross product. The residual is exactly zero outside a near-target range and
inside a capture corridor; when both gates are active, it uses only unused
signed steering headroom and does not depend on instantaneous closing sign.
This should preserve every far-path command while preventing a brief
within-beat closing reversal from withdrawing the final useful redirect.

Expected evidence is the same coherent diagonal wake, capture no later than
the v32 `24.6290T` baseline, zero posterior hard-stop occupancy, and the v32
low-load class, with a course-miss estimate that moves inside the capture
corridor without a post-pass loop. Falsify the mechanism if any command differs
outside the terminal range, capture is lost or delayed, the wake/route changes
before terminal approach, the posterior hard stop returns, or peak loads leave
the inherited low class. The candidate's CFD outcome is not claimed here; EvE
will evaluate it after this worker exits.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal target capture
source_mechanism: retain a phase-lagged propulsive rhythm while a bounded sensory residual corrects only an observed terminal course error
transferable_invariant: preserve the demonstrated traveling-wave carrier and maintain near-target steering when body-frame velocity predicts a miss, without letting a single within-beat closing-sign reversal erase the correction
nontransferable_details: published CPG gains, dimensional cadence, species kinematics, full-body envelopes, exact vortex phase, capture radius, and task-specific routes
policy_translation: use normalized body-frame target range and the signed velocity-target cross product to add a bounded near-only collision-cone residual through unused two-joint steering headroom
falsification: reject if far commands change, capture or coherent wake is lost, posterior hard-stop protection or the low-load class regresses, or terminal arrival is not earlier than the evaluated v32 parent

## Pre-evaluation validation

- The required public-contract state returns two finite accelerations. All `87`
  direct `params.FIELD` references resolve among the `89` fields returned by
  `target_policy_params()`.
- A `54,675`-state grid spanning far range, target angle, body-frame velocity,
  both joint positions and rates, closing sign, and steering state is
  bit-for-bit equal to evaluated v32 whenever distance exceeds the owned
  `1.60L` terminal boundary. This establishes source-level far dormancy; it is
  not a CFD trajectory claim.
- Across `96` mirrored terminal states, both signed course miss and the new
  residual reverse sign to numerical tolerance. At the reconstructed v32
  `0.886L` within-beat closing reversal, the ordinary course-preview request is
  exactly zero while the new bounded residual is `0.2692`. At the later
  `0.765L` state whose estimated miss is about `0.697L`, the residual is
  exactly zero as designed.
- The reusable-guidance semantic check, Julia public-contract check, explicit
  parameter-schema audit, focused terminal probes, and solver editable-boundary
  audit pass. The configured check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account; its three declared
  commands were run directly and passed. No formal CFD was run.
