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
- Across the common prewarm state, bounded body-frame bearing-to-mean-curvature
  feedback converted the seed's `50.13`-time lower exit and `8.61L` closest
  approach into two target captures at `42.86` and `39.74` release time. The
  faster allocation expressed one `12 deg` total-curvature budget as only
  `5.4 deg` anterior and `6.6 deg` posterior center bias; an anterior-heavy
  `10/5 deg` implementation instead moved downstream, made negative progress,
  and exited after `18.68`. For this target-blind-oscillator failure topology,
  preserve the lagged traveling component and distribute a bounded target-
  signed curvature request across both joints rather than recentering primarily
  at the anterior joint. The causal boundary is the shared wake phase and the
  coupled difference between implementations: retain this lesson only while a
  held-out or repeated rollout preserves target capture, turn sign, and
  propulsion, and test saturation residence and load histories before claiming
  robustness or efficiency.
- Do not interpret small wake-response magnitudes as successful disturbance
  rejection in this lane. The immediate downstream-exit failure saw only
  `0.045` RMS relative crossflow and `299` RMS moment, whereas both captures
  traversed the developed wake at `0.215-0.227` crossflow and `713-762` moment.
  Add a flow/force residual only after keyframes identify a repeatable
  target-directed trajectory that is specifically lost during wake events;
  falsify it if capture, upstream propulsion, or loads worsen.
- Treat feedback that moves the oscillator centers as part of the propulsion
  loop, even when the nominal gait parameters are unchanged. An inherited
  additive bearing-trend candidate retained the declared `0.55/28 deg` rhythm
  but reached only `0.140/0.163 rad` peak joint excursions and `8.64` mean
  command energy, moved downstream, made negative progress, and exited after
  `16.956` with a `12.424L` closest approach; its released sheet shows no
  developed traveling bend. Do not reuse an unrestricted bearing-rate term
  upstream of the joint centers. If route-trend feedback is revisited, bound
  it relative to the persistent target error and gate it by observed joint
  activity; reject it if upstream propulsion, target capture, or the proven
  diagonal trajectory is not preserved. The aggregate rollout cannot isolate
  the exact center/oscillator interaction, so removal or safeguarded replay is
  required before treating that mechanism as causal.
- Once bearing-conditioned `40/60 -> 35/65` allocation of a bounded total
  curvature already captured at `35.0625` release time, a joint-state-inferred
  posterior half-cycle gain of at most `8%` preserved the same compact diagonal
  topology and improved capture to `32.472`, mean distance from `1.73388L` to
  `1.64761L`, and score from `0.140088` to `0.224538`. Its lower total command
  energy (`46,288` versus `50,175`) came from the shorter episode: mean command
  energy and power were nearly unchanged, both joints still touched velocity
  and acceleration limits, and force/moment RMS rose from `56.57/793.76` to
  `68.70/931.60`. A different half-cycle mechanism that modulated curvature
  allocation instead captured later at `35.431` despite lower loads, so phase-
  dependent mechanisms are not interchangeable. Reuse small target-gated
  posterior-wave asymmetry when arrival and distance integral justify the load
  tradeoff; do not label it efficient or robust. Falsify it if a repeat or
  held-out wake loses capture or the direct route, or if load and saturation
  residence rise without an earlier arrival.
- When that `8%` posterior half-cycle residual is already active, recent
  target-bearing improvement is not evidence that another positive burst is
  needed. A response-release extension kept capture but worsened arrival from
  `32.472` to `32.824`, mean distance from `1.64761L` to `1.66402L`, score from
  `0.224538` to `0.208280`, force/moment RMS from `68.70/931.60` to
  `70.97/945.05`, and visibly widened the late body wake. Two independently
  evaluated, code-equivalent direction-selective headroom gates instead
  reproduced the same compact capture at `32.7305`, mean distance `1.64927L`,
  and score `0.223211`, while reducing force/moment RMS to `56.29/800.58` and
  posterior peak excursion from `0.5834` to `0.5684 rad`; nearly unchanged
  local and relative crossflow RMS shows that aggregate load relief did not
  come from avoiding the developed wake. If that `0.80%` arrival trade is
  acceptable, gate only the incremental residual when posterior motion
  reinforces it, normalized by the gait's own velocity and acceleration
  scales. Do not substitute an undirected physical-limit gate: it delayed
  capture to `33.9405` and scored `0.181716`. Treat the exact repeat as fixed-
  snapshot reproducibility, not wake-phase robustness, and falsify the
  mechanism if the base traveling wave, direct capture, load reduction, or
  reduced saturation residence fails in a held-out wake.
- Keep response evidence at the same optional-residual locus as normalized
  target-window progress rather than creating another withdrawal layer. Three
  code-identical progress supervisors reproduced the compact diagonal capture
  at `32.340`, mean distance `1.63773L`, score `0.234663`, force/moment RMS
  `65.12/888.56`, and posterior excursion `0.57530 rad`. One sampled extension
  allowed either coherent closure or a gait-qualified combination of correct-
  sign heading response and shrinking bearing to supervise that same residual;
  it preserved the visible route and improved to `32.318`, `1.63741L`,
  `0.234705`, `65.52/881.45`, and `0.57481 rad`. The improvement is marginal,
  force did not fall, and both joints still reached the velocity and
  acceleration ceilings, so it supports single-locus response supervision but
  not more authority or an efficiency claim. In contrast, two reproduced
  combinations with an independent response-confirmed mean-curvature release
  regressed to `32.4555`, `1.64548L`, `0.226804`, and `67.83/914.09` without a
  different useful trajectory. Keep distributed mean curvature and the unit-
  gain traveling wave outside the supervisor, treat the response result as
  fixed-snapshot evidence until repeated, and falsify it if replay loses the
  small navigation gain, if loads rise without earlier arrival, or if a held-
  out wake loses capture, the direct topology, or propulsion.
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
