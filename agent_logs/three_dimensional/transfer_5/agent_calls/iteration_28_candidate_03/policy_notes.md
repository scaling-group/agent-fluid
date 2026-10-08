# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- All four sampled solver rollouts and the inherited optimizer rollouts are
  finite direct-uniform still-water evaluations with `U_infinity=[0,0,0]`, no
  cylinders, no prewarm, and capture termination. The strongest sampled
  baseline is the role-separated observer reproduced exactly by
  `solver_3cb46b9057a1`, `solver_8ae803ceeb4c`, and
  `solver_f5ac4c378d79`: it captures at `23.83702T`, with score
  `-0.53501328`, scoring mean/final distance `2.433468/0.746096L`, and
  inside-`3L` mean/peak absolute yaw `1.67938/3.19386 rad/T`. The sampled v33
  comparator captures at `23.84252T`, score `-0.53509095`, mean/final distance
  `2.433543/0.746165L`, and mean/peak yaw `1.67999/3.18484 rad/T`. Thus the
  split observer is a narrow progress/load improvement with a mixed peak-yaw
  boundary, not evidence for more observer gain.
- I inspected both rows of the combined sheets from release through capture
  for the repeated split baseline, v33, and the weakest inherited terminal
  intervention. The top-down mid-plane row shows self-propulsion along the
  same smooth target-directed arc and an ordered alternating wake through the
  terminal bend. The oblique Lambda2 row shows a persistent compact 3D vortex
  chain without passive advection, wake breakup, boundary contact, or
  instability. Their visual differences are below the rendered cadence, so
  the measured distance, joint, yaw, and moment histories decide among them.
- The assigned-parent inherited rollout directly rejects another one-sided
  anterior-envelope intervention: it retained capture at `23.83702T` and
  lowered peak yaw from `3.19386` to `3.18039 rad/T`, but worsened score and
  mean/final distance to `-0.53587987` and `2.434158/0.746981L`, while peak
  moment rose from `0.013581` to `0.013804`. The inherited quadrature and
  rate-led phase gates also regressed score to `-0.535561` and `-0.535363`
  and raised peak moment to `0.013725` and `0.013888`; half-cycle envelope
  redistribution regressed further to `-0.536347` and `0.747467L` final
  distance. These completed attempts rule out another envelope, timing, or
  duty-share variation.
- The repeated split trace exposes a different opportunity. Inside `3L`, 85
  of 90 samples with `|moment_z_L2| >= 0.010` have negative instantaneous
  yaw--moment power: the fluid moment already opposes the current yaw. Mean
  yaw--moment power is `-0.002185`, and the strongest dissipative sample is
  `-0.030019`. The peak moment (`0.013581`) itself occurs with opposite-sign
  yaw (`-1.18054 rad/T`), so treating moment magnitude as an unqualified
  disturbance would suppress a useful hydrodynamic brake. The controller
  should instead condition only redundant active correction on the measured
  power sign.

## Single candidate hypothesis

Retain the repeated split observer, continuous target-course brake,
response-released C-bend carrier, posterior target and lag, cadence, and
component-wise smooth command projection. Add one bounded load-aware
arbitration layer to the existing phase-selected anterior counter-curvature:
when normalized body yaw and measured yaw moment have opposite signs, smoothly
release part of that residual because the fluid is already extracting yaw
energy; when the moment is weak or yaw-supporting, leave the established
residual unchanged. Do not gate the continuous course brake or alter either
joint's propulsive oscillator.

This should avoid stacking active curvature on top of a naturally restorative
load, preserve more target-directed propulsion than the failed envelope
variants, and reduce peak moment without adding posterior authority. Falsify
it if CFD loses capture, materially worsens split-baseline arrival or
mean/final distance, changes the coherent wake, raises peak yaw or moment,
increases actuator-limit exposure, or merely trades lower load for worse
progress. Offline load-power sign is a selector hypothesis, not evidence that
the unevaluated candidate improves CFD.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: preserve helpful fluid-induced motion and condition a small rhythmic residual on sensed load rather than cancelling every lateral response
transferable_invariant: when measured fluid moment is already extracting yaw energy, avoid stacking redundant active correction while preserving slow target feedback and the traveling-wave carrier
nontransferable_details: published gains, species-specific CPG envelopes, prescribed wake phase, cylinder routes, dimensional load scales, and task-specific timing
policy_translation: use normalized instantaneous body yaw and `moment_z_L2` to form a bounded dissipative-power gate that relieves only the existing terminal anterior half-cycle residual; retain the anterior-only course observer and posterior wave unchanged
falsification: reject if capture/progress, wake coherence, yaw or moment histories, or actuator feasibility regress relative to the repeated split-observer baseline

## Non-CFD validation

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account and failed before inspecting files. I
  ran its three prescribed commands directly and separately.
- The guidance/materiality check passes, and the solver boundary check passes
  with exactly one nonempty `candidate_target_policy.jl` in the candidate
  repository.
- Julia is not installed, so the lightweight executable mock-state check
  cannot start. The deterministic static schema audit finds 71 unique direct
  `params.FIELD` references among 73 returned fields, with no undeclared
  reference; only `version` and `control_period` are metadata. Public contract
  function counts are one each, and the policy contains no elapsed time, step,
  cylinder, random, file-I/O, or mutable-global state reference.
- Offline replay of the gate alone on the repeated split trace keeps residual
  authority bounded in `[0.50055, 1]` inside `3L`; its mean is `0.82263`, and
  zero or yaw-supporting moment leaves authority exactly one. This checks
  selectivity and bounds only. No formal CFD was run, and no performance claim
  is made for the unevaluated candidate.
