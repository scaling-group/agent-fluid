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
- The sampled target-steering comparison separates useful posterior steering
  from three failed corrections. Re-centering both joints on a `10 deg` bias
  reduced anterior excursion from `0.459` to `0.175 rad`, reduced mean force
  magnitude from `0.0077` to `0.0003`, left both visual views nearly wake-free
  through `8T`, and worsened final distance to `13.411L`; do not move the
  anterior oscillator equilibrium when this carrier is working. With that
  equilibrium preserved, bearing-lookahead posterior mean curvature remains
  the strongest result (`11.413/11.421L`, upper exit at `9.740T`). A
  yaw-rate-damped static bias reached only `12.091L`; posterior half-cycle
  asymmetry reached `11.778L` and exited earlier at `8.800T`; and the inherited
  desired-turn-rate residual reached `11.858L` while raising raw posterior
  acceleration-envelope exceedance from `54.9%` to `69.8%`. The last failure
  also shows that the adapter's seven-entry `turn_rate_recent` window (about
  `0.033T`) is not a slow-yaw observable and should not be treated as one. At
  `4T` all four evaluated policies still have a small positive bearing
  (`+0.06` to `+0.16 rad`) while normalized body-frame lateral velocity is
  already `+0.21` to `+0.26 U`; bearing reverses by `5T` after the upward
  course is established. The later sampled evidence closes that open
  hypothesis: a forward-speed-reliable redirect driven by large bounded
  target-versus-course mismatch, with continuous release as course responds,
  preserved the coherent wake and changed the upper-exit topology to capture
  in all four sampled variants (`0.745-0.748L` at `16.258-16.291T`). For this
  coherent-wake, inertial-sideslip topology, preserve posterior-only mean
  curvature and course compensation instead of returning to phase asymmetry
  or beat-scale yaw-rate feedback. Falsify this implication if it fails on a
  weak-thrust carrier, fails to release after course realignment, or produces
  instability rather than a finite target-directed path.
- Redirect allocation and terminal scheduling relieve different bottlenecks
  and should remain separate feedback roles. The assigned mean-priority parent
  preserved capture at `16.258T` and reduced posterior limiting relative to the
  inherited unallocated redirect, but below `1.75L` it still occupied the
  acceleration envelope for `65.9/50.8%` of anterior/posterior samples and
  crossed at `1.120U`. A closing-gated zero-bend hold cut those fractions to
  `30.9/37.7%` and ended at `1.024U`, but delayed capture to `16.269T` and
  discarded directional bend. Closing-gated selective wave relief retained
  mean steering, tied the parent's earliest capture, ended at `1.047U`, and
  produced the best sampled score (`-0.066121`). Thus preserve role-priority
  allocation during large target-versus-course redirects, then use normalized
  proximity plus positive closing to attenuate the rhythmic carrier without
  zeroing the slow posterior steering channel; neither result establishes true
  translational braking. Apply this only after a coherent carrier and robust
  capture route exist. Falsify it if relief changes pre-approach motion, loses
  or materially delays capture, fails to restore propulsion when closing is
  lost, or does not reduce the intended joint/load channel.
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
