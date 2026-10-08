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
- The completed posterior acceleration-reserve continuation converts the
  inherited `0.834--0.876L` tangent-miss/left-exit family into capture near
  `0.75L` and `18.27T`, with an alternating top-down wake and compact
  three-dimensional Lambda2 structures. Preserve its explicit allocation of
  the posterior envelope between carrier and target-course steering; prior
  curvature, held-bend, and phase/load overlays do not support adding nominal
  bend. The later barrier family resolves its mechanical hard-stop defect and
  separates the useful invariant from an ineffective spatial guard. The
  sampled `8 deg` fixed-width brake still touches exactly `-45 deg` and peaks
  at `0.17183/0.07699` force/yaw moment. In contrast, both normalized
  velocity-conditioned stopping-margin variants preserve capture, remain near
  `-42.8` to `-43.0 deg`, and reduce whole-trace peaks to `0.03716/0.01907`.
  The continuous stopping-risk projection also lowers applied posterior limit
  occupancy from the binary brake's `46.86%` to `46.40%` while slightly
  improving score. Therefore protect a rhythmic joint with kinetic stopping
  distance relative to remaining angle margin, not guard width alone; prefer
  a continuous directional acceleration projection over a Boolean maximum-
  braking switch when both preserve viability. The successful continuous
  sample multiplied risk by a target-distance gate that was already fully open
  at the terminal event, so it does not establish that mechanical safety may
  be disabled farther away. If decoupling that gate, first separate ordinary
  carrier risk from terminal risk: in these traces the stopping-risk ratio
  briefly reaches about `0.506` during the broad route but does not exceed
  `0.60` until the terminal stroke. Applicability is currently evidenced only
  for the posterior negative-side terminal stroke in this capture family:
  falsify or revise if a global projection changes broad-route commands, loses
  the alternating wake or capture, contacts either boundary, exceeds
  `0.0372/0.0191` loads, or fails to reduce limit occupancy relative to the
  binary barrier.
- The later completed soft-envelope sample shows that actuator regularization
  need not trade away propulsion on this capture carrier. Adding a C1
  identity-to-sublimit shoulder to both acceleration outputs preserved the
  alternating top-down street and compact 3D Lambda2 wake, captured earlier at
  `16.943T` instead of `18.276T`, improved mean distance from `2.135L` to
  `2.090L`, and raised peak self-propelled speed from `1.329U` to `1.393U`
  while local flow stayed below `0.033U`. It simultaneously eliminated raw
  acceleration-envelope exceedance (from about `51.3/46.4%`), reduced peak
  force/yaw moment from `0.03716/0.01907` to `0.03609/0.01766`, and kept the
  posterior joint within `0.5907 rad` rather than `0.7505 rad`. Preserve the
  low-command identity region and smooth shoulder before adding drive or a
  hard command clip. This result is established only for the current
  acceleration-reserve capture family in direct still water, and exact
  joint-speed-limit occupancy remains about `3.73/3.54%`; a later
  speed-viability mechanism must retain capture and coherent shedding while
  lowering that occupancy. Falsify the broader lesson if the soft envelope
  fails to reproduce capture, earlier arrival, and lower effort, or if it
  merely shifts saturation into angle or speed hard stops on another carrier.
- Four completed joint-speed overlays resolve the soft-envelope carrier's
  residual hard-stop defect and separate the value of narrow intervention from
  work reallocation. Relative to the soft-envelope capture at `16.943T`,
  `2.090L` mean distance, and `1.393U` peak speed with `3.73/3.54%` exact
  speed-limit occupancy, a `0.90` positive-power guard and broader linear
  barrier removed occupancy but regressed to `17.330/17.435T`,
  `2.102/2.111L`, and `1.366/1.328U`. The sampled `0.94` phase-local guard is
  the stronger safety mechanism: it remains below the stops at
  `258.92/259.20 deg/T`, captures at `17.115T` with `2.098L` mean distance,
  and retains an alternating top-down street, compact 3D structures, and
  `1.404U` peak speed. Narrow positive-power suppression, not extra speed
  clearance or wake coherence alone, is therefore the evidenced priority.
  One-way anterior-to-posterior carrier allocation at the matched `0.90`
  onset gives only a secondary benefit (`17.275T`, `2.098L`,
  `257.11/257.75 deg/T`) over the no-transfer `0.90` guard, and remains slower
  than the `0.94` guard. Because the unguarded trace never limits both joints
  simultaneously and the other joint stays below 90% speed at every contact,
  later allocation tests should combine the high onset with a bounded
  carrier-signed posterior transfer, never broaden the gate or send posterior
  clipping into the zero-centered anterior oscillator. Apply this only when
  phase-separated joint headroom is observed; falsify it if transfer cannot
  beat `17.115T` and `2.098L`, restores speed contact, loses capture or the
  alternating wake, worsens posterior angle use, or materially exceeds the
  soft carrier's `0.0361/0.0177` force/moment peaks.
