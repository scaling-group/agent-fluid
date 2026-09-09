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
  another rate test. The clean direct-body-rate sweep now closes that tuning
  axis: `damping/scale=0.70/0.35` is the finite anchor (`-6.93L` upstream head
  travel, `5.33L` closest approach, `0.380` progress), while `0.80/0.35`,
  `1.05/0.35`, and `0.70/0.25` regress to `-6.35/-6.67/-5.30L`,
  `5.66/5.64/6.41L`, and `0.351/0.369/0.291`, respectively. All four retain
  roughly `+1.8L` head-y drift, the same final upward curl, and both joint
  rate/command-cap hits; the higher `1.05` gain even raises RMS load to
  `334/3463`. Therefore restore `0.70/0.35` and stop tuning maximum rate
  damping or its near-zero sensitivity. The isolated bias bracket establishes
  `11 deg` only as the far-field anchor: relative to `10 deg`, it improves
  upstream head travel from `-6.93L` to `-7.89L`, closest approach from
  `5.33L` to `4.87L`, and progress from `0.380` to `0.424`, but leaves the
  upper drift at about `+1.79L`, raises posterior peak angle from `0.770` to
  `0.781 rad`, and raises RMS force/moment from `325/3331` to `406/4113` with
  the same rate/command-cap hits. The sampled follow-ups now rule out two
  apparent steering repairs. Fading the `11 deg` bias toward `70%` inside
  `6L` retains `+1.78L` drift and the upper curl while regressing upstream
  travel to `-7.19L`, progress to `0.393`, and mean distance to `7.85L`.
  Separately, a measured `40--45 deg` posterior angle/outward-rate soft stop at
  `10 deg` worsens closest approach to `5.77L`, raises RMS loads to
  `357/3779`, and does not reduce posterior peak angle (`0.772 rad`). Thus do
  not continue static-bias increases, distance/phase relief, or that near-limit
  servo as lateral-route repairs. Preserve the full `11 deg` far-field anchor
  when testing a distinct normalized lateral-motion signal; accept such a
  signal only if it keeps upstream progress while reducing the roughly
  `+1.8L` drift/curl and either closest approach or saturation/load.
- The sampled phase-opposition headroom term is now the finite route anchor,
  not the plain `11 deg` bias: a bounded `0.35` boost improves upstream head
  travel from `-7.89L` to `-11.33L`, closest approach from `4.87L` to `3.03L`,
  and progress from `0.424` to `0.517`, while mean head speed remains more
  upstream than mean local flow. This gain is not yet a lateral repair: RMS
  force/moment rise from `406/4113` to `511/5305`, the posterior joint still
  approaches `45 deg`, both rate/command caps remain active, and the fish still
  hooks out the upper boundary. Do not compose this anchor with the tested
  target-motion gates. A signed-forward bearing gate regresses travel/approach
  to `-8.49L/3.45L`; two close-range receding-distance reversals regress them
  to `-10.15L/3.13L` and `-10.83L/3.10L`. All three retain approximately
  `+1.77--1.79L` head-y drift and the same cap contacts, consistent with the
  inherited failures of lateral-velocity and yaw-moment rejection. Isolated
  phase-headroom tuning is applicable only while it improves approach and
  preserves upstream progress; close that axis and restore `0.35` if added
  boost merely raises load/saturation or leaves the upper exit unchanged.
- Prefer a small additive body-frame lateral-offset request over replacing the
  bearing drive near the target. On the complete `0.50` phase-opposition
  controller, adding `0.18*tanh(target_body_L[2]/2L)` changes the repeated
  upper-exit topology into target capture at `0.747L`: progress rises from
  `0.509` to `0.940`, terminal head-y travel changes from `+1.78L` to
  `-4.44L`, and RMS force/moment fall from `535/5416` to `445/4597`. The
  sampled alternative that blends bearing into lateral offset only inside
  `3L` briefly improves closest approach from `2.13L` to `1.89L` but still
  exits high at `+1.79L` and raises loads to `568/5495`; therefore do not
  retune that replacement's thresholds. Treat the additive `0.18`, `2L`
  controller as the first semantic-success anchor, while recognizing that it
  still hits the posterior angle and both joint rate/command caps. Retain the
  lesson across later wake-phase or geometry tests only if lateral route
  correction and upstream propulsion survive; do not infer desaturation from
  capture alone.
