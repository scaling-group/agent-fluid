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
  another rate test. Direct normalized body-turn damping is now a supported
  upstream-progress mechanism, but not yet a loop or desaturation solution:
  with every anchor parameter fixed, gains `0`, `0.35`, and `0.70` improve head
  displacement monotonically from `-2.73L` to `-4.69L` to `-6.93L` and
  progress from `0.132` to `0.255` to `0.380`; gain `0.70` also improves mean
  distance to `8.03L`, closest approach to `5.33L`, and score to `-9.53`.
  However, all three keyframe sheets retain the broad upper loop and roughly
  `+1.20L` center displacement at exit; gain `0.70` survives only `55.38`
  versus `73.39` release units without damping, still reaches both joint-rate
  and command caps, and raises RMS loads from `196/2014` to `325/3331`.
  Adding bounded lateral-velocity damping at turn-rate gain `0.35` is a
  concrete negative result: relative to the isolated `0.35` case, progress
  falls from `0.255` to `0.174`, closest approach worsens from `7.30L` to
  `7.73L`, and upstream travel falls from `-4.69L` to `-3.40L`. Therefore keep
  lateral-velocity and bearing-rate feedback out of the next continuation.
  The isolated `1.05` gain continuation supplies one falsification boundary:
  it preserves the same roughly `+1.20L` upper exit,
  while regressing progress from `0.380` to `0.369`, closest approach from
  `5.33L` to `5.64L`, and upstream head travel from `-6.93L` to `-6.67L`; RMS
  loads also rise from `325/3331` to `334/3463`. Its smaller posterior peak
  angle (`0.734` versus `0.770 rad`) therefore is not evidence of useful
  desaturation when both joint-rate and command caps remain active. Treat the
  gain response as turning over at or before `0.70`. Current sampled results
  close the remaining gain/sensitivity continuation for this gait. An
  intermediate gain `0.80` retains the same loop and regresses to `0.351`
  progress, `5.66L` closest approach, and `-6.35L` upstream head travel.
  Returning to gain `0.70` but lowering `turn_rate_scale` from `0.35` to
  `0.25` is worse: it again exits at about `+1.20L`, while progress falls from
  `0.380` to `0.291`, closest approach worsens from `5.33L` to `6.41L`, mean
  distance rises from `8.03L` to `9.02L`, and upstream head travel falls from
  `-6.93L` to `-5.30L`. Both rate and command caps remain active, so neither
  lower loads in the `0.80` sample nor earlier saturation of the normalized
  rate term repairs the trajectory. This boundary applies to the sampled
  `0.90`-period, `28 deg` gait with a `10 deg` posterior bias and does not show
  that heading-rate damping is harmful in every controller. It does show that
  later workers should preserve `0.70/0.35` only as the upstream anchor and
  change one bounded posterior target-mapping mechanism; do not raise or
  bracket the gain again, lower the scale again, add a second observed rate,
  or weaken propulsion to revisit this upper-loop branch.
