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

- This is a fresh 40-iteration lineage with no solver or optimizer population
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- The common naive oscillator/posterior-lag carrier is already self-propelling
  in direct-uniform still water, but that does not establish useful navigation:
  the sampled seed traveled about `1.52L` with a coherent 3D wake yet improved
  target distance by only `0.258L`, accumulated `1.252 rad` heading error, and
  exited the upper boundary at `8.602T`. When this zero-steering topology
  recurs, test bounded body-frame target-error-to-mean-curvature feedback while
  preserving the lagged carrier before changing scalar drive gains. This
  implication applies only when the wake and displacement confirm propulsion;
  a wrong-sign turn, lost wake coherence, or worse actuator-limit residence
  falsifies the curvature sign or joint split and should be corrected before
  adding flow or force compensation.
- Once restrained target-relative curvature establishes a coherent approach,
  preserve its cruise scaffold and diagnose the near miss by relative geometry
  and motion rather than proximity alone. Posterior bearing gating improved
  closest approach from `4.067L` (plain `7 deg` curvature) to `2.443L`, but
  closing response fell from about `0.586--0.606 L/T` between `3--4L` to
  `0.131--0.163 L/T` inside `2.7L`; at minimum the full body-frame direction
  error was about `1.42 rad` while speed remained `0.669 U`. Distance-only
  relief (`2.845L`), full-direction gating (`2.494L`), away-half-cycle braking
  (`2.501L`), target-ray lead (`3.167L`), and direct slip correction all failed
  to repair that powered lower-exit topology; the last even reversed release
  into an upper exit at `12.150L`. Avoid retrying proximity-only drive gates,
  isolated half-cycle effort, persistent early line-of-sight/slip correction,
  or a scalar increase to a carrier already clamped for about `0.746/0.354` of
  anterior/posterior samples.
- Treat posterior S-bending as a response-selective local improvement, not as
  evidence for more persistent mean curvature. A wrong-side lateral-velocity
  counterbend improved minimum distance from `2.443L` to `2.187L`, but making
  the same counterbend persist from target geometry regressed to `2.477L`; a
  same-sign closing/turn-response redirect was worse at `2.601L`. Adding a
  bounded target-ray course residual to the velocity-gated counterbend reached
  `2.011L`, the best completed minimum, yet worsened mean/final distance to
  `8.740/9.836L` and still powered through the lower boundary. Preserve the
  far-field carrier and the bounded counterbend envelope, but do not retry more
  equilibrium persistence or gain. A next test must separate terminal
  propulsion from steering only when normalized cross-track motion and failed
  closure agree, or introduce a genuinely different actuator topology. This
  implication applies to coherent, stable lateral near misses and is falsified
  by capture or a useful new termination; premature coasting, degraded cruise,
  larger loads/limit residence, or the same lower exit falsifies an added
  approach-hold mechanism.
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
