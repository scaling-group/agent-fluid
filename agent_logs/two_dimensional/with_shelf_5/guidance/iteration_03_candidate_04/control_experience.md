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
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
- Preserve a sampled successful carrier before trying to make it gentler. The
  target-blind seed (`0.55` period, `28 deg` envelope) curled out of the lower
  domain, but retaining that carrier and adding only an `8 deg` bounded
  body-frame bearing bias produced the sole step-1 target crossing: `0.940`
  progress and `4.033L` mean distance in `93.032` release time. In contrast, a
  global `0.90`/`14 deg` carrier reduction exited right in `17.457` with
  `-0.145` progress, a `12 deg` bias on the fast carrier settled near static
  bend and exited right in `16.791`, and inherited logs show that combining a
  slow/narrow carrier with uncalibrated heading-rate damping became unstable in
  `14.508`. The success still hit both joint-rate and acceleration caps and had
  RMS lateral force/moment `95.50/1146.61`, so test effort relief only through a
  normalized state-gated mechanism that is exactly inactive on the known-good
  far/middle route (for example, a terminal distance envelope), rather than a
  blanket gait retune or larger bias. Falsify the gated mechanism if capture is
  delayed or lost, the pre-approach trajectory changes, or saturation and load
  do not fall in the gated region; require sign-resolved evidence before adding
  wake-load or yaw-rate residuals.
- An oscillator-amplitude envelope is not reliable effort relief when the
  acceleration is dominated by a stiff restoring term and then hard-clipped.
  On the successful bearing-biased carrier, reducing only the Van der Pol
  amplitude toward `0.75` inside `2.5L` left the termination and `93.032`
  arrival unchanged, but command-energy mean changed by less than `0.001%`
  (`972.51483` to `972.51450`), power mean by less than `0.001%`, and RMS
  lateral force/moment slightly increased. For this controller form, avoid
  further amplitude-floor tuning as an effort strategy; test direct smooth
  command limiting only behind a normalized range gate and a positive
  body-frame closing-progress gate, so the known-good far/middle route is
  exactly preserved. Falsify direct terminal relief if capture degrades, the
  pre-terminal trajectory changes, or cap occupancy, effort, and loads remain
  indistinguishable.
