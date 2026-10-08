# Evidence-constrained multi-wake policy selection

## Pre-edit visual diagnosis

- The assigned parent and all four sampled solvers contain the same policy
  (`452903db...`). Their trajectories (`84ec5c93...`) and combined keyframe
  sheets (`6d2c1aa...`) are also byte-identical, so this population supplies
  one reproducible physical trajectory rather than four mechanism tests. Each
  rollout starts directly from uniform still water with
  `U_infinity=(0,0,0)`, has no cylinders or prewarm, and captures after
  `16.604496T` and 237 moving-window shifts at `0.743958L`, with
  `1.998146L` distance integral and score `-0.113729`.
- I inspected the combined sheet from release through capture in both views.
  The top-down row shows a shallow target-closing arc and an alternating
  red/blue vorticity street connected to the posterior body. The oblique row
  shows compact alternating three-dimensional Lambda2 structures following
  the tail and traveled path. With zero imposed flow, this is self-propulsion,
  not advection. Neither row shows collision, wake breakup, instability, or a
  recentering-aligned discontinuity.
- The metrics agree with the image: distance falls monotonically into the
  first-crossing radius, final inertial velocity is
  `(-1.10010,-0.27006)U`, and the fish remains on an active but finite beat at
  capture. The endpoint speed and yaw are not a diagnosed hold error because
  the objective has no dwell requirement.
- No distinct failed keyframe sheet exists in the sampled or inherited
  artifacts. The valid failure contrast is metric-level: inherited terminal
  yaw release, posterior relief, projected-corridor, target-rate, moment, and
  local-flow-residual descendants preserved finite wakes but failed to improve
  the demonstrated capture. The nearest changed terminal release crossed one
  step earlier yet regressed crossing depth, distance integral, and score to
  `0.744276L`, `1.998380L`, and `-0.114037` without a meaningful feasibility
  or load benefit.
- Four exact current rollouts and four completed inherited selections all
  traverse 237 integer-cell storage shifts without a changed trajectory or a
  visible two-view wake discontinuity. Storage recentering therefore does not
  identify a physical disturbance for a new feedback channel in this lane.

## Sole candidate and falsifiable hypothesis

Retain the prefilled normalized body-frame two-joint controller byte-for-byte
as the sole candidate. It preserves the demonstrated traveling-wave carrier,
raw target geometry, mean-preserving yaw and lateral-response demodulation,
phase-compatible posterior steering, smooth acceleration bound, and narrow
one-sided speed guard. The evidence supplies no nonduplicate failure or new
body-frame response deficit that would justify changing this successful route;
adding a terminal, fluid-residual, or moving-window compensation would repeat
a negative family, while scalar-only tuning is not a mechanism.

This is an evidence-constrained null translation, not a same-worker claim of
CFD improvement. Formal evaluation should reproduce capture, route cost,
crossing depth, arrival, two-view wake connectivity, joint feasibility,
effort, force, and moment. Falsify preservation if that nominal envelope does
not reproduce. Reopen one compact bounded primitive only after a completed
nonduplicate or held-out pose, target, flow, or imposed-wake rollout exposes a
repeatable body-frame error.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish direction control, and wake-interaction control
source_mechanism: preserve a productive posterior-lagged carrier and recruit a separate bounded steering or disturbance channel only for an observed response deficit
transferable_invariant: repeated carrier-correlated motion or storage recentering is not itself a control error; retain an evidenced traveling carrier until body-frame observations identify a persistent propulsion, route, or response deficit
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, fixed schedules, world-frame coordinates, storage-shift timing, and task-specific routes
policy_translation: null translation; retain the existing normalized two-joint carrier and response separation because the only supplied trajectory captures and completed terminal or residual perturbations regress route quality
falsification: test one bounded state-feedback primitive only after a nonduplicate or held-out rollout isolates its target error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All numerical comparisons above come from completed assigned, sampled, or
inherited evaluations. The current candidate receives formal CFD only after
this worker exits. Exact nominal repetition establishes determinism, not
robustness to a changed pose, target, inflow, or imposed wake; the absence of a
failed image is not treated as an image-level failure comparison.
