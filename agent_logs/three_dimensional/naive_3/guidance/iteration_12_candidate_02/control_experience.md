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
  and motion rather than proximity alone. In the completed samples, posterior
  bearing gating improved closest approach from `4.067L` (plain `7 deg`
  curvature) and `3.587L` (toward-bend half-cycle boost) to `2.443L`, with a
  coherent wake and survival to `31.097T`. Across the three closest sampled
  approaches, median closing response fell consistently from about
  `0.586--0.606 L/T` between `3--4L` to `0.131--0.163 L/T` inside `2.7L`; at
  the best minimum the full body-frame direction error was about `1.42 rad`
  while translational speed remained about `0.669 U`, after which the fish
  receded to a lower-boundary exit. A distance-only energy envelope (`2.845L`),
  full-direction posterior gating alone (`2.494L`), and away-half-cycle braking
  (`2.501L`) all preserved that topology. Two inherited attempts to repair the
  course earlier also failed: matched-window target-ray lead worsened minimum
  and mean distance from `2.443/8.443L` to `3.167/8.602L`, and an earlier
  wrong-side lateral-velocity posterior guard reached only `2.697L`; both
  retained the powered lower exit. Direct sideslip-to-curvature feedback was
  worse still, reversing the useful release into an upper exit with only
  `12.150L` closest approach. Later completed evidence separates posterior sign
  from persistence. A sampled `7 deg` opposite-sign, velocity-gated posterior
  counterbend improved minimum distance from `2.443L` to `2.187L`, held mean
  distance nearly unchanged (`8.446L` versus `8.443L`), and preserved the long
  coherent wake; the assigned parent's same-sign response-gated redirect
  reached only `2.601L`. But making the opposite-sign counterbend persist from
  target geometry alone repeatedly regressed to `2.477--2.484L`, rotated the
  body farther in the unhelpful direction at minimum (`0.771` versus
  `0.622 rad`), and did not reduce command-limit residence or change the lower
  exit. A bounded target-ray residual on the velocity-gated S-bend achieved the
  best inherited minimum (`2.011L`) but worsened mean/final distance to
  `8.740/9.836L`; adding course/closure-conditioned posterior-wave attenuation
  reached `2.179L` with `8.700/9.717L` mean/final distance and still exited low.
  At that minimum, projecting center velocity onto the target ray indicated
  `0.304 L/T` closure even though head distance was at its turning point, so
  center translation is not a reliable terminal-response proxy when yaw moves
  the head. The formerly clean posterior-response test is now also negative:
  an approach-localized opposite-sign S-bend gated by measured head-distance
  closure and released by corrective bearing trend reached only `2.536L`
  (`8.436L` mean), versus the assigned parent's `2.443/8.443L`, and preserved
  the coherent powered lower exit with anterior/posterior clamp residence
  `0.748/0.348`. Cross-track/closure-gated posterior-wave attenuation changed
  the minimum only to `2.429L`, worsened mean distance to `8.454L`, and retained
  the same exit and `0.748/0.358` clamp residence. Together with the sampled
  full-direction result (`2.494L`), no positive terminal lesson survives from
  more posterior counterbend, wave attenuation, or gate refinement. Retire
  that actuator family unless new evidence changes termination or beats the
  inherited `2.011L` local benchmark without degrading the distance integral.
  For the next distinct mechanism, preserve the posterior traveling wave and
  place a bounded, approach-localized signed bearing-trend brake in the primary
  mean-curvature request when measured head-distance closure collapses; at the
  parent's minimum, bearing was `1.421 rad` and worsening at `2.36 rad/T` while
  closure was only `0.009 L/T`. This implication applies only to coherent,
  powered lateral near misses and is falsified by degraded far-field progress,
  a shortened wake, higher limit residence, or the same lower exit with no
  meaningful local or integral improvement; it does not apply to weak-wake or
  wrong-sign-release failures.
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
