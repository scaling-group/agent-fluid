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
- A finite seed rollout showed that active propulsion alone is not the missing
  capability: its traveling bend moved the head `13.30L` laterally but only
  `3.55L` upstream, hit both joint velocity and acceleration caps, carried
  `21.94` RMS lateral force and `541.70` RMS moment, and exited the lower domain
  after `50.13/300` release time. Preserve a traveling bend, but do not add
  target-blind drive when transverse advection and loaded yaw dominate.
- Across three target-aware descendants released from the same snapshot, the
  positive body-frame-bearing curvature was the only sign that produced
  meaningful upstream progress (`0.259`, head x `-3.59L`, versus `-0.170` and
  `+2.74L` for a negative-curvature finite exit); the other negative-curvature
  candidate became unstable after `1.66` time. However, the positive candidate
  combined a `22 deg`, `0.75`-period orbit with up to `16 deg` steering, reached
  both acceleration caps and the joint-one velocity cap, folded visibly, and
  terminated unstable at `33.06` with extreme force/moment loads. For this
  body-frame convention, preserve the positive sign but regulate phase energy
  and leave margin for the sum of oscillation, tail lag, and steering rather
  than relying on hard caps. The sign inference is still confounded by gait and
  feedback differences: falsify it if a lower-demand positive-sign controller
  again turns away, or if a matched negative-sign test improves trajectory and
  stability together.
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
