# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. It is the common release state,
  not candidate-specific evidence. The best sampled released sheet
  (`solver_7fc712bc668d`) shows a prompt targetward rotation, a sustained
  posteriorly traveling bend, and a compact diagonal crossing into the capture
  circle. It shows neither passive downstream advection nor a late near miss.
- The current prefill is that best sampled policy. Relative to the otherwise
  identical filtered-bearing constant `40/60` anterior/posterior allocation,
  bearing-dependent scheduling toward `35/65` at large error improves capture
  from `35.6895` to `35.0625`, mean distance from `1.7619L` to `1.7339L`, and
  score from `0.112158` to `0.140088`. It also lowers lateral-force RMS from
  `59.28` to `56.57`, moment RMS from `821.23` to `793.76`, and total command
  energy from `50,871` to `50,175`, while retaining the same `12 deg` total
  curvature budget. This supports geometry-conditioned posterior allocation,
  rather than an unbounded curvature or gait-gain extrapolation.
- Three sampled constant-allocation files reproduce exactly the same capture
  metrics and two use equation-identical policy files. They establish
  deterministic replay at the certified prewarm state, not independent wake
  robustness. The scheduled policy has one completed rollout, so its smaller
  navigation and load advantages remain conditional on this common wake phase.
- The strongest sampled policy still touches both `260 deg/time` velocity and
  `1800 deg/time^2` acceleration envelopes; peak joint angles are
  `0.528/0.583 rad`, relative-crossflow RMS is `0.247`, and the visible route
  crosses the developed wake rather than avoiding it. There is no event-level
  sign calibration for force, moment, or crossflow cancellation, so this
  candidate does not add a wake-load residual.
- The inherited route-trend failure is the relevant negative boundary. Its
  released sheet shows the propulsive body wave collapse into a short
  downstream drift and `left_domain` at `16.956`; metrics confirm negative
  progress, only `0.140/0.163 rad` peak joint angles, and `8.64` mean command
  energy. A faster additive target signal can therefore cancel the traveling
  oscillator even when nominal gait parameters remain present. The present
  edit keeps steering tied to persistent bearing and observed joint phase.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG turning with asymmetric flapping and classical traveling-wave propulsion
source_mechanism: make the target-side half-cycle modestly stronger while preserving a posteriorly lagged propulsive wave and a separately bounded mean-curvature request
transferable_invariant: persistent body-frame turn demand may smoothly bias the amplitude envelope between observed joint-state half-cycles, but the bias must vanish on alignment and must not replace wave direction, posterior lag, or bounded mean steering
nontransferable_details: published duty ratios and gains, dimensional beat frequencies, robot or species kinematics, exact vortex phases, actuator shares, and source-task routes
policy_translation: retain the evaluated filtered bearing, scheduled curvature allocation, oscillator, and posterior lag; use normalized anterior wave displacement and normalized persistent turn demand to enlarge only the steering-side oscillator envelope and shrink the opposite envelope by the same small bounded fraction
falsification: reject the half-cycle mechanism if capture is lost or later than 35.0625, mean distance exceeds 1.7339L, the compact diagonal route curls or drifts downstream, or anterior saturation residence and force or moment rise without a navigation gain

## Candidate hypothesis

Make one feedback-architecture addition to the best sampled controller:
body-frame turn demand and anterior joint-state phase jointly schedule a bounded
half-cycle amplitude asymmetry. The effective anterior oscillator envelope is
slightly larger when its displacement has the requested turn sign and equally
smaller on the opposite half-cycle. It returns continuously to the evaluated
baseline as persistent bearing approaches zero. No clock or inferred vortex
phase is used.

The filtered target bearing, `12 deg` total-curvature law, bearing-dependent
`40/60 -> 35/65` allocation, `0.55`-period state-feedback oscillator, and
posterior lag remain unchanged. The hypothesis is that a modest phase-local
steering impulse can shorten the early redirect without increasing static
curvature or erasing the traveling bend. The formal CFD result is unevaluated;
later evidence must compare arrival, mean distance, trajectory topology,
saturation residence, command effort, and force/moment loads with the sampled
prefill.
