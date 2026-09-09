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
  pulse-phase gating as the robustness mechanism. Transferring the released
  shared half-cycle share to target-line-rate feedback then produced the best
  sampled score and distance integral (`-0.01965/1.90130L`) while preserving
  capture, the direct compact wake, zero `>40 deg` dwell, and
  `0.0363/0.0180` peak normalized planar force/moment. This is useful progress
  evidence, but not terminal-margin evidence: arrival slowed to `15.6893T`,
  raw course miss remained `0.674L`, and absolute target-line rate remained
  `1.562/T`, even though body yaw rate was nearly arrested at `0.073 rad/T`.
  Do not retune the line-rate scale or equate its scalar gain with robust
  redirect completion; it separates settled body yaw from unresolved lateral
  translation. Changing the actuator did not rescue that observation:
  posterior phase-lag modulation retained capture and the compact wake, but
  worsened score to `-0.02201` and crossed with `0.727L` predicted miss and
  `1.715/T` absolute line rate. Requiring instantaneous/windowed line-rate
  consensus also captured and scored `-0.02023`, yet widened those terminal
  quantities to `0.747L/1.738/T`. Together, the shared-handoff, phase-lag, and
  persistence variants reject target-line rate as a redirect-completion signal
  on this carrier: a finite capture or better scalar score can mask the same
  lateral-course defect. Inherited identical-controller repeats still expose
  `1.2164L` and `1.0117L` left-exit misses, while angle-domain subtraction
  lowered effort but missed at `0.8293L`. Preserve the shared geometry/response
  handoff; test any new terminal actuator as a separately scheduled residual
  that tends rapidly to zero on already-centered predicted courses, and require
  both capture and reduced course spread with the direct route, compact wake,
  joint reserve, and load scale intact. Revisit line-rate feedback only under a
  different carrier or when an independently evidenced history statistic
  predicts the near-field course over an interval and improves margin as well
  as score.
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
- Separate terminal speed improvement from terminal-margin improvement on the
  unified predicted-miss carrier. Four direct-quiescent sampled captures all
  retained the same compact alternating wake and direct route, yet final
  body-frame target/velocity reconstruction left `0.651--0.747L` constant-
  course miss against a `0.75L` capture radius. A tail-only cubic predicted-
  miss residual produced the earliest arrival, best score, and smallest miss
  of that group (`15.1403T`, `-0.01094`, `0.651L`), but crossed faster at
  `1.479L/T`, increased peak normalized planar force/moment to about
  `0.0404/0.0190`, and incurred posterior `>40deg` dwell; carrier-separated
  wrong-side-force re-engagement returned to `15.7384T`, `-0.01874`, and
  `0.744L` miss, while instantaneous/windowed line-rate consensus remained at
  `0.747L`. Later miss-conditioned posterior drive relief removed high-angle
  dwell but slowed to `15.8877T`, worsened score to `-0.02596`, and widened the
  miss to `0.734L`; releasing all terminal modulation inside a predicted
  capture corridor similarly slowed to `15.9109T/-0.02184`, crossed at
  `0.716L` miss, and slightly raised peak load to about `0.0376/0.0184`.
  Therefore neither extra terminal geometry/force feedback, suppressing the
  posterior traveling wave, nor wholesale correction release has evidenced a
  robust margin, and the cubic tail residual's scalar gain is mainly speed
  evidence. Four later direct-quiescent residual variants refine the next
  mechanism. Response-releasing only the extra tail authority improved
  reconstructed miss from `0.651L` to `0.573L`, but worsened posterior
  `>40deg` dwell from `1.269%` to `1.551%` and raised peak normalized
  force/moment from `0.04041/0.01902` to `0.04162/0.01968`; miss-conditioned
  posterior drive relief stayed wide at `0.635L` with `1.229%` posterior dwell.
  Neither response release nor drive relief therefore delivered the required
  reserve benefit. Allocating the cubic redirect by posterior angle/rate
  reserve produced a materially different `0.363L` terminal course, reduced
  posterior dwell to `0.996%`, and slightly lowered peaks to
  `0.03970/0.01889`, but slowed capture to `15.4464T/-0.01764` and transferred
  `0.285%` `>40deg` dwell into the anterior joint. Treat state-dependent
  cross-joint allocation as geometric evidence, not yet actuator-quality
  evidence: gate the receiving joint's reserve as well, and shed the extra
  residual when neither path is available. Retain this mechanism only if it
  preserves capture, direct routing, and the compact wake while improving the
  `0.651L` course boundary and reducing both joints' dwell without exceeding
  the tail-only load class. Avoid another residual gain, response-release, or
  broad drive-relief threshold on this carrier; do not transfer the ranking to
  a different carrier or imposed-wake regime without repeating the body-frame
  reconstruction.
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
