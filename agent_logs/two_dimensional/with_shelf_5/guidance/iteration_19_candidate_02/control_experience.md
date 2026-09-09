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
- Short-history target filtering is a route primitive, not a demonstrated load
  remedy. Blending `0.50` of the circular-mean bearing into both anterior bias
  and posterior half-cycle steering improved the reproduced carrier's capture
  from `43.9505` to `41.5030` and mean distance from `2.1391L` to `2.0216L`,
  but raised RMS force/moment from `49.44/701.26` to `61.80/862.48`. The
  assigned parent's role split—history for anterior curvature, current bearing
  for posterior half-cycle steering—materially improved the same direct route
  again to `40.6285` and `1.9759L`, yet loads remained high at `63.65/868.82`
  and both rate and acceleration caps were still reached. Two sampled
  history-driven policies whose rate guard was also activated by the filtered
  turn request likewise captured at `41.4205` with `63.05/872.36` loads,
  whereas the current-bearing-gated projection on the unfiltered carrier kept
  `43.9505` capture and lowered loads to `44.47/657.47` (consistent with the
  inherited `44.0220`, `44.86/663.89` result). Preserve short history for its
  evidenced arrival benefit, but do not reuse its lagged request to activate a
  fast envelope intervention or infer that posterior release damps wake load;
  gate such relief from a fast observed alignment/response signal and test its
  composition separately. This applies to the current saturated half-cycle
  carrier and is falsified for a proposed fast-gated composition if it delays
  the direct route or leaves the `63/870` load class and cap contact unchanged;
  then avoid threshold tuning and test a different disturbance observation.
- Treat observed bearing convergence as a channel selector, not generic
  permission to reduce controller authority. On the route/current sign-coherent
  carrier, releasing only the extra posterior half-cycle bias preserved
  `39.1104` capture while reducing RMS force/moment from `57.21/783.64` to
  `54.19/754.87`. Extending the same completion gate to lagged anterior route
  history improved capture to `39.0499`, mean distance to `1.91369L`, and score
  to `-0.03762`, but returned loads to `57.05/783.02`; extending it instead to
  oscillator amplitude slowed capture to `39.2149` and worsened mean distance,
  command energy, and loads relative to the posterior-only release. For this
  direct saturated carrier, preserve the rhythmic propulsion envelope and
  choose release scope by objective: posterior-only for demonstrated load
  relief, route-history plus posterior for demonstrated arrival/score benefit.
  This does not generalize to carriers without a measured convergence gate and
  is falsified if a future carrier preserves arrival and improves loads when
  amplitude relief is added; until then avoid tuning its amplitude floor or
  alignment width and obtain calibrated histories before testing a wake
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
