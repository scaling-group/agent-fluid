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
- Closure-conditioned yielding of only the optional posterior residual moved
  the direction-selective headroom gate from `32.7305` to `32.3400` release
  time and score `0.223211` to `0.234663`, but spent part of its load relief:
  force/moment RMS rose from `56.29/800.58` to `65.12/888.56`. Three
  code-identical evaluations reproduced the latter capture and metrics exactly
  on the certified snapshot. Adding a second, independent release condition—
  developed normalized joint activity plus agreement between targetward
  heading response and shrinking body-frame bearing—preserved the same visible
  direct route and improved only marginally to `32.3180`, mean distance
  `1.63741L`, score `0.234705`, and moment RMS `881.45`, while force RMS rose
  slightly to `65.52` and relative crossflow stayed effectively unchanged.
  Thus response-confirmed residual yielding is a compact, propulsion-preserving
  supervisor, not evidence for stronger asymmetry or wake cancellation. Reuse
  it only on the optional half-cycle residual; do not release mean curvature or
  the unit-gain traveling wave. Treat the tiny advantage as fixed-snapshot
  evidence with diminishing returns: before adding more response cues or
  tuning their scalar thresholds, require a held-out wake to preserve capture,
  route topology, and the speed/load tradeoff, and reject the mechanism if
  loads or saturation rise without an earlier arrival or lower distance
  integral.
- At the same closure-supervised optional posterior residual, extending the
  target-signed yaw-load cue with target-signed body-frame lateral force
  preserved the compact self-propelled diagonal and improved capture from
  `31.5645` to `30.4865`, mean distance from `1.60525L` to `1.56766L`, score
  from `0.266663` to `0.302848`, mean command energy from `1420.86` to
  `1416.41`, and force/moment RMS from `66.32/887.63` to `65.80/872.96`.
  Relative-crossflow RMS fell from `0.24105` to `0.23534`, and peak joint
  excursions fell from `0.5191/0.5555` to `0.5094/0.5190 rad`, although both
  joints still touched the velocity and acceleration limits. Each branch was
  reproduced exactly in two independent evaluations on the certified
  snapshot, so reuse measured target-aligned force as permission to withdraw
  only redundant incremental steering—not as a disturbance to cancel or a
  reason to weaken mean curvature or the unit-gain traveling wave. This is
  fixed-phase evidence for navigation and modest load relief, not desaturation,
  efficiency, or robustness; falsify it if a held-out wake loses the route or
  capture, or if loads and saturation rise without earlier arrival or a lower
  distance integral.
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
