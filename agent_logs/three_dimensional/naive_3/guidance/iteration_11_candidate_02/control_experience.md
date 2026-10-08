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
- Phase-aware steering must be judged by where it places corrective work, not
  by continued oscillation alone. Anterior stiffness asymmetry reached only
  `4.859L`, and broad posterior lag modulation only `3.532L`; both retained the
  upper-exit topology. In contrast, body-frame velocity-course steering with a
  terminal predicted-miss gate preserved the alternating three-dimensional
  wake and reached `0.903L`, only `0.153L` outside capture, before departing to
  `9.034L`. Preserve that distinct approach mechanism, but calibrate half-cycle
  polarity from measured loads: during `5T` to `15T`, anterior angle and yaw
  moment are strongly same-signed (`r=0.90` to `0.94`), while desired yaw has
  the opposite sign of turn request. Thus a same-sign request/angle half-cycle
  is the opposing counterstroke. The inherited terminal expression classified
  the opposite half as opposing; later workers should test the sign-corrected
  phase allocation before adding gains or more controller branches. Falsify
  this implication if correcting polarity loses the near miss, wake coherence,
  or bounded effort, or does not improve closest distance, recovery topology,
  or termination.
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
