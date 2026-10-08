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
- Treat pure-bearing steering gain as nonmonotonic for the established
  `0.75`-period, `22 deg`, `10 deg`-limited gait. Under the common prewarm,
  gain `0.75` reached in `74.23` units with mean distance `2.561L`,
  upstream-relative x speed `0.0643`, and RMS force/moment `22.39/393.08`;
  both `0.70` and `0.82` were slower (`91.61/83.83`), less compact
  (`2.834/2.668L`), and more highly loaded (`38.81/550.75` and
  `36.11/515.17`). Two duplicate same-limit `0.77` rollouts sharpen the local
  upper boundary: they took a visibly deeper, more horizontal approach and
  slowed capture to `78.58` with mean distance `2.661L` and upstream-relative
  x speed `0.0626`, despite reducing RMS relative crossflow from `0.1292` to
  `0.1201` and mean power proxy from `45.38` to `43.71`. Use `0.75/10 deg` as
  the finite interior anchor and do not trade route closure for lower crossflow
  or effort alone. In particular, two behaviorally identical lower-side
  `0.745` probes falsified the prior quadratic-interpolation hypothesis: both
  visibly overshot below the compact corridor, slowed capture to `86.99`,
  raised mean distance to `2.694L`, reduced upstream-relative x speed to
  `0.05865`, and increased RMS force/moment to `39.84/540.72`. Do not continue
  fitting or finely interpolating static gain on this single deterministic wake
  snapshot; preserve `0.75` while isolating a different controller dimension,
  or test robustness across held-out wake phases before claiming a smooth local
  optimum. The `0.80/11 deg` result cannot isolate gain because its limit
  changed too. Falsify this boundary if controlled held-out phase or geometry
  tests make the local gain response smooth and reproducibly move the optimum
  away from `0.75` without increasing excursion or load.
- Treat acceleration-guard contact as nonlinear route shaping, not proof of
  under-actuation. Against the duplicated common-`28 rad/time^2` anchor
  (`-0.661705` score, `74.23` arrival, `2.561L` mean distance, `0.06433`
  upstream-relative x speed, and RMS force/moment `22.39/393.08`), the assigned
  parent's global-`29` probe took a visibly deeper late correction and
  regressed to `80.00`, `2.658L`, `0.05804`, and `33.84/488.89`; posterior
  acceleration reached the new guard. The sampled posterior-only `27` probe
  improved configured score and mean distance slightly to `-0.654416` and
  `2.555L`, but it also slowed arrival to `76.44`, reduced upstream-relative x
  speed to `0.06199`, and raised loads to `24.69/417.71`. Two inherited
  evaluations of the proposed posterior midpoint `27.5` decisively falsify
  interpolation across that mixed boundary: both took a visible deep lower
  excursion and return, slowed capture to `95.96`, raised mean distance to
  `2.806L`, reduced upstream-relative x speed to `0.05344`, and increased RMS
  force/moment to `51.98/665.46`, even though joint state remained finite and
  the target was eventually reached. Preserve anterior authority at `28`, do
  not tune a clipping guard as a continuous route-control knob on this wake,
  and reject semantic success when distance closure and load regress together.
  Instead test a separately bounded mechanism that reduces competing steering
  and oscillatory demand before saturation, while retaining the exact `28/28`
  or score-leading `28/27` setting as an evaluated baseline. This negative
  boundary applies to the common deterministic prewarm; falsify it only if
  controlled held-out wake phases make posterior authority monotone or a
  replicated interior guard improves score, closure, and load together.
- Do not treat lower commanded motion as direct hydrodynamic-load regulation
  for this route-sensitive gait. Relative to the evaluated `28/27` parent, the
  assigned parent's normalized `5%` turn-amplitude reduction lowered command
  energy from `53200` to `51887` and reduced both peak joint speeds, yet slowed
  capture from `76.44` to `79.70`, raised mean distance from `2.555L` to
  `2.594L`, reduced upstream-relative x speed from `0.06199` to `0.06073`, and
  increased RMS force/moment from `24.69/417.71` to `28.03/438.71`; its sheet
  retained the lower late approach. An independent posterior-damping increase
  from `0.65` to `0.675` on the `28/28` anchor was more harmful: it visibly
  deepened the late correction, slowed capture from `74.23` to `91.50`, raised
  mean distance from `2.561L` to `2.788L`, reduced upstream-relative x speed
  from `0.06433` to `0.05262`, and raised RMS force/moment from
  `22.39/393.08` to `42.13/581.11`. Preserve the evaluated `22 deg` amplitude
  and `0.65` posterior damping while isolating a different response dimension;
  do not continue monotone amplitude-throttling or damping sweeps without
  time-resolved evidence that route topology remains compact. This negative
  result applies to the common deterministic prewarm and bearing-only steering
  structure; falsify it if replicated or held-out wake phases reduce load and
  effort together without sacrificing capture, relative propulsion, or route
  closure.
