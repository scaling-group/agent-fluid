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
  on re-projecting, renaming, or otherwise repackaging it.
- The three replicated phase-neutral-yaw plus carrier-first-allocation
  captures establish a protected route mechanism, while the next controlled
  comparison shows that the phase decomposition should be applied
  consistently to coupled body-frame route derivatives.  Relative to
  carrier-first allocation alone, the replicated combination advances capture
  from `25.9545` to `23.9305 T` and lowers mean distance from `2.55008` to
  `2.45000 L`, with the same sampled `0.02974/0.01484` peak planar-force/yaw-
  moment scale and a coherent two-view posterior wake.  Removing the same
  joint-observed carrier rotation from body-frame bearing trend as from yaw
  preserves that wake, advances capture again to `23.6390 T`, lowers mean
  distance to `2.44217 L`, and improves score from `-0.55178` to `-0.54451`.
  Applying the same decomposition to proportional target geometry is the
  stronger result: keep raw normalized body-frame geometry for large-error
  redirect selection, subtract the redirect's expected anterior-joint mean,
  and rotate bearing and target-vector angle by the residual observed carrier
  angle.  This gait-frame projection preserves the coherent two-view wake and
  continuous target-signed arc, advances capture to `20.5315 T`, lowers mean
  distance to `2.18697 L`, and improves score to `-0.29558`; distance is
  already `11.8178 L` at `4 T` and `1.1210 L` at `20 T`, versus `11.9855` and
  `3.2546 L` for its parent.  Its cost boundary is a rise in mean/max speed
  from `0.553/0.810` to `0.628/0.894 L/T`, peak planar force/yaw moment from
  `0.02974/0.01484` to `0.03056/0.01525`, and head acceleration-limit
  residence from `32.53%` to `35.95%`; tail and any-joint residence fall to
  `10.37%` and `46.32%`.  Preserve raw-geometry redirect, gait-frame
  proportional steering, phase-neutral derivative feedback, and carrier-first
  residual allocation when joint-correlated recoil contaminates body-frame
  route observations.  Falsify this decomposition in held-out conditions that
  lack that correlation or if its higher speed/anterior saturation causes lost
  capture, incoherent wake, or materially larger loads.
- Better early distance is not sufficient evidence for a launch mechanism.
  The body/joint-stillness-gated posterior bend improves the common-mode
  parent's distance from `12.2844/11.9855/10.5536 L` to
  `12.2595/11.8580/10.1631 L` at `2/4/8 T`, and slightly improves mean distance
  and score from `2.44217/-0.54451` to `2.42365/-0.52481`, but it is behind by
  `20 T`, delays capture from `23.6390` to `24.2220 T`, and raises peak planar
  force/yaw moment from `0.02974/0.01484` to `0.03442/0.01717`.  Both visual
  rows retain a coherent posterior wake, so this is a route-phase regression,
  not failed propulsion.  Together with the earlier tail-velocity energy
  envelope, which also improved `2--4 T` closure but delayed capture and
  worsened mean distance, this shows that a bounded startup term must be judged
  through late route topology and loads.  Do not compose either isolated launch
  term into the gait-frame winner without a factorized test that preserves its
  capture time, mean distance, coherent wake, saturation, force, and moment.
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
