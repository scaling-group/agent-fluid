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
- When circular-history bearing owns slow anterior curvature and current
  bearing owns fast posterior steering, sign coherence is a useful semantic
  selector rather than just a smoother. Falling back toward the persistent
  request only when the two bounded requests conflict improved the split
  parent's capture from `40.6285` to `39.1104`, mean distance from `1.9759L`
  to `1.9149L`, RMS force/moment from `63.65/868.82` to `57.21/783.64`, and
  command/power from `52374.2/3960.5` to `50060.7/3768.8`; maximum joint
  excursions also fell from `0.574/0.510` to `0.543/0.463` rad. Two
  history-plus-directional-rate guards instead took `40.6450` with
  `64.70/875.97`, while all variants still touched both actuator caps. For
  this two-timescale carrier, preserve the coherent fast channel and use the
  slow request as the contradictory-motion fallback before adding outer
  action clipping. This boundary is falsified if a held-out route loses
  target capture under sign selection, or if a response measured after
  alignment beats it without degrading arrival; then test that response as a
  distinct gated mechanism rather than tuning the coherence transition.
- Range localization can erase an otherwise useful load-shaping mechanism.
  An alignment-gated outward posterior-rate projection active throughout
  aligned transit retained direct capture at `44.0220` and reduced RMS
  force/moment from `49.44/701.26` to `44.86/663.89`; multiplying the same
  projection by the smooth `2.5L` approach gate produced a sampled rollout
  indistinguishable from the unguarded carrier (`43.9505`, `2.1391L`,
  `0.2111/49.44/701.26` crossflow/force/moment, with only about `0.0044` of
  `53082.6` integrated-command difference).  Thus the useful projection acted
  before the terminal neighborhood, and first-crossing capture supplied no
  evidence for terminal cap relief.  Do not tune the approach or rate
  thresholds to revive it; test a different semantic selector, such as
  joint-state half-cycle, while preserving the large-error redirect and all
  reversals.  This applies to the demonstrated half-cycle carrier and
  first-crossing objective, and is falsified if a held-out route shows
  near-target outward rate reinforcement together with a load or miss benefit
  from terminal localization.
- Beat-phase refinement is a negative direction for this carrier in two
  distinct completed tests.  Adding `0.35*phi_dot1/omega` to the steering
  selector retained the baseline route but raised RMS force/moment from
  `49.44/701.26` to `53.18/736.58`; adding a nonpreferred-half selector to the
  aligned posterior-rate projection retained capture at `44.0605` and lowered
  loads to `46.71/677.72`, yet was dominated by the phase-indiscriminate
  projection's earlier `44.0220` capture and lower `44.86/663.89` loads.  Do
  not tune another phase lead, phase width, or rate-guard threshold on this
  lagged two-joint carrier.  Test a different observed-response primitive,
  such as an alignment-conditioned gait envelope, while preserving the proven
  bearing steering; this boundary is falsified if a held-out phase selector
  improves both arrival and loads over the ungated projection.
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
