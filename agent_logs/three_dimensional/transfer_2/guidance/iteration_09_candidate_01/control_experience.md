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
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Steering release is useful only as a partial correction in this lane, not a
  source of the missing counter-turn.  Yaw-response release changed the seed's
  `4.780/9.709L` minimum/final distance to `4.660/9.604L` but retained the
  lower exit and about `98%` raw acceleration-envelope exposure.  Geometry-
  gated wrong-polarity curvature release then improved minimum distance to
  `4.141L` and survival from `28.369T` to `32.197T`, yet still exited below at
  `9.570L`; late progress-gated cadence relief likewise retained the lower
  topology while worsening closest approach to `5.347L`.  Preserve the
  coherent `0.55T/28 deg` posterior-lagged carrier and the evidenced curvature
  release, but do not repeat another release threshold, yaw-window gain, or
  cadence gate as the sole mechanism.  This implication applies while the
  evaluator's seven-state history spans only about `0.0385T` and the carrier
  remains clipping-dominated; it would be falsified by a genuinely cycle-scale
  response signal or carrier-allocation mechanism that changes termination or
  produces a meaningfully different useful trajectory without losing the deep
  approach.
- Put route steering upstream of final acceleration clipping and treat target
  passage as a distinct control regime, but do not assume that more persistent
  target-ahead phase allocation improves a later recapture. The inherited
  progression from opposing-only relief (`3.033L`) to persistent route relief
  (`2.999L`, `89.62%` raw acceleration-envelope exposure) improved the pass but
  retained the westward runout. A posterior-curvature branch then supplied the
  new semantic capability: it preserved the approach through about `22T` and
  produced the only sampled late hairpin. The new paired evaluation closes the
  prior combination hypothesis negatively: persistent route relief plus that
  recapture changed basic recapture's minimum/mean/final distances only from
  `3.031/7.107/7.528L` to `2.996/7.071/7.522L`, and both left the upper boundary
  at about `49.4T` with essentially the same trajectory. Do not repeat route-
  phase persistence as the sole addition to this recapture. Posterior carrier
  unloading is a useful allocation adjunct rather than a completed maneuver:
  it retained the hairpin, lowered raw acceleration-limit exposure from
  `92.77%` to `82.97%`, and improved mean/final distance to `7.021/7.417L`, but
  still exited with the target behind. Separately, a closing/abeam sector pulse
  achieved the unique `2.606L` approach yet removed the hairpin and left at
  `39.699T`. The now-evaluated state-defined handoff from that pulse to the
  carrier-unloaded, mirror-equivariant tail-only pivot preserved and slightly
  deepened interception (`2.579L`) with `82.76%` raw acceleration-envelope
  exposure, but it still kept the target behind and moved the upper exit
  earlier to `45.331T` at `7.435L`. The assigned parent's paired result closes
  its proposed distributed-curvature follow-up as a standalone remedy: minimum
  and final distance remained `2.591/7.436L` with the same upper-exit family,
  so do not repeat another anterior/posterior curvature split without a new
  release or allocation observable. In contrast, reserving acceleration
  headroom for the existing closing-sector steering changes the useful
  topology materially: minimum/mean/final distance improve from
  `2.579/6.913/7.435L` to `1.076/6.178/6.307L`, and raw acceleration-envelope
  exposure falls from `82.76%` to `74.65%`. Preserve that allocation rather
  than retuning the sector thresholds. Its coherent top-down and Lambda2 wake
  passes just outside capture with `0.762L/T` speed and `1.41 rad/T` yaw while
  local crossflow is only about `0.010L/T`, then follows a broad near-vertical
  runout to the upper boundary. For a near-and-closing target under those conditions,
  the next reusable test is to unload only the propulsive carrier toward a
  nonzero floor while preserving bounded steering, then release the unloading
  when closing ends or the target is materially behind. Falsify this implication
  if it disturbs the pre-terminal approach, destroys the coherent wake,
  worsens loads or limit exposure, or fails to turn the `1.076L` pass into
  capture or a demonstrably tighter miss.
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
