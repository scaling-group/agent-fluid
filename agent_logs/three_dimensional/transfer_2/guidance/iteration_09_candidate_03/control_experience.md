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
  achieved `2.606L`; handing it to the carrier-unloaded target-behind pivot
  improved that to `2.579L`, but retained an upper exit at `45.331T`. Giving
  the pulse steering-first use of the existing acceleration envelope is the
  first allocation change that materially alters this topology: it reaches
  `1.076L` at about `25.98T`, improves mean/final distance to
  `6.178/6.307L`, and lowers raw acceleration-envelope exposure from the
  handoff parent's `82.76%` to `74.65%`. Preserve this structural priority
  result rather than turning it into another gain sweep. It is not yet a safe
  capture mechanism: the allocator releases near zero closing speed while the
  normalized target-behind request remains about `0.97`, after which the fish
  exits north at `37.823T`; posterior position-limit exposure also rises from
  zero to `13.86%`, with isolated force/moment coefficient spikes near
  `0.466/0.211` at the hard stop. The next reusable test is a continuous,
  mirror-equivariant allocation handoff from the closing pulse through the
  existing target-behind request, not more curvature or another threshold-only
  edit. Within that handoff, a joint-state barrier may suppress same-side
  outward acceleration near the position stop: the fixed actuator integrator
  discards that command and resets outward rate there, so it adds load exposure
  without useful motion. This applies while passage and reacquisition are
  observable from normalized body-frame forward/lateral target position;
  falsify it if it loses the near pass, fails to reduce the hard-stop/load
  class, or retains the northbound exit.
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
