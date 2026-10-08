# Moment-residual steering with translational terminal damping

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite dynamics, and capture. There is no
  failed-termination sheet in this sample, so the repeated lower-scoring
  capture is the informative relative failure rather than a claimed collision,
  domain exit, or instability.
- I inspected the combined sheets for the sampled best
  (`solver_2acfcfa19ef8`) and prefilled parent
  (`solver_144c414f516d`) from release to capture. In both top-down rows, the
  release transient develops into a coherent alternating caudal wake that
  remains attached to a smooth target-directed arc; with zero background flow,
  this is self-propulsion rather than advection. In both oblique body/Lambda2
  rows, compact three-dimensional structures alternate behind the caudal fin
  without visible wake collapse or out-of-plane instability. The visible wake
  topology is effectively unchanged between the policies, so the best result
  is evidence for a course-response refinement rather than a new gait.
- The current parent and two other independently sourced translational
  line-of-sight variants are trajectory-identical captures at `15.768509T`,
  final/minimum distance `0.745720L`, distance integral `1.924067L`, `232`
  moving-window shifts, and score `-0.041674`. The inherited notes establish
  that this exact translational terminal signal changes only terminal-scale
  action relative to net bearing-rate damping; another terminal scalar or
  line-of-sight decomposition is not supported.
- The distinct sampled moment-residual policy retains the coherent two-view
  wake and capture while improving arrival to `15.735508T`, final/minimum
  distance to `0.744372L`, distance integral to `1.919818L`, shifts to `231`,
  and score to `-0.037222`. It advances the `8/6/4/2/1.25L` crossings by
  `0.0275/0.0330/0.0165/0.0440/0.0385T`. Mean posterior command falls from
  `25.221` to `25.012 rad/T^2`, with essentially unchanged posterior
  acceleration-limit residence (`23.58%` versus `23.59%`). The tradeoff is a
  modest increase in maximum posterior angle (`34.73` to `35.15 deg`), peak
  lateral force (`0.03329` to `0.03380`), and peak yaw moment (`0.01895` to
  `0.01920`), all still finite and within the established envelope.
- The inherited step-33 analysis found that normalized anterior joint position
  and velocity explain `95.97%` of route-regime yaw-moment variance; its
  residual opposes the reliable target redirect on `47.2%` of route samples
  and is negatively correlated with the existing yaw-rate opposition gate.
  The evaluated improvement therefore supports separating repeatable carrier
  moment from a distinct hydrodynamic steering response. In contrast, the
  inherited adverse-axial-load wave-relief candidate delayed capture and
  worsened distance integral, so this candidate does not revive that branch.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance rejection
source_mechanism: separate repeatable locomotor rhythm from hydrodynamic yaw-moment disturbance and apply bounded residual feedback
transferable_invariant: preserve the traveling-bend carrier and slow target-directed mean turn while adding authority only against a measured body-frame moment residual that opposes the requested turn
nontransferable_details: published gains, dimensional moment scales, species-specific kinematics, exact tail or vortex phase, source wake geometry, clock-defined events, and task-specific routes
policy_translation: predict normalized yaw moment from normalized anterior joint position and velocity, subtract the carrier prediction, and add bounded posterior mean curvature only when the residual opposes a reliable body-frame target redirect; fade it through approach while retaining the parent's translational terminal damper
falsification: reject if capture or any route milestone regresses, distance integral worsens, the coherent two-view wake or force envelope degrades, limiting grows without route benefit, or the moment branch merely duplicates yaw-rate or terminal response
```

## One candidate hypothesis

Keep the current parent's anterior oscillator, posterior traveling wave,
positive axial-response allocation, target/course steering, response-gated
redirect, approach shaping, exact translational line-of-sight terminal damper,
and actuator projection unchanged. Add the sampled carrier-demodulated moment
branch to posterior mean curvature. It is zero unless reliable target-directed
redirect duty is open and the measured moment residual opposes that direction;
it fades continuously with approach proximity, so it is nearly removed before
the terminal slip damper becomes active and is fully removed at the full
approach distance.

This is one small compatible combination of two response-separated roles, not
scalar-only gain tuning: evaluated route-scale moment rejection plus the
current terminal translational response. The falsifiable expectation is to
retain the sampled moment policy's earlier milestones and coherent wake while
preserving or improving its final crossing through the parent's terminal-only
slip decomposition. The new combination receives CFD only after this worker
exits, so no same-worker outcome is claimed.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `36372dfaacd09f56275a70aeaef8a17c6e736d3908b91b801166374d052e32ba`.
  The deterministic schema audit finds exactly 56 returned parameter fields
  and 56 direct `params.FIELD` names, with no difference between the sets.
- The prescribed lightweight Julia contract returns two finite accelerations.
  A mirrored active-moment probe returns exactly sign-reversed actions within
  `1e-12`, and both actions remain within the acceleration bound. This checks
  the intended lateral reflection symmetry without running CFD.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were run
  directly and separately: guidance materiality, Julia policy contract, and
  solver editable-boundary checks all pass. The first materiality run exposed
  two identical assigned-parent markers in the rendered workspace `README.md`;
  removing only the duplicate repaired that inherited metadata defect, after
  which the check passed.
- No formal CFD rollout was run; evaluation of this single candidate remains
  post-exit evidence for a later worker.
