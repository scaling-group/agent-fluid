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
- For this half-cycle carrier, joint rate is useful as a one-sided actuator
  envelope signal but not as an uncalibrated phase or wake-disturbance signal.
  Adding `0.35 q̇1/ω` to the half-cycle phase retained a direct `43.9780`
  capture but raised RMS crossflow/force/moment from
  `0.2111/49.44/701.26` to `0.2136/53.18/736.58`; an inherited bounded
  yaw-moment residual was worse, delaying capture to `45.1935` and raising
  force/moment to `71.51/957.29`. By contrast, after body-frame alignment,
  projecting away only posterior acceleration that pushed a near-envelope
  rate farther outward preserved direct capture at `44.0220` and reduced
  crossflow/force/moment to `0.2102/44.86/663.89`, while leaving every
  reversal intact. Use proprioceptive rate for direction-aware load shaping,
  not for shifting the evidenced steering half-cycle; do not reuse raw moment
  feedback until sign-resolved disturbance events calibrate it. This applies
  to the posterior-lag/half-cycle carrier and is falsified if the projection
  loses direct capture, weakens reversal, or fails to reproduce lower loads;
  continued peak-rate contact alone is not a reason for scalar threshold
  tuning because the evaluated benefit was distributed load relief.
- Successive completed inherited logs re-materialized that same
  alignment-gated posterior rate projection and reported the bit-identical
  `44.0220` direct capture with `44.86/663.89` RMS force/moment.  This
  recurrence strengthens the load-shaping result but adds no new termination
  class or trajectory mechanism, while both acceleration components still
  reach the hard cap.  Treat another copy or rate-threshold retune as a
  mechanism plateau.  A distinct clean test is to preserve the raw
  anterior/posterior acceleration ratio with a coupled policy-owned envelope
  only after body-frame alignment, leaving the proven large-error redirect
  unchanged.  This implication applies when componentwise saturation can
  distort a two-joint traveling bend, and is falsified if coordinated scaling
  delays or loses direct capture, breaks posterior lag, or leaves cap-contact
  and load histories indistinguishable; its outcome is not yet evaluated.
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
