# Preserve v50 after terminal posterior feedback regressions

## Completed evidence and visual diagnosis before policy selection

- The four sampled solver artifacts are byte-identical v50 controllers with
  byte-identical trajectories.  Each begins from a direct uniform still-water
  field with `U_infinity=(0,0,0)`, no cylinders, and no prewarm, then captures
  at `17.41299 T`, score `-0.0595203`, final distance `0.745094 L`, and
  total/observed distance integrals `1.945327/1.329976 L`.  Their maximum
  speed, any-joint acceleration-limit residence, and peak normalized
  force/moment are `0.98310 L/T`, `40.11%`, and `0.032252/0.016092`.
- I inspected all four combined sampled sheets from release to termination.
  The readable top-down row shows active self-propulsion on a smooth
  target-signed arc: a compact startup disturbance becomes an organized
  alternating posterior street through capture.  The fully readable oblique
  replication shows compact paired caudal Lambda2 structures at release,
  `4 T`, `12 T`, `16 T`, and capture.  Two sheets have black oblique rows and
  one has missing middle oblique panels; because controller, trajectory, and
  diagnostics are identical, those are rendering failures rather than
  hydrodynamic counterexamples.
- The inherited completed v54 branches are the informative failures.  A
  posterior course-shape residual formed after unit-gain carrier-angle
  rejection still captures on the v50 step but worsens score, final distance,
  and total/observed integrals to `-0.0599417`, `0.745503 L`, and
  `1.945667/1.329978 L`.  A terminal bearing-divergence duty bias also captures
  on the same step but regresses further to `-0.0622763`, `0.747766 L`, and
  `1.947549/1.329991 L`, while raising any-joint limit residence to `40.21%`.
  Both keep v50's maximum speed and peak force/moment; the de-gaited-course
  sheet has a black oblique row, while the readable duty-bias sheet shows the
  same compact caudal structures and no beneficial wake topology.
- These results extend the inherited three-placement failure of raw
  instantaneous course slip.  Analytical subtraction of a posterior carrier
  estimate and phase-selective posterior duty modulation both leave the
  observed-route integral almost unchanged but make the terminal crossing
  shallower, so neither supplies reusable terminal authority for this coherent
  captured route.  The seven-step line-of-sight derivative is also not an
  alternative history cue: inherited reconstruction found it nearly perfectly
  correlated with anterior joint rate because its window is far shorter than
  the `0.55 T` carrier period.

## Sole candidate and falsifiable expectation

Keep the materialized
`dogfish_target_control_v50_geometrically_qualified_posterior_response` as the
only candidate.  It preserves the reproduced joint-state traveling-wave
carrier, posterior lag and launch allocation, normalized body-frame target
sensing, whole-wave pose rejection, selective crossflow confidence, base
route and redirect steering, carrier-first spillover, half-cycle steering,
geometry-qualified posterior response, approach priority, and componentwise
actuator projection.  Do not retain the failed course, line-of-sight-rate, or
terminal duty residuals in another channel.

The next CFD evaluation should reproduce capture near `17.413 T`, score near
`-0.05952`, total/observed integrals near `1.94533/1.32998 L`, the coherent
target-signed two-view wake, and the established speed/saturation/load
envelope.  Falsify this retained candidate if it loses capture or checkpoint
closure, changes the wake topology, or materially exceeds that envelope.
Revisit terminal navigation only when a completed trace provides a direction
signal spanning a meaningful fraction of a beat, or a held-out pose exposes a
persistent failure topology that is absent from the current monotone captured
route.  Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a productive traveling-wave carrier while separating persistent navigation error from fast gait-correlated lateral observations
transferable_invariant: supplementary feedback requires a response-coherent normalized cue that survives carrier-phase rejection; visible lateral motion alone is not route error
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, full-body oscillator state, exact vortex phases, and task-specific routes
policy_translation: retain v50's state-feedback carrier and bounded body-frame steering as the sole candidate; do not add another terminal posterior residual from raw course slip, a sub-beat derivative window, carrier-angle subtraction, or divergence duty
falsification: reject retention if v50 fails to reproduce, and reject this boundary if a cycle-separated cue or held-out failure improves capture, distance integrals, or loads without degrading the coherent wake and action envelope
```

## Evidence boundary

The outcome and visual claims above come from the assigned-parent guidance,
sampled completed v50 results, and inherited completed optimizer branches.  The
retained policy has completed evidence, but this worker's next evaluation has
not occurred and no same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole materialized policy is the completed v50 controller, SHA-256
  `cf9ca6aa2892b1aa4298d75c1359d84c467330129e0ea6167857742403b046ab`.
  It is byte-identical to all four sampled solver policies.
- The lightweight Julia contract returns two finite accelerations.  All `68`
  distinct direct `params.FIELD` references resolve among the `70` fields
  returned by `target_policy_params()`.
- The material-guidance check and solver editable-boundary check pass.  The
  configured check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this ChatGPT account, so its three exact no-CFD commands
  were run locally and separately.  No formal CFD was run.
