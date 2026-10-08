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
- An anterior or two-joint target-to-mean-curvature equilibrium is a concrete
  negative result for this near-downstream-boundary release. Four completed
  variants spanning periods `0.55--0.90`, amplitudes `15--28 deg`, split versus
  anterior bias, and optional soft acceleration limiting all reduced effort
  and cap contact, but each was advected about `+2.2L` to the downstream margin
  within `16.73--18.11` time units without beating its initial `12.42L` target
  distance. By contrast, the saturated target-blind seed produced a visible
  traveling wake and `-3.55L` upstream displacement before its separate
  lower-boundary steering failure. Do not keep tuning curvature magnitude or
  gait scalars around that recentered architecture; first preserve the
  anterior propulsive transient and test target steering through posterior
  half-cycle/duty asymmetry or another mechanism that does not weaken initial
  restoring acceleration. This lesson is falsified if an equilibrium-shift
  policy restores negative-x motion before the downstream margin and improves
  distance history without returning to cap-dominated loads.
- Half-cycle steering is sensitive to where asymmetry enters, not merely its
  sign or scalar strength. Two posterior-target multiplicative variants kept
  the seed's lower-exit topology: only `-4.24L` to `-4.56L` upstream motion,
  `8.20--9.29L` closest approach, exit by `52.54--54.90`, and mean command
  energy `1493--1504`, with both joint rates and accelerations at their hard
  caps. A distributed acceleration-level variant instead preserved the
  zero-centered traveling bend and improved upstream motion to `-9.73L`,
  closest/mean distance to `4.62L`/`9.14L`, survival to `91.24`, and mean
  command energy to `853`. Its benefit is provisional because it still exited
  low after reaching `0.73` rad anterior bend and raised force/moment RMS from
  about `22/535` to `314/3430`. Preserve this distributed propulsive scaffold
  rather than increasing asymmetry or repeating posterior sign/gain swaps.
- A smooth normalized yaw-moment-magnitude gate applied only to distributed
  half-cycle steering is a semantic improvement when a response-aware gait
  already self-propels toward the wake but amplifies its own turn under load.
  The ungated heading-response policy reached `1.65L` but folded into a lower
  exit at `75.09`, displaced only `-8.32/-13.23L`, and produced force/moment RMS
  `487/4680`; the otherwise matched gate preserved a nonzero steering floor and
  changed the result to `target_reached` at `51.47`, `0.748L` final/minimum and
  `1.82L` mean distance, `-11.28/-4.94L` displacement, and `426/4084` RMS load.
  The posterior-curvature alternative was much lower-load (`116/1278`) yet
  still exited above the target after approaching only `2.43L`, so minimizing
  aggregate load is not itself a route controller. Preserve the zero-centered
  traveling bend and gate only its target-steering residual when moment
  magnitude indicates that wake/body yaw is already strong. This lesson
  applies after upstream propulsion and correct initial target response are
  established; falsify it if replay loses target success, upstream travel, or
  the improved lateral topology. Do not infer moment sign, a universal scale,
  or a directional wake residual from these aggregate diagnostics; require
  sign-resolved event evidence before adding one.
- Exact repeated outcomes from functionally identical candidates establish a
  materialization baseline, not wake robustness. Four sampled solver replays
  and the assigned parent's inherited rollout reproduce `target_reached` at
  `51.47`, `0.748L` final/minimum and `1.82L` mean distance, `-11.28/-4.94L`
  head displacement, and `426/4084` force/moment RMS under the same prewarmed
  wake. Preserve that deterministic reference instead of interpreting duplicate
  samples as support for another scalar steering or signed-disturbance edit.
  This implication applies only when the policy expressions and initial wake
  snapshot are functionally identical; it is falsified as a robustness claim
  until changed wake phase, inflow, geometry, target, or genuinely different
  policy output also succeeds.
- Treat posterior propulsion earned by target progress as a small
  route-conditioned residual, and distinguish positive normalized closure from
  merely weak progress. On the same successful yaw-gated scaffold, fixed
  alignment emphasis reached at `46.80` with `1.745L` mean distance and
  `441/4259` force/moment RMS; dimensional signed-closure modulation reached at
  `46.66` with `1.731L` and `453/4371`; progress-deficit emphasis reached at
  `46.31` with `1.736L` and `393/3878`; body-speed-normalized positive-closure
  emphasis was best at `45.48`, `1.724L`, and `405/4029`. The inherited
  propulsive-priority allocator is the boundary: it traveled farther but
  passed below capture and collided at `58.93` after only a `1.872L` closest
  approach with `537/4995` loads. Preserve the normalized positive-closure
  residual rather than making stalls or reversals earn more tail motion.
  Multiplying only that small residual by a bounded body-frame course trend
  preserved capture and the same diagonal keyframe topology while improving
  the prefilled progress-deficit candidate's arrival/mean distance/score from
  `46.31/1.736L/0.145334` to `45.61/1.722L/0.158830`; command-energy mean was
  essentially unchanged (`1028` versus `1028`). This is evidence that
  decreasing absolute bearing can refine a positive-closure residual without
  replacing the gait. It is not a clean load or arrival win over the simpler
  normalized-closure variant: capture was slightly later (`45.61` versus
  `45.48`) and force/moment RMS rose from `405/4029` to `453/4406`. Keep the
  course multiplier bounded and confined to the progress-earned residual; do
  not amplify it or move it onto the base wave until sign-resolved histories
  explain the load increase. This lesson applies only after route alignment,
  upstream propulsion, yaw-gated target success, and positive normalized
  closure exist; falsify it if a replay loses the shared trajectory topology
  or if its distance benefit disappears without a compensating load reduction.
