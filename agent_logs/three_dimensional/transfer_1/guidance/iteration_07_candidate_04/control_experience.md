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
  residence causing instability or loss of capture.
- The completed posterior-thrust comparison confirms the inherited
  response-gating hypothesis while sharply limiting where it should act.
  Relative to the completion-gated capture, a closure-gated increase of only
  the observed-head-velocity term in the posterior target preserves the
  coherent two-view wake and peak lateral force/moment, reduces capture time
  from `26.4110 T` to `26.0425 T`, and improves score-model mean distance from
  `2.61340 L` to `2.59751 L` and score from `-0.71050` to `-0.69472`.  An
  aligned low-speed cadence residual is not an equivalent propulsion
  mechanism: it captures at `26.5430 T` and raises peak lateral force/moment
  despite a modest distance-integral benefit.  The posterior residual itself
  trails the parent near `2 T` and `8 T` before leading by `16 T` and `24 T`,
  so preserve the base carrier at low body-forward motion and use measured
  locomotor response to admit posterior wave-shape assistance after propulsion
  is established; do not substitute a global or alignment-only cadence boost.
  This implication is evidenced for the direct-uniform still-water pose and is
  falsified if motion gating loses the late distance lead, delays capture past
  `26.0425 T`, increases actuator-limit residence or loads, or fails to recover
  the early distance deficit; held-out poses must re-establish the speed scale.
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
