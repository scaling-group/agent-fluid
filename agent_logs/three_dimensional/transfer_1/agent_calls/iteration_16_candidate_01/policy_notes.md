# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled solver rollouts and the assigned-parent rollout report
  direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders, and no prewarm snapshot. Motion in the sheets is therefore
  self-propulsion rather than advection or inherited flow.
- The combined top-down vorticity and oblique Lambda2 sheets were inspected
  from release to termination for the highest-scoring finite capture
  (`solver_6b0e320e2f55`) and the assigned-parent failure
  (`solver_6c5d98621185`). The capture builds a coherent alternating wake by
  about `4T` and retains a traveling bend and compact three-dimensional wake
  structures through the `0.7494L` crossing at `18.6010T`. Its crossing speed
  is `0.8268L/T`; there is no visible collision, coasting, wake collapse, or
  numerical instability.
- The parent projected-miss replay also remains self-propelled and keeps a
  coherent alternating wake, so its failure is steering-semantic rather than
  propulsive. It passes below the target, reaches only `1.6366L` at
  `18.7880T` while still moving at `0.8221L/T`, then continues away and exits
  the lower virtual boundary at `31.6910T` with final distance `10.2810L`.
  Immediately at closest pass its head is `(10.094,8.282)L`, below and to the
  right of the target, while yaw rate is `-1.2803 rad/T`; the wake remains
  finite and organized. This exact replay falsifies the prior one-run claim
  that replacing terminal course error by signed projected miss is robust.
- The prefilled LOS-guarded controller captured once at `18.6065T`, but the
  evaluated speed-reserve policy bytes (`567de354...`) captured in all three
  sampled repeats at `18.2050--18.6010T`, with score
  `-0.15856-- -0.15140`, mean distance `2.0387--2.0456L`, and the same
  coherent carrier in both visual rows. The three repeats are stronger
  evidence than either the single prefill capture or the failed projected-miss
  replay.

## Candidate hypothesis

Materialize the repeat-supported
`dogfish3d_intercept_guarded_speed_reserve_v1` policy byte-for-byte. It keeps
the achieved-course route command, response-conditioned steering release,
intercept-compatibility veto, traveling-bend carrier, and selective relief of
only outward carrier effort already unusable near the joint-speed and action
envelopes. This is an evidence-led reversion from the prefilled one-run LOS
guard and the assigned parent's falsified projected-miss translation; no new
terminal observation or scalar tuning is layered onto it.

Expected test: retain the coherent top-down and oblique traveling wake and
reproduce capture near `18.2--18.6T` without increasing the existing load or
actuator envelope. Falsify the selection if the exact candidate loses capture,
weakens the terminal carrier, changes far-field closure, materially raises
force or yaw-moment peaks, or establishes that its prior three captures were
not repeatable.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish turning by bounded curvature bias
source_mechanism: preserve a rhythmic posterior-lagged propulsive carrier while sensed target geometry supplies a bounded steering residual
transferable_invariant: route correction should modulate a continuing traveling bend without replacing interception geometry by a memorized route or suppressing propulsion
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact gait and vortex phases, duty ratios, and task-specific routes
policy_translation: retain the evaluated state-feedback carrier, body-frame achieved-course steering, intercept release veto, and sparse outward-carrier reserve; reject the failed projected-miss replacement rather than tune it
falsification: reject if exact replay loses capture, changes far-field closure, weakens wake coherence, increases loads, or no longer preserves a useful terminal traveling bend

## Non-CFD verification

- The materialized candidate SHA-256 is
  `567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`,
  byte-identical to all three sampled finite speed-reserve captures.
- The lightweight Julia contract check passes with a finite two-joint action,
  no `params.L`, and a parameter object covering all direct `params.FIELD`
  references. Julia was not on the default `PATH`; the same mandated command
  was run with the installed `julia`.
- The semantic guidance check and editable-boundary check pass. No CFD rollout
  was run in this worker.
