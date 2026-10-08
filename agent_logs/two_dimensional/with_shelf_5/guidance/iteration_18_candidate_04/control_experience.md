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
- Semantic coherence is the first sampled selector to improve the
  history-driven route and its load class together. Replacing unrestricted
  current-bearing posterior steering with a smooth fallback to persistent
  route bearing when their signs conflict shortened capture from `40.6285` to
  `39.1104`, reduced mean distance from `1.9759L` to `1.9149L`, and lowered
  RMS crossflow/force/moment from `0.2248/63.65/868.82` to
  `0.2193/57.21/783.64`; excursions also fell from `0.574/0.510` to
  `0.543/0.463` rad and command energy from `52374` to `50061`. By contrast,
  the inherited current-alignment outward-rate projection delayed capture to
  `40.7715` and retained `62.41/843.60` loads. Preserve the coherence fallback
  and the exact padded-history release redirect; while both actuator caps are
  still reached, test a semantic restriction on fast posterior authority
  rather than another rate-guard threshold. This result applies to the
  circular-history, half-cycle carrier in the current deterministic wake and
  is falsified on held-out wakes if sign coherence loses direct capture or no
  longer jointly improves route and load evidence.
- Fast-authority release must require both alignment and observed response.
  On the coherent carrier, multiplying only the extra posterior half-cycle
  boost by a small-bearing, bearing-convergence release preserved the exact
  `39.1104` capture time while reducing RMS force/moment from `57.21/783.64`
  to `54.19/754.87` and command energy from `50060.7` to `50044.8`; mean
  distance and RMS relative crossflow changed only from `1.91494L/0.21935` to
  `1.91533L/0.21986`.  This is a modest load improvement, not cap relief:
  both rate and acceleration limits remain reached, and the scalar score
  changed from `-0.03850` to `-0.03925`.  Preserve the large-error redirect,
  mean curvature, carrier, and small-bearing boundary; if seeking more release,
  test a fast normalized signal that distinguishes target-assisting from
  target-opposing yaw rather than another rate threshold.  This implication is
  specific to the coherent history/half-cycle carrier and is falsified if a
  held-out wake delays capture, changes the direct route, or fails to improve
  loads when the response gate activates.
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
