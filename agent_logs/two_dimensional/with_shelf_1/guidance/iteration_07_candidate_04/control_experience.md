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
- Keep persistent bearing and measured course response in separate actuator
  roles. Feeding the slip-corrected error into both steering and reserve
  allocation reached but regressed arrival, route, effort, crossflow, and load
  relative to raw-bearing scheduling. Slip confined to the residual with raw
  bearing owning reserve has now reproduced the same result three times: it
  improves arrival `46.035 -> 45.727`, mean distance `2.0695L -> 2.0543L`, and
  RMS force `51.40 -> 49.36`, but worsens mean command energy
  `1237.1 -> 1264.7`, relative crossflow `0.2290 -> 0.2349`, and RMS moment
  `761.46 -> 799.31`. Treat this separation as a validated route/arrival
  mechanism, not a general effort/load benefit; preserve bearing-owned
  authority when testing a distinct disturbance or effort mechanism. This is
  bounded to the shared prewarm and allocator, and is falsified if a changed
  wake phase loses capture or the arrival advantage.
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
