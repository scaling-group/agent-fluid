# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts used direct uniform initialization in still water
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their displacement
  and wakes are therefore self-generated rather than inherited advection.
- I inspected both rows of the combined keyframe sheets for the strongest
  sampled finite rollout (`solver_563a0d75514e`, `2.385L`) and the assigned
  prefill (`solver_68aa0ab11610`, `2.494L`). The top-down rows show sustained
  alternating vorticity and the same diagonal approach followed by a nearly
  vertical departure below the target. The oblique rows show a coherent
  three-dimensional Lambda2 chain through that departure. Neither trace shows
  collision, passive drift, wake collapse, or numerical instability before
  its lower-boundary exit near `31T`; the unresolved failure is terminal
  steering allocation while propulsion remains strong.
- The sampled measured-response posterior brake is the best current action:
  it reaches `2.385L`, versus `2.494L` for full-direction posterior gating,
  `2.512L` for a joint-phase counterbend, and `2.536L` for a
  response-released posterior equilibrium S-bend. All four still leave the
  lower boundary with final distance `9.188--9.207L`, so none supplies a
  semantic recovery.
- At the brake's minimum near `17.87T`, full body-frame target-direction error
  is about `1.38 rad`, error-growing yaw is `2.19 rad/T`, closure is about
  zero, and speed remains about `0.705U`. The logged commands are only about
  `(7.71, 0.30) rad/T^2` at that instant, leaving acceleration authority for
  an anterior redirect even though carrier acceleration is frequently clamped
  elsewhere. This supports changing where the terminal correction acts, not
  increasing global drive or the command limit.
- The assigned parent's completed logs rule out three nearby continuations.
  Reallocating the brake into a posterior equilibrium residual reached
  `2.444L`, reversing removed authority into a posterior counterstroke reached
  `2.585L`, and approach-localized gait-yaw residualization reached `2.541L`;
  each retained the powered lower exit. A sampled phase-only posterior
  counterbend also reached only `2.512L`. Another posterior reallocation,
  joint-rate cancellation coefficient, or brake-strength edit would therefore
  repeat a falsified family.

## Policy hypothesis

Start from the sampled `2.385L` response-gated brake, preserving its anterior
state-feedback oscillator, bounded cruise curvature, posterior lag and
alignment envelope, raw-yaw-selected posterior attenuation, command reserve,
and effectively exact far-field behavior. Add one new mechanism: when
normalized distance and full body-frame target direction show a persistent
lateral near miss, shift only the anterior oscillator equilibrium by a second
bounded curvature request. The request persists through alternating gait yaw
because it follows geometry, and releases continuously as distance or lateral
direction error clears. The posterior equilibrium remains the established
cruise curvature, avoiding the repeatedly failed posterior reallocation
family.

At the best rollout's minimum, a `6 deg` maximum anterior request with the
existing smooth distance and direction envelopes is about `5.5 deg`; an
action-local calculation predicts an anterior-command increment near
`12.5 rad/T^2`, still inside the configured `28 rad/T^2` reserve at that
state. At `8L`, the distance envelope is below `0.001`, so cruise should be
unchanged. These are policy-signal checks, not coupled-CFD predictions.

Expected evidence is the established diagonal route and coherent wake followed
by an earlier reversal of the error-growing terminal yaw. Capture, a useful
new termination class, or a minimum materially below `2.385L` without worse
broad progress supports the mechanism. Falsify it on altered cruise, a
short-wake tight curl, one-sided or collapsed vorticity, materially increased
anterior limit/load residence, or the same powered lower exit without useful
minimum improvement.

```text
bookshelf_consulted: true
source_domain: nonsteady fish C-start redirection and sensor-modulated robotic-fish mean-curvature turning
source_mechanism: a large observed directional error evokes a bounded body-bend request that persists until geometric correction while the propulsive rhythm remains available
transferable_invariant: after a coherent carrier reaches a powered lateral near miss, place a bounded redirect on a joint with evidenced instantaneous authority and let normalized target geometry, rather than gait phase or elapsed time, sustain and release it
nontransferable_details: published gains, species-specific body envelopes, robot duty ratios, dimensional frequencies, prescribed C-start timing, exact vortex phases, approach radii, and task-specific routes
policy_translation: normalized distance and full target_body_L direction gate an anterior-only equilibrium residual inside the two-joint state-feedback oscillator, while the evidenced raw-yaw posterior brake and cruise tail target are retained
falsification: reject on changed far-field progress, a tight curl, lost wake coherence, greater anterior command/load residence, no material improvement below 2.385L, or persistence of the powered lower exit
```

## Evaluation boundary

Formal CFD for this candidate occurs only after this worker exits. Local checks
can establish contract compliance, boundedness, reflection equivariance, and
mechanism locality, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD checks

The candidate starts from the sampled response-gated posterior brake and adds
only the geometry-persistent anterior equilibrium request described above. In
an action-local reconstruction of the best rollout's minimum, the candidate
changes the anterior command from about `10.96` to `23.56 rad/T^2`; the same
lateral geometry at `8L` changes it by less than `0.009 rad/T^2`. The replayed
value differs from the trajectory's logged previous action, but the mechanism
increment is the predicted `12.6 rad/T^2`. This is a static policy comparison,
not a prediction of the coupled wake response.

The mandated material-guidance, lightweight Julia contract, deterministic
parameter-schema, and solver-boundary checks pass. All `22` direct
`params.FIELD` references are returned by `target_policy_params()`. Mirrored
near-miss states negate both commands exactly, a finite extreme-state grid
remains within the configured `28 rad/T^2` bound, and all `324` repository
non-CFD assertions pass. Formal CFD was not run.
