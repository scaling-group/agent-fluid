# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets have the same SHA-256 and show the
  common held fish above the fully developed, merging four-cylinder streets.
  This anchors the cylinder layout and release flow but cannot rank policies.
- Three sampled `tail_lag_gain=0.75`, `tail_damping=0.65` rollouts are exact
  metric and keyframe replicas and remain the strongest finite evidence. The
  released sheet shows an early left-down turn followed by a dense alternating
  tail trail, a safe diagonal entry into the merged wake, and target crossing.
  Mean fish x velocity `-0.2853` exceeds mean local flow `-0.1687`, confirming
  useful self-propulsion rather than passive advection. Each reaches at
  `38.049` with mean distance `1.802L`, energy `52895`, power `3965`,
  relative-crossflow RMS `0.2249`, force/moment RMS `42.01/653.13`, and joint
  peaks `0.496/0.521` rad; both joints touch the recorded rate and acceleration
  caps.
- No sampled or inherited sheet is a semantic failure. The inherited
  `tail_lag_gain=0.70` rollout is the most informative policy-hypothesis
  failure. It visibly retains the same self-propelled diagonal corridor and
  safe capture, but trails the `0.75` fish at matched late keyframes. Metrics
  reject the proposed monotone lag extension: arrival worsens to `39.605`,
  mean distance to `1.872L`, energy/power to `55461/4197`, crossflow to
  `0.2429`, and force/moment to `43.11/675.66`. Mean x velocity falls to
  `-0.2744`, while posterior peak rises to `0.570` rad despite unchanged
  rate/acceleration maxima. This is worse even than sampled gain `0.80` on
  arrival, distance, effort, crossflow, and loads.
- The inherited optimizer notes and parent guidance also bound the other
  measured axes: fraction `0.30` and `0.45` allocation continuations regress,
  gain `1.725` and `1.9` regress, and a mixed velocity/moment controller became
  unstable at `2.807`. The new candidate therefore does not extrapolate lag,
  allocation, or bearing gain and does not add an unscaled observation.
- The compact evidence exposes embedded wake diagnostics in
  `wake_observation.json` but no local standalone `wake_diagnostics.json`.
  Claims here are restricted to the provided sheets, CSV metrics, embedded
  diagnostics, assigned parent guidance, and inherited notes inside this
  Phase 2 workspace.

## Candidate hypothesis

Restore the replicated `tail_lag_gain=0.75` anchor and preserve its `0.55`
period, 28-degree oscillator, gain-`1.7` bounded body-frame bearing law,
12-degree steering limit, fraction-`0.35` allocation, and observation set.
Change only `tail_damping` from `0.65` to `0.70`. This isolated `7.7%` damping
increase tests a separate bounded posterior-dynamics axis suggested by the
failed `0.70` lag rollout's larger posterior excursion and worse crossflow,
moment, and effort. The aim is to temper posterior overshoot/cap residence
while retaining the proven propulsion phase and diagonal route; it is not a
claim that damping response is monotone or that lower actuation alone improves
navigation.

The later CFD rollout supports the candidate only if it captures on the same
safe corridor and improves at least one of posterior peak, command energy,
power, crossflow, or moment relative to the `0.75/0.65` anchor without arrival
exceeding the sampled `0.80` bound `38.362` or mean distance exceeding
`1.812L`. It is falsified by loss of capture, collision/exit/instability,
arrival no better than `39.605`, or any material regression beyond the failed
`0.70` lag envelope (`0.570` rad posterior peak, `0.2429` crossflow,
`43.11/675.66` force/moment). Any positive conclusion is limited to this
certified wake phase and start pose until a held-out rollout reproduces it.
