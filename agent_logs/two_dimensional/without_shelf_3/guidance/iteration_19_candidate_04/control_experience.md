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
- The target-blind seed's early leftward motion is genuine but insufficient
  propulsion evidence: it reached `8.61L` range, then its head moved
  `-13.30L` laterally and exited after `50.13` released time while mean lateral
  velocity (`-0.263`) nearly followed local flow (`-0.241`) and both joint-rate
  caps were touched. Preserve the state-encoded gait only behind bounded
  target-relative course correction, and size nominal rhythm below the hard
  velocity/acceleration limits; do not mistake a transient minimum distance or
  visible body wave for wake rejection. This lesson applies to the far-field
  domain-exit regime; it does not establish steering sign, wake-entry quality,
  or tight-radius capture until a feedback candidate is evaluated.
- Sampled target-feedback results separate a useful steering sign from a
  useful propulsion regulator. The positive-bearing angle-only oscillator was
  the sole variant with meaningful upstream travel (`-3.59L` head x, `0.259`
  progress), but it reached both acceleration caps and failed unstable with
  RMS force/moment `20024/314391`. Two full-orbit radial regulators stayed
  finite and low-load yet almost followed local flow and moved about `+2.25L`
  downstream. A later angle-only parent bundled a slower period, lower steering
  limit, `34 deg`/`200 deg/time` guards, and a `1600 deg/time^2` bound: it
  survived `63.55` time but moved its head `(+0.43,+1.80)L`, lost progress, and
  exited upward. Its joint-one speed reached `227 deg/time` and action reached
  `1557 deg/time^2`, so the nominally localized protection was active and the
  bundle did not preserve the useful orbit. In the far-field regime, neither
  full-orbit regulation nor simultaneously retuning gait, steering, and guards
  is supported. Isolate terminal protection against the exact progress gait,
  with thresholds above its nominal anterior `27.6 deg`/`184 deg/time` orbit
  and sampled `32.1 deg` posterior maximum but below its measured joint-one
  `38.1 deg`/`260 deg/time` failure excursion; reject this lesson if that
  controlled ablation still loses upstream relative motion or repeats the
  folded-body load event.
- Do not escalate turn-rate damping from a visible loop without a controlled
  ablation. In the positive-bearing lineage, fixed `0.04` damping gave the
  strongest finite sample (`-4.08L` head x, `6.71L` minimum range, RMS
  force/moment `66.5/958`). Adding up to `0.02` more damping inside roughly
  `8L` preserved nearly the same joint extrema but began the same upward loop
  earlier, reached only `8.59L`, and moved just `-2.48L` upstream; inherited
  exact uniform `0.05` damping did not interpolate safely: it survived
  `92.81` time and transiently reached `6.83L`, then made a full lower return,
  moved its head `(+0.33,-13.31)L`, and nearly followed the mean local
  crossflow (`-0.142/-0.150` mean y velocity/flow). The inherited `0.0425`
  midpoint also retained the upper exit while cutting head-x travel to
  `-1.93L` and worsening minimum range to `8.42L`; there is no unevaluated
  safe midpoint left in the `0.04--0.05` bracket. The inherited `0.0375` test
  closes the other side as well: it repeats the upper exit, moves only `-0.63L`
  upstream, reaches `9.92L`, has negative progress, and raises RMS force/moment
  to `73.2/1099`. A lower bearing gain of `0.45` was worse again (`-0.73L` head
  x, `9.90L` minimum range). Reversing curvature while combining turn-rate and
  moment feedback also moved `+2.74L` downstream, and a bearing-window-rate
  architecture failed unstable after `1.66` time. Before useful wake entry,
  treat `0.04` as a sharply isolated anchor and do not infer monotone course
  response from derivative-gain interpolation or transient minimum range;
  uniform derivative changes on either side are now negative. Revisit
  derivative additions only after a finite static loop reaches the wake
  corridor and shows course-rate growth that joint-state guards cannot arrest.
