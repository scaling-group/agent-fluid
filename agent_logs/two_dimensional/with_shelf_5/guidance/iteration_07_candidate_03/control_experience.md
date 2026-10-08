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
- Once the `0.55`-period, `28 deg` anterior carrier and bounded `8 deg`
  body-frame bearing bias establish target-directed motion, preserve them and
  distinguish where half-cycle asymmetry enters. Before posterior curvature
  redistribution, amplitude taper, bearing-rate lead, and near-target
  local-frequency duty asymmetry all retained the same broad-loop
  `92.988--93.032` capture, about `4.031L` mean distance,
  `972--973` mean command effort, and `95.4--95.8/1146--1150` RMS lateral
  force/moment. Redistributing posterior steering curvature onto the
  target-favored joint-state half-cycle instead produced an immediate sharper
  redirect and `43.951` capture with `2.139L` mean distance; total command
  energy fell from about `9.05e4` to `5.31e4` and RMS force/moment to
  `49.4/701`, despite higher per-time effort and unchanged rate/acceleration
  cap hits. Thus, for this two-joint bearing-directed topology, prefer
  state-phased posterior curvature allocation over scalar carrier retuning or
  local-frequency duty modulation. This lesson applies when the anterior
  traveling bend and correct turn sign are already established; it is
  falsified if the fast topology fails to reproduce under another wake phase,
  if the traveling bend collapses, or if higher instantaneous effort loses the
  distance-integral and episode-load advantage.
- In the fast posterior-half-cycle topology, a smooth amplitude taper inside
  `2.5L` is optional rather than causal: the clean ablation and two tapered
  samples all captured at the same recorded `43.9505` time with the same
  compact trajectory. Tapering changed mean distance only from `2.1412L` to
  `2.1391L`, total command energy from `53082.36` to `53082.58`, and RMS
  force/moment from `49.45/701.31` to `49.44/701.26`. Do not stack further
  scalar terminal schedules on this evidence or credit the taper for the fast
  redirect; first test robustness under a changed wake phase or obtain
  sign-resolved terminal evidence. This boundary is falsified if a controlled
  taper ablation later changes termination, arrival class, or trajectory
  topology rather than only sub-frame distance statistics.
- Response-conditioned release of the fast topology's posterior half-cycle
  boost exposes a real load/navigation tradeoff, not a free efficiency gain.
  Attenuating up to `35%` of that boost while body-frame bearing was already
  converging retained target success and reduced RMS force/moment from about
  `49.4/701` to `36.3/587` (and relative-crossflow RMS from `0.211` to
  `0.206`), but delayed capture from `43.9505` to `46.673`, worsened mean
  distance from `2.139L` to `2.250L`, and raised total command energy from
  `5.31e4` to `5.66e4`. For the fast route, preserve the evaluated asymmetric
  boost during improving alignment; if response gating is tested again, use it
  to add bounded recovery only while signed bearing error worsens, rather than
  releasing baseline authority. This implication applies after the direct
  half-cycle redirect is established and is falsified if a controlled smaller
  release improves arrival or distance integral without restoring the broad
  route under another wake phase.
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
