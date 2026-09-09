# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the relevant assigned-parent rollouts report
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, and active moving-window shifts. Their translation
  and wakes are released-swimmer behavior rather than ambient advection.
- The current samples contain two exact
  `dogfish3d_intercept_guarded_speed_reserve_v1` captures at
  `0.7485--0.7494L` after `18.287--18.601T` and two exact
  `dogfish3d_speed_reserve_posterior_wave_shape_v1` captures at
  `0.7480--0.7492L` after `18.199--18.469T`. Scores and mean distances overlap;
  neither sampled mechanism is superior on those scalar metrics.
- The inherited logs change the robustness conclusion. An exact posterior-
  pulse replay missed below at `1.2589L`, and exact speed-reserve replays
  missed below at `1.7276L` and `1.6463L`. The posterior residual is therefore
  `2/3` and the exact baseline is `3/5` across the evidence available here;
  neither threshold-crossing policy should be called robust.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  highest-scoring sampled baseline capture, a sampled posterior-pulse capture,
  and the assigned parent's newest full-terminal-veto failure. All three fish
  visibly self-propel and retain an organized alternating mid-plane street and
  compact bilateral three-dimensional structures. The failed fish passes
  below at `1.0757L` and continues beating to the lower boundary. This is
  terminal path sensitivity, not passive transport, carrier collapse, or
  numerical instability. Metrics agree: capture occurs near `0.83--0.90L/T`,
  while the full-veto failure still travels about `0.83L/T` at closest pass.
- The full-terminal projected-corridor veto improved the inherited miss
  distance to `1.0757L` but still failed semantically. Its instantaneous
  target/velocity projection is strongly beat dependent: in both captures and
  misses the reconstructed projected miss alternates between inside and well
  outside the corridor over adjacent carrier phases. Earlier evidence likewise
  showed terminal lateral velocity correlating `-0.937` to `-0.961` with
  anterior joint speed. A projection veto must therefore express observation
  confidence rather than act continuously.

## One candidate hypothesis

Remove the falsified posterior wave-shape residual and retain the evaluated
speed-reserve carrier, achieved-course turn command, additive steering, and
original `2.75--2.0L` intercept guard. Add one observation-confidence
mechanism ahead of its full authority: throughout the existing terminal-
response region, the projected corridor may veto response-conditioned steering
release only near anterior-joint reversal, when normalized anterior speed
indicates that the dominant gait-synchronous lateral-velocity component is
small. At fast carrier phase the pre-gate projection is ignored. Across the
original `2.75--2.0L` blend it occupies only the complement of the distance
gate, and at `2.0L` inward the original compatible-intercept veto has full
authority.

This is neither half-cycle actuator reallocation nor scalar steering tuning.
Joint state qualifies an observation; it does not weight carrier or steering
acceleration. Recorded-trace replay of the release equation leaves terminal
mean release within `0.0015` of the baseline on all five available capture
traces, while reducing it from about `0.035--0.041` to `0.024--0.035` on the
baseline, phase-observer, and full-veto lower-exit traces. That is a contract
and selectivity check only, not a counterfactual CFD result.

Expected test: preserve the far-field path and both active wake views, retain
the sampled capture-speed and actuator/load envelope, and prevent premature
pre-gate release without the persistent oversteering of the failed full veto.

Falsification: reject the phase-qualified projection and restore the exact
speed-reserve baseline if it loses capture, changes motion outside `4L`,
weakens either wake view, retains the same lower-exit topology, or worsens
clipping, speed-limit residence, force, or yaw moment. Do not answer a miss by
tuning only the phase thresholds or by stacking the failed posterior pulse,
mean-curvature servo, course compensation, yaw brake, or full veto.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and rhythmic swimming with gait-correlated lateral motion
source_mechanism: separate a persistent target/interception request from fast rhythmic motion while preserving the posteriorly lagged propulsive wave
transferable_invariant: gait-contaminated achieved-motion feedback should affect steering only when joint state makes that observation physically trustworthy
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, explicit oscillator or vortex phase, world-frame routes, and task-specific coordinates or distances
policy_translation: use normalized anterior joint speed as a clock-free confidence signal for the body-frame target/velocity projection before the existing intercept guard, without changing the two-joint carrier or steering allocation
falsification: reject if capture, far-field closure, wake coherence, or the repeat-supported actuator and load envelope degrades, or if the lower-exit topology remains
