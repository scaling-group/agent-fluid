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
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Preserve the now-supported capture scaffold as a combination rather than
  attributing success to a scalar steering gain. The assigned 2D-sign parent
  formed a coherent self-propelled wake but reversed after reaching `6.18L` and
  exited at `10.60L`; inherited intermediate variants likewise repeatedly left
  the domain after `2.12--7.53L` near misses. In contrast, all four current
  samples combining the corrected 3D bend sign, fore/aft-aware body-frame
  target vector, distance/closing drive relief, and bounded velocity-course
  redirect captured in `20.21--20.97T` from direct quiescent initialization,
  with coherent wakes and peak force/moment coefficients no greater than about
  `0.025/0.013`. Keep this full scaffold when testing one additional mechanism;
  invalidate its portability if a held-out pose or inflow restores a pass-and-
  exit topology, destroys wake coherence, or materially increases load or
  joint-limit residence.
- Once that scaffold captures, joint-state half-cycle asymmetry is supported as
  a trajectory-shaping mechanism, with actuator cost as its boundary. Against
  an otherwise matched terminal course redirect, phase-aligned steering reduced
  capture time from `20.971T` to `20.207T`, improved score from `-0.27435` to
  `-0.22712`, and slightly reduced peak planar force/yaw moment from
  `0.0249/0.0130` to `0.0244/0.0128`; however, anterior mean command increased
  from `18.67` to `19.29 rad/T^2` and residence above 90% of the smooth command
  bound increased from `34.6%` to `36.6%`. Transfer only the invariant—derive a
  bounded useful/return-stroke asymmetry from normalized joint phase and
  body-frame turn request—not the sampled gains. Reject or reduce it if capture
  timing/integral fails to improve, near-bound command residence approaches
  persistent saturation, or joint margin, loads, and wake coherence regress;
  its composition with earlier middle-field course correction remains untested.
- Treat posterior half-cycle allocation as regime-specific rather than choosing
  one global amplitude or lag modulation from scalar score. In the current
  direct-quiescent samples, posterior carrier-amplitude asymmetry reached
  `10/8/6L` at `6.892/9.680/12.342T`, about `0.12--0.14T` earlier than the
  posterior-lag sample, and reduced mean anterior command from `19.03` to
  `18.09 rad/T^2`; however, it then lengthened head path from `12.095L` to
  `12.549L`, doubled sub-`2L` lateral speed from `0.085` to `0.200U`, and
  arrived later (`19.552T` versus `19.409T`). This supports testing a smooth
  normalized-distance handoff from amplitude allocation while far to lag
  allocation before capture, not tuning either asymmetry globally. Its boundary
  is repeat evidence: the apparently best wrong-sign-yaw posterior bend ranged
  from `19.360T/2.08911L` to `19.591T/2.09637L` across byte-identical runs, so
  do not stack that terminal gate unless held-out or repeat results establish a
  benefit beyond this spread. Reject the handoff if it fails to retain both
  early progress and the shorter, lower-slip approach without worse command,
  joint, load, or wake diagnostics.
- Treat the first whole-command joint-rate governor as a mixed but meaningfully
  different trajectory result, not as a validated scalar headroom fix. Added
  to the response-aware scaffold, it advanced the `10/8/6L` milestones from
  `6.897/9.658/12.210T` to `6.760/9.416/11.979T`, captured at `18.755T` rather
  than the unguarded repeat envelope of `19.162--19.338T`, and improved the
  distance integral to `2.04031L` from `2.06924--2.07622L`. It also cut summed
  outward action-velocity impulse above 99% of the joint-rate bound from about
  `12742/5589` to `5666/2041` anterior/posterior and reduced posterior 99%-rate
  residence from `4.36%` to `3.28%`. However, anterior residence barely moved
  (`8.35%` to `8.07%`), head path widened from `12.309L` to `12.421L`, and peak
  planar force/yaw moment rose from `0.02537/0.01356` to
  `0.02686/0.01397`. Because the implementation independently attenuated each
  complete raw command, it confounds carrier-energy withdrawal with steering
  and two-joint phase distortion. Do not tune only its rate threshold or rank
  it by score. The reusable next test is to separate rhythmic carrier from
  target-conditioned steering and govern the carrier with one normalized,
  phase-preserving scale. Retain that refinement only if repeat CFD combines
  the earlier timing/integral with the `12.30--12.31L` short path, inherited
  load class, lower outward impulse, joint margin, capture, and coherent wake;
  otherwise restore the unguarded response-aware handoff.
- Treat response-gated redirect priority as a validated timing mechanism but
  not yet as a satisfactory carrier governor. Relative to the assigned
  dominant-joint common guard, it advanced the `10/8/6/2L` crossings from
  `6.644/9.119/11.457/16.352T` to `5.863/7.838/9.779/14.201T`, captured at
  `16.044T` instead of `17.990T`, and improved distance integral from
  `1.98918L` to `1.82409L` while both wake views remained coherent. It also
  lengthened head path from `12.170L` to `13.178L`, raised peak planar
  force/yaw moment from `0.02909/0.01498` to `0.03579/0.01770`, raised
  anterior/posterior residence above 99% joint rate from `8.44/0.89%` to
  `12.24/1.37%`, and more than doubled sub-`2L` lateral speed from `0.159` to
  `0.359U`. Code and normalized trajectory reconstruction expose a reusable
  semantic hazard: the governor requested priority from velocity-course
  redirect magnitude but declared fulfillment from yaw aligned to the broader
  LOS turn command; those two commands had opposite signs on about 87% of its
  near-rate samples. When allocation is response-gated, compare response with
  the same command being fulfilled and keep other response signals scoped to
  their own mechanism. Retain this correction only if repeat CFD preserves
  the earlier milestones and capture while shortening path and reducing load,
  near-rate residence, and terminal slip; otherwise prefer the lower-load
  dominant-joint guard rather than tuning another threshold or strength.
- Do not treat the repeatable late hook of this fixed direct-quiescent release
  as evidence for another terminal steering gate or an unfiltered slip-to-mean-
  curvature residual. An exact projected-miss/intercept-corridor controller
  first captured at `19.701T/2.10438L/-0.21449` but replicated at
  `19.817T/2.10672L/-0.21655`, straddling the simpler LOS-led controller's
  `19.706T/2.10594L/-0.21598` while using more mean command. The inherited
  approach-gated tail residual from relative crossflow then preserved the same
  coherent capture class but regressed to `19.894T/2.11284L/-0.22287`, raised
  sub-`2L` mean yaw from `0.437` to `0.486 rad/T`, and increased head-path
  inefficiency. On this release, restore the plain scaffold instead of tuning
  corridor or slip scalars; reconsider either observation only when a held-out
  pose or inflow exposes a repeatable intercept/slip failure, and require a
  different useful trajectory plus timing/integral improvement beyond repeat
  variation without worse command, load, joint-margin, or wake metrics.
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
