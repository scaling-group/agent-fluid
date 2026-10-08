# Carrier-demodulated moment-lead redirect candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture. I inspected the combined sheets
  for the best finite result and the only numerically distinct, lower-scoring
  control from release through termination. The top-down rows show the release
  transient developing into a coherent alternating lateral wake and a smooth
  target-directed arc; with zero background flow, the motion is self-propelled
  rather than advected. The oblique body/Lambda2 rows show persistent compact
  three-dimensional caudal structures without wake collapse, collision,
  virtual-boundary exit, or out-of-plane instability. The two sheets differ
  below visual resolution, so the trajectory and load traces, not vortex
  appearance alone, determine the hypothesis.
- Three distinct policy source hashes are executable-equivalent apart from
  comments and produce byte-identical trajectories and combined sheets. Each
  captures at `15.768509T`, uses 232 moving-window shifts, reaches final
  distance `0.745720148L`, and has distance integral `1.924067164L`. The
  axial-response parent without exact translational line-of-sight terminal
  damping has the same arrival step and all `8/6/4/2/1.25/0.9L` milestones,
  with final distance `0.745725095L` and distance integral `1.924071330L`.
  Thus the replicated terminal observation change is positive only at crossing
  scale; it is not route diversity and does not justify another terminal
  threshold, curvature scalar, or equivalent line-of-sight decomposition.
- The inherited logs show the same boundary more broadly: several terminal
  phase/onset variants either changed only a few samples, reproduced a prior
  path, or regressed, while the genuinely new axial-force posterior allocator
  advanced later route milestones and capture. The assigned-parent guidance
  therefore supports preserving propulsion, redirect direction, terminal
  shaping, and all proven authority limits while testing a distinct measured
  response that can act over the established route.
- The sampled trace exposes one such dynamic-order gap. Raw normalized yaw
  moment correlates `0.9723` with same-sample measured yaw acceleration. Over
  the established `t>=4T` carrier, a reflection-odd linear prediction from
  normalized anterior angle and velocity explains about `96.0%` of raw moment
  mean-square energy. After subtracting a rounded two-term carrier prediction,
  the moment residual's correlation with the future derivative of the existing
  carrier-demodulated yaw-rate residual rises from `0.172` at the current
  sample to `0.374` six samples (about `0.033T`) later. Correlation is not proof
  of beneficial control, but it supports a falsifiable lead-response test. A
  `0.003` residual scale is approximately the established carrier's 90th
  percentile residual magnitude; replayed gate support spans the route rather
  than only the terminal fraction of a beat.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: wake-interaction disturbance rejection and sensor-modulated robotic-fish CPG control
source_mechanism: separate repeatable locomotor-carrier loading from a fast hydrodynamic yaw disturbance, then use only the residual to modulate bounded direction tracking
transferable_invariant: preserve the traveling-bend carrier and target-defined mean turn while a normalized body-frame response residual selects existing steering authority only when the response opposes the requested turn
nontransferable_details: published gains, species-specific kinematics, exact vortex or tail phase, Karman-gait timing, source moment scales, cylinder locations, dimensional frequencies, and task-specific routes
policy_translation: subtract a reflection-odd anterior-joint prediction from normalized yaw moment; use the opposing residual as an anticipatory alternative to the existing yaw-rate opposition gate, take the maximum of those gates inside the same reliable redirect envelope, and retain the same supplemental curvature ceiling and terminal release
falsification: reject if capture, earlier distance milestones, distance integral, coherent two-view wake, limiting, or force/moment envelopes regress; also reject if the moment branch changes no feasible action, merely duplicates the yaw-rate gate, or creates carrier-phase steering when target-directed redirect duty is absent

## One candidate hypothesis

Keep the assigned-parent anterior oscillator, axial-force posterior allocation,
cruise and high-authority redirect laws, wave relief, approach shaping, exact
translational line-of-sight terminal damping, and actuator projections intact.
Add one carrier-demodulated moment-lead selector to the existing supplemental
yaw-curvature branch. The predictor uses only normalized anterior joint angle
and velocity; a non-finite moment produces zero residual. The branch opens only
when reliable target-directed redirect duty already exists and the residual
moment predicts yaw acceleration opposite that requested turn. If measured
yaw-rate opposition is already stronger, the command is unchanged. Taking the
maximum of the old and new selectors prevents stacking beyond the existing
`4 deg` curvature envelope, and the established terminal response still
releases the supplement.

This is a new response-feedback mechanism, not scalar-only gain tuning. Its
falsifiable expectation is that moment lead advances at least one established
route milestone or reduces distance integral while retaining capture and the
coherent wake, without exceeding the parent's supplemental steering authority.
Lower command effort or moment correlation without target-progress benefit is
not success. Formal CFD occurs only after this worker exits, so no rollout
outcome for the candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `301deb24f8ce56ace6f75ba8a6cf2b39f15e4aba5a7c5e2bfd8d162cea4057c3`.
  Static schema validation resolves all 55 direct `params.FIELD` references
  against exactly 55 fields returned by `target_policy_params()`, with no
  missing or unused field. The lightweight Julia contract returns two finite
  accelerations.
- A deterministic 20,000-pair sweep across target side and distance,
  body-frame velocity, axial/lateral force, yaw moment, bearing/yaw response,
  and joint phase returns finite bounded commands with exactly zero lateral-
  reflection error. A non-finite moment probe remains finite and removes the
  new residual path.
- Counterfactual execution on all 2,867 assigned-parent states changes 103
  posterior commands and no anterior commands, only from
  `4.179998-14.410007T` and `11.606835-2.240986L`. Mean and maximum changed-
  command differences are `2.316` and `7.905 rad/T^2`. The candidate creates
  no new exact posterior acceleration-limit hit and removes nine on this
  frozen replay. This establishes feasible route-scale, non-clamp-equivalent
  action support; it does not predict the unevaluated closed-loop trajectory.
- Guidance materiality, the finite contract, parameter ownership, and solver
  editable-boundary checks pass locally. The configured check-runner was
  invoked after both required evidence files changed, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account; its three
  prescribed commands were therefore run directly and pass. No CFD was run.
