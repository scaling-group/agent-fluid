# Step 33 target-policy diagnosis

## Evidence read before the edit

- All four sampled solver rollouts satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and stable capture
  at `0.7480--0.7495L` after `18.199--18.749T`. The combined sheets show
  released-swimmer advance, an organized alternating top-down vorticity
  street, bilateral oblique Lambda2 structures, and continuing undulation at
  capture. Propulsion is therefore self-generated and coherent rather than
  imposed advection or terminal coasting.
- No sampled solver sheet is a failure. The informative failure is the
  inherited burden-allocation exact repeat from the assigned-parent logs. Its
  top-down and oblique rows also retain an active traveling wake, but the fish
  passes below the target, turns down, reaches only `1.8544L`, and exits at
  `31.3665T` with final distance `10.1364L`. Its head/tail action clipping is
  about `70.2%/72.2%`, above the `68.46--68.48%/70.64--71.00%` of the two
  sampled exact-baseline captures. This is a terminal path/allocation failure,
  not loss of thrust.
- The assigned parent removed that failed allocator and the prefilled
  posterior pulse by restoring the exact intercept-guarded speed-reserve
  policy. Its newly available rollout captured at `0.74953L` and `18.4525T`.
  Both wake views remain coherent, terminal speed is `0.858L/T`, head/tail
  clipping is `68.46%/71.00%`, speed-limit residence is `10.49%/11.39%`, and
  peak planar force/yaw-moment coefficients are `0.0312/0.0162`. These values
  agree with the other sampled exact-baseline capture at `0.74939L` and
  `18.6010T`, rather than merely improving the scalar score.
- The prefilled posterior wave-shape pulse captures in the sampled run at
  `0.74797L` and `18.1995T`, but it is the lowest-scoring sample, does not
  improve the actuator/load envelope, and inherited exact-policy evidence
  includes a coherent-wake lower exit at `1.2589L`. Its `2/3` record remains
  weaker than the exact speed-reserve baseline, whose assigned-parent capture
  raises the inherited record from `3/5` to `4/6`.

## Candidate hypothesis

Produce one exact speed-reserve rollback candidate: remove the posterior
wave-shape parameter, helper, and tail residual from the prefill while
preserving the evaluated traveling-bend carrier, raw achieved-course servo,
intercept release veto, additive steering allocation, and sparse outward-only
carrier reserve. This is mechanism removal backed by an exact parent result,
not scalar gain tuning.

Expected result: another rollout should remain in the assigned parent's
capture, wake, load, and actuator envelope. A capture is useful repeat evidence
but does not make a `4/6` controller robust. Falsify the rollback as the useful
control if it exits, passes outside `0.75L`, loses the active terminal beat, or
materially exceeds the sampled clipping, speed-residence, force, or moment
envelope. Later workers should not re-add phase, bearing, projected-miss,
observer, or actuator-allocation residuals without a genuinely different
normalized state signature and exact-repeat benefit.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and sensor-modulated robotic-fish control
source_mechanism: preserve posteriorly lagged reactive propulsion and retain feedback additions only when observed closed-loop response improves the task
transferable_invariant: keep the active traveling bend while removing a terminal wave-shape residual that fails repeat evidence
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waves, exact vortex phases, and task-specific routes
policy_translation: restore the normalized body-frame achieved-course and intercept controller with state-conditioned carrier reserve, without the failed posterior phase pulse or burden-conditioned allocation
falsification: reject as robust if another exact rollout misses, follows the lower branch, weakens either coherent wake, or leaves the sampled load and actuator envelope
