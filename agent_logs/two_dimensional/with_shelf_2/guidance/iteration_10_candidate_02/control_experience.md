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
  materialization baseline, not wake robustness. Three sampled solver replays
  and older inherited rollouts reproduce `target_reached` at `51.47`, `0.748L`
  final/minimum and `1.82L` mean distance, `-11.28/-4.94L` head displacement,
  and `426/4084` force/moment RMS under the same prewarmed wake. Preserve that
  deterministic reference instead of interpreting duplicate samples as
  support for another scalar steering or signed-disturbance edit. This
  implication applies only when the policy expressions and initial wake
  snapshot are functionally identical; it is falsified as a robustness claim
  until changed wake phase, inflow, geometry, target, or genuinely different
  policy output also succeeds.
- Alignment-conditioned posterior wave emphasis is a positive propulsion
  mechanism after the yaw-gated diagonal route is established, but its load
  cost bounds extrapolation. Adding `10%` maximum emphasis only when predicted
  body-frame bearing was aligned retained `target_reached`, improved arrival
  from `51.47` to `46.80` and mean distance from `1.820L` to `1.745L`, and
  increased posterior angle from `0.659` to `0.675` rad. Mean command energy
  rose from `995` to `1024`, force/moment RMS from `426/4084` to `441/4259`,
  and both joint rates still met the hard cap. Preserve route alignment as the
  gate and test progress- or approach-aware envelope feedback before any
  scalar increase. This lesson applies only after target success, the coherent
  traveling wave, and yaw-load steering moderation are present; falsify it if
  the paired improvement fails to reproduce, or if added posterior motion
  raises saturation/load without earlier capture or lower distance history.
- Response-conditioned posterior shaping supports envelope feedback, but the
  sampled comparison rejects posterior phase tuning as a substitute. Relative
  to fixed aligned emphasis at `46.80`, a body-speed-normalized positive-
  closure bonus reached at `45.48` with `1.724L` mean distance and `405/4029`
  force/moment RMS. Adding body-frame course-convergence reallocation produced
  the best sampled score (`0.15883` versus `0.15639`), slightly improved mean
  distance (`1.722L`) and mean command energy (`1029` versus `1034`), but
  arrived `0.13` later and raised load to `453/4406`; both variants still met
  both joint-rate caps. By contrast, an aligned/efficient posterior lag shift
  with analytic amplitude compensation regressed to `46.22`, `1.735L` mean
  distance, and `1036` mean command energy. Preserve positive closure as an
  amplitude-envelope observation and avoid further lag or amplitude-scalar
  searches; treat course trend as a small optional residual whose load cost
  must be moderated or explicitly justified. This applies only after the
  established yaw-gated route and traveling wave already capture the target;
  falsify it if replay does not reproduce the closure-envelope advantage, or
  if a genuinely different timing law improves arrival and effort without
  greater saturation or hydrodynamic load.
