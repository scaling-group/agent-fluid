# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet shows the fish held at the upper-right while four
  mature cylinder streets merge through the target neighborhood. This is the
  common initial condition, not candidate-specific route evidence.
- All four current sampled rollouts reach the target, so no sampled
  termination-failure keyframe exists. The most informative degraded finite
  comparison is the assigned parent's completed acceleration-projection test:
  its released sheet retains the direct route but shows a broader, more
  strongly bent body wake near the target. Metrics confirm the degradation:
  arrival slows to `39.4569`, excursions grow to `0.575/0.540` rad, and RMS
  force/moment rise to `94.55/1093.63`, versus `39.1104`, `0.543/0.463`, and
  `57.21/783.64` for the current prefill. Independent actuator clipping is
  therefore not evidence that common-factor command projection preserves the
  realized traveling bend.
- The two byte-identical best samples (`solver_a68507de2b6a` and
  `solver_209afb1b0e33`) make one decisive downward-left redirect and then
  self-propel on a compact upstream-left diagonal through the interacting
  wakes. Mean fish velocity `(-0.2781,-0.1162)` versus local flow
  `(-0.1531,-0.1687)` includes `0.1250` mean relative upstream motion, so the
  `39.0499` capture is not passive advection. They improve the prefill's mean
  distance from `1.91494L` to `1.91369L` and command energy from `50060.7` to
  `49942.8`.
- The history-only response release (`solver_a7d11ae4462d`) is slightly slower
  at `39.1159`, but has lower RMS force/moment `51.63/734.35` than the best
  samples' `57.05/783.02`. Thus releasing both lagged route memory and the
  auxiliary half-cycle bias is supported for the present score/arrival
  objective, but not as a general load-reduction claim. Every sampled variant
  still reaches both rate and acceleration caps.

## Policy hypothesis before the edit

Preserve the prefill's oscillator, range envelope, circular-history anterior
curvature, route/current sign-coherence selector, posterior lag, parameter
schema, and all large-error behavior. Add the repeatedly evaluated
response-completion mechanism: reconstruct the oldest bearing from the wrapped
window delta, measure scale-free reduction in bounded bearing-request
magnitude, and release both lagged route memory and the extra posterior
half-cycle asymmetry only when convergence coincides with small current
bearing. Padded history, stationary/diverging response, and large error give
zero release, so the decisive initial redirect is unchanged.

The current evidence predicts reproduction of the compact target-reaching
topology and approximately `39.05` arrival, with lower mean distance and
command effort than the prefill. Falsify this candidate for the present lane
if capture is lost, arrival materially exceeds the `39.11` class, or the route
and effort do not reproduce the two identical samples. Do not infer a load
benefit: for load-prioritized descendants, retain only route-memory release
rather than tuning this gate.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-feedback robotic-fish CPG direction tracking
source_mechanism: retain strong rhythmic redirect for large target error, then release auxiliary steering and route memory when observed target-bearing response demonstrates completion
transferable_invariant: preserve the propulsive carrier while normalized body-frame error and its observed convergence continuously withdraw transient redirect authority
nontransferable_details: species-specific burst shapes, robot duty ratios, published gains, dimensional frequencies, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use current bearing and wrapped bearing-window delta to release circular-history curvature and posterior half-cycle asymmetry only during aligned convergence; retain the two-joint oscillator and posterior lag
falsification: reject if direct capture or the early redirect degrades, or if arrival, mean distance, and effort fail to reproduce the two identical best samples

## Pre-evaluation verification

The required guidance-semantic, Julia policy-contract, deterministic
parameter-schema, and solver-boundary checks pass. All `14` direct
`params.FIELD` references match the `14` fields returned by
`target_policy_params()`, and the candidate is byte-identical to both evaluated
best samples. No formal CFD was run; the new rollout remains evidence for a
later worker.
