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
  more drive gain as directed turning. The subsequent anterior-only curvature
  center with a zero-mean posterior lag is a real semantic improvement: all
  four sampled descendants replace the early upper hook with a long
  lower-going trajectory, preserve self-propelled 3D wake evidence, and reach
  `4.233--5.033L`. It is not yet route control. The plain center passes below
  the target with bearing near `1.13 rad` at its `5.033L` minimum and exits at
  `28.59T`. Bearing-gated posterior relief gives the narrow best result:
  minimum/mean distance improve to `4.233/8.611L`, survival extends to
  `31.87T`, and tail rate-cap occupancy falls from about `13.4%` to `5.2%`;
  nevertheless bearing is still `1.405 rad` at closest approach and the same
  lower exit remains. Target-signed slip rectification independently reaches
  `4.252L` but retains that topology, so it is not a reliable missing
  mechanism. Recent-yaw unloading reaches `4.376L` but lets joint motion,
  command effort, and the visible wake decay nearly to zero after about `18T`,
  leaving an inertial coast to the boundary. Reuse anterior/tail mean
  separation and modest posterior relief, but avoid direct recent-yaw
  unloading and further slip or relief scalar tuning as substitutes for yaw
  authority. The subsequently tested large-bearing anterior half-cycle
  residual supplies only a narrow benefit when paired with relief: closest
  approach improves from `4.233L` to `4.018L` and bearing there falls from
  `1.405` to `1.333 rad`, but the lower exit and large-error topology remain.
  Without relief it is worse (`4.859L`, `28.74T`) and restores about `12.5%`
  posterior rate-cap occupancy, so anterior phase selection must not replace
  the evidenced tail unloading. Posterior half-cycle redistribution instead
  gives the best sampled approach (`3.909L`) and survival (`32.64T`) with only
  about `4.9%` posterior rate-cap occupancy, yet closest-approach bearing stays
  `1.410 rad`; treat it as useful trajectory shaping, not established yaw
  control. Combining anterior and posterior phase selection confirms that
  their distance effects are compatible: the alternating three-dimensional
  wake survives, closest approach improves to the sampled best `3.691L`, and
  survival reaches `33.27T`. It fails the more important orientation boundary:
  full target error is still `1.364 rad` at the minimum, the trajectory again
  exits low, and the anterior command is acceleration-limited for about `68%`
  of samples. Do not escalate that phase residual by another scalar change;
  it is spending additional actuator authority without establishing net yaw.
  Replacing folded bearing with the full body-frame target angle is also
  insufficient by itself: the sampled full-angle posterior-redistribution
  policy still reaches only `3.909L`, carries about `2.75 rad` of true error at
  the same lower exit, and is visually indistinguishable in route topology.
  Keep full-angle semantics when a controller has recovery authority, but do
  not count the semantic repair as that authority. A discriminating next test
  may instead make a bounded, proximity-and-error-gated trade from cyclic
  thrust to one-sided anterior curvature, releasing continuously on true
  alignment. Falsify such terminal curvature capture if it changes the wake
  before the `6L` approach, fails to improve `3.691L` or reduce full error
  below `1 rad`, collapses into inertial coasting, repeats the lower exit
  without earlier target-side yaw, materially exceeds the sampled `13.7/5.5%`
  rate-cap envelope, or raises force/moment peaks beyond about `0.03/0.016`.
  The completed tests now falsify both easy versions of that proposal.
  Keeping the whole-body redirect active with the full target angle leaves the
  `3.691L` minimum unchanged in two independently constructed variants; both
  still exit low near `33.6T` with about `2.54--2.55 rad` of full error, so
  rear-aware release semantics do not add recovery authority. More strongly,
  blending the anterior oscillator into a damped one-sided center and adding
  terminal tail relief worsens the minimum to `4.145L`, advances lower exit to
  `27.79T`, and visibly removes the alternating wake as joint rates and actions
  approach zero. Do not suppress self-excitation or deeply unload both tail
  strokes to obtain terminal curvature; in this inertia-dominated regime that
  produces coasting, not capture. The completed live one-sided-envelope test
  closes the less destructive version too. It retains the state-feedback
  oscillation and alternating three-dimensional wake, increases the anterior
  `18--22T` mean from about `+0.243` to `+0.282 rad`, and slightly reduces
  rate-cap occupancy, but the posterior mean remains opposite-signed near
  `-0.076 rad`; minimum distance worsens from `3.691` to `3.712L`, full error
  there remains `1.291 rad`, and the same lower exit occurs at `32.95T`.
  Preserving the target-side anterior excursion while trimming its cancelling
  excursion is therefore not sufficient yaw authority; do not spend another
  test on envelope shift, phase-residual gain, or tail-relief tuning. An
  independently completed same-sign posterior C-bend supplies a narrower
  positive lesson. Its angle-only gate begins at `19.83T` and `3.733L`, only
  `0.63T` before closest approach, so it leaves the minimum effectively
  unchanged at `3.692L` and advances lower exit to `32.23T`. After recruitment,
  however, posterior mean over `24--28T` changes from the reference's `-0.065`
  to `+0.120 rad`, mean heading rate over `28--32T` rises from `0.126` to
  `0.320 rad/T`, late mean full error falls from `2.558` to `1.893 rad`, and
  the alternating wake survives. Distributed same-sign curvature is thus an
  evidenced yaw-producing body shape, but post-miss angle-only recruitment is
  falsified for capture. Reuse it only with normalized feedback that recruits
  before the miss while preserving the far carrier and continuous realignment
  release; reject it if it cannot beat `3.691L` and `1 rad` full error, delays
  yaw until after closest approach, repeats the lower exit, collapses cycling,
  or materially exceeds the sampled `13.7/5.5%` rate and `0.032/0.016` load
  envelope.
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
