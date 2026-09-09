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
  do not assume it composes with more distance allocation. The inherited
  independent `8L--2L` middle-field course window has now been evaluated with
  half-cycle steering: it retained capture and the coherent/load class but
  reached only `19.872T`, mean distance `2.11310L`, and score `-0.22294`, versus
  the strongest approach-gated LOS sample's `19.706T`, `2.10594L`, and
  `-0.21598`. Treat that as a concrete negative result: another course-distance
  window or scalar course gain is unsupported unless a held-out trajectory
  exposes the old pre-approach discrepancy again.
- Do not tune or stack the approach-weighted wrong-sign-yaw multiplier on
  posterior lag. The assigned parent added that response gate to the clean
  joint-phase lag controller and captured at `19.486T`, mean distance
  `2.09523L`, and score `-0.20571`; three byte-identical clean-controller
  evaluations span `19.409--19.635T`, `2.09210--2.10246L`, and
  `-0.20288-- -0.21272`, fully enclosing the gated result. Their top-down and
  oblique sheets all retain the same coherent alternating wake and terminal
  hook, so the multiplier produced neither a repeat-resolved scalar benefit
  nor a different physical class. Restore the clean symmetric lag allocation
  before testing a distinct actuator primitive; reconsider response-gated lag
  only if a held-out pose produces repeatable wrong-sign yaw and the gate then
  improves arrival/integral or effort/load diagnostics beyond exact-policy
  variation without degrading capture, wake coherence, or joint margin.
- Do not tune or stack either phase-conditioned posterior carrier amplitude or
  direct wrong-sign-response curvature on this fixed release. The assigned
  parent's direct posterior-curvature gate captured at `19.360T`, mean
  distance `2.08911L`, and score `-0.19989`, only `0.049T` ahead of the fastest
  exact phase-lag repeat and well inside its `0.226T` timing spread; it retained
  the same two-view late-hook topology while raising anterior mean command and
  90%-bound residence to `19.25 rad/T^2/37.07%`. Posterior carrier-amplitude
  allocation captured at `19.552T/2.09001L/-0.20065`, but its head path grew to
  `12.549L`, posterior excursion to `0.608 rad`, and peak planar force/yaw
  moment to `0.02535/0.01343`, again without a new visual class. Treat both as
  concrete negative mechanism results despite finite capture and small scalar
  leads: restore constant carrier amplitude, base lag, and mean curvature
  before testing a distinct posterior actuator path; reconsider either only
  if a held-out pose exposes repeatable response or amplitude insufficiency
  and the mechanism then clears exact-policy timing/integral variation or
  materially improves actuator headroom without worse path, load, joint
  margin, capture, or wake coherence.
- Do not treat a tiny reduction in smooth-bound residence as evidence that
  previous-command feasibility feedback is useful. The assigned parent's
  effort-aware half-cycle gate reduced anterior mean absolute command only
  from `18.20` to `18.09 rad/T^2` and anterior residence above 90% of the
  smooth bound only from `35.25%` to `35.04%`, yet slowed capture from the
  sampled `19.701--19.817T` cluster to `19.949T`, worsened mean distance to
  `2.12277L` and score to `-0.23265`, and raised peak planar force/yaw moment
  to about `0.0250/0.01336`. Both keyframe rows retained the same coherent
  wake and late-hook topology, so the gate did not create a useful physical
  class. Restore the clean LOS/range-aware scaffold rather than tuning its
  effort threshold or floor; revisit command-history gating only if a later
  rollout demonstrates a material headroom gain together with improved
  arrival/integral and non-worse loads, or test a distinct normalized
  observation and posterior actuator path instead.
- Keep posterior LOS-led redirect continuous when testing a release trigger.
  Full response release was the slowest current sample at
  `19.850T/2.11128L/-0.22093`, while anterior-only response release varied
  between `19.701T/2.10634L/-0.21675` and an inherited
  `19.877T/2.11339L/-0.22325`, providing no improvement beyond executable
  repeat variation. In contrast, bounded projected-miss geometry retained the
  strongest class at `19.723T/2.10565L/-0.21601` with the same coherent wake,
  joint margin, and approximate `0.023/0.013` force/moment envelope. This
  supports projected miss as a release observation to test, not as a proven
  gain: restrict it to transient anterior bias and falsify it if capture,
  integral, terminal topology, command headroom, loads, or wake coherence
  regress.
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
