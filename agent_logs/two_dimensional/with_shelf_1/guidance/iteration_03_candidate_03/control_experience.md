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
- The naive posterior-lag oscillator is a usable propulsion scaffold but not a
  navigation law: it moved the head `-3.55L` in targetward world x and briefly
  reduced target distance to `8.61L`, yet accumulated `-13.30L` lateral
  displacement and exited the lower domain after `50.13` released time units.
  The sampled controller comparison resolves the useful steering interface:
  a positive, bounded body-frame bearing residual added directly to the
  `0.55`-period acceleration carrier reached the target in `62.304` time with
  head displacement `(-10.922,-4.153)L`, whereas shifting a slower/smaller
  oscillator's angle equilibrium stayed far from the target and became
  unstable after `121.517` time with force/moment RMS `16749.8/290421`.
  Preserve the direct acceleration-residual sign and carrier before testing a
  new mechanism; do not treat curvature-center steering or scalar gait changes
  as interchangeable. Falsify this lesson if the residual loses target reach
  under a changed wake phase despite retaining coherent propulsion.
- A steering-reserved carrier/residual mixer is a validated improvement over
  symmetric episode clipping in the sampled common prewarm: a candidate-owned
  `30.0` acceleration envelope with `0.20` steering reservation shortened
  capture from `62.304` to `49.142` time, improved mean distance from `2.460L`
  to `2.156L`, and reduced mean command energy from `1436.3` to `1272.3`, while
  retaining target reach and capping acceleration below `31.416`. Both versions
  still touched the `4.538` joint-speed cap, and the bounded version modestly
  increased force/moment RMS from `27.25/525.79` to `39.05/617.13`; maxima do
  not establish saturation duty. Preserve the mixer before testing a
  normalized velocity-aware carrier guard, and retain such a guard only if it
  reduces speed contact, effort, or loads without losing or materially
  delaying capture.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
