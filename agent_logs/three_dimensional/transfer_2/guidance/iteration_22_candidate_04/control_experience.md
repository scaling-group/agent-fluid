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
  do not assume that more authority or a second redirect will preserve it.
- Distance-conditioned posterior wave allocation is provisionally supported,
  but needs an exact repeat before composition. The sampled handoff used
  joint-phase-conditioned posterior carrier amplitude while far and restored
  posterior lag allocation near the target; relative to the all-distance lag
  parent it reached `10/8/6L` about `0.143/0.154/0.171T` earlier, reduced the
  distance integral from `2.09210L` to `2.07892L`, improved score from
  `-0.20288` to `-0.18968`, and lowered mean anterior command and its greater-
  than-90%-bound residence from `19.03/36.92%` to `18.26/35.52%`. Capture time
  stayed comparable (`19.354T` versus `19.409T`), while head path grew from
  `12.095L` to `12.416L` and force/moment peaks rose slightly within the common
  load class (`0.02523/0.01333`). Transfer the invariant—blend two bounded
  joint-state wave allocations with normalized approach geometry—not the
  sampled gains. Retain it only if replication keeps capture and coherent
  wakes while confirming an integral or effort benefit outside the completed
  `2.08911--2.09637L` exact-policy envelope without worse path, joint/rate
  margin, near-bound residence, or loads.
- Treat response-conditioned posterior handoff as repeat-sensitive rather than
  a proven improvement knob. Two evaluations of the exact same yaw-response
  policy both preserved the coherent capture class, but spanned
  `19.162--19.338T`, scores from `-0.18691` to `-0.18047`, and
  `2.06924--2.07622L` in capture time, score, and distance integral; that
  within-policy spread is comparable
  to its small apparent lead over the distance-only handoff
  (`19.354T/-0.18968/2.07892L`). Replacing target-turn alignment with velocity-
  course alignment also captured but regressed to
  `19.398T/-0.19253/2.08187L` without producing a visibly different wake or
  route. Preserve capture, but do not tune or compound these response gates
  from a single scalar winner. Test an orthogonal, one-factor mechanism against
  early trajectory allocation, and require either replicated timing/integral
  separation beyond this envelope or a useful semantic trajectory change;
  reconsider response gating only if a held-out release exposes a repeatable
  wave-handoff failure.
- Reject the inherited composite that simultaneously removed posterior-lag
  phase allocation and exposed 20% of the terminal velocity-course redirect
  outside the `6L` approach region. It left the domain after improving only to
  `11.895L`, finished at `12.085L`, and scored `-14.48666`, whereas the sampled
  lag, amplitude, handoff, and response-gated controllers all captured. The
  two simultaneous changes prevent assigning causality to either term alone,
  but future workers should not repeat or tune this composite; reconsider
  earlier course feedback only as a one-factor test when a held-out release
  shows a repeatable far-course failure, and require correct-sign progress
  before any terminal or actuator refinement.
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
