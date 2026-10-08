# Evidence-selected carrier-residual yaw opposition

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and capture
  after `2,919` steps. I inspected the top-down mid-plane-vorticity and oblique
  body/Lambda2 rows for the assigned prefill `solver_ed6d64fbfa4b` and the
  distinct strongest sample `solver_d9f2302868e3`; the other two samples are
  byte-identical to the prefill in policy, combined keyframes, and metrics. In
  both distinct sheets the fish is self-propelled, establishes an alternating
  red/blue wake by about `4T`, retains a traveling posterior bend and compact
  three-dimensional shed structures through capture, and avoids passive
  advection, boundary interaction, wake collapse, and instability. The yaw
  variant changes the route and terminal pose without sacrificing the coherent
  two-view wake.
- The prefill and its two replicas capture at `16.0545T`, cross at
  `0.744345L`, have distance integral `1.938857L`, and score `-0.055617`.
  `solver_d9f2302868e3` subtracts a joint-phase prediction from normalized
  heading rate and adds posterior mean curvature only when the residual yaw
  opposes a speed-reliable target redirect. It preserves the same capture time
  while advancing the `8/6/4/2/1.25L` crossings from
  `9.2015/11.1540/13.0130/14.9050/15.6035T` to
  `9.0750/11.0440/12.9195/14.8005/15.5320T`, lowering distance integral to
  `1.931257L`, and improving score to `-0.048654`. Its terminal crossing is
  shallower at `0.747530L`, so the evidence supports route acceleration rather
  than better terminal centering.
- The positive route change has a bounded cost. Versus the prefill, the yaw
  variant slightly lowers whole-rollout posterior acceleration-limit residence
  (`22.47%` to `21.86%`) and mean posterior command (`24.89` to
  `24.62 rad/T^2`) without increasing peak yaw moment (`0.01945` to
  `0.01903` in the logged normalization), but raises approach-only posterior
  limit residence (`23.98%` to `34.05%`) and posterior angle excursion
  (`0.553` to `0.636 rad`). It remains inside the `45 deg` angle envelope and
  is not a clamp-equivalent command cleanup because its trajectory, window
  shifts (`229` to `239`), milestones, heading, and wake sheet all differ.
- The assigned-parent optimizer log proposed signed terminal-intercept mean
  curvature after a fixed-trace replay predicted only 25 feasible posterior
  command changes and lower approach limiting. Its completed evaluation
  `solver_b4b0e0b88895` instead regressed from the replicated prefill's
  `-0.055617`, `0.744345L` capture to `-0.056917`, `0.745590L`. Together with
  inherited failures from posterior-wave and mean-steering corridor edits,
  this rejects another geometric terminal correction despite locally
  promising replay. The sampled carrier-subtracted yaw response is the only
  current mechanism with positive closed-loop route evidence.

## Policy hypothesis

Replace the prefill with the evaluated `solver_d9f2302868e3` controller while
preserving its anterior state-feedback oscillator, carrier-phase-residual
redirect selector, raw target-versus-course turn direction, one-sided opposing
wave relief, mean-first posterior allocation, response-subordinate approach
settling, intercept-conditioned anterior damping release, and exact
speed-boundary projection. Add only its carrier-residual yaw-opposition branch:
predict the reflection-odd beat-scale heading rate from normalized anterior
joint angle and velocity, subtract that carrier, and apply bounded posterior
mean curvature only when the remaining yaw opposes a target-directed redirect
after forward speed is reliable. Aiding residual yaw receives zero additional
authority.

The expected result is the already evaluated distinct route, coherent wake,
capture, earlier distance milestones, and lower distance integral of
`solver_d9f2302868e3`, rather than another scalar adjustment or terminal
wrapper. Falsify selection if the downstream evaluation does not reproduce
capture and the earlier milestones, if either wake view loses coherence, if
posterior angle/approach limiting grows beyond the sampled envelope, or if the
shallower terminal crossing turns into a near miss. This worker does not claim
new CFD evidence; evaluation occurs after exit.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and wake-disturbance residual control
source_mechanism: separate repeatable locomotor yaw from task-response yaw, then reject only the residual motion that opposes target-directed turning
transferable_invariant: preserve the rhythmic carrier, predict its reflection-odd body response from normalized joint phase, and add bounded feedback only when the carrier-subtracted response opposes a measured route correction
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, prescribed oscillator or vortex phase, source-task disturbance spectra, exact capture radii, and task-specific routes
policy_translation: subtract a bounded anterior-joint-state prediction from heading-rate normalized by carrier frequency; gate a small posterior mean-curvature residual by forward-speed reliability, the existing target redirect, and opposition sign while leaving aiding yaw and the propulsive wave unchanged
falsification: reject if carrier subtraction breaks lateral reflection equivariance, acts without reliable target-directed translation, cancels useful aiding yaw, weakens either wake view, loses capture or earlier milestones, or raises terminal limiting and angle excursion beyond the sampled benefit

## Non-CFD verification after the policy edit

- The final policy SHA-256 is
  `ec7aaed22fc3e0b6fee4c441b76dea5a54c9dc8f39f2003be085ebcf0dd0920e`,
  byte-identical to the evaluated `solver_d9f2302868e3` source. This establishes
  exact evidence-selected reuse, not a same-worker CFD result.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported for this ChatGPT account. Its first check
  exposed a duplicate assigned-parent marker in the rendered `README.md`;
  removing only the duplicate restored unique provenance. All three prescribed
  checks then passed when run directly and separately: material guidance,
  lightweight Julia policy contract, and solver editable boundary. No CFD was
  run.
- Static schema inspection finds all `41` direct `params.FIELD` references in
  the object returned by `target_policy_params()`, with no unused declared
  controller fields. A deterministic `6,561`-state sweep over joint state,
  exact speed boundaries, target side, bearing, lateral velocity, and heading
  rate returns finite bounded actions, zero outward acceleration at either
  exact joint-speed boundary, and machine-exact zero lateral-reflection error.
