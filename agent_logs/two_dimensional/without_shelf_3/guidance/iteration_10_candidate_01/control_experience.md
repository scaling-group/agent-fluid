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
- Treat `0.04` opposing recent-turn damping as an isolated far-field anchor,
  not the midpoint of a monotone course-response curve. It gave the strongest
  finite sample (`-4.08L` head x, `6.71L` minimum range, RMS force/moment
  `66.5/958`), while controlled uniform gains on both sides repeated the upper
  turn sooner: `0.0375` moved only `-0.63L`, reached `9.92L`, and had progress
  `-0.014`; `0.0425` moved `-1.93L` and reached `8.42L`; `0.045` moved about
  `-0.15L` and reached `9.59L`. Uniform `0.05` instead survived `92.81` time
  before a full lower return whose mean y velocity nearly followed local flow
  (`-0.142/-0.150`), and range-gating up toward `0.06` reached only `8.59L`.
  A lower bearing gain, combined turn-rate/moment feedback, and a
  bearing-window-rate controller were negative as well. Before useful wake
  entry, avoid further scalar recent-turn interpolation and do not rank a
  transient closest approach above the final trajectory topology; revisit
  derivative feedback only after a finite policy reaches the wake corridor or
  a different steering architecture establishes a new bracket.
- Treat the guarded controller's `12 deg` saturated steering ceiling as locally
  bracketed, not as a monotone tuning knob for its upper loop. With every other
  term fixed, `10 deg` retained the visible upper-turn topology but cut head-x
  travel from `-4.08L` to `-1.43L`, worsened minimum range from `6.71L` to
  `9.00L`, and reduced progress from `0.217` to `0.0417`; raising the ceiling to
  `14 deg` also began the turn earlier, moved only `-2.46L` upstream, reached
  just `8.85L`, and raised RMS force/moment from `66.5/958` to `111/1560`.
  Absolute-bearing attenuation is negative too: a smooth `45 deg` rolloff with
  `0.25` residual authority pitched upward before a useful leg, moved only
  `-0.50L`, reached `10.20L`, and produced progress `-0.023`. Nor should the
  anchor's `+1.80L` head-y displacement be treated as a disturbance that an
  additive body-lateral-velocity term will automatically reject. A bounded
  gain-`0.35`, `2 deg`-cap correction repeated the upper exit, reduced head-x
  travel to `-2.72L`, worsened minimum range to `8.20L`, and raised anterior
  peak speed from `4.361` to `4.453 rad/time` and RMS loads from `66.5/958` to
  `78.6/1084`. Before wake/target entry, preserve the `12 deg` static law and
  avoid more scalar attenuation or additive steering-request corrections; they
  can perturb the progress-producing oscillator before curing the loop. An
  orthogonal test may redistribute the same bounded steering demand between
  joints, but this implication is falsified if redistribution merely moves cap
  contact or load to the posterior joint. Motion feedback after demonstrated
  wake entry remains outside this evidence boundary.
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
