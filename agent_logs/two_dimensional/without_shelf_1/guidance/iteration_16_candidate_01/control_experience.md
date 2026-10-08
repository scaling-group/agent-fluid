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
  damping or its near-zero sensitivity.
- Treat a small positive posterior-bias increment as a far-field propulsion
  result, not evidence that lateral steering is solved. With the gait and
  `0.70/0.35` rate anchor fixed, increasing `10` to `11 deg` improves upstream
  head travel from `-6.93L` to `-7.89L`, closest approach from `5.33L` to
  `4.87L`, and progress from `0.380` to `0.424`; the inherited `8 deg` result
  had already collapsed progress to `0.095`. However, `11 deg` leaves head-y
  drift unchanged at about `+1.79L`, preserves the upper-domain curl and all
  rate/command-cap hits, reaches `44.7 deg` posterior angle, and raises RMS
  force/moment from `325/3331` to `406/4113`. Keep `11 deg` only as the current
  far-field anchor. Further static increases are falsified as steering repairs
  if they again buy x progress without changing y drift or if their load rise
  erases the approach benefit.
- Do not attenuate the static posterior request using gait phase, approach
  distance, fore-aft target projection, or lateral body velocity. At the
  `10 deg`, `25 deg`, `0.70/0.35` anchor, multiplying reinforcing phases down
  by as much as `0.35` retains the terminal curl and about `+1.78L` head-y
  drift while worsening upstream travel/closest approach/progress to
  `-4.59L/6.88L/0.250`; its lower `302/3197` RMS load reflects lost propulsion,
  not navigation. The sampled `11 deg` approach gate confirms that this is not
  merely a far-field timing problem: relief below `6L` regresses the static
  anchor from `-7.89L/4.87L/0.424` to `-7.19L/4.93L/0.393`, retains
  `+1.78L` drift and the upper exit, and leaves every joint-rate/command maximum
  unchanged. A signed fore-aft bearing-drive gate likewise reaches only
  `-7.11L` and `0.388` progress with `+1.80L` drift and the same saturation.
  Inherited lateral-motion feedback closes the proposed replacement signal:
  normalized slip damping reaches `-6.79L/5.47L/0.375`, still exits at
  `+1.77L`, and contacts the exact posterior angle limit; direct lateral-speed
  damping collapses to `-4.41L/5.82L/0.239`, retains `+1.79L` drift, and raises
  RMS loads to `428/4648`. These mechanisms all weaken or cancel a request
  that the current gait uses for propulsion without changing route topology.
  Restore the complete static `11 deg` anchor and do not deepen these gates or
  retune lateral-velocity damping. The sampled nonattenuating opposing-headroom
  allocation answers the remaining phase test: a `0.35` boost improves
  head-x travel/closest approach/progress from `-7.89L/4.87L/0.424` to
  `-11.33L/3.03L/0.517` and mean distance from `7.52L` to `6.44L`, but it still
  reaches both joint rate/command caps, leaves through the same upper boundary
  at about `+1.20L` center-y displacement, and raises RMS force/moment from
  `406/4113` to `511/5305`. Retain this allocation only as a far-field
  propulsion/approach anchor; further boost is falsified as a steering repair
  if the terminal curl persists or load rises without lateral-route change.
  A globally active receding-speed bearing reversal supplies a complementary
  negative boundary: it improves closest approach to `2.67L`, reduces the
  posterior peak from about `0.781` to `0.713 rad`, and lowers loads to
  `367/3880`, yet regresses head-x travel/progress to `-7.45L/0.405` and still
  exits through that upper boundary. Therefore do not apply receding recovery
  throughout the far-field leg; a later recovery test is justified only if it
  is inactive outside a close approach, preserves the phase anchor's upstream
  reach, and produces a second approach or changed exit topology.
- Localizing a further positive opposing-headroom increment does not rescue
  that gain direction. Relative to the sampled global `0.50` anchor, adding up
  to `0.05` only below `2.75L` increases upstream travel from `-12.28L` to
  `-12.66L` but worsens closest approach from `2.13L` to `2.21L`, leaves
  progress at about `0.509`, and repeats the same visible upper hook and
  rate/command-cap hits. RMS force/moment also rise from `535/5416` to
  `566/5660`. Retire positive phase-boost continuation even when close-gated;
  restore `0.50` for future structural tests. A close controller must change
  the conditioning observation without weakening the demonstrated far-field
  leg, and is supported only by capture, a second approach, or changed exit
  topology rather than extra upstream travel alone.
