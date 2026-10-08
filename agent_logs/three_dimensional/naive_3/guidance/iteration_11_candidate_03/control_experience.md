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
  exit. The assigned response-gated parent exposes a complementary blind spot:
  at its `2.989L` minimum the full-quadrant bearing was already about
  `-1.23rad`, yet the anterior redirect gate was zero because instantaneous yaw
  did not have the selected wrong-way sign; after the pass, anterior amplitude
  and the visible new wake decayed while distance reopened. Its inherited
  score-only descendant changed closest distance only to `2.978L`, worsened
  final distance to `6.714L`, and retained the upper exit. Avoid further
  anterior restoring-stiffness, equilibrium-shift, or instantaneous-yaw-gate
  variants on this carrier. If testing phase-aware correction, place it in
  posterior wave timing or another cycle-resolved channel that leaves the
  zero-centered anterior oscillator unchanged and gates directly on persistent
  target geometry. Falsify this boundary if oscillator decay also occurs with
  an untouched anterior carrier, or if an anterior mechanism improves bearing
  recovery or termination class while preserving the `2.960L` approach and
  without raising limit occupancy.
- Score-only descendants expose a selection boundary for near-capture work.
  One inherited step-9 rollout reached `0.857L`, only `0.107L` outside the
  capture radius, but then departed to `8.909L` and scored `-9.971`; another
  reached only `3.532L` and finished at `7.156L`, while the sampled anterior
  phase variant scored better (`-7.690`) despite never coming closer than
  `4.859L`. For uncaptured policies, aggregate score and final distance can
  therefore discard a materially different useful approach topology. Preserve
  a reproducible near miss as a mechanism lead and inspect its policy,
  trajectory, wake, loads, and limit occupancy before adding recovery control;
  never attribute the `0.857L` approach to a controller feature when only its
  score summary is inherited. Abandon that lead if fuller evidence shows an
  unstable or non-reproducible transient, destructive saturation, or no
  target-directed geometry that can be retained through a recovery edit.
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
