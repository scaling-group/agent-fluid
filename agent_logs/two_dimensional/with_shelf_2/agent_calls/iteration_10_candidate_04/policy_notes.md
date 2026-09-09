# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held fish in the upper-right and
  the same four developed, interacting cylinder streets for every rollout.
  Released-route differences therefore come from controller output rather than
  a changed wake initialization.
- All four sampled released sheets show active self-propulsion: each policy
  sustains a body-generated traveling wake, follows a continuous diagonal
  down-left path through the merged streets, and crosses the `0.75L` target
  circle in `45.48--46.66` release-time units. Their mean upstream body
  velocities near `-0.24` exceed local upstream flow magnitudes
  `0.172--0.177`, so the useful motion is not passive advection.
- The prefilled dimensional signed-closing envelope succeeds at `46.66`, with
  score `0.150223`, mean distance `1.731L`, total command energy `47725`, and
  force/moment RMS `453/4371`. The body-speed-normalized positive-closure
  sibling reaches earlier at `45.48` with score `0.156386`, mean distance
  `1.724L`, energy `47033`, and lower `405/4029` RMS load. This supports a
  normalized progress ratio rather than another dimensional closing threshold.
- The strongest sampled finite policy adds a bounded bearing-convergence check
  only to that small closure-earned posterior bonus. It raises score to
  `0.158830`, lowers mean distance to `1.722L` and total energy to `46916`, and
  retains the same capture topology at `45.61`. The tradeoff is force/moment
  RMS `453/4406`, about `12%/9%` above the simpler normalized-closure sibling;
  both also touch the `4.538` joint-rate limit. Thus this is a modest
  route-efficiency result, not evidence for more posterior authority.
- No current sampled failure sheet exists: all four examples terminate at the
  target. Inherited logs provide the negative contrasts. A phase-lag-shift
  child retained success but regressed to score `0.146573`, arrival `46.22`,
  and mean distance `1.735L`; an earlier propulsive-priority allocator passed
  below capture and collided. Those results rule out stacking a lag shift or
  weakening the complete route-steering composition in this candidate.

## Candidate hypothesis

Materialize the strongest sampled architecture as the single candidate.
Preserve the zero-centered anterior oscillator, predicted-bearing half-cycle
steering, yaw-moment magnitude gate, smooth limiter, and aligned posterior
traveling wave. Replace the prefill's dimensional signed-closing modulation
with positive windowed closure normalized by observed body speed. Modulate
only the closure-earned posterior residual by the bounded sign of normalized
`bearing * bearing_window_rate`: shrinking bearing magnitude permits the small
bonus, while growing cross-track error relaxes it. Missing history is neutral,
and neither the base traveling wave nor target-steering residual is changed.

This materialization is falsified if the next rollout loses `target_reached`,
does not reproduce the useful diagonal topology and approximately
`45.61`/`1.722L` arrival/mean-distance result, or if its load increase over the
simpler normalized-closure sibling recurs without the sampled score, energy,
and distance benefit. Success in the fixed snapshot does not establish
robustness to changed wake phase, inflow, layout, or target.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: preserve rhythmic propulsion while bounded body-frame route feedback schedules only a small propulsion-envelope residual
transferable_invariant: grant extra posterior wave emphasis for normalized range closure only while observed body-frame direction error is also converging
nontransferable_details: published gains, dimensional rates, robot linkage geometry, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: keep the two-joint traveling bend and yaw-gated half-cycle steering; use body-speed-normalized positive closure and bearing-error trend to bound only the closure-earned posterior bonus
falsification: reject if capture or diagonal topology is lost, if arrival and mean distance regress, or if rate-limit contact and hydrodynamic load increase without the sampled score and energy benefit
