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
  `12.150L` closest approach. Later completed evidence nevertheless separates
  posterior sign and persistence: a sampled `7 deg` opposite-sign posterior
  counterbend improved minimum distance from `2.443L` to `2.187L`, kept mean
  distance nearly unchanged (`8.446L` versus `8.443L`), and preserved the long
  coherent wake, whereas the assigned parent's approach-localized same-sign
  response-gated posterior redirect reached only `2.601L`; both still exited
  low. In the `2.187L` trace, its instantaneous lateral-velocity gate exceeded
  `0.05` on only `57%` of samples inside `3L` and repeatedly released while
  normalized lateral target error remained `0.7--1.0`. Since the carrier
  already clamped anterior/posterior acceleration for about `0.746/0.354` of
  its samples, avoid more scalar relief, isolated half-cycle effort, persistent
  early line-of-sight/slip correction, another same-sign posterior redirect,
  or treating a single corrective velocity half-cycle as completed recovery.
  The remaining evidence-backed test is an approach-localized, opposite-sign
  posterior S-bend whose persistence follows normalized lateral target geometry
  and whose release follows geometric correction. This implication applies to
  coherent, powered lateral near misses; it is falsified by degraded far-field
  progress, a short-wake tight curl, unchanged lower exit or minimum, or
  increased posterior actuator/load residence, and does not apply to weak-wake
  or wrong-sign-release failures.
- Validate posterior steering sign as an actuator-topology choice before
  refining when the steering gate activates. Relative to the alignment-gated
  carrier, the assigned parent's same-sign posterior redirect combined four
  plausible signals (approach distance, full target direction, closing
  deficit, and recent turn response) yet worsened minimum/mean distance from
  `2.443/8.443L` to `2.601/8.517L`. A simpler opposite-sign, velocity-gated
  posterior S-bend instead improved the minimum to `2.187L` while holding mean
  distance near `8.446L`; both remained finite, self-propelled, and exited the
  lower boundary. Therefore do not add state features or retune thresholds to
  rescue a same-sign terminal C-bend in this powered-below-target topology;
  preserve the evidenced opposite-sign posterior allocation and test whether
  a geometric persistence/release signal changes the trajectory. This lesson
  is limited to coherent lateral near misses with the same cruise scaffold and
  is falsified by a later same-sign capture, a useful new termination class, or
  evidence that the posterior sign convention changes under another actuator
  split.
- Use raw measured yaw as a terminal half-cycle selector, not as an invitation
  to keep modifying posterior authority or as an unevidenced slow-course
  estimate. The response-selected posterior brake remains the strongest
  sampled intervention: its `2.385L` minimum beat a joint-phase counterbend
  (`2.512L`), full-direction gating (`2.494L`), and a response-released
  posterior equilibrium S-bend (`2.536L`) while preserving a coherent wake.
  The assigned parent's next three completed logs then provide a concrete
  negative sequence: a response-gated posterior equilibrium reallocation
  reached `2.444L`, a response-selected posterior counterstroke reached
  `2.585L`, and approach-localized cancellation of gait yaw with anterior
  joint rate reached `2.541L`; every run remained a powered lower exit. Do not
  tune those posterior reallocations, their phase selectors, or the
  joint-rate cancellation coefficient without a new semantic trajectory. At
  the best brake's minimum, target-direction error was `1.38 rad`, wrong-way
  yaw was `2.19 rad/T`, speed remained `0.705U`, and the instantaneous anterior
  command was only `7.71 rad/T^2` despite frequent carrier clamping elsewhere.
  A defensible next architecture therefore preserves the posterior brake and
  tests bounded, geometry-persistent correction on the anterior actuator that
  still has authority at the failure instant. This implication is limited to
  coherent powered lateral near misses with this cruise scaffold; it is
  falsified by a posterior-reallocation capture or new termination class, by
  loss of wake coherence under anterior redirection, or by unchanged minimum
  and lower-exit topology with increased anterior limit/load residence.
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
