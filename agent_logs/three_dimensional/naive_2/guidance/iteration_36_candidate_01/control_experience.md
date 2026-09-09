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
- Use carrier-separated corrective response and residual predicted miss
  together as a rhythmic-steering completion signal; do not replace measured
  terminal geometry with a joint-angle carrier estimate. Among four sampled
  compact-wake captures, applying one response-plus-miss consensus gate to
  both the shared half-cycle redirect and posterior pulse captured earliest
  (`15.5008T` versus `15.9209--16.0270T`), produced the best score and lowest
  normalized distance integral (`-0.02109/1.90236L`), crossed with nearly
  horizontal targetward velocity, and had no `>40 deg` dwell. A fixed
  lateral-corridor half-cycle gate crossed lower, scored `-0.02549`, and put
  the posterior joint above `40 deg` for `0.276%` of samples. This supports a
  common normalized geometry/response handoff over separate threshold logic
  when a predicted-miss carrier already reaches the terminal regime, but not
  stronger drive: the common gate still occupied the near-rate band for about
  `17.8/17.0%` and had slightly higher but comparable `0.0365/0.0180` peak
  normalized planar force/moment. A semantic replicate differing only by one
  blank line also captured (`15.6625T`), upgrading this handoff from a single
  threshold success to repeat capture; however, raw terminal course miss
  widened from `0.1790L` to `0.5900L` and score changed from `-0.02109` to
  `-0.02425` at comparable loads, so the centered crossing is not repeatable
  evidence. Making only the posterior pulse carrier-phase selective retained
  capture but worsened terminal miss/score to `0.7226L/-0.02503`; do not retry
  pulse-phase gating as the robustness mechanism. Inherited identical-
  controller repeats still expose `1.2164L` and `1.0117L` left-exit misses,
  while angle-domain subtraction lowered effort but missed at `0.8293L`.
  Preserve the shared geometry/response handoff, but test a distinct bounded
  redirect-to-cruise mechanism and require both capture and reduced terminal-
  course spread with the direct route, compact wake, joint reserve, and load
  scale intact; repeat capture, lower effort, or one centered score alone does
  not establish margin robustness.
- Treat rapid target-line rotation as a tangential-margin diagnostic, not a
  steering command. Relative to the unified handoff's
  `15.5008T/-0.02109/0.179L` arrival, score, and predicted miss, active yaw
  arrest, course-confirmed release, amplitude relief, duty skew, and moment
  rejection retained direct compact-wake captures but ended with
  `0.679--0.747L` misses. Direct target-line-rate steering then improved scalar
  score to `-0.01965` but crossed at `15.6893T` with `0.674L` miss; adding
  instantaneous/windowed persistence consensus crossed at `15.7829T` with
  `0.747L` miss, and remapping the same rate to posterior phase lag crossed at
  `15.7509T/-0.02201` with `0.727L` miss. All three rate policies retained the
  direct route, alternating 3D wake, and narrow `0.0355--0.0371/0.0174--0.0184`
  peak normalized force/moment class, so their captures do not rescue the
  missing terminal margin. Avoid more line-rate scaling, persistence filtering,
  or actuator remapping on this carrier. The apparently better
  carrier-separated lateral-force sign statistic was not causal: re-engaging
  rhythmic steering on wrong-side force residual captured at
  `15.7384T/-0.01874` but ended with `0.744L` predicted miss and `1.741/T`
  target-line rate, effectively the same wide terminal class despite retaining
  the narrow `0.03563/0.01764` force/moment load scale. Releasing all correction
  inside a predicted capture corridor also remained wide
  (`15.9109T/-0.02184/0.716L`) and reintroduced posterior `>40 deg` dwell, so
  do not iterate force-residual gains or corridor width/horizon thresholds.
  A cubic posterior predicted-miss residual instead produced the earliest,
  score-best sampled capture (`15.1403T/-0.01094`, mean distance `1.89264L`),
  but terminal miss stayed `0.651L` while peak normalized force/moment rose to
  `0.04041/0.01902` and posterior `>40 deg` dwell reached `1.269%`. Treat this
  as evidence for useful translation, not established margin robustness or
  acceptable actuator quality. A later residual allocator should retain the
  direct compact-wake arrival only if joint/load quality improves without a
  worse terminal course; otherwise abandon the posterior residual rather than
  tuning its scalar magnitude.
- Allocate a target-relative rhythmic residual from the present joint command,
  not from the previous action as a carrier-phase proxy. On the same compact-
  wake capture route, absolute dual-reserve shedding captured at
  `15.2957T/-0.01484` with `0.556L` predicted miss, zero anterior and `0.898%`
  posterior `>40 deg` dwell, and `0.03872/0.01876` peak normalized planar
  force/moment. Directional residual-sign capacity improved this tradeoff to
  `0.461L`, zero/`0.681%` dwell, and `0.03959/0.01889` loads at
  `15.3385T/-0.01502`. Replacing that direction with bounded previous action
  then regressed to `0.631L`, zero/`1.878%` dwell, and
  `0.03930/0.01922` loads at `15.2107T/-0.01708`, despite retaining capture and
  the visible coherent route. The lagged action mixes carrier, steering, and
  allocation, so its slightly earlier arrival/lower planar-force peak is not
  evidence of usable phase capacity. Avoid tuning its action scale or reusing
  one-step command sign for allocation. A current-command restoring-margin
  allocator is a distinct falsifiable follow-up only if it matches or beats
  the directional policy's terminal miss and two-joint dwell without changing
  the direct wake-supported route; otherwise preserve directional capacity or
  abandon this posterior residual family. Revisit the ranking only under a
  different carrier or if current-command and actuator state are unavailable.
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
