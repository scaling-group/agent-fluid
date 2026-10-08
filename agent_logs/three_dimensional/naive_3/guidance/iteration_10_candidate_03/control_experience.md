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
- Later completed rollouts separate broad approach from corrective yaw
  authority. Bearing-minus-body-slip posterior curvature preserved the
  coherent carrier and reached `2.960L`, while posterior relief (`3.162L`), a
  damped hold (`3.592L`), a static distributed bend (`2.999L`), and two
  tail-only counterstroke-relief variants (`2.986L` and `3.013L`) all retained
  `left_domain`; the hold/static redirects nearly froze and the beating
  tail-only variants never reversed the hook. A state-gated active bend reached
  `2.679L` but released on closing speed at the pass. The subsequently logged
  response-released bend also failed: it reached `2.989L`, switched from weak
  corrective yaw near the minimum to `-0.55 rad/T` wrong-way yaw by `18T`,
  then settled near `(0,-12) deg` and exited at `6.387L`. Its positive-only
  squared yaw gate fell near zero whenever wrong-way yaw merely slowed, while
  recentering the anterior oscillator supplied a shifted equilibrium rather
  than a durable active stroke. Do not repeat carrier-wide damping,
  geometry-only oscillator recentering, or tail-only attenuation as if freed
  reserve were corrective action. When a redirect must survive a stall, keep
  the propulsive oscillator zero-centered and test bounded turn-side
  half-cycle forcing with response authority nonzero at zero yaw, releasing
  only after yaw is measurably corrective. Falsify this implication if that
  phase-aware forcing loses the coherent wake, materially worsens limit
  occupancy, fails to beat `2.960L`, or repeats the upper exit without a
  distinct recovery arc.
- A later inherited course-angle controller supplies the first materially
  different useful trajectory in this lineage: comparing the normalized
  body-frame target ray with actual velocity direction reduced closest
  distance from the unrelieved bearing-minus-slip reference's `2.960L` to
  `0.857L`, while the visual sheet retained an alternating three-dimensional
  wake.  At the minimum the head was only `0.153L` longitudinally past and
  `0.843L` laterally high, but it still traveled about `0.845U`, missed the
  `0.75L` capture radius, and eventually exited the upper boundary.  Treat
  target-versus-course angle as supported broad guidance even though its raw
  score is poor after the miss; the remaining failure is terminal overshoot,
  not evidence to return to folded bearing, static redirects, or anterior
  stiffness asymmetry.  Because earlier distance relief/holds activated near
  `5L` and worsened closest approach to `3.162L` and `3.592L`, test terminal
  drive allocation only after course tracking has brought distance inside
  roughly `2L`, keep course curvature and the zero-centered anterior rhythm
  active, and release relief when distance opens.  Falsify this boundary if a
  course-controlled replication loses the near-capture path, or if closing-
  only terminal allocation changes the pre-`2L` wake, raises limit occupancy,
  or cannot beat `0.857L`.
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
