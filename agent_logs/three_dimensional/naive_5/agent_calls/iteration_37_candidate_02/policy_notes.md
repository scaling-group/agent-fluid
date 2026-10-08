# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and an
  inertial moving window. All terminate in capture. The combined sheets for
  the highest-score force-qualified sample (`solver_64a9b2cc44b2`) and the
  assigned phase-rejected parent (`solver_2515fae158ed`) were inspected from
  release through capture in both the top-down vorticity/body row and the
  oblique body/Lambda2 row. Both fish visibly self-propel from rest, shed an
  orderly alternating wake with compact three-dimensional structures, and
  reach the target through the same shallow late hook. Neither sheet shows
  passive advection, boundary interaction, wake breakup, thrust collapse,
  numerical instability, or moving-window-induced body rotation. With no
  sampled termination failure, the parent's weaker middle response is the
  informative finite failure.
- The assigned parent captures at `0.748269L` and `25.9105T`, with mean
  distance `2.497000L`. Its intended phase-rejected posterior reaction does
  not improve the full-beat response inherited in the logs: over `18--24T`,
  mean normalized target-course error is `0.5518` versus `0.5520` for the
  prior sideslip parent, and mean projected miss is slightly worse at
  `1.7971L` versus `1.7967L`. The four current samples remain identical at
  `8T` and `16T` and retain one visual route family, so the parent's favorable
  crossing depth is a finite tie-break rather than validated course recovery.
- Replacing that posterior command with a yaw-moment-qualified same-sign
  residual captures at `25.8885T`; combining the posterior and moment
  residuals reaches `25.8280T`; the force-qualified branch is fastest and has
  the best score at `25.8115T`, mean distance `2.496011L`, and score
  `-0.594050`. At `24T`, the parent/combined/force distances are
  `1.7177/1.7076/1.6940L`. These are bounded improvements, but all remain the
  same shallow-hook capture class rather than a new useful trajectory.
- Every sampled branch retains common peak joint angle, speed, and command of
  about `0.76352 rad`, `4.51496 rad/T`, and `29.65805 rad/T^2`, with no angle,
  rate, or applied-command contacts. Peak planar force and yaw moment stay in
  the narrow `0.01891--0.01910` and `0.01009--0.01014` bands. The carrier,
  coupled governor, and viability guards therefore need no scalar retune.
- Across each `18--24T` trace, velocity-normal force and yaw moment are about
  `-0.993` correlated and identify the same adverse response phase on roughly
  `56%` of rows. They are not independent reasons to stack steering. Normal
  force is retained as the more direct observation of translational-course
  response, while the parent's phase-rejected course error remains the
  evidenced persistent geometric qualifier.

## Policy hypothesis

Preserve the assigned traveling bend, course/miss-triggered response-released
redirect, line-of-sight response, upstream vectoring, capture modulation,
coupled acceleration projection, and angle/rate viability guards. Remove only
the falsified direct posterior reaction half-cycle. In the existing closing
`1.75--4.5L` middle corridor, use phase-rejected normalized target-course error
to establish a persistent route-owned deficit and measured velocity-normal
force to select only a hydrodynamic half-cycle that is rotating translation
away from that route. Apply one small same-sign two-joint curvature residual;
helpful force, disagreed geometry, weak translation, far travel, active
redirect, and the capture corridor pass through continuously. Yaw moment is
not added because the current evidence shows it is redundant with force.

The falsifiable expectation is lower full-beat target-course error and
projected miss over `20--24T`, arrival no later than the `25.8115T`
force-qualified comparison, and visible route separation before the common
late hook while retaining capture, coherent two-view wake, zero actuator
contacts, and the sampled `0.0191/0.0102` planar-force/yaw-moment regime.
Reject the mechanism if persistent qualification removes the force branch's
finite gain, if the result remains in the same milliscale shallow-hook cluster,
or if wake, load, or actuator viability degrades.

bookshelf_consulted: true
source_domain: adaptive wake-response control and sensor-modulated robotic-fish rhythmic steering
source_mechanism: separate persistent geometric route error from fast alternating hydrodynamic response and modulate only the adverse half-cycle
transferable_invariant: body-frame target geometry owns turn direction while one normalized load observation may qualify a bounded state-feedback residual without cancelling helpful wake motion
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, clock phase, exact vortex phase, source wake layout, and prescribed routes
policy_translation: phase-rejected normalized velocity-to-target course error supplies the slow engagement gate; velocity-normal body-frame force selects the adverse response phase; a bounded same-sign two-joint residual leaves the traveling carrier and safety projections intact
falsification: reject on unchanged full-beat course error or projected miss, lost or slower capture, route-side reversal, incoherent wake, actuator contact, or peak force and moment above the sampled regime

## Non-CFD audit after the policy edit

- Re-evaluating the assigned parent and candidate on all `4,711`
  reconstructed parent-trace observations changes `1,135` post-guard command
  pairs, including `465` by more than `0.05 rad/T^2`; maximum separation is
  `0.73823 rad/T^2`. Activation is confined to `18.876--25.119T` and
  `4.499--1.102L`, while the candidate's frozen-state peak remains the
  parent's `29.65805 rad/T^2`. This establishes a material bounded mechanism
  test, not CFD evidence of improvement.
- The returned parameter object owns all direct references and contains `62`
  fields. The prescribed public-contract state returns two finite commands.
  A deterministic `18,225`-state grid spanning lateral reflections, distance,
  course, closing response, force, and beyond-limit joint states remained
  finite and within the `30 rad/T^2` envelope. All reflected parent-trace pairs
  had zero numerical command error.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Its three exact prescribed commands
  were run directly: the material-guidance check, Julia public-contract check,
  and solver editable-boundary check all pass. No formal CFD was run.