- Completed signed-feedback samples resolve the earlier null result for
  load-aware residuals and now separate useful feedback from excess receiver
  permission. An absolute-yaw-magnitude gate produced byte-identical actions
  and a `16.988T`, `-0.204764`, `2.08931L`-mean-distance capture because its
  whole-trace threshold did not overlap discretionary transfer events; a
  joint-angle phase proxy improved arrival only to `16.965T`. In contrast, two
  independent samples of the same signed measured-yaw policy reproduced the
  policy hash, complete trajectory, `16.932T` arrival, `-0.200045` score, and
  `2.08513L` mean distance. It increases posterior-to-anterior reclaimed work
  only when the receiver agrees with body-frame turn request and opposes
  current yaw moment, while retaining sublimit `258.93/259.20 deg/T` speeds and
  the coherent alternating 3D wake. Its bounded cost relative to the prefilled
  allocator is a posterior-angle increase from `0.5700` to `0.5992 rad` and
  force/moment peaks from `0.03634/0.01804` to `0.03693/0.01835`.
  A separate plateau receiver gate then relaxed the established all-speed
  taper on that residual; it still captured but regressed to `16.960T`,
  `-0.204089`, and `2.08869L`, with `0.59395 rad` posterior angle and
  `0.03668/0.01838` loads. Thus instantaneous spare speed is not evidence for
  bypassing an already successful receiver taper. Verify observation/gate
  overlap, prefer target-signed measured response over global magnitude or a
  joint-phase proxy, and retain the inherited receiver-speed attenuation on
  both base and residual work. Applicability is limited to existing posterior
  speed-guard donor events in this capture family. Falsify or revise if the
  signed residual loses its replicated route, capture, coherent shedding, or
  sublimit speeds, or if another headroom law beats `16.932T/2.08513L` without
  exceeding `0.5993 rad` posterior angle or `0.0370/0.0184` loads.
- The sampled bidirectional allocator and three completed inherited terminal
  overlays close two tempting extensions of that signed residual. Mirroring
  adverse-yaw arbitration onto anterior-to-posterior transfer captures at
  `16.926T` but worsens score/mean distance/crossing depth to
  `-0.200966/2.08585L/0.74483L` versus the three-times-replicated one-sided
  policy's `-0.200045/2.08513L/0.74389L`; posterior angle, joint-speed peaks,
  and yaw-moment peak are unchanged, and the small force reduction does not
  establish safer mechanics. Two collision-corridor steering releases then
  regress to `-0.204337/2.08858L` and `-0.202941/2.08746L`, while an
  agreement-gated terminal yaw increment reaches only
  `-0.200362/2.08539L` with essentially inherited joint, load, and yaw-rate
  maxima. Their visual evidence retains the alternating top-down street and
  compact three-dimensional wake, so the regressions are control-allocation
  results rather than propulsion collapse. Treat signed load feedback as
  directional, not a rule to mirror across donor channels, and preserve the
  existing target-course loop through capture instead of adding collision-cone
  relief or more same-sign terminal yaw authority. Prefer the replicated
  one-sided topology until a genuinely different observation or mechanism
  supplies a semantic benefit. Revisit this boundary only if a held-out route
  shows that the one-sided policy loses capture or mechanical viability, or if
  a new mechanism beats `16.932T/2.08513L` while keeping sublimit speeds,
  posterior angle below `0.5993 rad`, and loads below `0.0370/0.0184`.
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
