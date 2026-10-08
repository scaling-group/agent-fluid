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
- Static mean curvature and posterior-only asymmetry do not repair the seed's
  wrong-way curl in this lane: sampled sub-limit descendants still exit upward
  near `9T` with minimum distance above `12L`. Anterior phase-gated actuation
  does contain a useful propulsive mechanism: the strongest sampled policy
  preserves a coherent alternating three-dimensional wake, survives to
  `39.088T`, and reaches `5.156L`. But its raw-yaw selector is mostly a hidden
  phase pump, not slow steering: `corr(heading_rate, phi_dot1)=-0.935`, and at
  least one joint is above `250 deg/T` on `58.9%` of samples while the fish
  passes the target's x station near `y=14.678L`. Preserve the traveling bend
  and phase-synchronous propulsion explicitly; do not infer target response
  directly from within-beat yaw or return to static-curvature gain searches.
  This applies while heading rate remains strongly gait-correlated and is
  falsified if a different carrier shows a stable cycle-mean yaw measurement
  without material loss of propulsion or limit occupancy.
- The assigned parent's speed-weighted target-versus-course replacement is a
  concrete negative result, not evidence that course geometry alone closes the
  turn. It regresses to the seed-like upper exit at `8.778T`, reaches only
  `12.186L`, and finishes at `12.547L`. Its half-stroke selector is positive on
  `70.2%` of samples and stays near `+0.99` after `5T`; after bearing crosses
  negative, cycle-mean yaw nevertheless remains roughly `-0.15` to
  `-0.31 rad/T`. A second bearing-persistent rollout independently shows that
  raising the selector from about `+0.36` to `+0.99` accompanies sustained
  negative yaw. Therefore calibrate geometry-to-actuator sign from whole-beat
  response before trusting a normalized course or bearing formula, and
  separate a symmetric phase pump from a response-gated steering asymmetry.
  Avoid another course-signal blend with the same unverified half-stroke sign.
  The sign lesson is specific to this morphology/carrier and should be retested
  if the gait changes; falsify it if repeated whole-beat evidence shows a
  positive selector produces positive rather than negative slow yaw.
- A velocity-only phase subtraction is not a slow-yaw observer for this
  traveling-bend carrier. Across four contract-valid long samples, fitting
  `heading_rate = k_v*phi_dot1 + k_q*phi1 + residual` after `2T` gives the
  narrow ranges `k_v=-0.455..-0.481` and `k_q=1.078..1.214`. Subtracting only
  the velocity term leaves the nominal residual `0.977..0.989` correlated with
  anterior angle after `8T`, whereas removing both normalized quadratures cuts
  residual standard deviation from about `0.084` to `0.010..0.015`. Therefore
  phase-reject yaw feedback with both observed joint-angle and joint-velocity
  coordinates before assigning a persistent target error to a half-stroke;
  otherwise the loop still alternates mainly with gait phase. Combine this
  with the whole-beat actuator-sign calibration: the correctly signed parent
  shifts its late path down to `y=13.990L` and reaches `4.676L`, while the
  opposite-sign prefill stays near `y=14.7L` and reaches only `5.264L`. This
  phase model is carrier-specific and must be refit if cadence, amplitude, or
  joint coordination changes; falsify it if the resulting residual remains
  materially correlated with either phase quadrature or if cycle-mean yaw has
  the wrong sign.
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
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
