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
- When an ungated residual and a direction-selective headroom gate share the
  same compact route, treat them as bounded control branches rather than
  repeatedly replaying either one. Four sampled ungated rollouts captured at
  `32.472` with `68.70/931.60` force/moment RMS, while the assigned parent and
  inherited completed headroom records captured at `32.7305` with
  `56.29/800.58`; three consecutive inherited completions added no new
  semantic result. The next informative structural test may use slow,
  normalized target-window trajectory efficiency only to supervise withdrawal
  of the optional posterior residual: restore the ungated value during
  redirection, lateral target-vector motion, stalled closure, or recession,
  and permit the lower-load gate during coherent closure. Keep mean curvature
  and the unit-gain traveling wave outside that supervisor, and do not route a
  target-rate term into oscillator centers. This is a bounded test implication,
  not evidence that the hybrid has succeeded; falsify it if capture or the
  direct topology is lost, it is worse than the completed headroom branch on
  both navigation and loads, or held-out conditions expose switching or
  propulsion loss.
- Target-aligned body yaw moment can be informative as a withdrawal cue even
  when it does not reduce aggregate load. Replacing a separate target-response
  gate with bounded, progress-conditioned yaw-load yielding at the same
  optional posterior residual improved capture from `32.318-32.340` to
  `31.5645`, mean distance from `1.63741-1.63773L` to `1.60525L`, and score
  from `0.234663-0.234705` to `0.266663`, while preserving the compact
  traveling-wave route. Relative-crossflow RMS remained comparable
  (`0.24105` versus `0.24339-0.24372`), mean command energy changed little,
  and force/moment RMS `66.32/887.63` did not improve jointly over the
  response-gated `65.52/881.45` branch, so this is evidence for faster closure,
  not Karman synchronization, efficiency, or load relief. Reuse a signed
  body-frame load only under coherent target closure and only to withdraw an
  incremental residual; keep distributed mean curvature and the unit-gain
  traveling wave outside the gate. Four byte-identical sampled policies,
  keyframe sheets, and metric records now reproduce the `31.5645` result
  exactly; this establishes deterministic fixed-snapshot repeatability, not
  changed-phase robustness or another semantic improvement. Inherited blanket
  headroom and cross-layer gate compositions were slower or worse on both
  navigation and loads, so a later structural test should remain at this
  single residual locus: aligned yaw may permit withdrawal, while opposing yaw
  may continuously veto actuator-state withdrawal and restore no more than the
  already successful ungated residual. This two-sided arbiter is a test
  implication, not an evaluated result. Falsify it if held-out wakes lose
  capture or the direct topology, if beat-scale switching appears, or if loads
  rise without retaining a navigation benefit.
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
