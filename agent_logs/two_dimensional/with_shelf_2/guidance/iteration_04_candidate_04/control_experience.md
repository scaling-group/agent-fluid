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
- Treat an early, saturated lateral escape as a missing steering mechanism, not
  a request for more propulsion. In sampled seed `solver_a328086a43ca`, the
  target-blind oscillator visibly beat while descending almost monotonically,
  hit both `260 deg/time` velocity and `1800 deg/time^2` acceleration caps,
  displaced its head `-13.30L` laterally, and left the domain after only
  `50.13` release-time units with progress `0.024`. For this failure topology,
  first test bounded body-frame target-to-curvature feedback while bringing the
  nominal gait inside the actuator envelope; avoid scalar drive increases.
  Do not generalize this diagnosis to an unsaturated target-directed near miss,
  where capture scheduling, authority, or wake rejection may instead be the
  limiting mechanism.
- Reduced saturation is not itself a semantic improvement when steering is
  implemented by recentering the propulsive oscillator. Three evaluated
  bearing-to-mean-curvature variants cut peak joint acceleration from the
  seed's `31.416 rad/time^2` cap to `7.87--15.03`, yet all were advected about
  `+2.17--2.20L` downstream and left the right boundary within `17.04--18.11`
  units with negative progress; even the variant retaining the seed's
  `0.55` period and `28 deg` amplitude shrank joint-1 excursion from `0.459`
  to `0.214 rad`. For an initialized gait that must overcome inflow before
  steering, avoid further scalar tuning of these equilibrium-shift designs:
  preserve the zero-centered startup bend and test a steering primitive such
  as bounded half-cycle asymmetry that does not cancel it. This implication is
  falsified if preserving that startup still fails to recover early upstream
  displacement, in which case the propulsive scaffold itself—not only its
  steering composition—must be replaced.
- Preserving startup through anterior half-cycle acceleration asymmetry does
  recover useful propulsion, but it is not sufficient target steering and
  should not be intensified after lateral escape persists. Evaluated
  `solver_928f830d4c45` more than doubled the seed's upstream head displacement
  (`-9.73L` versus `-3.55L`), survived `91.24` versus `50.13`, and improved
  closest approach from `8.61L` to `4.62L`; nevertheless, its keyframes still
  pass below the target and end at the lower boundary with essentially the
  same `-13.31L` lateral displacement. Joint 1 reached `0.732 rad`, both joint
  velocities reached the hard cap, and force/moment RMS rose to
  `314.32/3430.21` from `21.94/541.70`. For this combination of stronger
  upstream travel, unchanged lateral termination, and load growth, retain the
  mechanism only as a bounded propulsion scaffold and test a separately
  actuated, response-damped steering signal (for example posterior total-tail
  curvature from body-frame bearing and bearing rate); avoid increasing
  half-cycle authority. This separation is falsified if posterior steering
  destroys the recovered upstream displacement or cannot reduce lateral loss,
  in which case the anterior asymmetry's apparent propulsion benefit is too
  coupled to the failing trajectory to preserve.
- Response feedback can materially improve closest approach without curing an
  over-coupled half-cycle steering actuator. Adding heading-response prediction
  to the same anterior/posterior acceleration asymmetry in evaluated
  `solver_a84fba8bf04f` improved minimum/mean distance from the assigned
  parent's `4.62/9.14L` to `1.65/8.72L`, but it still displaced laterally by
  `-13.23L`, left the domain sooner (`75.09` versus `91.24`), and raised
  force/moment RMS from `314/3430` to `487/4680`. Together with inherited
  `solver_78b1ea3edfcb`, whose equilibrium-shift steering lost propulsion,
  moved `+2.19L` downstream, and made `-0.142` progress, this supports a
  mechanism change rather than more damping or gain tuning on the same
  anterior channel: preserve the zero-centered anterior wave and test bounded,
  rate-released body-frame curvature in the posterior total-tail target. The
  implication is falsified if that separation reduces upstream displacement or
  leaves the same lateral escape; then later workers should test posterior-bias
  sign/coupling or a calibrated disturbance residual rather than intensifying
  anterior half-cycle asymmetry.
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
