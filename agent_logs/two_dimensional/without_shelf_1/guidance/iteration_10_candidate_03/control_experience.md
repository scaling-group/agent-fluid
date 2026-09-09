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
- This no-Bookshelf ablation provides no cross-domain research shelf. Derive
  mechanisms only from the task contract, inherited guidance, sampled solver
  results and logs, and current rollout evidence; do not search for or
  reconstruct the omitted shelf.
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
- Retain the positive bearing-to-posterior-tail sign as the current finite
  anchor, but do not treat proportional steering or actuator saturation as
  solved. Relative to the saturated target-blind seed, the sampled
  `0.90`-period, positive `10 deg` tail-bias policy survived `73.39` versus
  `50.13` release units, improved progress from `0.024` to `0.132`, and reduced
  minimum distance from `8.61L` to `6.34L`; its near-zero mean local flow and
  upstream head velocity show useful self-propulsion. Yet it then made a broad
  upward loop, reached the posterior angle limit and both rate/command limits,
  and raised RMS force/moment to `196/2014`. A negative-sign, `1.10`-period,
  `11 deg` comparison instead moved `2.45L` downstream and exited after
  `17.26` units, while shifting the steering equilibrium into the anterior
  oscillator produced a curled unstable failure within `3.39` units and loads
  above `5e4/5e5`. Therefore the next reusable repair should keep steering
  out of the propulsion oscillator. A later posterior-only test subtracted a
  bounded bearing-window-rate term and lowered bias to `8 deg`; it still hit
  the posterior angle and both rate/command limits, exited sooner (`53.53`
  versus `73.39`), and worsened closest approach from `6.34L` to `7.90L`.
  Another mixed change reduced oscillator scale to `22 deg`, lag, bias, and
  command ceiling while adding bearing-rate lead, yet still produced roughly
  `39 deg` anterior excursion, an anterior rate-limit hit, a `9.31L` closest
  approach, and RMS loads `388/5262`. Thus do not treat target-bearing-rate
  feedback or nominal oscillator scale as actuator desaturation: bearing rate
  mixes body rotation with target-vector translation, and the self-excitation
  scale is not an observed angle bound. Inherited evidence also shows that a
  globally weakened `1.10`-period, `14 deg` gait can lower loads while moving
  downstream, so low effort alone does not justify coupling gait weakening to
  another rate test. Direct normalized body-turn damping is a supported
  upstream-progress mechanism with a now-bounded useful range, not a loop or
  desaturation solution. With every anchor parameter fixed, gains `0`, `0.35`,
  and `0.70` improve head displacement monotonically from `-2.73L` to
  `-4.69L` to `-6.93L` and progress from `0.132` to `0.255` to `0.380`; gain
  `0.70` also improves mean distance to `8.03L`, closest approach to `5.33L`,
  and score to `-9.53`. The current bracket closes that continuation: gains
  `0.80` and `1.05` regress progress to `0.351` and `0.369`, closest approach
  to `5.66L` and `5.64L`, and head travel to `-6.35L` and `-6.67L`; reducing
  only the rate scale from `0.35` to `0.25` at gain `0.70` regresses further
  to `0.291` progress, `6.41L` closest approach, and `-5.30L` head travel.
  Every sheet retains the broad upper loop and about `+1.20L` center-y exit,
  and every candidate still reaches both joint-rate and acceleration caps.
  Gains `0.80` and `1.05` lower posterior peak angle from `0.770` to `0.759`
  and `0.734 rad` without changing that topology, so posterior-angle relief
  obtained through more yaw damping is not evidence of a steering repair.
  Adding bounded lateral-velocity damping is independently negative: relative
  to isolated gain `0.35`, progress falls from `0.255` to `0.174`, closest
  approach worsens from `7.30L` to `7.73L`, and upstream travel falls from
  `-4.69L` to `-3.40L`. For this `0.90`-period, `10 deg` posterior-bias gait,
  retain `0.70/0.35` as the direct-rate anchor and stop raising its gain or
  lowering its scale; next tests should isolate geometric bearing sensitivity
  or a posterior-servo saturation repair while excluding target-bearing-rate,
  lateral-rate, and globally weakened-gait changes. This boundary must be
  re-established if the propulsion gait or bias ceiling changes materially.
- Do not allocate posterior steering headroom by suppressing the desired bend
  over oscillator phase for the `0.90`-period, `28 deg`, `0.8`-lag gait. Three
  inherited variants are consistently negative: multiplying steering by a
  phase-relief factor reduces progress from the unallocated anchor's `0.380`
  to `0.250`; fading aligned steering near a `32 deg` propulsive demand reduces
  it to `0.035`; and clamping the propulsive posterior target at `42 deg`
  reduces it to `0.102`. Closest approach worsens from `5.33L` to `6.88L`,
  `8.94L`, and `8.37L`, respectively, and all retain the approximately
  `+1.20L` upper exit. The target clamp does lower peak posterior angle from
  `0.770` to `0.683 rad`, posterior peak rate from `4.538` to `4.423 rad/time`,
  and RMS force/moment from `325/3331` to `215/2535`, but head travel collapses
  from `-6.93L` to `-2.31L`; angle/load relief here is propulsion removal, not
  route repair. Preserve the full unallocated posterior target in the next
  saturation tests and isolate feedback on measured posterior state near a
  cap instead of oscillator-phase gating. Re-establish this boundary if the
  propulsion period, amplitude, or lag changes materially.
