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
- The sampled siblings now validate one narrow steering translation: adding a
  bounded, same-sign body-frame bearing residual directly to the seed's
  `0.55`-period acceleration carrier reached `0.7496L` after `62.304` time
  units with head displacement `(-10.922,-4.153)L`. The target-blind seed
  instead exited downward after `50.127`; an opposite-signed curvature-center
  translation exited after `13.915` with negative progress; and a wholesale
  slower/smaller curvature-center carrier became unstable after `121.517`
  with RMS force/moment `16749.8/290421`. Preserve the successful carrier,
  steering sign, and acceleration-residual interface before testing a new
  mechanism; avoid interpreting slower scalar gait settings or an abstract
  curvature bias as interchangeable with the validated residual. This lesson
  is bounded to the shared prewarm case and is falsified if a later wake phase
  loses target reach with the same residual topology.
- Four independently sampled evaluations of the steering-prioritized
  allocator reproduce the same success metrics exactly: `49.142` arrival,
  `2.1560L` mean distance, `62522/1272.3` total/mean command energy,
  `0.2301` RMS relative crossflow, and `39.05/617.13` RMS force/moment. Their
  released sheets likewise show the same sharp initial redirect followed by a
  long upstream traverse. In contrast, the inherited lower-effort
  curvature-equilibrium replacement used mean command energy `419.1` but
  terminated unstable at `121.517` with force/moment RMS
  `16749.8/290421`. Treat the repeated success as a deterministic same-prewarm
  baseline for one-mechanism comparisons, not evidence of wake-phase
  robustness or permission to rank effort alone. The baseline still touches
  both joint speed and acceleration limits, so retain a new structural
  feedback only if it preserves target reach and leftward propulsion while
  improving effort, load, limit contact, or route compactness; falsify any
  robustness claim until a changed wake phase or held-out layout also succeeds.
- Two same-prewarm, one-mechanism children now expose an objective tradeoff
  around that deterministic allocator baseline. Scheduling the reserved
  steering share upward with absolute body-frame bearing improves arrival
  from `49.142` to `46.035`, mean distance from `2.1560L` to `2.0695L`, and
  total/mean command energy from `62522/1272.3` to `56948/1237.1`, but raises
  RMS force/moment from `39.05/617.13` to `51.40/761.46`. Course-slip damping
  instead reaches in `48.032` with lower RMS force/moment `37.92/605.38`, but
  its mean command energy rises to `1299.7` and mean distance is `2.1003L`.
  Because both retain the same coherent redirect-and-upstream trajectory and
  still touch joint-speed and `30.0` command limits, treat large-bearing
  reserve scheduling as an arrival/effort mechanism and course-slip damping
  as a load/route mechanism, not as interchangeable generic steering gains.
  Do not claim a combined benefit without a direct rollout; falsify either
  interpretation if a changed wake phase loses capture, or if the respective
  arrival/effort or load advantage disappears.
- Half-cycle asymmetry is a redirect/route-compactness mechanism, not a
  terminal-distance mechanism. Relative to the inherited raw-bearing-reserve
  plus course-slip controller, the joint-state-aligned half-cycle translation
  improves arrival `45.727 -> 36.471`, mean distance `2.0543L -> 1.6860L`,
  and total command energy `57829 -> 48700`; three independently sampled
  copies reproduce the latter rollout exactly. The tradeoff is higher mean
  command energy (`1264.7 -> 1335.3`) and force/moment RMS
  (`49.36/799.31 -> 63.59/953.42`), with both joint-speed and `30.0`
  acceleration limits still touched. Fading only the extra asymmetry with
  distance down to a `0.20` fraction near capture leaves the keyframe route
  visually unchanged and changes arrival by only `-0.0165`, total energy by
  `-21.3`, and force/moment RMS by `-0.33/-2.83`, while slightly worsening
  mean distance and score. Do not treat a near-target distance taper as a new
  control capability here; test response-, limit-, or disturbance-gated
  release if lowering half-cycle load, and require capture plus a meaningful
  arrival/distance or load change. This boundary is limited to the shared
  prewarm and is falsified if a changed wake phase makes terminal taper
  materially affect capture or route topology.
