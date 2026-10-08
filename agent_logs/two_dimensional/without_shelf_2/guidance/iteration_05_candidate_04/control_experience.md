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
- Do not infer steering sign from controllers that are swept out before their
  gait starts. Three positive-bearing descendants with `1.0--1.1` periods and
  `12--24 deg` amplitudes exited right in `16.27--16.73` units with only
  `0.016--0.023` upstream speed relative to local flow; later evidence
  falsifies the earlier preference for sign reversal because a propulsive
  `0.75`-period, `22 deg` positive-sign gait reaches the target. Inherited logs
  also show the combined negative-sign, `0.82`-period, `30 deg` trial becoming
  unstable in `4.45` units with RMS force/moment `5.50e4/5.68e5`. Preserve the
  positive sign while testing propulsion and steering separately; the unsafe
  reversal bundled sign with a larger gait, so falsify this boundary only with
  a propulsively comparable sign-only test that remains finite and improves
  bearing or distance.
- Once the `0.75`-period, `22 deg` energy-regulated gait supplies material
  upstream propulsion, bounded positive-bearing static curvature is useful but
  its gain benefit is not monotonic. The earlier gain/limit change from
  `0.55/8 deg` to `0.70/10 deg` shortened capture from `130.23` to `91.61`, but
  the new fixed-`10 deg` bracket at gains `0.70`, `0.75`, and `0.82` captures in
  `91.61`, `74.23`, and `83.83` units, with mean distance `2.834`, `2.561`, and
  `2.668L` and upstream-relative x speed `0.0515`, `0.0643`, and `0.0582`.
  Gain `0.75` also has the lowest RMS force/moment (`22.39/393.08` versus
  `38.81/550.75` and `36.11/515.17`) even though every sample touches the same
  action guard and has essentially the same maximum lateral target offset.
  Bracket future one-axis tuning near `0.75` rather than extrapolating gain;
  do not expand the curvature envelope from this evidence, because the
  confounded `0.80/11 deg` sample is slower (`87.63`) and raises loads to
  `52.88/687.45`. This local optimum is established only for the fixed gait and
  common wake snapshot; falsify it if repeat wake phases or held-out layouts
  make a neighboring gain consistently faster without losing capture or load
  margin.
- Avoid the sampled positive windowed-bearing-rate lead as a shortcut for
  reducing route curvature. Adding a clipped `+0.10`-horizon rate term to the
  otherwise identical successful `0.55/8 deg` controller changes capture into
  a right-boundary exit: progress falls from `0.9397` to `-0.1240`, head
  displacement changes from `(-10.93,-4.45)L` to `(+2.15,-2.23)L`, and mean
  upstream velocity relative to local flow falls from `0.0380` to `0.0223`.
  Later workers should prefer static-gain isolation until a rate term's sign
  and scale are established independently; falsify this negative lesson only
  if a rate-only comparison preserves propulsion and improves capture or
  distance without increased saturation or load.
