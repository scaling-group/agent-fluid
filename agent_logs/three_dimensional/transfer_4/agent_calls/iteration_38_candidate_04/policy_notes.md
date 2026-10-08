# Evidence-selected v31 exploitation candidate

## Visual and quantitative diagnosis before policy selection

- I read the workspace and guidance contracts, the assigned-parent candidate,
  completed score and inherited optimization note, all four sampled policies,
  scores, observations, diagnostics, trajectories, and combined keyframe
  sheets. Every rollout considered here is a finite capture from direct
  uniform still water with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and
  no boundary or numerical termination.
- I inspected both the top-down mid-plane vorticity row and oblique Lambda2 row
  from release through capture for the sampled v31 leader, the distinct v20
  comparator, and the assigned closing-stride anterior-envelope result. All
  three visibly self-propel from rest, turn toward the target, retain a
  coherent alternating reverse wake and compact three-dimensional posterior
  structures, and show no passive advection, standing reciprocal wiggle, wake
  breakup, boundary interaction, or out-of-plane instability. Their useful
  difference is terminal allocation and closure, not propulsion creation.
- Three sampled policies and trajectories are byte-identical v31 reruns at
  `18.0125T`, score/mean distance `-0.0640004/1.950346L`, observed distance
  integral `1.336756L`, and final distance `0.748395L`. The distinct v20
  comparator arrives `0.0055T` earlier and has a slightly better observed
  distance integral (`1.336706L`), but its score/mean distance/final crossing
  are worse at `-0.0640276/1.950358L/0.748419L`. Thus v31 is the sampled
  scalar leader, though the margin is too small to claim solved terminal
  control.
- The assigned parent tested an approach-only closing-stride selector that
  lowered only the anterior speed-increasing rate-governor onset while leaving
  posterior propulsion, cadence, lag, and mean bend unchanged. It retained
  capture and the same two-view wake, and improved the discrete final
  alignment/absolute yaw from v31's `0.1297/0.8077 rad/T` to
  `0.1957/0.3716 rad/T`. Those improvements were not sustained through the
  approach: capture slipped to `18.0180T`, score/mean distance regressed to
  `-0.0650022/1.951162L`, observed distance integral worsened to `1.336802L`,
  center path stayed essentially unchanged (`13.2149L` to `13.2147L`), and
  mean near-course alignment fell from `0.6688` to `0.6681`. Near posterior
  acceleration-ceiling residence changed only from `75.89%` to `75.70%`.
- The immediately preceding whole-carrier energy-envelope test also retained
  capture but regressed to `-0.0648860/1.951060L`. Together these completed
  outcomes reject another scalar amplitude, cadence, energy-target, or
  rate-onset relief as the next candidate. A better final sample alone is not
  evidence of terminal damping when approach-average closure and score worsen.

## Single policy hypothesis

Materialize the prefilled, evaluated
`dogfish_3d_course_consensus_posterior_duty_ratio_v31` policy unchanged as the
one candidate. It preserves the only sampled score/mean-distance leader, its
odd normalized body-frame route map, state-feedback anterior oscillator,
posterior lag and emphasis, phase-consistent work reserve, approach posterior
envelope, conserved mean-bend allocation, bounded course-consensus duty ratio,
half-cycle steering, and reversal-preserving rate governor.

This is evidence-led exploitation after two distinct terminal energy-relief
mechanisms failed, not a claim that repeated evaluation is a new mechanism.
The immediate falsification is deterministic reproduction of the sampled v31
capture and metric class. Later work should leave this baseline only for a
non-scalar, work-conserving actuator-allocation mechanism with independently
reachable authority, and should reject it unless capture, observed closure,
path, approach-average alignment/yaw, and non-migrating limit residence improve
together.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish rhythmic control
source_mechanism: preserve posterior-emphasized traveling-wave propulsion and change actuator role rather than repeatedly reducing the shared rhythmic drive
transferable_invariant: retain state-derived cadence, posterior lag, bounded body-frame steering, and posterior propulsion when terminal excess motion is not improved by scalar drive relief
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: no new bookshelf primitive is adopted; retain evaluated v31 because completed whole-carrier and anterior-only relief both worsened closure, while any future departure must conserve useful posterior traveling-wave work and alter allocation rather than another scalar envelope
falsification: reject the exploitation baseline if it fails to reproduce the sampled capture class; reject a later allocation transfer if transit changes or if capture, closure, path, approach-average alignment and yaw, wake coherence, and non-migrating joint-limit residence do not improve together
```

## Lightweight validation

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  commands directly gives PASS for guidance materiality and the solver
  boundary after removing only the duplicated assigned-parent listing from
  the rendered workspace `README.md`.
- Julia is not installed, so the executable include/action probe cannot run.
  Deterministic static checks find exactly one nonempty candidate, one
  definition of each public function, and all `66` direct `params.FIELD`
  references among the `68` fields returned by `target_policy_params`. They
  find no explicit clock, elapsed time, step count, randomness, file I/O,
  cylinder input, fixed target coordinate, or memorized route.
- The final candidate SHA-256 is
  `8b35036121fc14a9221cc081f234535a877aad2b6c1b0364a94ab7a5ac582a6e`,
  exactly matching all three evaluated v31 sampled captures. No CFD was run.
