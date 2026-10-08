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
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- In the sampled direct-still-water seed rollout, the lagged carrier formed a
  coherent 3D wake and reached `0.636U`, but target bearing swept from roughly
  `+0.19` through zero to `-1.44 rad`; best progress was only `0.250L` before
  an upper-boundary exit at `8.547T`. Raw joint-acceleration commands also
  exceeded the actuator envelope in about one third of samples. Treat this
  topology as missing target-relative steering, not evidence for more drive:
  preserve the useful traveling bend and test bounded body-frame curvature
  before increasing carrier gains. Falsify that implication if curvature
  feedback destroys wake coherence, materially increases saturation, or does
  not improve bearing containment, progress, or termination class.
- The first four direct-uniform still-water target-feedback rollouts sharpen
  that seed lesson. Three posterior mean-curvature variants preserved coherent
  propulsion and improved closest distance to `9.141L`, `11.642L`, and
  `11.824L`, yet all crossed into diverging negative bearing and exited the
  upper boundary by `13.129T`; changing curvature cap, bearing scale, trend
  lead, or instantaneous yaw-rate feedback did not improve termination class.
  A fourth variant moved both joint centers, limited the anterior oscillation
  to about `8 deg`, and worsened final distance to `13.403L`, despite avoiding
  raw acceleration clipping. For this carrier, do not treat static-offset gain
  tuning as course recovery and do not shift the anterior oscillator center
  without separate evidence that thrust survives. When a posterior offset
  retains progress but cannot reverse the post-crossing yaw, test a different
  phase-aware actuator primitive such as bounded half-cycle asymmetry or mild
  lag modulation. Reconsider this boundary only if such a controller loses
  wake coherence or a static offset later demonstrates bearing recovery and a
  better termination class without increased limit occupancy.
- The later sampled and inherited sequence separates target approach from
  corrective work. The unrelieved bearing-minus-slip carrier reached
  `2.960L`, while distance-conditioned posterior relief and carrier-wide hold
  worsened closest approach to `3.162L` and `3.592L`; a static full-quadrant
  redirect and an instantaneous-yaw-gated anterior redirect recovered only
  `2.999L` and `2.989L`. An additional inherited continuation reached
  `2.986L`, yet every case still exited the upper boundary. The visual sheets
  and trajectories show a coherent, self-propelled alternating wake during
  approach, followed by nearly fixed joints during the held redirects; local
  flow stayed far below swimming speed, so the common pass-and-hook is not
  passive still-water advection. Full-quadrant geometry is necessary after a
  pass, but neither distance relief, a held center shift, nor beat-contaminated
  instantaneous yaw gating supplies active course recovery. Preserve the
  zero-centered carrier and test target-signed, joint-phase-gated corrective
  work that stays rhythmic and releases with body-frame alignment. Falsify
  this implication if such asymmetry loses the alternating wake, materially
  raises limit occupancy, cannot beat the `2.960L` reference, or repeats the
  upper exit without a distinct recovery arc.
- Phase-aware steering must be judged by where it allocates corrective work,
  not by continued oscillation alone. The sampled anterior half-cycle
  stiffness variant kept an alternating 3D wake, but closest approach worsened
  to `4.859L` from the inherited unrelieved carrier's `2.960L`, peak speed fell
  from about `1.03U` to `0.95U`, applied acceleration-limit occupancy rose
  from roughly `34/45%` to `53/64%`, and termination remained the same upper
  exit. Avoid further anterior restoring-stiffness or gain asymmetry on this
  carrier; if testing phase-aware correction, place it in posterior wave
  timing or another cycle-resolved channel that leaves the zero-centered
  anterior oscillator unchanged. Falsify this boundary only if an anterior
  phase mechanism improves bearing recovery or termination class while
  preserving the `2.960L` approach and without raising limit occupancy.
