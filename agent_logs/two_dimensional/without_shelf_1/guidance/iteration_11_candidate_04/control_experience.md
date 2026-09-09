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
  `7.73L`, and upstream travel falls from `-4.69L` to `-3.40L`. Subsequent
  isolated tests close the direct-rate continuation: damping `0.80` and `1.05`
  and rate scale `0.25` all lose progress or closest approach while retaining
  the same upper loop, and a `20 deg` bearing scale regresses progress to
  `0.310`. Preserve the `0.70/0.35/25 deg` rate-and-bearing anchor rather than
  tuning those quantities again. Static posterior bias from `10` to `11 deg`
  is the strongest sampled approach continuation: progress rises from `0.380`
  to `0.424`, closest approach improves from `5.33L` to `4.87L`, and upstream
  head travel grows from `-6.93L` to `-7.89L`. Its boundary is equally clear:
  RMS force/moment rises from `325/3331` to `406/4113`, posterior peak reaches
  `0.781 rad` within `0.005 rad` of the hard limit, both rate/command caps
  remain active, and the sheet retains the `+1.20L` upper exit. Do not increase
  static bias again until that late curl is repaired. Raw distance relief of
  the already combined bearing-plus-rate command is a negative result: a
  `0.70` floor below `6L` lowers progress to `0.393`, worsens mean distance
  from `7.52L` to `7.85L`, and retains the same exit and every cap. A measured
  posterior soft stop on the `10 deg` anchor also fails to reduce peak angle
  (`0.772` versus `0.770 rad`) and worsens closest approach to `5.77L`.
  Inherited phase/headroom allocation is the opposite overcorrection: it
  lowers posterior peak to `0.698 rad` and loads to `161/1861`, but collapses
  progress to `0.035`, closest approach to `8.94L`, and upstream travel to
  `-1.33L`. These gates either act too late or attenuate target drive and
  direct turn damping together. The next reusable late-turn test should keep
  the full far-field `11 deg` approach and full direct body-rate damping while
  attenuating only target-bearing drive under a normalized geometric trigger;
  fore-aft target projection is applicable because the exposed bearing folds
  that sign. It is supported only if upstream progress remains near `0.424`
  while upper drift, closest approach, saturation, or loads improve. Early
  progress loss, a stall with the target abeam, or the unchanged upper exit
  falsifies separated fore-aft allocation and calls for a different late-turn
  discriminator—not more bias, raw-distance relief, joint-headroom gating,
  tighter soft stops, bearing-rate, or lateral-velocity feedback.
