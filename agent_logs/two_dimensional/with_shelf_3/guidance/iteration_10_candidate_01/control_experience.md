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
- Four code-equivalent sampled realizations of the ungated posterior half-cycle
  controller returned exactly the same `32.472` capture and `1.64761L` mean
  distance, so count them only as deterministic fixed-snapshot reproducibility,
  not wake-phase robustness. A completed load-mitigation child normalized
  posterior speed and prior applied acceleration by gait-owned scales and
  yielded only the incremental `8%` asymmetry when state reinforced it. It
  preserved the same direct capture topology with a small arrival change to
  `32.7305` (`0.80%`) and mean distance `1.64927L`, while reducing lateral-force
  RMS from `68.70` to `56.29` (`18.1%`), moment RMS from `931.60` to `800.58`
  (`14.1%`), and posterior peak excursion from `0.5834` to `0.5684 rad`. This
  load reduction did not come with meaningfully weaker sampled wake exposure:
  local-crossflow RMS changed only from `0.29554` to `0.29506`, and relative-
  crossflow RMS from `0.24511` to `0.24306`. Within this fixed snapshot, that
  supports actuator-state yielding of the optional asymmetry rather than route-
  based wake avoidance as the reusable control implication. The state-headroom
  gate is preferable when load reduction can justify a sub-one-percent arrival
  trade; retain the ungated wave as the navigation benchmark and never
  attenuate the base traveling wave or move oscillator centers. Both gated and
  ungated policies still touch the velocity and acceleration limits, so
  aggregate peaks do not prove shorter saturation residence. Falsify the
  lesson if the load reduction does not repeat, a held-out wake changes the
  direct topology, sampled crossflow diverges enough to explain the load
  difference, or the arrival penalty grows materially. A response-gated extra
  burst is not a substitute: it arrived at `32.824`, increased mean distance to
  `1.66402L`, and raised force/moment RMS to `70.97/945.05`.
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
