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
- Do not fit or interpolate the pure-bearing steering-gain response as though
  it were smooth on the common wake snapshot. With the `0.75`-period,
  `22 deg`, `10 deg`-limited gait fixed, duplicated gain `0.75` rollouts
  reached in `74.23` units with `2.561L` mean distance, `0.06433`
  upstream-relative x speed, and RMS force/moment `22.39/393.08`; duplicated
  gain `0.77` rollouts regressed to `78.58`, `2.661L`, `0.06261`, and
  `23.77/393.44`. More decisively, two inherited evaluations of the proposed
  quadratic-interpolation gain `0.745` took a visibly deeper route below the
  target and regressed to `86.99`, `2.694L`, `0.05865`, and `39.84/540.72`.
  Retain exact gain `0.75` as the same-snapshot anchor and avoid further
  sub-percent gain interpolation until wake phase is varied or time-resolved
  evidence explains the route switch. This does not prove a universal optimum;
  falsify it if controlled held-out wake phases or geometries recover a smooth
  ordering or move the finite optimum.
- Treat acceleration-guard contact and interpolation as nonlinear route
  shaping, not direct hydrodynamic-load regulation. Against three identical
  `28/28 rad/time^2` anchor rollouts (`74.23` arrival, `2.561L` mean distance,
  `0.06433` upstream-relative x speed, `50940` command energy, and RMS
  force/moment `22.39/393.08`), the isolated `28/27` guard reached more slowly
  at `76.44`, reduced relative speed to `0.06199`, increased energy to `53200`,
  and raised loads to `24.69/417.71`; its keyframes show a lower final
  correction, even though mean distance and scalar score improved slightly.
  More decisively, the inherited `28/27.5` midpoint did not interpolate these
  endpoints: it visibly took a much deeper lower route and regressed to
  `95.96` arrival, `2.806L` mean distance, `0.05344` upstream-relative x speed,
  `64918` energy, and `51.98/665.46` force/moment. The inherited opposite-side
  common-guard increase to `29` also regressed arrival, relative propulsion,
  and loads. Preserve exact `28/28` as the same-snapshot physical anchor and
  avoid further static guard interpolation until clipping timing or held-out
  wake phase explains the route branches; require arrival, relative-flow
  separation, effort, and load to corroborate any scalar gain. This boundary
  applies to the deterministic common prewarm and does not establish a
  universal guard optimum: falsify it if time-resolved or held-out-wake tests
  find a posterior limit that reproducibly reduces load without losing compact
  capture or upstream-relative propulsion.
- Separate constant damping from damping localized by normalized posterior
  speed. The inherited constant increase `0.65 -> 0.675` lowered posterior peak
  speed from `3.225` to `3.145 rad/time` but selected a visibly deeper, kinked
  route and regressed arrival, mean distance, relative propulsion, energy, and
  force/moment from `74.23/2.561L/0.06433/50940/22.39/393.08` to
  `91.50/2.788L/0.05262/60660/42.13/581.11`. In contrast, on the newer static
  `tail_steering_gain=0.70` anchor, keeping base damping `0.65` and adding at
  most `0.025` only near `abs(qd2)/(omega*amplitude)=1` with transition `0.08`
  preserved the compact visual route, improved arrival and mean distance from
  `72.457/2.4541L` to `70.823/2.3854L`, raised upstream-relative x speed from
  `0.06620` to `0.06972`, cut energy from `51842` to `50756`, lowered
  force/moment from `23.85/408.89` to `22.72/397.24`, and reduced posterior
  peak speed from `3.293` to `3.260`. Anterior peak speed did rise modestly
  from `3.086` to `3.112`, so use the exact normalized gate as a same-snapshot
  positive point, not evidence that more damping is monotone or that speed
  transfer is free. Any continuation or composition must retain compact
  capture and improve arrival, relative-flow separation, effort, and loads;
  falsify this implication if held-out wake conditions reverse those aggregate
  gains or if anterior motion/load grows materially while only tail speed
  falls.
- Treat posterior sharing of the bounded steering center as route shaping, not
  a monotone static knob. Across fixed gains `0.60 -> 0.65 -> 0.70`, mean
  distance tightened `2.4800 -> 2.4638 -> 2.4541L`, but arrival, propulsion,
  effort, and loads were non-monotone; three byte-identical `0.70` rollouts
  count as one deterministic result, not robustness. The inherited static
  `0.75` continuation then took a less compact final route, regressing mean
  distance/energy from `2.4541L/51842` to `2.5093L/52496` and posterior peak
  speed from `3.293` to `3.370`, despite partial arrival, propulsion, and load
  gains. A bounded schedule using the evaluated `0.65` share only at large
  bearing demand and recovering `0.70` when aligned avoided that static
  regression: it reached in `71.615`, with `2.4241L` mean distance, `0.07111`
  upstream-relative x speed, `51250` energy, and `23.26/402.06` force/moment,
  all better than the static `0.70` anchor, though posterior peak speed rose
  slightly to `3.299`. Preserve the exact demand schedule as a same-snapshot
  positive point and do not extrapolate its endpoints or blend power. Any
  composition remains an interaction test and must retain compact topology
  while checking both joint speeds, distance, relative propulsion, effort, and
  loads. This boundary is falsified if held-out wake phase, geometry, inflow,
  or target placement reverses the schedule's aggregate gains.
