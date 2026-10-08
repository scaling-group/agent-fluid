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
- A target-blind traveling-bend oscillator can demonstrate motion without
  demonstrating useful propulsion or navigation. In the seed evidence, both
  joint speed and acceleration reached their configured caps while the head
  moved only `3.55L` upstream but `13.30L` laterally, closest distance
  (`8.61L`) regressed to `12.12L`, and the fish left the domain after `50.13`
  released time units. For this lateral-escape topology, test a bounded
  body-frame target-to-mean-curvature mechanism before wake-phase control or
  scalar-only gait tuning; retain it only if correct-sign turning, upstream
  progress, and survival improve together without cap-dominated motion.
- Completed descendants narrow the useful steering primitive further. A
  static-curvature controller survived the full horizon but looped far from
  the wake (`1.19L` upstream displacement, `10.28L` closest approach), while
  an inherited controller that applied equal `0.35` target-driven half-cycle
  asymmetry to both joints moved `2.34L` downstream and exited after `25.81`
  units. In contrast, two controllers with weaker or no independent posterior
  asymmetry reached the target; the anterior-only version arrived in `179.22`
  units with mean distance `5.04L`, versus `268.49` and `8.04L` for the
  rate-damped version with attenuated posterior modulation. For this
  loop/advection topology, localize bearing-driven half-cycle steering to the
  anterior oscillator and let joint 2 inherit it through posterior lag before
  adding a second steering residual. Falsify this preference if replicated
  captures lose stability across wake perturbations or phase-resolved evidence
  shows that an independently bounded tail residual improves arrival and loads
  together. Do not infer that larger aggregate crossflow needs cancellation:
  the fastest capture also had the largest successful RMS relative crossflow
  (`0.133`), so flow rejection needs signed temporal evidence rather than an
  RMS scalar.
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
