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
- This lineage starts from the transferred 2D clean-B iteration-20 champion.
  It contains target-aware feedback; evaluate its actual 3D performance rather
  than assuming either successful transfer or a missing steering mechanism.
  No 3D solver or optimizer population is imported.
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
- Cross-candidate evidence supports geometry-gated equilibrium redirection but
  rejects replacing it with uncalibrated beat-side or course logic. The
  transferred seed formed a coherent wake yet reached only `4.780 L`, with
  raw acceleration beyond the envelope on about `71.4%/78.4%` of commands;
  geometry-gated redirection retained that wake, reduced the incidence to
  `32.1%/26.0%`, and reached `1.135 L`, whereas phase-demodulated redirection
  reached only `12.12 L` before an early exit. Preserve the outer carrier and
  target-angle redirect. This implication applies only after useful broad
  target motion is established and is falsified by a changed early trajectory,
  lost wake coherence, or return of the original boundary-exit topology.
- A fast misaligned near miss can be a joint-allocation problem rather than a
  need for more curvature gain or generic braking. Replacing the oscillatory
  carrier inside the gated terminal band with damped tracking of its same
  two-joint mean-curvature equilibrium converted the `1.135 L` pass into
  capture at `25.2615 T` (score `-0.530646`, mean distance `2.431797 L`) while
  removing joint-stop dwell and sharply reducing terminal loads. A
  closure-loss support gate produced an identical rollout because it stayed
  fully supported, so nominal noninterference is not recovery evidence. In
  contrast, bounded closure preview preserved the two-view wake and capture,
  advanced crossing to `25.1130 T`, improved score to `-0.530060` and mean
  distance to `2.430636 L`, removed terminal `|action|>30` incidence, and cut
  posterior terminal excursion from `0.7213` to `0.6620 rad`. Preserve the
  closure-previewed equilibrium as the terminal baseline; test new mechanisms
  through an independently active state gate rather than another dormant
  condition or scalar-only preview tweak. Reject a refinement if capture is
  delayed or lost, pre-terminal motion changes, coherent wake continuity
  degrades, or terminal clipping, joint-stop dwell, and force/moment spikes
  return.
- Treat the repeated compact capture as an allocation-refinement plateau, not
  a reason for another phase or scalar tweak. Three sampled evaluations of the
  coordinated, amplitude-normalized two-joint release are byte-identical at
  score `-0.528339`, mean distance `2.429294 L`, and capture `25.11852 T`, with
  a coherent outer wake, no joint-stop dwell, and no inside-`4 L` command above
  `30 rad/T^2`. Phase-selective departure allocation crosses one solver step
  earlier and lowers inside-band force/moment maxima from about
  `0.01547/0.00800` to `0.01427/0.00757`, but is marginally worse in score and
  mean distance (`-0.528376`, `2.429298 L`); inherited posterior-only and
  stacked-release tests regress to `-0.530288` and `-0.530990`, and two later
  inherited descendants remain weaker at about `-0.52928/-0.52930` without a
  new termination class. Preserve the paired release and do not infer benefit
  from one crossing step or lower peak load alone. A later shared body-rate
  residual supplies a sharper negative result: adding up to `3 deg` of total
  mean bend reduced final body-frame target angle from `0.7125` to
  `0.6938 rad`, crossed one step earlier, retained zero inside-`4 L`
  `|action|>30`/joint-stop samples, and slightly lowered peak loads, yet
  regressed score from `-0.528339` to `-0.528782`, mean distance from
  `2.429294` to `2.429626 L`, and final distance from `0.746410` to
  `0.746909 L`. Smaller terminal bearing is therefore not sufficient evidence
  for more total curvature; do not repeat yaw-rate-driven shared-bend
  augmentation. The baseline already has substantial targetward body-frame
  lateral velocity inside `4 L` (mean about `0.2286 L/T`, final
  `0.2566 L/T`), so a distinct next test may preserve total curvature and
  alter only its anterior/posterior distribution under body-frame geometry.
  This implication applies to the established closure-previewed compact
  capture and is falsified by repeated evidence under another approach state
  that total-bend response feedback improves distance/capture depth without
  changing the outer wake or restoring saturation, stop dwell, and load
  spikes.
- Reuse a validated response cue only through an evidenced actuator locus.
  Relative to the repeated v23 compact capture (`-0.528339`, mean distance
  `2.429294 L`, final distance `0.746410 L`), three byte-identical v26 runs
  show that late target-helpful body-relative crossflow, positive closure,
  proximity, and settled joint response can safely relieve the paired
  terminal-equilibrium allocation: score improves to `-0.528108`, mean
  distance to `2.429111 L`, and final distance to `0.746168 L` at the same
  `25.11852 T` crossing, with the coherent outer wake unchanged. The assigned
  parent records that using the same cue to scale both held-curvature targets
  instead regressed to `-0.528581`/`0.746666 L`, while the inherited zero-sum
  anterior redistribution improved heading alignment but regressed to
  `-0.528843`/`0.747277 L`. Preserve the paired carrier relief; do not infer
  that a good cue licenses generic unloading or more anterior steering.
  A distinct allocation test should preserve total mean curvature and isolate
  the posterior direction, and is falsified by worse distance/capture,
  changed outer motion, or renewed saturation, joint stops, load growth, or
  wake loss.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