- Treat the guarded controller's `12 deg` saturated steering ceiling as locally
  bracketed, not as a monotone tuning knob for its upper loop. With every other
  term fixed, `10 deg` retained the visible upper-turn topology but cut head-x
  travel from `-4.08L` to `-1.43L`, worsened minimum range from `6.71L` to
  `9.00L`, and reduced progress from `0.217` to `0.0417`; raising the ceiling to
  `14 deg` also began the turn earlier, moved only `-2.46L` upstream, reached
  just `8.85L`, and raised RMS force/moment from `66.5/958` to `111/1560`.
  A smooth absolute-bearing rolloff at a `45 deg` scale with `0.25` residual
  authority is now negative as well: it pitched upward before a useful leg,
  moved only `-0.50L` upstream, reached just `10.20L`, produced progress
  `-0.023`, and exited after `46.62` despite finite RMS force/moment
  `81.4/1261`. Before wake/target entry, preserve the demonstrated `12 deg`
  static bearing law and avoid both global ceiling changes and authority
  attenuation keyed only to `abs(bearing)`; the latter can erase the approach
  without curing the upper-turn topology. An always-active body-lateral-velocity
  subtraction is now negative too: gain `0.35` capped at `2 deg` repeats the
  upper exit, cuts upstream travel to `-2.72L`, worsens minimum range to `8.20L`,
  leaves head-y exit travel at `+1.80L`, and raises RMS force/moment to
  `78.6/1084`. Thus lateral velocity by itself does not identify the terminal
  turn, and direct motion corrections active from release can damage the
  approach. Before wake/target entry, require the next bounded structural term
  to be inactive during the demonstrated closing leg and conditioned on an
  observed terminal regime such as sustained range opening. This boundary does
  not rule out motion feedback after useful wake entry, but reject such a test
  if it loses the anchor's `-4.08L` upstream leg, worsens its `6.71L` approach,
  repeats either full return, or raises loads.
- Stop interpolating rearward bearing authority or small turn-damping boosts
  for the far-field upper exit. Four sampled fore/aft variants spanning full,
  zero, and `-0.25` rearward bearing authority and `0--0.02` added damping all
  make the same visible nose-up return, exit with about `+1.80L` head-y travel,
  move only `-4.15` to `-4.44L` upstream, and reach `6.57--6.71L`. The
  `-0.25` variant is the best local anchor by lifetime and score, but its
  `6.63L` closest range is followed by a `9.43L` final range and the highest
  sampled RMS force/moment (`76.8/1030`), so it is not a recovery mechanism;
  the coupled zero-bearing/extra-damping variant's smaller `6.57L` transient
  range likewise does not outweigh its worse score, mean/final range, and
  lifetime. Inherited full-circle target-vector bearing is a stronger negative:
  it moves only `-0.57L`, reaches `9.27L`, produces negative progress, and
  raises RMS moment to `1157`. Across the sampled bracket, anterior speed still
  reaches `250--260 deg/time` with action near the `1600 deg/time^2` soft limit
  despite a `200 deg/time` guard, whereas posterior speed remains near
  `191 deg/time`. Preserve the `-0.25` policy only as the current target-ahead
  anchor and next isolate conditional anterior speed protection rather than
  another bearing rewrite; falsify that direction if it fails to lower the
  anterior excursion while retaining roughly `-4.4L` upstream travel and a
  `6.6L` approach, or if it increases loads or repeats either boundary return.
- Under the deeply rearward, persistent dual-opening selector, terminal joint
  allocation is now nonmonotonically bracketed: preserve the measured
  anterior/posterior `0.10/0.65` anchor instead of attenuating either joint
  farther. Relative to the fixed-`0.35` anterior-allocation baseline, this
  anchor improved score from `-11.241` to `-11.149`, head-x travel from
  `-4.555L` to `-4.676L`, mean/final range from `9.415/9.360L` to
  `9.342/9.266L`, progress from `0.247` to `0.254`, anterior angle/speed from
  about `34.24 deg`/`259.90 deg/time` to `33.23 deg`/`251.35 deg/time`, and
  RMS moment from `1004` to `985`. Replicated full anterior unload to `0.0`
  slightly lowered speed/moment to `249.86 deg/time`/`982.10` but worsened
  score to `-11.165`, head-x travel to `-4.653L`, mean/final range to
  `9.355/9.283L`, and progress to `0.253`. Keeping anterior `0.10` while
  reducing posterior allocation to `0.55` was worse again: score `-11.213`,
  head-x travel `-4.593L`, mean/final range `9.393/9.332L`, and progress
  `0.249`, with no meaningful load benefit. The opposite posterior
  continuation is negative too: increasing its gated fraction from `0.65` to
  `0.75` worsens score to `-11.178`, head-x travel to `-4.642L`, mean/final
  range to `9.366/9.296L`, and progress to `0.252`, while RMS force/moment
  remain effectively unchanged at `75.55/984.56`. All endpoints retain the
  same `6.609L` closest range and visible nose-up upper exit, so both posterior
  directions and the anterior endpoint bracket the `0.10/0.65` anchor; the
  selector supports only terminal load/navigation shaping. Before useful wake
  entry, avoid further terminal allocation changes and require a structurally
  distinct term that is inactive on the demonstrated closing leg; reject it
  if it loses roughly `-4.68L` upstream travel, worsens the `6.61L` approach,
  raises loads, or repeats a boundary return with worse mean/final range. This
  does not establish wake exploitation or `0.75L` capture.
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
