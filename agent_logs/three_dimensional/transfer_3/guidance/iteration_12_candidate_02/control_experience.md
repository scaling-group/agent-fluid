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
- Treat the repeated compact capture as an allocation-refinement problem, not
  a reason for another phase or scalar tweak. Three sampled evaluations of the
  coordinated, amplitude-normalized two-joint release are byte-identical at
  score `-0.528339`, mean distance `2.429294 L`, and capture `25.11852 T`, with
  a coherent outer wake, no joint-stop dwell, and no inside-`4 L` command above
  `30 rad/T^2`. Phase-selective departure allocation crosses one solver step
  earlier and lowers inside-band force/moment maxima from about
  `0.01547/0.00800` to `0.01427/0.00757`, but is marginally worse in score and
  mean distance (`-0.528376`, `2.429298 L`); inherited posterior-only and
  stacked-release tests regress to `-0.530288` and `-0.530990`, and later
  body-alignment/carrier-release descendants regress to about
  `-0.53040/-0.53043`. Preserve the paired release and do not infer benefit
  from one crossing step or lower peak load alone. Shared yaw-rate feedback
  adding up to `3 deg` of total bend likewise reduces terminal bearing and
  crosses one step earlier but regresses to score `-0.528782`, mean distance
  `2.429626 L`, and final distance `0.746909 L`. The assigned parent's zero-sum
  shift of existing bend toward the anterior joint sharpens that negative
  result: despite reducing final heading error from `0.66697` to `0.64836 rad`
  and raising crossing speed from `0.65387` to `0.66074 L/T`, it worsens score,
  mean distance, and final distance to `-0.528843`, `2.429625 L`, and
  `0.747277 L`. Do not add total curvature or redistribute its location merely
  to improve body alignment.
- Productive crossflow is useful as an allocation cue only when translated at
  the correct actuator layer. Directly shrinking both terminal curvature
  targets under target-helpful relative crossflow regresses to score
  `-0.528581`, mean distance `2.429485 L`, and final distance `0.746666 L`.
  Using the same normalized body-frame cue, positive closure, late proximity,
  and actual joint settling to reduce the terminal-equilibrium blend instead
  recovers the already proven mean-centered carrier and improves score to
  `-0.528108`, mean distance to `2.429111 L`, and final distance to
  `0.746168 L` at the same `25.11852 T` capture, without changing the inherited
  inside-`4 L` peak action/force/moment values. Preserve this crossflow-
  supported paired carrier release as the terminal baseline; do not repeat
  direct target scaling, anterior/posterior redistribution, or bearing-only
  curvature additions. This implication applies to a late, settled,
  target-closing crab approach in which target-side geometry and measured
  relative crossflow have the evidenced helpful sign. It is falsified if a
  replicated or held-out approach delays or loses capture, worsens distance
  integral/depth, activates without helpful crossflow and closure, changes the
  outer wake, or restores saturation, joint stops, load spikes, instability,
  or looping.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
