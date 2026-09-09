# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis

- The assigned parent is `optimizer_c049dd27444d`. Its durable guidance
  preserves the first-generation comparison and warns that the useful upstream
  curvature result was coupled to a destabilizing gait. The inherited optimizer
  notes propose, but do not claim results for, radial phase regulation, softer
  actuation, and turn-rate damping. The sampled rollouts now show which parts of
  those proposals survived CFD.
- The shared prewarm sheet shows the same held upper-right fish, four staggered
  cylinders, and fully developed overlapping streets through the target corridor
  for every candidate. It is common initial-condition evidence, not a policy
  result.
- The strongest finite approach is `solver_3c1578b8a76f`. Its released sheet
  shows large active bends and sustained leftward travel, followed by repeated
  reorientation and a folded terminal body before `unstable_dynamics` at
  `33.06` released time. It moves the head `-3.59L` in x with only `+0.15L` in
  y and reaches `9.01L` minimum range. Diagnostics confirm self-propulsion:
  mean velocity x is `-0.149` versus local-flow x `-0.077`. They also reject
  this as a viable incumbent: both acceleration commands reach `31.416
  rad/time^2`, joint one reaches the `4.538 rad/time` rate cap, and RMS lateral
  force/moment explode to `20023.6`/`314391`.
- The target-blind seed, `solver_635a7c69c939`, is the informative longer
  failure. Its sheet shows energetic bending and an initially upstream but
  increasingly vertical descent that misses the wake/target corridor and
  crosses the lower boundary at `50.13` time. Its `8.61L` transient minimum
  rebounds to `12.12L`; head displacement is `(-3.55,-13.30)L`, mean vertical
  velocity `-0.263` nearly follows local flow `-0.241`, and both joint rate and
  acceleration caps are reached. Strong action without bearing feedback is
  therefore propulsion evidence, not useful navigation.
- The two regulated positive-bearing follow-ups isolate the opposite failure.
  The current prefill, `solver_83a7583cc3c9`, uses a `0.82`-period, `21 deg`
  radial oscillator behind a `tanh` acceleration bound; its sheet remains
  nearly straight and never enters the useful wake. It moves `( +2.24,-2.79 )L`,
  exits after `24.94` time, and never improves on its initial `12.42L` range.
  `solver_f4aa1d08eba0` removes that acceleration bound but slows to a
  `0.90`-period, `18 deg` gait and adds turn-rate damping; it likewise moves
  `( +2.27,-4.79 )L` and exits after `42.07` time without improving initial
  range. In the latter, velocity x `0.0523` nearly equals local-flow x `0.0540`,
  so visible displacement is essentially advection rather than active upstream
  swimming. Both keep RMS force/moment near `20`/`380` and stay below the hard
  action caps. Thus radial regulation survives as a stability mechanism, but
  stability obtained with these attenuated gaits does not preserve propulsion.
- Each visual claim is cross-checked against `wake_metrics.csv` and the
  `wake_diagnostics` object rendered in `wake_observation.json`; this workspace
  contains no standalone copied `wake_diagnostics.json`. Evaluation records
  show physical terminations rather than policy materialization errors.

## One candidate hypothesis

Test one coupled controller: keep bounded positive body-frame bearing curvature
and the radial phase regulator, but restore gait authority close to the only
actively upstream sampled controller. Use a `0.78` period and `22 deg` amplitude,
with the demonstrated `0.55` posterior velocity lag and `0.9` damping. Their
nominal anterior harmonic speed and acceleration are about `177 deg/time` and
`1426 deg/time^2`, below the `260/1800` hard envelope and materially stronger
than the two advection-dominated regulated rollouts.

Limit mean curvature to `12 deg` with a smaller `0.50` bearing gain and split it
`35/65` across the joints. This should preserve more of the initial targetward
diagonal attitude than the unstable `16 deg`, `0.75`-gain controller while still
reversing with body-frame bearing. Do not add turn-rate, bearing-rate, load,
coordinates, route, clock, or unavailable flow feedback because the inherited
rate-feedback candidates supplied no positive navigation evidence.

Use a policy-owned `1700 deg/time^2` eighth-power smooth bound. Unlike the
prefill's `tanh` limiter, it leaves nominal commands nearly linear and acts
mainly near the envelope, so this test does not confound regulation with the
large nominal attenuation visible in the weak rollout. The next CFD evaluation
supports the hypothesis only if velocity remains upstream relative to local
flow, the trajectory retains target-directed negative-y travel, range improves
below the initial value, and the fish remains finite beyond `33.06` without
hard cap contact or large load growth. It is falsified by downstream advection,
another lower-boundary exit, renewed folding, or merely replacing hard
saturation with persistent contact at the policy bound. No outcome for this
new candidate is claimed here.
