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
- A smooth normalized yaw-moment-magnitude gate on only the distributed
  half-cycle steering residual is a confirmed semantic improvement after
  heading-response feedback supplies the route turn. The ungated controller
  approached to `1.65L` but folded into a lower exit at `75.09`, with
  force/moment RMS `487/4680`; the otherwise matched floor-bounded gate changed
  termination to `target_reached` at `51.47`, with `0.748L` final/minimum,
  `1.82L` mean distance, `-11.28/-4.94L` displacement, and `426/4084` RMS load.
  Preserve the zero-centered traveling bend and attenuate only target steering
  when normalized yaw interaction is already large. This applies after useful
  upstream propulsion and correct initial turn sign exist; falsify it if replay
  loses capture or the improved lateral topology. Aggregate RMS does not
  establish moment sign, so do not add directional rejection without
  sign-resolved event evidence.
- Once that gated route reliably captures, schedule only a small posterior-wave
  residual from normalized progress; extra authority or phase change is not the
  evidenced opportunity. Fixed alignment emphasis reached at `46.80` with
  `1.745L` mean distance, dimensional signed-closing modulation at `46.66` with
  `1.731L`, and progress-deficit emphasis at `46.31` with `1.736L`. Normalizing
  positive windowed closure by body speed improved this to `45.48`/`1.724L`
  with lower `405/4029` RMS load than the dimensional variant's `453/4371`.
  Conditioning only the closure-earned bonus on convergence of body-frame
  bearing raised score from `0.156386` to `0.158830`, reduced mean distance to
  `1.722L` and total command energy from `47033` to `46916`, but arrived `0.13`
  later and raised load to `453/4406`; treat it as a score/route-efficiency
  tradeoff, not permission to increase amplitude. A phase-lag-shift child
  regressed to score `0.146573`, arrival `46.22`, and mean distance `1.735L`.
  Prefer the body-speed-normalized closure envelope, optionally gated by a
  bounded direction-error trend, and avoid stacking lag shifts unless new
  phase-resolved evidence reverses that negative result. This lesson is
  falsified outside the fixed wake if normalization no longer preserves
  capture or the modest distance/energy benefit fails to offset added load.
