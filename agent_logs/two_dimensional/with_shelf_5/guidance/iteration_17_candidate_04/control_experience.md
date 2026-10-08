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
- In the common seed failure, the fish left the lower boundary after only
  `50.127` released time with head displacement `(-3.545,-13.300)L`, while
  mean velocity differed from mean local flow by only about `0.038U` and both
  joint velocity and acceleration limits were reached. Large world displacement
  is therefore not evidence of useful propulsion when local-flow advection
  explains most of it. For a target-blind, advection-dominated failure with no
  visible recovery turn, test bounded body-frame target-bearing mean curvature
  before increasing drive or adding an uncalibrated wake residual; this lesson
  does not apply once target-directed turning is visible, and is falsified for
  this controller family if the added bias leaves the turn sign and
  lower-boundary trajectory topology unchanged.
- On the demonstrated bearing-biased carrier, moving posterior steering onto
  the target-favored joint-state half-cycle changed a roughly `93.03`-time
  dogleg into a direct `43.9505`-time capture; three byte-identical samples
  reproduced `2.1391L` mean distance and RMS force/moment `49.44/701.26`.
  Releasing that half-cycle boost whenever bearing merely converged retained
  success and reduced RMS force/moment to `36.25/587.15`, but delayed capture
  to `46.6730` and increased mean distance to `2.2503L` while peak rate and
  acceleration remained capped. Preserve full asymmetric authority during
  large-error redirect; if testing response-conditioned relief, additionally
  gate it to small body-frame bearing. This implication applies to the
  half-cycle controller, not arbitrary carriers, and is falsified if a
  small-bearing gate either delays the direct route or leaves load/cap evidence
  unchanged—in that case avoid further threshold tuning and test a different
  feedback primitive.
- Short-history target filtering is a route primitive, and semantic coherence
  is more useful than near-cap projection on its fast posterior channel.
  Moving posterior steering from history to current bearing improved the fully
  history-driven `41.5030`, `2.0216L` route to `40.6285`, `1.9759L`, but left
  RMS force/moment high at `63.65/868.82`. The sampled sign-coherence selector,
  which falls back toward persistent route bearing only when the fast request
  contradicts it, retained the direct wake-crossing topology and improved
  capture/mean distance again to `39.1104`/`1.9149L`; it also reduced RMS
  crossflow/force/moment to `0.2193/57.21/783.64`, excursions to
  `0.543/0.463` rad, and command energy to `50060.7`. In contrast, two sampled
  history-gated rate guards reproduced `40.6450`, `64.70/875.97`, while an
  inherited current-bearing guard managed only `40.7715`, `62.41/843.60`.
  Preserve persistent/current sign coherence before adding another actuator
  envelope guard; because the successful selector still touches both rate and
  acceleration caps, test response-observed release of only extra posterior
  asymmetry rather than another guard threshold. This applies to the current
  short-history saturated half-cycle carrier and is falsified if such release
  loses the direct capture, delays it beyond `40.6285`, or fails to improve any
  load, excursion, cap-contact, or effort evidence over the coherence selector;
  then require calibrated flow/load histories before adding a disturbance
  residual.
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
