# Dogfish L64 Second-Row Wake-Policy Experience

## Persistence contract

This file is mutable optimizer state, not a static task description. Every
successful worker must leave it with at least one material, evidence-backed
lesson added or revised from its assigned parent. Distill sampled solver results
and available inherited logs into a reusable control implication plus an
applicability or falsification boundary. When prior evidence shows no
improvement, record the concrete negative result and what later workers should
avoid or test; do not use a generic no-progress sentence or a cosmetic or
identifier-only change. The current worker's new CFD evaluation occurs after
it exits and therefore becomes evidence for a later sampled worker.

- This is a fresh 40-iteration lineage with no solver or optimizer population
  import. The same guidance is used by matched 2-, 3-, and 4-worker runs.
- The fixed task is `L64`, target `(9,9.5)L`, first-crossing radius `0.75L`,
  inflow `0.18`, held-fish prewarm `200`, released horizon `300`, and actuator
  envelope `45/260/1800` in degree-based units.
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Prefer normalized body-frame feedback changes that are bounded and carry a
  falsifiable expectation. Let evidence choose the observation and mechanism;
  do not hard-code a global-direction command, coordinates, target identity,
  elapsed time, step count, iteration number, or a case-specific route.
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
- Inspect shared prewarm and released keyframe sheets before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination.
- For the common target-blind seed, the released keyframes and diagnostics show
  a specific architecture failure: it exits the bottom boundary after `50.13`
  time units with `-13.30L` cross-stream displacement but only `-3.55L`
  upstream displacement, and its best distance (`8.61L`) regresses to
  `12.12L`.  Both joint velocities and accelerations reach their hard limits,
  so increasing oscillator gains is not a credible first repair.  On this
  failure topology, add bounded body-frame target-bearing control to the mean
  curvature of a realizable state-feedback traveling bend before introducing
  wake-phase or flow rejection.  This lesson is falsified if that curvature
  feedback turns with the wrong sign, preserves the bottom-exit topology, or
  removes the seed's upstream progress; only after target-directed motion is
  established should repeated wake-synchronous yaw reversals motivate a
  separate disturbance residual.
- Steering placement, rather than another gait scalar, changes the observed
  trajectory topology in this lineage. The assigned-parent mean-curvature
  policy survives the full horizon and halves the seed's RMS yaw moment, but
  remains in a far-right loop with only `-1.19L` upstream displacement;
  inherited logs also record two direct static-curvature variants exiting the
  right boundary in under `20` units. In contrast, two zero-mean policies that
  map body-frame bearing to state-inferred half-cycle asymmetry both reach the
  target, in `179.22` and `268.49` units. Preserve the alternating equilibrium
  and prefer half-cycle steering when a persistent curvature center loops or
  trades away thrust.
- Once zero-mean half-cycle routing works, a small normalized yaw-moment
  residual has a narrow positive operating point: the inherited `179.22`-unit
  baseline becomes a `149.57`-unit capture, and three sampled copies under the
  common prewarm reproduce `4.384L` mean distance, `16.22/314.99` RMS lateral
  force/moment, and `101995` total command energy. Adding body-frame windowed
  bearing-rate damping preserves essentially the same arrival (`149.61`) while
  improving mean distance to `4.358L`, force/moment to `15.49/308.48`, and
  energy to `96933`; its value is therefore smoother response and lower load,
  not demonstrated transit acceleration. Preserve the route-bearing owner,
  alternating equilibrium, and direct residual. Do not revive the inherited
  `1 - abs(route_turn)` headroom gate: bundled with a slower gait and higher
  load gain it exited the top boundary after `126.43` units and only `-1.12L`
  upstream travel, so it neither isolates a useful gate nor validates
  navigation from moderate load alone. A later bearing-response gate on the
  moment residual still captures but widens the route to `4.578L` mean
  distance, so bearing convergence must not label instantaneous wake yaw as
  helpful or harmful. Falsify further response gating if it loses capture or
  upstream translation, or fails to lower visible kinks, loads, and effort.
- Qualify route-response damping with actual targetward translation. Two
  otherwise identical policies that apply `bearing_window_rate` damping only
  when `window_closing_speed_L` is positive reproduce a `137.357`-unit capture,
  `4.184L` mean distance, `90228` total energy, and `14.75/303.02` RMS
  force/moment, improving the unqualified-rate result (`149.605`, `4.358L`,
  `96933`, `15.49/308.48`). This supports distinguishing useful translation
  from body spin, not an external phase model. Do not replace instantaneous
  route bearing with an eight-observation circular mean on this scaffold: the
  inherited filtered descendant still captures but regresses to `149.853`,
  `4.423L`, `100638`, and `15.58/312.62`, consistent with a blunted initial
  redirect. Retest history filtering only if a changed-wake rollout identifies
  bearing noise that outweighs this response delay. Exact common-snapshot
  replication does not establish wake-phase robustness.
- Preserve the posterior-lagged wave on the `137.357`-unit scaffold until a
  changed mechanism beats it: two opposite posterior reallocations both retain
  semantic capture but worsen every route-quality measure. Relieving phase lag
  at large bearing delays arrival to `158.147`, increases mean distance/energy
  to `4.692L/103629`, and raises force/moment to `15.66/311.93`; adding only a
  `0.1` requested-half-cycle envelope to the posterior target widens the
  visible initial loop further, delaying capture to `172.095` with `5.816L`
  mean distance, `111778` energy, and `16.39/322.27` force/moment. The latter
  also raises posterior peak acceleration from `25.552` to `27.791
  rad/time^2`, so spare actuator envelope is not evidence that more tail
  steering is useful. Avoid both target-error tail relief and extra posterior
  steering share on this route; retest posterior modulation only with an
  observed failure that localizes loss of thrust or turn authority to the
  tail. This boundary is falsified by a one-change posterior mechanism that
  preserves the alternating wave and `137.357` capture topology while jointly
  improving distance, effort, and load.
- Prefer normalized body-frame feedback. Wake phase, inflow, cylinder layout,
  and target position are intended held-out axes; coordinate memorization is
  not a valid solution.
- Treat every proposed observation as an empirical hypothesis: establish its
  scale, convention, and measurable effect from the current evidence before
  relying on it.
- Compare successful, near-miss, and failed trajectories without assuming a
  particular causal decomposition in advance.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
