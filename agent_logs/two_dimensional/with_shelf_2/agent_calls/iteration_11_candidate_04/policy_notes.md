# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held fish in the upper-right while
  four developed cylinder streets merge around the target. The released sheets
  therefore compare controllers under the same mature wake initialization.
- All four sampled rollouts are active, semantic successes rather than passive
  advection: they sustain a body-generated traveling wake, swim continuously
  down-left through the interacting streets, and reach the `0.75L` target in
  `45.48--45.61` time units. Their upstream mean body speed is about `0.24`,
  larger than the local-flow magnitude `0.174--0.177` in that direction.
- The prefilled normalized-positive-closure controller reaches at `45.48` with
  score `0.156386`, mean distance `1.724L`, total command energy `47033`, and
  force/moment RMS `405/4029`. The strongest sampled architecture additionally
  uses bearing convergence only on the small closure-earned tail residual. Its
  three identical replays retain the same diagonal topology, improve score and
  mean distance to `0.158830` and `1.722L`, and reduce energy to `46916`, but
  reach slightly later at `45.61` and raise force/moment RMS to `453/4406`.
  Exact replay establishes fixed-snapshot materialization, not wake robustness.
- Both variants touch the `4.538` rad/time hard rate limit on both joints. The
  course multiplier is therefore a useful but loadlier residual, not evidence
  for more posterior amplitude. No current sampled failure sheet is available.
  Inherited failures supply the boundary: weakening steering for propulsion
  passed below capture and collided, while an aligned-closure phase-lag shift
  retained success but regressed to score `0.146573`, arrival `46.22`, mean
  distance `1.735L`, and force/moment RMS `424/4253`. Do not repeat a lag-sign
  swap or weaken the proven route composition without sign-resolved evidence.

## Candidate hypothesis

Materialize the strongest course-convergence architecture, then add one compact
joint-state mechanism. Normalize the larger observed joint-rate magnitude by
the candidate's own oscillator rate-amplitude scale and use a smooth headroom
gate only on positive course-convergence amplification. Negative course trend
continues to suppress the closure-earned tail residual exactly as before; the
base traveling bend, normalized-closure bonus, predicted-bearing steering, yaw
load gate, and smooth acceleration limiter are unchanged. Thus high rate usage
blends only the loadlier positive course bonus toward the simpler successful
normalized-closure policy instead of clipping harder or coasting.

The next CFD rollout falsifies this candidate if it loses `target_reached` or
the diagonal topology, scores below `0.156386`, raises mean distance above the
simpler `1.724L` baseline, or fails to reduce the course controller's rate/load
symptoms while preserving its distance benefit. Same-snapshot success would
not establish robustness to changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and wake-interaction control
source_mechanism: preserve a propulsive rhythm while feedback schedules a small residual instead of replacing the gait or cancelling all lateral motion
transferable_invariant: keep the evidenced traveling bend and route law intact, and withdraw only extra progress modulation when normalized actuator-state usage indicates little headroom
nontransferable_details: published gains, dimensional rates, robot linkage geometry, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: normalize maximum observed joint rate by oscillator amplitude times frequency; gate only positive bearing-convergence amplification of the closure-earned posterior residual while retaining negative course correction and the base two-joint law
falsification: reject if capture or useful topology regresses, if score falls below or mean distance rises above the simpler closure baseline, or if cap contact and hydrodynamic load remain without the sampled course benefit
