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
- The inherited bearing-trend mean-curvature hypothesis survives only as a
  partial result, not a completed steering solution. Its posterior-only policy
  improved closest approach by `0.665L` over the target-blind seed and delayed
  upper exit from `8.547T` to `9.740T`, but still left at `y=15.200L`; its raw
  posterior acceleration exceeded the envelope in about 55 percent of samples
  and peaked near `101 rad/T^2`. A yaw-rate-damped posterior bias also retained
  the same upper-exit topology and reached only `12.091L`. For this combination
  of coherent propulsion, correct net progress, persistent yaw, and clipped
  posterior authority, test a phase-conditioned half-cycle or response-gated
  steering translation before increasing continuous curvature. Reject that
  implication if a continuous posterior bias achieves a better termination
  class with lower limit residence, or if phase conditioning loses the wake or
  the `11.413L` closest-approach benchmark.
- Distinguish two-sided half-cycle amplification from one-sided counter-turn
  wave relief. The former retained an alternating wake but regressed to
  `11.778/11.860L` minimum/final distance with about 43 percent posterior clamp
  residence. In the later course-feedback comparison, weakening only the
  posterior wave lobe opposed to the requested turn preserved the coherent 3D
  wake, improved closest approach from `6.218L` to `5.144L`, extended survival
  from `16.879T` to `18.975T`, and reduced posterior clamp residence from about
  60.8 to 35.9 percent. Preserve that one-sided headroom mechanism when testing
  stronger course regulation; it is not by itself a capture solution, because
  distance rebounded to `6.297L` after the closest point and the fish still
  exited the upper boundary. Falsify the transfer if coupling it to a new
  target/course signal loses wake coherence, restores roughly 56--61 percent
  posterior clamping, or fails to improve the `5.144L` closest-approach and
  upper-exit benchmarks.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
