# Dogfish L64 Second-Row Wake-Policy Experience

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
  import. The same guidance is used by matched 2-, 3-, and 4-worker runs.
- The fixed task is `L64`, target `(9,9.5)L`, first-crossing radius `0.75L`,
  inflow `0.18`, held-fish prewarm `200`, released horizon `300`, and actuator
  envelope `45/260/1800` in degree-based units.
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
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
- Inspect shared prewarm and released keyframe sheets before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination.
- Prefer normalized body-frame feedback. Wake phase, inflow, cylinder layout,
  and target position are intended held-out axes; coordinate memorization is
  not a valid solution.
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
- Body-frame bearing feedback is effective when it requests one bounded total
  curvature shared coherently across the two joint attractors, rather than a
  full anterior offset with an extra tail share. Two sampled shared-curvature
  policies preserved the `0.55`-period, `28 deg` traveling-bend scaffold and
  reached the `0.75L` target in `39.737` and `42.856` released time units, with
  `1.934L` and `2.119L` mean distance. In contrast, the inherited full-anterior
  bias prefill produced only `0.249/0.191 rad` peak joint excursions, moved
  `2.195L` in the wrong streamwise direction, and exited after `18.683` time
  units. Reuse the successful structure as a total curvature budget with a
  roughly balanced, slightly posterior-weighted split; falsify it under changed
  wake phase or target geometry if turn sign, propulsion, or capture is lost.
- Do not weaken the propulsive rhythm merely to create nominal actuator
  headroom before preserving reachability. An inherited candidate that changed
  the seed from `0.55/28 deg` to `0.9/20 deg` reduced mean command energy from
  the successful policies' `1176--1279` range to `17.02`, but it moved
  `(+2.185,-0.917)L`, made no meaningful approach (`12.424L` minimum distance),
  and exited after `16.984` time units. Later workers should first retain the
  evidenced traveling bend and change one steering or disturbance mechanism;
  revisit gait relief only if it preserves upstream propulsion while reducing
  saturation/load on a still-successful trajectory.
- Treat short-history bearing filtering as a navigation-speed mechanism, not
  automatic wake-load attenuation. Against two equation-identical instantaneous
  `45/55` replays (`39.737` capture, `1.934L` mean distance), the sampled
  circular-history policy reaches in `36.564` and lowers mean distance to
  `1.808L`, a genuine semantic improvement from changed equations under the
  common snapshot. But its mean command energy rises from `1278.79` to
  `1416.82`, force RMS from `53.74` to `66.17`, moment RMS from `761.95` to
  `901.74`, and relative-crossflow RMS from `0.227` to `0.245`; both joint-rate
  envelopes remain active. Preserve this filter when faster target progress is
  the priority, but do not claim smoothing or robustness from it. Test a
  separately bounded target-trend or load mechanism, and reject that addition
  if it sacrifices capture or distance without materially reducing the elevated
  effort/load; changed wake phase or target geometry remains the robustness
  falsification boundary.
- Do not add a cancellation-capable target-bearing derivative inside the route
  signal that also seeds the autonomous joint-state oscillator. The inherited
  filtered controller with an additive `bearing_window_rate` correction lost
  the visible traveling wake, reached only `0.140/0.163 rad` peak joint angles
  and `8.64` mean command energy, moved `(+2.175,-0.874)L` away from the target,
  and exited the domain after `16.956` units with `12.424L` minimum distance.
  By contrast, two equation-identical filtered `40/60` policies without that
  residual sustained the diagonal propulsive trajectory and captured at
  `35.690`. Low effort in the failed derivative case is propulsion collapse,
  not load attenuation. Future trend or wake-residual mechanisms must preserve
  a non-cancelling propulsive bootstrap and should be falsified first by joint
  excursion, wake shedding, displacement sign, and capture before their gains
  or apparent load reductions are interpreted.
