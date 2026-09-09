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
- Timescale separation improved route geometry but did not itself reject wake
  loads.  Driving anterior mean curvature from circular-history bearing while
  returning posterior half-cycle steering to current bearing shortened capture
  from the fully history-driven `41.5030` to `40.6285` and reduced mean
  distance from `2.0216L` to `1.9759L`, yet RMS force/moment rose from
  `61.80/862.48` to `63.65/868.82` and both rate and acceleration caps remained
  reached.  Moreover, composing the earlier outward-rate guard with the fully
  history-driven policy produced `63.05/872.36`, not a load improvement over
  its unguarded form.  Preserve the anterior/posterior timescale split when
  arrival is primary, but do not describe raw current-bearing posterior
  feedback as disturbance rejection and do not retune the near-cap guard.
  Test a semantic coherence selector that withholds only fast posterior
  requests contradicting the persistent body-frame route; this implication is
  falsified if such selection delays the direct capture or leaves load and cap
  evidence unchanged, in which case require calibrated flow/load histories
  before adding a disturbance residual.
- Extending response completion from posterior steering onto the anterior
  carrier is not supported by two completed variants.  The alignment-gated
  `0.90` gait-amplitude floor preserved the direct route but was dominated by
  its response-release parent: capture changed from `39.1104` to `39.2149`,
  mean distance from `1.9153L` to `1.9159L`, command energy from `50044.8` to
  `50246.0`, and RMS force/moment from `54.19/754.87` to `55.32/764.02`, with
  both rate and acceleration caps still reached.  Releasing circular-history
  curvature after the same response was slightly faster (`39.0499`) and used
  less command energy (`49942.8`), but raised force/moment to `57.05/783.02`
  and likewise retained both caps.  Do not tune the amplitude floor or route-
  memory release threshold: preserve the proven posterior response release
  and test a mechanism that changes saturated action coordination, or wait for
  calibrated signed load/flow histories before disturbance rejection.  This
  applies to the demonstrated history/coherence carrier under first-crossing
  capture and is falsified if a held-out route shows an anterior completion
  edit improving arrival, effort, and loads together without increasing cap
  contact.
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
