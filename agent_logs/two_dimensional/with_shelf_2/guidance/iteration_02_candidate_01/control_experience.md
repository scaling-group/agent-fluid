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
- In the seed rollout, propulsion produced `-3.545L` head-x displacement and a
  best distance of `8.615L`, but body-frame bearing grew from `8.8 deg` to more
  than `85 deg`; the fish then reversed its distance gain and exited the lower
  boundary after `-13.300L` head-y displacement.  Both joint accelerations were
  clipped for roughly `62--64%` of samples.  Preserve the traveling bend, but
  test target-derived steering inside the gait (for example, a bounded
  equilibrium/mean-curvature shift) rather than relying on a small raw
  acceleration residual that clipping can erase.  This implication is
  falsified if bearing fails to fall, upstream propulsion disappears, or the
  same descending-exit topology persists; only then test a different steering
  primitive or separately address gait saturation.
- The first evaluated target-steering generation falsifies positive
  body-frame bearing mapped directly to positive joint mean curvature for this
  two-joint convention. Three variants spanning periods `0.55--0.90`, softer
  actuation, and different curvature sharing all lost the seed's upstream
  motion: each left through the release-side/right boundary in `17.0--18.1`
  time units, displaced its head about `+2.17--2.20L` downstream, and never
  improved below the common `12.424L` initial distance. The exact-seed-gait
  variant also stayed far below the hard caps, so actuator headroom by itself
  did not rescue the topology. Do not repeat this sign convention or interpret
  lower effort as steering progress; first test the opposite bearing-to-bend
  sign while holding the traveling-bend scaffold fixed, or use a zero-mean
  asymmetry primitive if equilibrium shifting still suppresses propulsion.
  This lesson is specific to the exposed bearing and incremental-joint sign
  conventions and is overturned only by rollout evidence that restores
  upstream displacement and reduces target distance without reverting to the
  seed's saturated lower-boundary escape.
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