- Localize response feedback to the transient redirect mechanism rather than
  feeding it into persistent route steering. Against three exactly reproduced
  base-asymmetry successes, scheduling only the extra half-cycle burst with
  recent bearing closure improves arrival `36.471 -> 34.821`, mean distance
  `1.6860L -> 1.6270L`, and total command energy `48700 -> 47151`, while
  raising mean command energy `1335.3 -> 1354.1` and force/moment RMS
  `63.59/953.42 -> 77.09/1142.74`. The inherited predictive-bearing child
  instead put bearing trend into the mean route residual and exited after
  `18.304` with negative progress. Preserve raw-bearing ownership of mean
  steering and reserve; treat response-gated burst as an arrival/route
  mechanism with a load penalty, and test fast load- or limit-aware release
  only on the extra burst. This is bounded to the shared prewarm and is
  falsified if a changed wake phase loses capture, or if response gating no
  longer improves arrival/route while keeping persistent steering intact.
- Treat actuator-pressure release for a coupled traveling bend as one coherent
  maneuver modulation, not two independent joint-local steering schedules.
  The assigned parent recorded two exact coherent-release copies; the current
  sample raises that to three independently sampled policies using maximum
  normalized two-joint speed as one release signal. All three reach in
  `34.7105` with `1.62283L` mean distance, `46985.9` total command energy, and
  `68.96/1036.40` force/moment RMS. Independent per-joint release instead
  reaches in `34.8590` with `1.62681L`, `47176.8`, and `74.24/1105.81`, despite
  slightly lower mean command energy (`1353.36` versus `1353.65`); inherited
  logs also show that gating moment credit by one targetward joint phase raises
  load further to `82.35/1231.74`. Preserve carrier, mean steering, base
  asymmetry, and signed-moment ownership while sharing only optional-burst
  release. An inherited speed-only gate regressed arrival and load, so this is
  not evidence that speed is a standalone wake proxy; the lesson applies only
  to the compatible response-and-moment mechanism and is falsified by failed
  replication, lost capture under a changed wake phase, or a genuinely
  joint-specific mechanism benefiting from independent gating.
- At the coherent-release plateau, relative crossflow is an evidenced
  route/effort response, but neither it nor lateral force is an unloading cue.
  Replacing bearing-window closure with targetward relative crossflow preserves
  the visible redirect-and-traverse route while improving arrival
  `34.7105 -> 33.9460`, mean distance `1.62283L -> 1.60066L`, and total effort
  `46985.9 -> 46092.2`; force/moment RMS nevertheless rise from
  `68.96/1036.40` to `85.04/1244.16`. Requiring co-signed normalized lateral
  force to confirm that crossflow improves arrival, mean distance, total
  effort, and score again (`33.7260`, `1.59412L`, `45776.3`, `0.278591`), but
  raises loads further to `93.64/1383.73`. Targetward local-flow substitution
  is slightly weaker on route and score and reaches `94.55/1395.74` loads;
  inherited direct-force credit regresses the coherent baseline to `34.9415`,
  `1.63256L`, and score `0.240755`. Thus use force agreement only as a
  crossflow-confidence/selectivity mechanism, never as evidence of reduced
  loading, and avoid standalone force or local-flow replacement when seeking
  this route benefit. Preserve the carrier, raw-bearing route request, base
  asymmetry, moment response, and coherent speed release. This conclusion is
  bounded to the common prewarm and is falsified if the arrival/distance/effort
  ordering fails to repeat or a changed wake phase loses capture; further load
  relief needs a distinct fast mechanism and must actually reduce loads or
  limit contact without erasing route compactness.
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
