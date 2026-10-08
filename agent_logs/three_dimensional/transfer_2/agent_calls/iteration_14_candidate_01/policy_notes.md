# Predictive-stroke load shaping with feasible public actions

## Visual diagnosis before the policy edit

- All four current solver examples are finite captures under direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and active moving-window transport. Three are byte-identical v27
  course-preview policies and reproduce capture at `24.5795T`, minimum/final
  distance `0.74697L`, and mean distance `2.36044L`; they are one replicated
  mechanism, not three independent architectures. The fourth is the v31
  predictive-stroke guard and captures at `24.5960T`, `0.74858L`, with mean
  distance `2.36174L`.
- The combined top-down/oblique sheets were inspected for the replicated v27
  capture, sampled v31 predictive guard, and assigned-parent v30 bounded
  stroke-aware capture. In top view all three self-propel down the established
  diagonal, shed a coherent alternating wake, bend before passage, and enter
  the target from the same side near `24.6T`. The oblique Lambda2 row retains
  compact three-dimensional structures through redirect and capture. There is
  no visible passive-advection, wake-breakup, or instability explanation for
  their small metric differences. No terminating failure sheet is present in
  this workspace's sampled solver set; the inherited parent notes supply the
  available negative boundary, a terminal-priority controller that kept a
  coherent wake but missed at `1.092L` and exited left.
- The intended stopping-stroke benefit of v31 does not survive direct
  comparison with the assigned parent's evaluated v30 static stroke guard:
  tail hard-limit occupancy is `12.63%` versus `12.60%`, and joint-rate-limit
  exposure is `15.14%` versus `15.10%`. It should not be described as a stroke
  or rate cure. A different positive effect does survive: v31 preserves
  capture and slightly improves arrival/mean distance while lowering peak
  absolute body-frame force coefficients and yaw-moment coefficient to
  `0.149/0.097/0.067`, from v30's `0.165/0.118/0.089` and replicated v27's
  `0.269/0.178/0.143`.
- V31 still exposes infeasible public commands: `72.74%` of trace samples have
  at least one raw acceleration above `1800 deg/T^2`, with the same
  `74.01/112.97 rad/T^2` joint peaks as v27. The assigned parent establishes
  that final independent projection onto the owned symmetric envelope is
  dynamically transparent under the evaluator's identical downstream
  clipping: v30 has zero raw exceedance and exactly reproduces its unprojected
  stroke-aware trajectory and loads.

## Policy hypothesis

Use the sampled v31 predictive-stroke policy without retuning its guard, route,
carrier, or steering terms, and add only the assigned parent's final symmetric
projection after full two-joint allocation. This small compatible combination
should preserve v31's captured trajectory and lower-load class because the
downstream actuator already performs the same independent clipping, while
making every returned public action realizable. The predictive term is treated
as an evidence-backed load shaper, not as a joint-boundary cure.

Falsification: reject the candidate if it loses capture, materially changes
the v31 `24.5960T` approach or `0.149/0.097/0.067` load class, retains any
returned acceleration outside `+/-31.41593 rad/T^2`, or is later shown to
increase tail hard-limit/rate exposure materially. Do not claim additional
stroke or rate improvement unless a completed rollout beats the established
`12.60%/15.10%` boundary.

## Bookshelf transfer

The fish-control bookshelf was consulted after current metrics and both visual
views. Its sensor-modulated rhythmic-control and posterior reactive-propulsion
guardrails support retaining the validated traveling bend while using
proprioception to modulate posterior allocation within a finite actuator
envelope. The current rollout, not source gains, supports the edit.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive propulsion
source_mechanism: preserve a traveling propulsive rhythm while proprioceptive feedback anticipates finite posterior stroke and bounded allocation exposes only feasible actuator effort
transferable_invariant: retain the state-feedback traveling wave and target steering while modulating posterior authority from observed joint state and returning only a feasible composite command
nontransferable_details: published gains, dimensional cadence, motor curves, species-specific kinematics, full-body envelopes, exact vortex phases, and task-specific routes
policy_translation: keep the sampled mirror-equivariant stopping-stroke gate unchanged and independently project both fully allocated joint accelerations onto the owned symmetric envelope
falsification: reject if capture or the sampled lower-load trajectory changes, posterior limit exposure worsens materially, or any returned acceleration exceeds the owned envelope

## Pre-evaluation validation

- The final candidate SHA-256 is
  `f2e3b5d58433d0787a18c622a8ec7a15bbfe34a4924a46162a742d6b0fee7424`.
  Its functional difference from sampled v31 is only the final independent
  symmetric acceleration projection. On a `3645`-state grid spanning range,
  target side, body-frame slip, both joint positions, and both joint rates,
  every candidate action exactly equals the sampled action after the
  evaluator's downstream clipping operation.
- All `82` unique direct `params.FIELD` references resolve among the `84`
  fields returned by `target_policy_params()`. A separate `3645`-state smoke
  grid returns two finite in-envelope accelerations throughout, and direct
  mirrored probes confirm reflection equivariance of the added predictive
  posterior gate.
- The durable-guidance semantic check, Julia public-contract smoke check, and
  solver editable-boundary check pass. The required configured check-runner
  was invoked but could not start because its pinned `gpt-5.4-mini` model is
  unsupported on this account; its three exact no-CFD checks were therefore
  run directly and separately. No formal CFD was run.
