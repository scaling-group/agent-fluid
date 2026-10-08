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
  damping or its near-zero sensitivity. The isolated static-bias bracket is now
  also closed. Decreasing the bias from `10` to `8 deg` collapsed progress to
  `0.095`; increasing it to `11 deg` improved upstream head travel from
  `-6.93L` to `-7.89L`, closest approach from `5.33L` to `4.87L`, and progress
  from `0.380` to `0.424`, but did not change the roughly `+1.8L` upper-exit
  drift. Instead, posterior peak angle rose from `0.770` to `0.781 rad` and
  RMS force/moment rose from `325/3331` to `406/4113`, with the same joint-rate
  and command-cap hits. Thus positive posterior bias is necessary for approach,
  but static magnitude trades load for upstream progress without repairing the
  route; do not continue that scalar sweep. The inherited follow-ups now
  falsify preemptive phase/headroom attenuation as the saturation repair. A
  `35%` relief when nominal posterior wave and bearing request aligned reduced
  progress from `0.380` to `0.250`, worsened closest approach from `5.33L` to
  `6.88L`, and cut upstream travel from `-6.93L` to `-4.59L`, while retaining
  the `+1.78L` upper exit. A separate gate that faded steering as the nominal
  posterior target approached `32 deg` collapsed progress to `0.035`, closest
  approach to `8.94L`, and upstream travel to `-1.33L`; its lower RMS load
  (`161/1861`) accompanied lost propulsion and the same `+1.80L` exit rather
  than route control. Together with the global `8 deg` result, this shows that
  reducing the requested posterior waveform before an observed boundary event
  is destructive in this gait. Restore the static `10 deg` anchor and do not
  continue phase-allocation strength or nominal-headroom sweeps. The assigned
  parent's distinct measured-boundary test now closes that branch too: blending
  the ordinary servo toward inward braking only at `40--45 deg` posterior
  angle and outward rate left the `+1.75L` upper exit, both rate/command caps,
  and posterior peak (`0.772` versus `0.770 rad`) essentially unchanged, while
  worsening closest approach from `5.33L` to `5.77L` and raising RMS loads
  from `325/3331` to `357/3779`. Do not continue posterior soft-stop strength
  or threshold sweeps. Nor should body-lateral velocity be used as the next
  route-error proxy: a speed-normalized `0.30` correction still exited upward
  at `+1.77L`, worsened closest approach to `5.47L`, and reached the exact
  posterior angle limit; a raw `0.20` correction cut upstream travel from
  `-7.89L` to `-4.41L`, reduced progress from `0.424` to `0.239`, raised loads
  from `406/4113` to `428/4648`, and retained the `+1.79L` exit. These negative
  results falsify preemptive posterior suppression and lateral-velocity
  damping for this gait, not feedback activated only after objective distance
  progress is lost. A later recovery test should preserve the complete
  `11 deg`, `0.70/0.35` finite anchor while distance is closing and be rejected
  if it changes the approach before activation or repeats the upper exit.
