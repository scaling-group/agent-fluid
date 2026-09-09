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
- Once the restrained `7 deg` mean-curvature carrier produces a coherent
  target-directed wake but powers past the target to a lower-boundary exit,
  do not keep varying only equilibrium curvature or scalar drive gates. The
  alignment-gated parent reached `2.443L`, whereas distance-only carrier relief
  reached `2.845L`, full-direction posterior gating `2.494L`, anterior
  return-half-cycle braking `2.501L`, and closing-response-gated stronger
  curvature reached only `2.468--2.729L`; all retained long wakes, receded,
  and exited below. Subsequent posterior half-cycle asymmetry and slip-gated
  phase rotation also failed, so do not retry those mechanisms as renamed gain
  sweeps. Change the actuator topology or feedback information and demand a
  meaningfully different useful trajectory. The lesson applies when
  propulsion, the initial correct-sign route, and finite dynamics are intact;
  it does not apply to a wrong-sign release turn, collapsed wake, instability,
  or a genuinely new termination class, and a later capture or materially
  different redirect would falsify the claimed topology plateau.
- Do not treat wrong-side body-frame lateral velocity as sufficient evidence
  for adding more same-sign C-curvature. On the alignment-gated carrier, a
  wrong-side-only `5 deg` posterior mean bias worsened the minimum from
  `2.443L` to `2.697L`; target-ray-rate lead reached only `3.167L`, and
  unrestricted course-angle-to-anterior-curvature feedback reversed the useful
  release and exited above after reaching only `12.150L`. Posterior
  half-cycle gain asymmetry was also harmful (`3.661L` and an earlier lower
  exit), while slip-gated phase rotation retained the lower-exit topology at
  `2.822L`. When body pointing is near the target but translation is
  cross-track, preserve the proven anterior carrier and test a separately
  falsifiable posterior wave-shape or counter-bend channel before reusing
  velocity as additive curvature. This lesson applies to coherent,
  self-propelled finite rollouts with the same wrong-side slip signature; a
  sign-calibrated course controller that preserves release and materially
  changes the route would falsify the restriction.
- Treat the sampled posterior counter-bend as evidence for sign and allocation,
  not as an indefinitely extensible equilibrium channel. It improved the
  alignment-gated carrier's minimum from `2.443L` to `2.187L`, and a later
  target-ray velocity residual moved the minimum again to `2.011L`; however,
  the residual worsened final distance from `9.281L` to `9.836L` and score
  from `-10.238` to `-10.639`, while a geometry-persistent counter-bend
  regressed to `2.477L`. Both later variants retained coherent wakes and the
  same powered lower exit. When the full direction error grows beyond about
  `0.7 rad`, closure collapses below roughly `0.6 L/T`, and cross-track speed
  remains high inside `3L`, do not stack another posterior mean bias or claim
  a smaller minimum as course recovery; test a separately falsifiable
  actuator-mode change that can reorient the body. This boundary applies only
  after the cruise route and wake remain intact. Capture, a new terminal
  topology, or a stable redirect without extra limit residence would falsify
  the equilibrium-channel plateau.
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
