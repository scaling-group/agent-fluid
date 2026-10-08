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
- In the sampled seed rollout, the 0.55-period, 28-degree oscillator reached
  both joint-acceleration caps while the fish moved -13.30 L laterally but only
  -3.55 L upstream and exited the lower domain after 50.13 time units; its
  8.61 L minimum distance and 0.024 progress show that self-propulsion alone
  was not directional control. Do not continue this target-blind, cap-demanding
  gait by propulsion-only retuning: test bounded body-frame target steering and
  keep nominal gait demands inside the actuator envelope. This is a negative
  boundary from one initial-condition rollout, not evidence that any particular
  steering gain or slower frequency succeeds; falsify the proposed remedy using
  target-distance progress, x/y trajectory topology, termination, and measured
  saturation together.
- Do not treat low load or lack of cap contact as evidence that a regulated
  gait is propulsive. Two sampled positive-bearing controllers that regulated
  the combined angle-and-rate phase radius stayed finite with only `19.5--21.5`
  RMS lateral force, yet their streamwise head displacements were `+2.24L` and
  `+2.27L`, their mean velocities nearly matched local flow, and both exited
  downstream/lower with negative progress. In contrast, the angle-only
  positive-bearing oscillator moved `-3.59L` upstream with `0.259` progress,
  but reached both acceleration caps and ended in a visibly folded,
  high-force unstable state after `33.06` time. For this far-field release,
  preserve positive-bearing steering and enough state-encoded gait energy to
  create negative streamwise relative motion, while testing a lower smooth
  acceleration envelope and turn-rate damping; reject a candidate if it merely
  reproduces local advection or the unstable fold. This does not establish that
  all phase-radius regulators fail: falsify the boundary with a regulated
  rollout that sustains upstream relative motion, finite loads past `50.13`
  time, and target-directed lateral progress together.
- Stabilizing the progress-bearing angle-only gait is necessary but does not
  preserve its directional authority automatically. Its guarded `0.80`-period
  descendant stayed finite for `63.55` time and reduced RMS force/moment from
  `20024/314391` to `103/1600`, yet after reaching `10.35L` it made a broad
  visible loop, finished at `13.54L`, moved `(+0.43,+1.80)L`, and had `-0.090`
  progress. Moreover, an inherited low-effort result (mean command `150`)
  exited after only `10.02` with `+2.79L` downstream motion, `0.827` RMS
  relative crossflow, and RMS force/moment `4188/48543`; command effort alone
  is not a load or wake-rejection proxy. When safeguarding this far-field gait,
  test propulsion authority and turn damping as separate effects, and require
  negative streamwise displacement, finite loads, and final-distance progress
  together rather than accepting a transient minimum or longer survival. This
  boundary is falsified by a smoothly bounded rollout that retains upstream
  motion without a folded-body load spike or a late looping domain exit.
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
