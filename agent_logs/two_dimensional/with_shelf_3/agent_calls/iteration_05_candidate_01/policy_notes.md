# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The common prewarm sheet shows the fish held above four fully developed,
  interacting vortex streets; it is shared initial-condition evidence. In the
  two equation-identical filtered `40/60` released sheets, the fish rotates
  toward the body-frame target, sustains a visible posterior traveling wake,
  crosses the interacting streets diagonally, and first enters the target
  circle without collision or terminal overshoot. Both evaluations replay
  exactly: score `0.112158`, capture at `35.6895`, mean distance `1.76192L`,
  mean command energy `1425.38`, force RMS `59.28`, and moment RMS `821.23`.
- The instantaneous-bearing `40/60` sample preserves the same successful route
  topology with lower relative-crossflow, force, moment, and mean command
  energy (`0.220`, `45.93`, `670.16`, and `1295.37`), but capture is later at
  `37.9554` and mean distance is worse at `1.85834L`. The filtered estimator is
  therefore supported as a navigation-speed mechanism, not a load-reduction
  mechanism. The filtered `45/55` sample is also slower (`36.5640`) and more
  heavily loaded (`66.17/901.74` force/moment RMS), so the `40/60` split is the
  stronger filtered result rather than an arbitrary allocation retune.
- The assigned parent's inherited notes proposed adding a bounded
  `bearing_window_rate` term to release filtered steering while target bearing
  converged. Its completed rollout falsifies that additive translation. The
  failure sheet shows no sustained body-generated wake and a short downstream
  drift away from the cylinders and target, followed by `left_domain` at
  `16.9564`. Metrics agree: progress `-0.14697`, minimum distance `12.4239L`,
  head displacement `(+2.1748,-0.8736)L`, only `0.140/0.163 rad` peak joint
  excursions, and mean command energy `8.64`. Low load here is propulsion
  collapse, not efficient wake rejection.
- The failure is especially relevant because the parent's nominal gait,
  history filter, and curvature scaffold matched successful policies. The new
  semantic difference was subtracting a fast target trend inside the same
  bearing signal that supplies initial curvature to the autonomous joint-state
  oscillator. The evidence does not identify an isolated scalar threshold;
  it establishes that this cancellation-capable route composition is unsafe
  without an independently evidenced propulsion bootstrap or non-cancelling
  gate.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking and organized-wake fish interaction
source_mechanism: separate persistent target-directed modulation of a rhythmic gait from fast alternating body-frame motion
transferable_invariant: a slow body-frame route estimate may steer a traveling bend, but faster residual feedback must not cancel the excitation that sustains propulsion
nontransferable_details: published gains, dimensional frequencies, robot or species geometry, exact vortex phase, full-body kinematics, source-task routes, and cylinder-specific timing
policy_translation: use the sampled circular history of normalized body-frame bearing to set one bounded total-curvature command shared across both joint attractors; retain the evidenced state-feedback traveling bend and omit the falsified additive bearing-rate residual
falsification: reject this candidate if it loses first-crossing capture, fails to reproduce the compact diagonal trajectory, or materially worsens arrival and mean distance relative to the two deterministic filtered 40/60 samples; treat unchanged elevated effort and load as a known boundary rather than evidence of attenuation

## Candidate hypothesis

The candidate makes one semantic change from the prefilled instantaneous
`40/60` controller: it extracts persistent route error with an exponentially
weighted circular mean over the supplied bearing history. It otherwise retains
the successful `0.55`-period, `28 deg` state-feedback traveling bend, posterior
lag, `12 deg` total-curvature budget, and coherent posterior-weighted split.
Every active quantity remains owned by `target_policy_params`; the controller
uses neither time nor coordinates, wake phase, cylinder identity, or a fixed
route.

This is deliberately not another bearing-rate repair. The assigned parent's
completed rollout shows that the cancellation-capable derivative composition
destroyed reachability, while two current sampled evaluations directly support
the selected filtered equations. Later evaluation should first confirm target
capture, arrival, distance integral, and the visible traveling wake. It should
also remeasure saturation, command effort, force, and moment; this candidate
does not claim that the known navigation gain solves the load tradeoff.
