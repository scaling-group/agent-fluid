# Carrier-demodulated yaw-moment rejection candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts and the assigned-parent rollout satisfy the
  frozen direct-uniform still-water contract: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite dynamics, and capture. I inspected the
  sampled-best, sampled-prefill, and assigned-parent combined keyframe sheets
  from release through capture. In both the top-down vorticity rows and the
  oblique body/Lambda2 rows, the release transient becomes a compact,
  alternating three-dimensional caudal wake behind a self-propelled fish; the
  fish follows a smooth target-directed arc without wake collapse, collision,
  virtual-boundary exit, or out-of-plane instability. No failed-termination
  sheet is present in the allocated sample, so the assigned parent's weaker
  finite capture and the inherited logged regressions are the informative
  negative controls rather than a claimed visual failure.
- The prefilled axial-force allocator captures at `15.768509T`, with
  `1.924071L` distance integral, `0.745725L` final distance, `232` moving-window
  shifts, and score `-0.041679`. Three independently sourced sampled policies
  that replace only the final net-bearing-rate damper with exact translational
  line-of-sight rate retain the same capture step, every route milestone, all
  `232` shifts, and byte-identical sheets; their approximately `4.2e-6L`
  distance-integral change is terminal numerical scale, not route diversity.
- The assigned parent adds adverse-axial-load base-wave relief to the same
  carrier. Its two-view wake remains coherent and it still captures, but
  capture moves to `15.785009T`, distance integral to `1.925588L`, final
  distance to `0.747963L`, and score to `-0.043610`. Relative to the prefill,
  relief therefore delays arrival by `0.016500T`, worsens the integral by
  `0.001516L`, and moves the crossing outward by `0.002238L`. Lowering feasible
  posterior action on an adverse body-force lobe is not route-neutral; do not
  continue tuning its force threshold or relief fraction.
- A trace fit on the prefilled capture gives a distinct usable observation.
  Over the route regime (`t>4T`, distance `>2L`), normalized anterior joint
  position and velocity explain `95.97%` of yaw-moment variance with a
  reflection-odd linear carrier model. The residual has 5th/50th/95th
  percentiles `-0.00329/0.00008/0.00304`, and it opposes the reliable requested
  redirect on `47.2%` of route samples. A smooth residual-moment opposition
  gate is negatively correlated (`-0.31`) with the existing residual-yaw-rate
  opposition gate, so it provides anticipatory hydrodynamic response support
  rather than another terminal line-of-sight decomposition.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: separate the repeatable locomotor rhythm from a fast hydrodynamic moment disturbance, then apply bounded feedback only against the residual disturbance
transferable_invariant: preserve the traveling-bend carrier and slow target-directed mean turn while rejecting only a measured body-frame yaw-moment residual that opposes the requested turn
nontransferable_details: published CPG gains, dimensional moment scales, species-specific kinematics, exact tail or vortex phase, source wake geometry, clock-defined events, and task-specific routes
policy_translation: predict normalized yaw moment from normalized anterior joint position and velocity, subtract that carrier prediction, and add a small bounded posterior mean-curvature correction only when the residual moment opposes an already reliable target-directed redirect; fade the correction through the established near-target approach while leaving propulsion and the proven terminal law unchanged
falsification: reject if capture or any route milestone regresses, distance integral worsens, the coherent two-view wake or force envelope degrades, posterior limiting grows without route benefit, or the residual correction merely reproduces the existing yaw-rate or terminal gates

## One candidate hypothesis

Keep the prefilled anterior oscillator, posterior traveling wave, positive axial
force allocation, target/course steering, response-gated redirect, approach,
terminal shaping, mean-first allocation, and exact actuator projection
unchanged. Add one reflection-equivariant hydrodynamic moment-residual branch
to posterior mean curvature. The branch is zero unless course reliability has
already opened the existing raw redirect gate and measured non-carrier yaw
moment opposes its direction. It is continuously removed through the existing
near-target proximity schedule, so the evaluated terminal controller is not
reopened.

The carrier-moment coefficients and residual scale are trace-derived normalized
quantities, not transferred literature gains. The curvature ceiling is smaller
than the existing yaw-rate correction because moment is an anticipatory, less
direct response signal. The falsifiable expectation is earlier route
milestones or a lower distance integral with the same capture and wake
topology. Reduced moment or command statistics alone do not count as success.
Formal CFD occurs only after this worker exits, so no outcome for this candidate
is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `06b3f382ced6cf7bb2f48a04aa9bfdd2424def5efcbbdf2a38ce039a2e885a27`.
  Static schema validation resolves all 56 direct `params.FIELD` names against
  exactly 56 fields returned by `target_policy_params()`, with no missing or
  unused field. The prescribed lightweight Julia contract returns two finite
  accelerations.
- A deterministic 20,000-state sweep across target side and distance,
  body-frame velocity, force and moment, bearing and yaw response, and joint
  phase returns finite bounded commands with zero lateral-reflection error. A
  non-finite moment probe returns a finite action by selecting the predicted
  carrier-moment path.
- Counterfactual evaluation on reconstructed prefill states changes 418
  posterior commands and no anterior commands. Changed support extends from
  the soft opening of the reliability gate through `0.823L`; the largest
  posterior change is `2.7701 rad/T^2`, mean changed-command magnitude is
  `0.3129 rad/T^2`, and no new acceleration-limit hit appears. This establishes
  non-clamp-equivalent feasible-action support, but it does not predict the
  unevaluated closed-loop hydrodynamic response.
- The guidance-materiality check, lightweight Julia policy contract, and
  solver editable-boundary check pass. The first materiality run exposed two
  identical assigned-parent markers in the rendered workspace `README.md`;
  removing only the duplicate repaired that inherited metadata defect without
  changing the assigned parent. The configured check-runner was invoked after
  the edits, but its pinned `gpt-5.4-mini` model is unavailable for this
  account; its three prescribed commands were therefore run directly and
  pass. No CFD was run.