- Three completed inherited posterior/recovery tests show that detecting the
  failed pass is not the same as producing corrective yaw. Posterior phase-lag
  modulation worsened closest approach to `3.532L` and raised raw
  acceleration-limit occupancy to about `56/66%`; posterior counterstroke
  relief retained a `2.978L` approach, but full bearing still diverged from
  about `-1.39 rad` near the pass to `-2.66 rad` by `24T`. A receding-gated
  distributed coil slightly improved closest distance to `2.959L`, yet it
  settled near `(-14,-20) deg`, shed little sustained corrective wake, and
  reached about `-2.71 rad` bearing before the same upper exit. Treat large
  error and target-receding motion only as gates, not as turn mechanisms, and
  avoid further held distributed bends or half-cycle selectors based on an
  unevidenced posterior-target sign. The repeatable `4--12T` carrier data give
  a sharper phase calibration: yaw-moment sign follows anterior-angle sign
  (means near `-0.0077/+0.0078`). A posterior-only cyclic allocation may use
  that observed sign to reduce the counter-moment half while leaving the
  zero-centered anterior carrier and useful half intact. Falsify this boundary
  if moment-aligned allocation degrades the broad approach, raises limit
  occupancy, loses alternating shedding, or still cannot reverse bearing or
  termination topology.
- The inherited speed-gated target-ray/velocity-course controller is the first
  sampled observation change to break the repeated `2.959--3.532L` approach
  plateau: with the same zero-centered anterior oscillator and lagged
  posterior carrier, it reached `0.857L` and changed the common upper hook to
  a left-boundary exit. Its top-down and oblique sheets retain a coherent,
  self-propelled three-dimensional wake (`1.052U` peak speed versus `0.031U`
  peak local flow), so the improvement is consistent with correcting actual
  motion direction rather than stronger drive or passive advection. Preserve
  wrapped body-frame course error as the broad steering observation before
  adding another recovery mode. It is not yet a terminal solution: the fish
  passed nearly tangent to the capture circle with about `-1.42 rad` course
  error, missed the `0.75L` radius, finished at `8.909L`, and raw acceleration
  exceedance remained about `58/68%`. Falsify the broad-steering lesson if it
  cannot reproduce a sub-`1L` approach or loses alternating shedding; test any
  later terminal-authority mechanism separately and require capture or lower
  effort rather than accepting another small closest-distance change.
- The completed posterior acceleration-reserve controller converts the
  inherited `0.834--0.876L` tangent-miss/left-exit family into capture near
  `0.75L` and `18.27T`, with an alternating top-down wake and compact
  three-dimensional Lambda2 structures. Preserve its explicit allocation of
  the posterior envelope between carrier and body-frame velocity-course
  steering; prior curvature, held-bend, and phase/load overlays do not support
  adding nominal bend. The later barrier results separate mechanical safety
  from scalar score. The sampled `8 deg` fixed-width brake scores slightly
  better at `-0.247735`, but still reaches exactly `-45 deg` and peaks at
  `0.17183/0.07699` normalized force/yaw moment. Three normalized
  velocity-conditioned stopping-margin variants instead preserve the same
  capture topology and visual wake, stop near `-42.998 deg`, and reduce those
  peaks to `0.03716/0.01907`, despite scores near `-0.24813`. Protect a rhythmic
  joint using kinetic stopping distance relative to remaining angle margin,
  not a fixed spatial guard; keep that mechanical invariant independent of
  target distance when the empirical risk onset leaves the broad route
  untouched. Applicability is currently established only for the posterior
  negative-side terminal stroke, so revise this lesson if held-out cruise
  motion activates the barrier, capture or alternating shedding is lost, a
  boundary is contacted, or loads exceed `0.0372/0.0191`.
- Output feasibility is distinct from demand economy. In the stopping-margin
  capture trace, raw anterior/posterior acceleration exceeds the envelope in
  `51.28/46.40%` of samples and joint speeds touch `260 deg/T` in `160/89` of
  3323 samples. A sampled variant that merely clamps both returned commands to
  `1800 deg/T^2` has exactly the same score, trajectory, joint history, wake,
  and loads because it duplicates downstream clipping. Do not count policy-
  side hard clipping as a physical improvement or continue threshold-only
  edits. To test whether saturation is necessary for this carrier, change the
  demanded waveform continuously while retaining the zero-centered rhythm,
  posterior steering reserve, and stopping-margin override; require capture
  plus lower acceleration and joint-speed limit occupancy. Falsify this
  direction if demand shaping alters the broad route, destroys coherent
  shedding, loses capture, reintroduces posterior contact, or only changes the
  reported raw command without changing applied joint motion.
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
