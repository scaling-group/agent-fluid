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
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- In the direct-quiescent L64 seed rollout, a coherent self-generated wake and
  0.94 L of targetward x motion did not provide navigation: y drifted 1.20 L
  away, distance improved by only 0.258 L, both joint-rate limits were reached,
  and the fish exited the upper boundary at 8.60 T. With the same carrier,
  shared-joint bearing/slip half-cycle asymmetry first improved displacement to
  `2.041L` left and `11.347L` closest distance; gating stronger redirect
  authority on wrong-side response then preserved the coherent alternating 3D
  wake and extended those results to `3.801L` left and `9.759L` closest.
  Posterior static curvature (`1.056L` left, `12.056L` closest) and tail-only
  half-cycle variants (`11.670--11.867L` closest) remained weaker. Prefer
  bounded shared-joint beat asymmetry over persistent curvature when this
  carrier already propels, and treat response-gated authority as a real
  distance/translation improvement rather than semantic success: even the
  strongest sample drifted `1.202L` upward, occupied a joint-rate limit for
  `11.1%` of logged steps, and exited the same upper boundary at `10.32T`.
  Falsify the ranking under a different carrier or if wake coherence, loads,
  limit occupancy, closest approach, and termination do not improve together.
- Protecting joint-rate reserve is not by itself evidence of better control.
  On the same carrier, a course-residual half-cycle policy with a smooth rate
  barrier reduced sampled near-limit occupancy from `11.1%` to zero, but
  weakened leftward displacement from `3.801L` to `1.647L`, worsened closest
  approach from `9.759L` to `11.643L`, and still exited the upper boundary at
  `9.14T`. Avoid broad carrier braking as an add-on to steering unless it
  preserves translation; to isolate whether course feedback is useful, test
  it as a geometry/response gate on the high-progress carrier and require a
  better termination class as well as distance progress.
- Phase-compensating body yaw before response feedback is the first sampled
  mechanism to escape the repeated early upper-boundary topology on this
  carrier. Subtracting a two-joint-rate carrier model from heading rate while
  retaining response-gated shared half-cycle steering extended survival from
  `10.32T` to `27.43T`, improved closest distance from `9.759L` to `3.174L`,
  and preserved a compact alternating 3D wake. It did not capture: the fish
  crossed the target x station about `3.16L` high at roughly `0.98L/T`, then
  exited the left boundary with distance back at `9.415L`. Preserve the
  phase-separated response mechanism when the carrier dominates raw yaw, but
  treat full-drive approach overshoot as its new boundary; test normalized
  approach hold or terminal steering without broad far-field carrier braking,
  and require capture or a closer pass without loss of pre-approach translation
  and wake coherence.
- Do not infer a universal terminal common-curvature sign from one quiet
  closest-pass state.  A closing-speed hold improved the inherited
  course-residual route from `1.276L` to `1.00784L`, removed `>40 deg` joint
  dwell, and limited peak normalized planar force/moment to about
  `0.028/0.018`, yet still crossed at `1.011L/T` and exited left.  Reversing
  only that hold's common-curvature sign then worsened closest approach to
  `1.106L` and retained `left_domain`, despite improving final distance from
  `9.228L` to `8.686L`.  Together with the sampled mean/posterior bend releases
  (`2.664L` at `0.488/0.220` peaks versus `3.312L` at `0.890/0.414`), this
  rejects further static-bend sign/gain or bend-threshold iteration on this
  carrier.  Test a distinct normalized response-gated actuator that preserves
  the rhythmic restoring half-cycle, and retain it only if capture/closest
  pass and termination improve together without losing wake, joint, and load
  quality; revisit persistent curvature only under a different carrier or a
  reflected-case response map.
- Treat carrier changes and static steering offsets as a coupled risk, not
  independent scalar knobs. Inherited evidence shows that equal two-joint
  mean-curvature variants weakened useful translation, while centering a
  slower carrier on bearing/slip/yaw curvature removed rate saturation but
  produced a large wrong-way loop, moved `2.201L` away in x, and ended at
  `15.408L`. Later workers should not infer a universal curvature-to-yaw sign
  across carrier regimes or accept longer survival as improvement; after
  repeated same-boundary exits, test a new normalized response-gated actuator
  mechanism and require both geometric progress and a better termination
  class before retaining it.
- Once body-frame constant-course predicted miss produced capture, four
  sampled posterior/half-cycle handoff variants all retained the same direct,
  compact-wake capture class at `15.921--16.027T` and
  `0.74729--0.74998L`. Keeping the posterior pulse active scored `-0.024438`;
  releasing it on corrective yaw alone scored `-0.025018`; qualifying that
  release by small remaining predicted miss gave the best sampled score
  (`-0.023351`) and lowest distance integral (`1.905785L` versus
  `1.906407L` for the assigned parent); a lateral-corridor gate on the
  separate half-cycle handoff arrived fastest but scored `-0.025487`. Preserve
  the traveling carrier and raw target/course predictor, and prefer agreement
  between corrective response and remaining miss when releasing a terminal
  wave-shape correction. Do not combine terminal gates or tune gains merely
  from these small nominal score differences: inherited repeats of closely
  related pulse policies missed at `1.0--1.22L`, while a low-load,
  lower-rate-occupancy carrier-angle rewrite still missed at `0.829L` and
  exited left. Falsify the preference with repeat or reflected captures,
  increased capture margin, or a jointly worse termination, wake, joint, load,
  and distance-integral class.
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
