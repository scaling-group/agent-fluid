# Dogfish L64 3D Moving-Window Still-Water Policy Experience

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

- This is a fresh 10-iteration lineage with no solver or optimizer population
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
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
- Inspect both top-down and oblique 3D keyframe rows before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination. A prewarm
  artifact is a contract failure in this direct-uniform experiment.
- Prefer normalized body-frame feedback. Inflow, target position, initial pose,
  and hydrodynamic conditions are intended held-out axes; coordinate
  memorization is not a valid solution.
- Treat every proposed observation as an empirical hypothesis: establish its
  scale, convention, and measurable effect from the current evidence before
  relying on it.
- Compare successful, near-miss, and failed trajectories without assuming a
  particular causal decomposition in advance.
- In direct-uniform still water, target feedback should leave the anterior
  carrier equilibrium unchanged until contrary evidence appears. Among the
  sampled first-generation policies, posterior-only bearing-plus-trend bias
  retained the coherent alternating 3D wake and improved the seed's
  minimum/final distance from `12.078/12.380L` to `11.413/11.421L`. Centering
  the same kind of bias on both joints instead held joint excursions near
  `10 deg`, delayed visible wake growth, made a broad U-turn, and ended at
  `13.411L`. Apply this lesson to a working traveling-bend carrier; falsify it
  if a future shared-bias design preserves comparable joint/wake amplitude and
  improves target progress rather than merely surviving longer.
- On a working target-versus-course posterior-curvature carrier, phase
  conditioning is useful specifically as attenuation-only wave relief. The
  sampled one-sided policy never amplified the aiding lobe, retained the
  coherent alternating top-down and oblique 3D wake, cut posterior
  acceleration-limit residence from `60.8%` to `35.9%` versus the otherwise
  matching continuous-bias policy, improved closest approach from `6.218L` to
  `5.144L`, and delayed upper exit from `16.879T` to `18.975T`. Do not generalize
  this to arbitrary half-cycle scaling: the inherited two-sided
  strengthen/weaken policy regressed to `11.778L` and `8.800T`, and one-sided
  acceleration-lobe gating reached only `11.448L` at `9.053T`. Preserve the
  successful relief scaffold when testing a response-gated redirect, but do
  not claim steering is solved: its best rollout still passed its closest
  point and exited at center y=`15.203L` with `0.632 U` positive-y velocity.
  Falsify the reusable implication if attenuation loses wake/x progress on a
  different carrier, or if a simpler continuous bias achieves a better
  termination class with comparably low limit residence.
- A speed-reliable, response-gated increase from cruise curvature to a strong
  posterior redirect is now positive evidence, not merely a proposed rescue.
  Applied on the one-sided-relief scaffold above, it preserved the coherent
  alternating top-down and oblique wake and changed the sampled outcome from a
  `5.144L` closest approach plus upper exit at `18.975T` to capture at `0.746L`
  in `16.291T`. The reusable mechanism is to open extra posterior curvature
  only for a large target-versus-course mismatch after forward translation is
  reliable, then release it continuously as measured course realigns. Its cost
  is also material: posterior acceleration-limit residence rose from `35.9%`
  to `60.4%`, despite posterior angle staying within `30.4 deg`. Thus limit
  residence alone must not veto a better termination class, but follow-up
  designs should preserve the evidenced mean redirect while testing whether
  the joint-state wave can yield acceleration headroom. Falsify this transfer
  on carriers without coherent cruise propulsion, or if the stronger redirect
  loses capture/early x progress, fails to release with course response, or
  creates instability rather than a finite target-directed path.
- Once the response-gated redirect captures, decompose posterior control into
  mean-bend tracking and oscillatory-wave acceleration before applying the
  hard envelope. In the sampled follow-up, reserving redirect-dependent
  headroom for the mean component while retaining wave acceleration that fit
  or unloaded it preserved the alternating top-down and three-dimensional
  wake, cut whole-rollout posterior limit residence from `60.4%` to `22.5%`,
  advanced the `5L`, `2L`, and `1.2L` approach milestones by roughly
  `0.028T`, `0.039T`, and `0.044T`, and captured at `16.258T` instead of
  `16.291T`. Near capture, prefer relief that preserves mean curvature: the
  sampled target-aligned damping plus posterior-wave attenuation achieved the
  best score (`-0.066121`) at `16.258T`, whereas a full zero-bend joint hold
  lowered near-field force and command residence but slipped to `16.269T` and
  `-0.066867`. Thus allocate limited actuation by control role, and attenuate
  the carrier rather than the directional bend during reliable closing.
  An initially poor stack does not by itself establish dynamical
  non-additivity. Mean-first allocation plus selective approach relief first
  captured at `16.225T` but scored `-0.067754` because strong redirect closed
  through a measured terminal course mismatch. On that same transit scaffold,
  lowering only the redirect-error onset during reliable near-target closing
  retained the coherent two-view wake and `16.225T` arrival while improving
  the sampled score to `-0.063208`, crossing at `0.7448L`, and keeping
  posterior hard-limit residence at `21.3%`. This beats both the assigned
  approach-course-weight parent (`-0.066256`, `16.258T`, `58.3%` residence)
  and standalone selective relief (`-0.066121`, `16.258T`, `59.3%`). The
  reusable implication is to diagnose a stacked controller's regime handoff
  before discarding compatible transit mechanisms: retain mean curvature until
  measured course response aligns, rather than increasing a near-field course
  weight or reworking the carrier. Apply this only after coherent propulsion,
  a capture route, and reliable closing exist. Falsify it if another carrier's
  pre-approach path changes, the lower onset produces a late hook or higher
  load/limit residence, or capture and distance integral do not improve.
- Once a closing-conditioned capture route exists, separate repeatable
  carrier-phase sway from persistent target-versus-course error before opening
  strong posterior redirect authority. The sampled relief-only residual gate
  used normalized anterior joint angle and velocity only to select redirect
  duty, retained raw measured error for bend direction and actuator fallback,
  and preserved the coherent top-down and oblique wake. Against the otherwise
  matching raw-response controller, it advanced the `5L` and `2L`
  milestones by `0.071T` and `0.121T`, advanced capture from `16.225T`
  to `16.044T`, and improved score from `-0.063208` to `-0.058311`;
  force and yaw-moment envelopes stayed comparable, although posterior
  acceleration-limit residence rose modestly from `21.3%` to `22.7%`.
  This validates phase separation as a route mechanism, not a reason to
  residualize every steering term: the inherited direct gate-and-turn replay
  raised limiting, while sampled short-window bearing-rate lead and extra
  response-gated terminal wave unloading left all approach milestones
  unchanged and regressed scores to `-0.065510` and `-0.064416`.
  Apply the residual only on a coherent carrier whose phase signature is
  repeatable across trajectories, preserve a raw-error fallback, and judge the
  small limit cost against semantic route/arrival improvement. Falsify it if
  the phase fit is not stable on another carrier, wake or capture is lost,
  loads rise materially, or the earlier route gain does not repeat. Do not add
  a still-water flow/load residual without new evidence: local crossflow,
  lateral force, and yaw moment did not explain the remaining held-segment
  error beyond joint phase and body velocity in these sampled captures.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
