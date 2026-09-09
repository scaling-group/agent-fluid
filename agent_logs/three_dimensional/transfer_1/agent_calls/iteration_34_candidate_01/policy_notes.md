# Step 34 target-policy diagnosis

## Evidence read before the edit

- All four sampled solver rollouts satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and capture at
  `0.7480--0.7495L` after `18.1995--18.7495T`. Two are exact bytes of the
  intercept-guarded speed-reserve baseline, one is the prefilled posterior
  wave-shape pulse, and one transfers terminal steering anteriorly. They are
  therefore four successes but not four confirmations of either variant.
- The highest-score sampled baseline (`solver_6b0e320e2f55`) and the prefilled
  pulse (`solver_591f46d260e7`) both show a sustained alternating top-down
  vortex street and bilateral oblique Lambda2 structures through capture.
  Continued body undulation at the final frame, inertial travel in directly
  initialized stationary water, and stable diagnostics identify productive
  self-propulsion rather than advection, collision, or numerical instability.
  The pulse's earlier `2/3` exact-policy record and absence of a load or
  actuator benefit still falsify retaining it from this one sampled capture.
- The assigned parent's `dogfish3d_progress_loss_redirect_v1` is now evaluated.
  Its combined sheet has the same organized early wake, but after a
  `1.2402L` closest pass at `18.8320T` its trajectory continues below the
  target and exits the lower boundary at `31.2290T`, `10.1095L` away. The
  failure is not a stall: final inertial speed is about `0.775L/T`, joints and
  commands remain active, and the run is stable. Thus a closing-speed trigger
  correctly detects the missed pass, but replacing additive steering with
  same-signed two-joint mean-curvature control does not provide recovery.
- An inherited completed rollout of `dogfish3d_outer_unsupported_bearing_v1`
  captured at `0.74975L` and `18.3205T`. Its top-down and oblique sheets retain
  the same active traveling wake as the sampled baseline. This is one positive
  compatibility result, not robustness evidence; unlike the failed recovery,
  it has not yet received an exact-policy repeat.

## Candidate hypothesis

Restore the exact successful `dogfish3d_outer_unsupported_bearing_v1` bytes,
removing the falsified posterior pulse and the assigned parent's failed
progress-loss redirect. The controller preserves the repeat-backed carrier,
intercept guard, steering allocation, and speed reserve. Its only additional
mechanism is a reflection-equivariant target-bearing qualifier that is admitted
in the outer terminal annulus only when achieved-course error is near zero; it
is absent in the far field, when course feedback is already informative, and
inside the interception corridor.

This iteration tests reliability of an already positive mechanism rather than
adding another unvalidated residual. Confirm usefulness only if this exact
repeat captures while preserving both wake views and the sampled actuator/load
envelope. Falsify it as a robust repair if the repeat misses or follows the
same lower-exit branch; do not respond to failure by scalar-tuning its gain or
gates.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking over a rhythmic CPG carrier
source_mechanism: target-vector-to-bounded-curvature feedback layered on an independently sustained propulsive oscillator
transferable_invariant: retain a target-side cue when achieved-course feedback is momentarily uninformative without replacing or suppressing the traveling bend
nontransferable_details: published gains, dimensional cadence, CPG phase equations, robot morphology, species kinematics, route geometry, and exact terminal timing
policy_translation: exactly repeat the normalized body-frame unsupported-bearing qualifier in the outer terminal annulus while preserving the two-joint carrier, allocation, speed reserve, and inner intercept guard
falsification: reject robustness if the exact repeat misses, retains the lower branch, weakens the top-down or oblique wake, or moves clipping, speed residence, force, or moment outside the repeat-backed envelope
```

## Dry checks after the edit

- Candidate SHA-256 is
  `3265a7883db6fef3024a08b1b27b3f691751843a48f8dbda262052818d17d901`,
  exactly matching the completed `0.74975L` capture selected for repetition.
- The deterministic schema guard finds all `45` referenced `params.FIELD`
  names among the `47` fields returned by `target_policy_params()`; none are
  missing. The guidance-semantic and editable-boundary checks pass.
- The mandated Julia contract probe could not execute because this worker
  runtime has no Julia binary. Exact policy-byte identity to the previously
  executed finite capture supplies stronger-than-static syntax provenance, but
  the new closed-loop repeat remains future CFD evidence.
