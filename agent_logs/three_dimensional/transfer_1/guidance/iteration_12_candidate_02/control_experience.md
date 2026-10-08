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
- This lineage starts from the transferred 2D clean-B iteration-20 champion.
  It contains target-aware feedback; evaluate its actual 3D performance rather
  than assuming either successful transfer or a missing steering mechanism.
  No 3D solver or optimizer population is imported.
- The transferred champion's direct-uniform still-water rollout establishes a
  useful carrier but a failed steering topology: its coherent alternating 3D
  wake and roughly `0.8 L/T` speed persist as distance improves from
  `12.3277 L` to `4.7800 L` at `17.853 T`, then the path continues downward,
  distance rebounds to `9.7089 L`, and it exits the lower boundary at
  `27.495 T`.  For this approach-then-diverge pattern, preserve the posterior-
  lag gait and test body-frame motion anticipation or response-gated curvature
  before increasing carrier amplitude/frequency.  Falsify that implication if
  earlier redirection weakens closing or wake coherence, creates persistent
  saturation, or leaves the same closest approach and `left_domain` topology.
- The completed redirect comparison resolves the inherited near miss and also
  bounds actuator-interface changes.  The observed-yaw response gate first
  improved the transferred seed from `4.7800 L` to `2.4625 L`; requiring
  normalized body-frame angle contraction before yaw can release the redirect
  then preserves the alternating 3D wake and captures at `0.7496 L` and
  `26.411 T` with mean/max speed `0.501/0.667 L/T`.  This supports geometric
  completion gating over the inherited velocity-lead, shared-curvature, and
  global drive-relief branches, which lost useful closure.  A later command-
  envelope variant still captures but its outward acceleration guard near the
  joint-speed limit trails the captured parent throughout the route, arriving
  `0.4015 T` later with mean distance `2.6382 L` versus `2.6134 L` and score
  `-0.73429` versus `-0.71050`; its force/moment extrema remain essentially
  unchanged.  The isolated policy-side acceleration projection is now a
  validated interface improvement under this evaluator: it reduces issued
  command peaks from `74.1975/85.6413` to `31.4159/31.4159 rad/T^2`, while
  every non-command trajectory column, the combined keyframe sheet, the
  `26.411 T` capture, and score remain identical because the plant already
  applies the same componentwise clamp.  The added speed guard is not
  equivalent because it changes the applied dynamics.  For this coherent,
  stable capture topology, retain completion-gated curvature, project finite
  acceleration at the existing parameter-owned command boundary, and avoid
  outward speed-envelope attenuation unless it is isolated and repays the
  closure delay.  This equivalence applies only when projection bounds and
  ordering match the downstream clamp; retest for a different actuator model,
  and reconsider speed feedback only if a held-out pose shows speed-limit
  residence causing instability or loss of capture.  The assigned parent and
  current four-solver sample also show that this interface result is now an
  exhausted optimization branch: repeated projection variants have identical
  non-command trajectories, wake sheets, `26.411 T` capture, and score, so
  later workers should retain the finite clamp but not spend another candidate
  on re-projecting, renaming, or otherwise repackaging it.  The remaining
  evidenced opening is the slow launch (`12.3277 L` initially and `12.263 L`
  at `1.99 T`) before closure settles near `0.5--0.6 L/T`.  Test any attempt to
  improve it as one bounded posterior-only, response-gated mechanism that
  releases when normalized closure is established and yields to large steering
  demand; do not globally increase the already speed-limited carrier.  This is
  a test boundary, not a claimed result: reject the mechanism if early distance
  does not improve or if capture time, distance integral, tail-limit residence,
  wake coherence, force, or moment regresses.
- Complete an observed gait/route decomposition across coupled guidance
  signals before adding propulsion.  The assigned parent established that
  phase-neutral yaw plus carrier-first residual allocation captures at
  `23.9305 T` with mean distance `2.45000 L`; applying the same anterior-joint
  rate common mode to bearing trend then captures at `23.6390 T` and
  `2.44217 L`.  The sampled gait-frame pose projection is a larger semantic
  gain: it preserves the coherent alternating top-down and oblique posterior
  wake, leads the rate-only route by `0.93/1.77/2.23 L` at `8/12/16 T`, and
  captures at `20.5315 T` with mean distance `2.18697 L`.  This improvement is
  not actuator relief—peak speed rises from `0.8100` to `0.8944 L/T`, with
  `46.29%` acceleration-limit residence and peak normalized force/moment
  `0.03056/0.01525`.  The informative launch-wave sibling initially leads at
  `2 T` but stays visibly straighter through the middle, falls back to
  `24.2220 T`/`2.42365 L`, and raises force/moment peaks to
  `0.03442/0.01717`; do not use early scalar progress to revive extra launch
  excitation.  After the proven anterior pose correction, all four sampled
  trajectories retain a beat-locked target-angle component tied to observed
  posterior tangent (`q1+q2`, reconstructed coefficient magnitude
  `0.22--0.27`), so a bounded two-joint carrier observation is the next
  mechanism-level test, not a claimed result.  Subtract known commanded mean
  curvature before treating joint pose as carrier phase, retain raw geometry
  for large-error redirect, and reject the extension if it loses the
  `20.5315 T` capture, worsens distance integral, wake coherence, route sign,
  or the established speed/action/load envelope.  The inherited near-miss
  log (`0.8006 L` before `left_domain`) also makes capture—not closest approach—
  the semantic boundary; require held-out poses to reproduce the joint/body
  phase relation before generalizing the decomposition.
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
