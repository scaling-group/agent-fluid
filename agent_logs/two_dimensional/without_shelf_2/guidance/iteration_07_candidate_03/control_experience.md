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
- This no-Bookshelf ablation provides no cross-domain research shelf. Derive
  mechanisms only from the task contract, inherited guidance, sampled solver
  results and logs, and current rollout evidence; do not search for or
  reconstruct the omitted shelf.
- Inspect shared prewarm and released keyframe sheets before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination.
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
- Do not treat large displacement as useful propulsion when body motion nearly
  matches local-flow advection. In the only sampled seed, mean velocity
  `(-0.0725,-0.2633)` was close to mean local flow `(-0.0414,-0.2414)`; its
  target-blind `0.55`-period beat ran at `32.83` times the estimated shedding
  frequency, hit both acceleration caps, and still exited laterally with only
  `0.02425` progress. Later candidates should not preserve that oscillator
  unchanged: add bounded target-relative heading correction and require
  improved distance progress plus velocity-flow separation without persistent
  saturation. This single failure does not establish an optimal beat period;
  falsify the lesson if the unchanged target-blind mechanism produces stable,
  material relative propulsion and target progress from the common prewarm.
- Do not infer steering sign from under-driven descendants. Although three
  positive-bearing/positive-curvature controllers with `1.0--1.1` periods
  exited right in `16.27--16.73` units with only `0.016--0.023` upstream speed
  relative to local flow, a propulsive positive-sign controller at `0.75`
  period and `22 deg` amplitude reached the target in `130.23` units with
  `0.9397` progress, `0.0380` mean upstream-relative x speed, joint angles
  below `0.523 rad`, and finite RMS force/moment `26.34/427.54`. In contrast,
  the inherited negative-sign `0.82`-period, `30 deg` candidate visibly
  coiled/spun and failed as `unstable_dynamics` after `4.45` units, with RMS
  relative crossflow `3.139` and force/moment `5.50e4/5.68e5`. Use the
  successful positive-sign, energy-regulated envelope as the current anchor;
  avoid combining sign reversal with higher amplitude until steering sign is
  isolated at comparable propulsive authority and lower load. This conclusion
  applies to the common prewarm snapshot and does not isolate sign from gait
  tuning; falsify it if a propulsively comparable negative-sign controller is
  finite, reduces bearing, and improves target approach, or if the positive
  anchor fails across held-out wake phase or geometry.
- Treat pure-bearing steering gain as wake-sensitive and nonmonotonic for the
  established `0.75`-period, `22 deg`, `10 deg`-limited gait. Under the common
  prewarm, gain `0.75` reached in `74.23` units with mean distance `2.561L`,
  upstream-relative x speed `0.0643`, and RMS force/moment `22.39/393.08`.
  Same-limit probes on both sides regressed: `0.745` visibly dipped below the
  direct corridor and corrected upward, reaching in `86.99` with `2.694L`,
  `0.05865`, and `39.84/540.72`, while duplicated `0.77` rollouts reached in
  `78.58` with `2.661L`, `0.06261`, and `23.77/393.44`; wider probes `0.70`
  and `0.82` were also slower and more highly loaded. Do not fit or interpolate
  a gain optimum from this sparse bracket: retain exact `0.75/10 deg` as the
  common-snapshot steering anchor and isolate propulsion or posterior-gait
  changes next. The `0.80/11 deg` result cannot isolate gain because its limit
  changed too. This anchor is not a general optimum; falsify the lesson if a
  controlled held-out wake-phase, geometry, or inflow test moves the finite
  compact-route advantage, or if a same-limit gain probe improves both route
  metrics without a load increase.
