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
  retune lateral-velocity damping. A distinct phase allocation remains
  testable only if it never reduces the sampled anchor, acts on opposing
  posterior headroom remaining after that anchor, and preserves upstream
  approach; it is falsified if the upper exit persists or loads rise without
  lateral change.
- Treat opposing-posterior-headroom strength as a bounded, nonlinear regime,
  not a monotone gain knob. The sampled `0.50` continuation improves the
  `0.35` anchor's upstream travel/closest approach from `-11.33L/3.03L` to
  `-12.28L/2.13L`, with head speed still exceeding local upstream flow, but it
  retains the upper hook, both rate/command caps, about `+1.78L` head-y exit,
  and raises RMS force/moment from `511/5305` to `535/5416`. The assigned
  parent's global `0.55` continuation crosses a sharp failure boundary:
  travel/closest approach/progress collapse to `-3.89L/5.70L/0.206`, the fish
  turns upward in the far-field, and RMS moment rises to `5969`. Therefore do
  not increase this coefficient globally beyond `0.50` or interpret its load
  growth as useful steering. A continuation is applicable only if it preserves
  the complete `0.50` far-field command and activates in the newly demonstrated
  sub-`2.75L` region; it is falsified if localization repeats the hook or adds
  load without improving the `2.13L` approach. Also avoid desired-posterior
  clipping as the companion repair: a `42 deg` target envelope lowers loads
  but collapses travel/closest approach/progress to `-1.89L/8.21L/0.074`, so
  desired-angle headroom is part of propulsion rather than a safe navigation
  limiter in this gait.
- Promote small additive body-frame cross-track feedback to the current
  successful route anchor, and distinguish early augmentation from a late
  geometric substitution. Starting from the `0.50` phase-headroom policy, the
  assigned parent's close-only continuation toward `0.55` worsens closest
  approach from `2.13L` to `2.21L`, retains the upper exit, and raises RMS
  force/moment from `535/5416` to `566/5660`. Replacing bearing with lateral
  offset only inside `3L` reaches `1.89L` but likewise retains about `+1.79L`
  head-y drift and the upper exit. By contrast, adding
  `0.18*tanh(target_body_L[2]/2L)` throughout the approach reaches the
  `0.75L` capture circle after `88.13` release units, changes head-y motion to
  `-4.44L`, and lowers RMS crossflow/force/moment to `0.289/445/4597` while
  mean head speed remains more upstream than local flow. Thus the reusable
  mechanism is early, bounded lateral-error augmentation of the preserved
  bearing/rate/phase controller, not more phase gain or a near-target bearing
  replacement. Retain it as the success baseline when body-frame target offset
  is available; a variant is falsified if capture is lost, the upper hook
  returns, or load rises without a shorter route. Angle/rate/command cap hits
  remain, so this result does not validate desaturation.
- Treat `0.18` as an isolated global cross-track-gain arrival point and close
  two-sided global tuning around it. Four comment-only copies reproduce its
  `88.13` arrival, `2.736L` mean distance, `-10.925/-4.435L` head displacement,
  and `445/4597` RMS force/moment exactly. In contrast, decreasing the gain to
  `0.17` restores the upper exit, reaches only `-7.31L` upstream and `3.27L`
  closest approach, and raises loads to `478/5138`; increasing it to `0.20`
  also restores the upper exit and raises loads to `490/4800`, despite a
  faster `-11.03L` upstream leg and `1.12L` closest approach. Both failures
  finish near `+1.8L` head-y displacement rather than the successful
  `-4.44L`, so neither lower effort nor closer passage is evidence of a usable
  route. Preserve the exact `0.18`, `2L` term through close approach. The only
  evidence-supported way to reopen the stronger side is to use its surplus in
  the far field and return to the complete `0.18` anchor before `3L`; this
  remains unvalidated until a sampled rollout captures. Reject such scheduling
  if the upper hook persists, capture is lost, or load rises without improving
  successful arrival time or distance integral.
