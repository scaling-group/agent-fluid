# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held fish at the upper-right release
  while four developed cylinder streets merge around the target. Every released
  sheet therefore starts from the same mature wake; identical trajectories are
  materialization evidence, not phase robustness.
- All sampled sheets are finite target captures, so no sampled failure keyframe
  exists. The strongest repeated parent visibly sustains a body-generated
  traveling wake, swims diagonally down-left, makes one broad correction in the
  merged wakes, and crosses the target at `45.61`. Diagnostics confirm active
  propulsion: mean x velocity is `-0.241`, versus `-0.174` mean local flow. Its
  `1.7222L` mean distance and `0.7471L` final/minimum distance are useful, but
  both joints reach the `4.538` rad/time rate cap and force/moment RMS are
  `453/4406`.
- The inherited rate-headroom variant preserves the same capture topology,
  reaches earlier at `45.10`, keeps mean distance at `1.7227L`, reduces total
  command energy from `46916` to `46677`, and lowers force/moment RMS to
  `414/4104`. Its sheet shows a slightly cleaner late approach without losing
  the traveling bend. This supports withdrawing only positive course-earned
  posterior amplification when normalized joint-rate usage is high.
- Two functionally equivalent yaw-load variants instead attenuate the entire
  signed course residual and repeat the weaker `45.84`, `1.7300L`, `460/4433`
  outcome. Because negative course feedback suppresses optional posterior
  drive, fading that negative branch can restore drive during an already-strong
  yaw event. That causal reading is a hypothesis, but the measured regression
  is enough to reject whole-signed yaw gating. The inherited collision at
  `58.93` after a below-target pass remains the nonvisual failure boundary:
  preserve the base wave and route steering rather than broadly prioritizing
  propulsion.

## Policy hypothesis

Start from the evaluated rate-headroom mechanism and make one asymmetric
separation: positive course-convergence amplification must have both actuator
rate headroom and low yaw load, whereas negative course correction remains
fully active. This combines two normalized state signals only on the optional
progress-earned tail residual. It leaves the zero-centered oscillator, lagged
posterior target, predicted-bearing half-cycle steering, steering floor,
positive-closure qualification, and smooth acceleration limiter unchanged.

The next CFD rollout falsifies the candidate if it loses `target_reached`,
meaningfully exceeds the `1.7227L` rate-gated mean-distance trajectory, arrives
later than the `45.61` parent without a material load reduction, or recreates a
low pass/collision. A fixed-snapshot success still does not establish
robustness to changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish rhythmic control
source_mechanism: separate slow route modulation from fast wake/body yaw response while preserving the propulsive rhythm
transferable_invariant: withdraw only an optional route-conditioned gait residual when measured yaw response or actuator usage is already large; do not cancel the base traveling wave or useful corrective suppression
nontransferable_details: published gains, dimensional rate and moment scales, species-specific kinematics, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: multiply only positive bearing-convergence tail amplification by smooth body-normalized yaw-load and oscillator-normalized joint-rate headroom gates; keep negative course correction and the two-joint base law intact
falsification: reject if capture or diagonal topology is lost, mean distance or arrival regresses without lower load, or rate/load symptoms remain without the sampled course benefit
