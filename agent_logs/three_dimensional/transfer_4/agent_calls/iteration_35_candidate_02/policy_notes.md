# Closing-stride cadence governor

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled scores,
  observations, metrics, diagnostics, trajectories, and policies, and the
  assigned-parent optimizer notes and completed v34/v35 evaluations. Every
  examined rollout is a finite capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and no boundary or numerical
  termination.
- I inspected the combined keyframe sheets for the sampled v31 scalar leader,
  the informative v26 regression, the prefilled v25 policy, and the inherited
  v34/v35 policies, including the top-down mid-plane vorticity and oblique
  Lambda2 rows from release through capture. All visibly self-propel from
  rest, turn toward the target, shed a coherent alternating reverse wake, and
  retain compact three-dimensional posterior structures. None shows passive
  advection, a standing reciprocal wiggle, wake breakup, boundary interaction,
  or out-of-plane instability. The unresolved difference is terminal control,
  not propulsion creation or wake topology.
- V31 is the sampled scalar leader at score/mean distance
  `-0.064000/1.950346L`, but its observed distance integral `1.336756L` is
  worse than v20's `1.336706L` and the prefilled v25 policy's `1.336693L`.
  It captures at `18.0125T` with final alignment only `0.1297`, absolute yaw
  `0.8077 rad/T`, target-normal speed `0.8732U`, and near posterior
  acceleration-ceiling residence `75.89%`. The sheets and trajectory therefore
  show a productive transit carrier crossing the target quickly but obliquely,
  not a route or wake failure.
- V26's one-sided slip feathering preserves the same two-view wake and improves
  final alignment/yaw and posterior residence to
  `0.1728/0.6545 rad/T/74.11%`, yet regresses score/mean distance to
  `-0.064149/1.950469L`. The completed v19 conserved mean-bend allocation has
  the best inherited final alignment/yaw (`0.1957/0.2875 rad/T`) but scores
  `-0.064778`. These are useful terminal bounds, not evidence for another
  posterior-wave or mean-share tune.
- The assigned parent tested the remaining allocation suggestions. A bounded
  extra mean-bend share selected by short-window bearing-centering retained the
  v31 wake and `18.0125T` capture but regressed score/mean distance to
  `-0.064408/1.950675L` and left path, final alignment/yaw, and near posterior
  ceiling residence essentially at v31. Reallocating only load-increasing
  tail steering into measured anterior headroom also retained capture but
  scored `-0.064495/1.950735L`; its observed distance integral
  `1.336717L` and final state remained in the same class. Thus another
  mean-bend share, bearing-rate selector, direct-steering allocator, or
  actuator-headroom threshold is not supported.
- The remaining phase-invariant mismatch is stride scale. On the evaluated
  v31 approach the body speed stays narrowly around `0.89U`, while course
  alignment ranges down to `-0.166` and ends at `0.130`. The anterior
  angle/rate explain about `99%` of raw yaw variance in inherited traces, so a
  bounded change to the common carrier timescale can test terminal yaw without
  adding another phase-contaminated yaw command. The dimensionless nominal
  closing stride `drive_period * max(window_closing_speed_L,0) / distance_L`
  uses only target-relative progress; it estimates the fraction of remaining
  range traversed in one beat and requires neither a capture-radius constant
  nor a world-frame route.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd body-frame route controller,
state-feedback oscillator, posterior lag and emphasis, phase-consistent
reserve, v20 approach envelope, conserved v19 mean-bend allocation,
course-consensus duty surface, half-cycle steering, and reversal-preserving
rate governor. Add only a closing-stride cadence governor. During the already
defined moving, misaligned approach, compute the fraction of remaining target
range closed per nominal beat from windowed closing speed and distance. As
that phase-invariant fraction enters a bounded terminal band, reduce the
common carrier cadence continuously toward a conservative floor. Release the
governor if closure stops or velocity becomes target-aligned.

This changes neither the odd turn request, mean-bend allocation, posterior
wave gain, nor the state-derived phase relation. It is exactly inactive at and
beyond `2.10L`, at zero approach speed, or in the established aligned capture
corridor. Simultaneous lateral reflection preserves distance, closing speed,
alignment, and governor magnitude while reflecting both joint states and
commands.

Expected evidence is v31-identical far/middle output and coherent two-view
wake, retained capture and observed-distance-integral class, with lower
terminal joint-rate/yaw and posterior ceiling residence. Falsify if any
pre-approach output changes; capture is lost; arrival or observed closure
regresses materially; cadence relief is active while receding or aligned;
terminal yaw, alignment, and non-migrating limit residence fail to improve
together; reflection fails; or either coherent wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and fish gait speed scaling
source_mechanism: retain a coupled traveling rhythm while sensory progress feedback modulates its common cadence for terminal approach
transferable_invariant: preserve state-derived phase and posterior lag, but reduce common cadence continuously when one nominal beat would traverse a large fraction of the remaining range while the course is still misaligned
nontransferable_details: published gains, dimensional frequencies, species-specific speed-frequency curves, linkage geometry, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: normalize windowed target-closing speed by remaining distance and nominal drive period, smooth-gate a bounded common cadence scale only inside the moving misaligned approach, and leave steering, mean bend, posterior lag, and wave gain unchanged
falsification: reject if transit changes, capture or observed closure regresses materially, the governor activates while receding or aligned, terminal alignment/yaw and non-migrating actuator residence do not improve together, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  checks directly initially exposed two identical assigned-parent markers in
  the rendered workspace `README.md`; removing only the duplicate made the
  parent unambiguous. The guidance-materiality check then passed, and the
  solver-boundary check passed with `candidate_target_policy.jl` as the only
  solver change.
- Julia is not installed, so the executable include/action probe cannot run.
  No CFD was attempted. Deterministic static checks find one definition of
  each public function, cover all `69` direct `params.FIELD` references with
  the `71` unique fields returned by `target_policy_params`, confirm balanced
  delimiters and a nonempty candidate, and find no explicit elapsed time, step
  count, randomness, file I/O, cylinder coordinate, target coordinate, or
  memorized-route input.
- Offline replay of only the new selector on the evaluated v31 trace gives
  exactly zero authority on every sample at or beyond `2.10L`. It is positive
  on `68.27%` of approach samples, with mean/maximum authority
  `0.1971/0.6316`; the resulting cadence multiplier has mean/minimum
  `0.9724/0.9116`. Across the other three sampled policies and inherited
  v34/v35 traces, activity remains `68.19%--70.23%`, mean authority
  `0.1951--0.1976`, and minimum cadence multiplier `0.9113--0.9167`. Focused
  algebraic cases give exact inactivity outside the approach, while receding,
  at rest, and at full capture alignment; lateral reflection preserves the
  selector. These are reachability and contract checks on completed traces,
  not claims about the pending CFD response.
