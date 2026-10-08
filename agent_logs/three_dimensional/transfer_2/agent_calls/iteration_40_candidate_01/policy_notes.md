# Terminal posterior achieved-turn release candidate

## Visual diagnosis before editing

- I read the observation, metrics, diagnostics, trajectory, and combined
  keyframe sheet for all four sampled solvers.  Their policies, full
  trajectories, and combined sheets are byte-identical, so they are four
  replications of the assigned v44 parent rather than independent mechanism
  comparisons.  Each begins from direct-uniform quiescent water
  (`U_infinity=[0,0,0]`) with no cylinders or prewarm, and captures at
  `24.557514T` and `0.747654L` with mean distance `2.347238L` and score
  `-0.447653764`.
- I inspected both required rows from release through termination.  The
  top-down vorticity row shows wake-free release, self-propelled diagonal
  progress, a coherent alternating vortex street, and a compact transverse
  hook through the target disk.  The oblique Lambda2 row shows discrete,
  coherent three-dimensional structures through the hook.  There is no
  visible passive advection, wake breakup, out-of-plane escape, collision, or
  instability.  No sampled termination failure or visually distinct sheet is
  available; the informative failures are therefore the inherited numerical
  controls, not a fabricated visual comparison.
- The metrics support the visual stability: all four captures use `283`
  moving-window shifts, have zero sampled joint-position hard-stop occupancy,
  peak absolute forward/lateral force and yaw-moment coefficients of
  `0.02292/0.02893/0.01559`, `73.393%` raw acceleration-envelope exposure,
  and `13.617%` exact-rate exposure.  Relative to its v41 parent, inherited
  v44 evidence advances capture by `0.082501T`, improves final/mean distance
  by `0.000702/0.000699L`, reduces final projected miss from `0.631928L` to
  `0.612134L`, and reduces terminal yaw rate from `1.887` to `1.564 rad/T`
  without changing the far route or wake class.  This validates anterior
  collision-course commitment while leaving a measurable rotating terminal
  hook; it does not support altering the carrier or adding more course gain.

## Policy hypothesis

Produce exactly one v45 candidate by preserving the complete evaluated v44
controller and adding one posterior-only achieved-turn release.  When v44's
normalized body-frame range, positive closing, course-speed, and projected-miss
gate already identifies a safe collision course, taper only the posterior
route-steering share when its requested sign matches measured yaw.  Leave the
anterior oscillator, posterior traveling-wave carrier, phase-selective terminal
miss residual, posterior stroke reserve, and posterior rate coast unchanged.
The added gate is sign-equivariant with respect to its two inputs: under a
lateral reflection that reverses both measured yaw and the inherited signed
route request, their alignment and the amount of relief do not change.  The
inherited controller has sign-asymmetric turn gains, so this is not a claim
that the complete v45 policy is exactly reflection-equivariant.

This is deliberately not a posterior hold whenever the target is near.  It
cannot synthesize acceleration, cannot increase the inherited steering or
command envelope, and releases immediately when route steering opposes yaw or
the predicted intercept leaves the safe corridor.  A parent-trace audit predicts
action changes in only `25/4465` states, first at `23.738T/1.064L`.  The maximum
pre-filter route withdrawal is `0.374 rad/T^2`, and the inherited allocation
and safety layers reduce the largest final command change to `0.224 rad/T^2`;
every far-route state remains unchanged.
Falsify the mechanism if post-worker CFD loses capture, changes the route before
the `2.10L` approach neighborhood, worsens arrival, mean/final distance,
projected miss, or terminal yaw rate, or regresses the coherent-wake,
zero-hard-stop, low-load, raw-command, or exact-rate classes.  Because the four
samples are fixed-pose replications, reflection and release-pose robustness
remain untested.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach hold
source_mechanism: preserve the rhythmic phase anchor while sensory feedback withdraws redundant direction-tracking effort after the measured motion already supplies the requested turn and a safe intercept
transferable_invariant: keep propulsion state-derived and continuously taper only an already-requested steering residual when normalized body-frame course, closing, range, projected miss, and measured yaw show that the residual is redundant
nontransferable_details: published gains, dimensional cadence, robot hardware, species kinematics, full-body waveforms, exact vortex phases, capture geometry, and task-specific routes
policy_translation: retain v44 unchanged except for a sign-equivariant posterior route-steering release equal to the existing collision-course commitment gate times same-sign measured-yaw alignment; preserve the carrier, terminal miss correction, and safety filters
falsification: reject if nominal capture or v44's arrival, distance, projected-miss, or yaw advantage is lost, if any command changes before the established approach neighborhood, or if wake, load, stroke, rate, or raw-command classes regress; require reflected or pose-perturbed evidence before claiming generality

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The sampled numbers above
belong to the assigned v44 parent; the v45 result is not available in this
worker and is not claimed as evidence.

## Pre-evaluation validation

- The public Julia contract returns two finite accelerations on the prescribed
  smoke state.  The deterministic schema audit resolves all `87` direct
  `params.FIELD` references among the `89` fields returned by
  `target_policy_params()`.
- The reusable-guidance semantic check and solver editable-boundary check pass.
  A reconstructed body-frame replay over the `4465` sampled parent rows
  confirms the stated `25`-row locality and `0.224 rad/T^2` maximum final
  command difference.  This replay is a non-CFD counterfactual audit, not a
  prediction of the coupled trajectory outcome.
- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported on this account, matching the inherited infrastructure failure.
  Its three declared no-CFD checks were therefore executed directly and
  separately; no formal CFD was run.
