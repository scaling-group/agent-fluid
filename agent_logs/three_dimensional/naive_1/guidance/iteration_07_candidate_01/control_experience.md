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
- Direct-uniform still-water evidence separates propulsion progress from route
  control. The drive-only seed formed a coherent 3D posterior wake but reached
  only `12.078L` before upper exit. Four inherited shared/partial
  mean-curvature variants then retained `left_domain` and regressed final
  distance to `13.258--15.361L`; do not retry common, shared, or tail-biased
  moving equilibria by scalar gain changes. Anterior useful-half-cycle steering
  instead improved minimum/final distance to `11.782/11.797L`, while posterior
  half-cycle scaling and a shared residual were weaker (`12.006/12.205L` and
  `12.140/12.686L`). A later slip-aware, both-stroke anterior residual retained
  the alternating wake and improved monotonically to `10.062L`, yet all sampled
  variants still hit the `260 deg/T` rate cap and exited the upper boundary. In
  that strongest trace, bearing reversal was followed by opposite joint means
  of about `-0.081/+0.122 rad` near exit because the full biased anterior angle
  entered the `-q1` tail target. Reuse the narrow positive result—body-frame
  slip feedback and anterior steering can preserve thrust and substantially
  improve progress—but do not treat an opposite-mean posterior response or
  more drive gain as directed turning. The subsequent clean separation—an
  anterior-only curvature center with a zero-mean posterior lag—survived this
  test: it retained the alternating top-down and oblique wake for `28.59T`,
  changed the common upper exit to a lower exit, and improved closest approach
  from `10.062L` to `5.033L`. It did not capture: distance rose again to
  `9.084L`, bearing grew from `0.155` to about `1.455 rad` near the miss, and
  `14--20T` means showed saturated-sign anterior curvature
  (`0.143--0.158 rad`) with a near-zero posterior mean while heading barely
  changed. Reuse anterior/tail mean separation as the strongest trajectory
  base, but treat a full-strength posterior carrier during large bearing as a
  concrete failure mode. A next mechanism should temporarily trade posterior
  thrust for redirect authority using observed geometry, then restore it as
  bearing falls; reject that implication if carrier relief destroys the
  staggered wake, loses the `5.033L` approach, worsens loads/saturation, or
  leaves bearing and the lower-exit topology unchanged.
- The next sampled separation resolves that proposed carrier-relief test but
  not the capture problem. Bearing-gated posterior relief preserved the
  coherent alternating 3D wake, lowered pooled rate/acceleration limit
  occupancy from roughly `14.3/68.6%` to `9.7/47.8%`, and improved closest
  approach from `5.033L` to `4.233L`; it nevertheless retained the lower exit
  at `9.176L` and still had about `1.292 rad` bearing at closest approach.
  Target-signed slip unloading was weaker (`4.252L`) with the same topology and
  high saturation. A recent-yaw residual reached `4.376L` but then drove the
  joint-state oscillator onto its moving equilibrium near `20T`: both joints,
  forces, moments, and the visible wake decayed almost to zero before exit.
  Preserve geometry-gated tail relief as the better finite base, and do not
  feed turn response back into the oscillator center without an explicit
  non-quenching construction. At large bearing, the relieved trace's joint-1
  stroke toward requested curvature coincided with desired-sign heading rate
  near `-1.19 rad/T`, while the return stroke produced about `+1.25 rad/T`;
  phase-selective authority is therefore a sharper next test than another
  static bias or slip remapping. Reject it if it disorders the staggered wake,
  restores the unrelieved saturation/load burden, loses the `4.233L` approach,
  or fails to change net yaw and the lower-exit topology.
- The completed joint-rate-gated half-stroke test gives a narrow trajectory
  improvement but falsifies phase inference as the missing route mechanism by
  itself. It preserves the alternating top-down and oblique wake and improves
  closest approach from `4.233L` to `3.909L`, yet keeps the same lower-domain
  exit, worsens final distance from `9.176L` to `9.261L`, and leaves pooled
  rate/acceleration-cap occupancy near `7.7/49.6%` rather than the parent's
  `7.7/47.5%`. At closest approach its target bearing is still about
  `+1.287 rad` while yaw is `+2.203 rad/T`, opposite the needed yaw sign; mean
  yaw over `14--20T` and `20--26T` is only `+0.021` and `-0.037 rad/T` despite
  large mean bearing. Do not tune the joint-rate asymmetry or posterior relief
  as a substitute for closed-loop yaw authority. A subsequent mechanism may
  use measured wrong-sign turn response to gate a bounded, reversal-vanishing
  anterior pulse, but it must remain additive rather than shifting the
  oscillator center: reject it if the limit cycle/wake quenches, saturation
  materially rises, closest approach exceeds `3.909L`, corrective mean yaw
  does not emerge, or the lower-exit topology remains.
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
