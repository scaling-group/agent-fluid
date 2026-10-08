# Closing-stride posterior positive-work governor

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned-parent optimizer
  notes and completed v36/v37 rollouts, all four sampled scores, observations,
  diagnostics, and trajectories, and the assigned-parent/v31 policy delta. I
  inspected the combined keyframe sheets for sampled v31, the informative v26
  regression, and inherited v37. Every evaluated rollout is a finite capture
  from direct uniform still water with `U_infinity=(0,0,0)`, no prewarm, no
  cylinders, and no boundary or numerical termination.
- In both the top-down mid-plane vorticity row and the oblique Lambda2 row,
  sampled v31, the informative v26 regression, and inherited v37 self-propel
  from rest, turn toward the target, and retain the same coherent alternating
  traveling wake with compact three-dimensional posterior structures through
  capture. There is no passive advection, standing reciprocal wiggle, wake
  breakup, boundary interaction, or out-of-plane instability. The remaining
  mismatch is terminal carrier energy and actuator work, not route polarity or
  propulsion formation.
- Sampled v31 is the scalar leader at `18.0125T`, score/mean distance
  `-0.064000/1.950346L`, observed distance integral `1.336756L`, center
  path/head cross-track `13.2149L/0.7327L`, and final
  alignment/yaw/speed `0.1297/0.8077 rad/T/0.8806U`. Its near anterior/posterior
  acceleration-ceiling residence is `69.29/75.89%`, so it reaches the target
  quickly but carries a fast, heavily driven posterior cycle across it.
- Sampled v26 confirms that another half-cycle duty edit is not the answer: it
  preserves the wake and improves final alignment/yaw and posterior residence
  to `0.1728/0.6545 rad/T/74.11%`, but regresses score/mean distance to
  `-0.064149/1.950469L`. The assigned parent also records regressions from
  bearing-rate, actuator-headroom, shared yaw-rate, mean-share, phase-reset,
  and persistent posterior-relief variants.
- The inherited v36 common-cadence governor improved the crossing state but
  delayed capture to `18.0290T`, worsened score/mean distance to
  `-0.065162/1.951313L`, and widened the path. The inherited v37 common
  amplitude envelope kept the v31 arrival and shortened path/cross-track
  slightly to `13.2127L/0.7321L`; final alignment/yaw/speed improved to
  `0.1536/0.6775 rad/T/0.8743U`. That result did not improve the full evidence:
  score/mean distance regressed to `-0.064492/1.950743L`, observed distance
  integral to `1.336759L`, and near acceleration-ceiling residence increased
  on both joints to `69.80/76.14%`. Thus the normalized closing-stride event is
  reachable, reflection-invariant, and terminally relevant, but changing the
  whole carrier frequency or amplitude perturbs useful work and does not
  relieve the posterior bottleneck.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd body-frame route controller,
state-feedback cadence and amplitude, posterior lag and emphasis,
phase-consistent reserve, v20 approach envelope, conserved mean-bend
allocation, course-consensus duty surface, half-cycle steering, and
reversal-preserving rate governor. Reuse only the inherited dimensionless
closing-stride event. While a moving, misaligned approach would traverse a
large fraction of the remaining range in one nominal beat, continuously
withdraw only the positive-work part of the posterior drive acceleration
(`tail_drive_accel * phi_dot[2] > 0`). Leave negative-work braking and reversal,
the anterior oscillator, explicit tail steering, cadence, amplitude, mean
curvature, posterior/anterior ratio, and lag unchanged.

This is a joint-specific mechanical-work governor rather than a scalar gain
tune: the same target-relative event that diagnosed excess closing stride now
selects which actuator and which sign of power may be relieved. It is exactly
inactive outside `2.10L`, while receding or at rest, and in the aligned capture
corridor. Distance, closing stride, course alignment, and power sign are
unchanged by lateral reflection, while posterior state and acceleration both
reverse.

Expected evidence is v31-identical far/middle output and wake, retained capture
and observed-closure class, lower posterior acceleration-ceiling residence,
and a lower-speed, lower-yaw crossing without the common cadence/amplitude
variants' path or load regression. Falsify if any pre-approach or anterior
output changes; explicit steering or braking is withdrawn; capture is lost;
arrival, observed distance integral, path, or cross-track regresses materially;
posterior ceiling residence fails to fall or pressure migrates anteriorly;
terminal alignment/yaw/speed do not improve together; reflection fails; or
either coherent wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: Lighthill reactive-propulsion theory and sensor-modulated robotic-fish CPG control
source_mechanism: posterior kinematics supply much of the reactive thrust, while feedback can regulate rhythmic energy without replacing the coupled traveling pattern
transferable_invariant: preserve the observed traveling-wave phase and steering geometry, but reduce excess target-closing energy at the posterior work-producing channel while retaining negative-work braking
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics and amplitude envelopes, exact vortex phases, linkage geometry, target coordinates, capture radius, and task-specific routes
policy_translation: use normalized closing speed times nominal period divided by remaining distance to gate only posterior drive acceleration whose product with posterior joint rate is positive; keep cadence, amplitude, lag, mean bend, anterior actuation, explicit steering, and reversal authority unchanged
falsification: reject if transit changes, capture or observed closure regresses materially, posterior limit residence does not fall without anterior migration, terminal alignment/yaw/speed do not improve together, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  commands separately gives PASS for guidance materiality and PASS for the
  solver boundary after removing one duplicated copied-parent marker from the
  rendered workspace `README.md`.
- Julia is not installed, so the executable include/action probe cannot run.
  No CFD was attempted. Deterministic static checks find one definition of
  each public function, cover all `69` direct `params.FIELD` references with
  the `71` fields returned by `target_policy_params`, confirm balanced
  delimiters and a nonempty candidate, and find no explicit elapsed time, step
  count, random input, file I/O, cylinder observation, target coordinate, or
  memorized-route input.
- Replaying the eight-sample closing-stride selector on the evaluated v31
  trajectory gives exact zero authority outside `2.10L`, while receding or at
  rest, and at full capture alignment. It is active on `269/3275` total samples
  and selects `136` positive-work posterior samples; their mean/minimum retained
  drive scale is `0.8592/0.6838`. Across sampled v20/v26 and inherited v36/v37,
  selector activity remains `8.19%--8.36%` of the full rollout with no gating
  violations. These are reachability, sign, and contract checks on completed
  traces, not claims about the pending CFD response.
