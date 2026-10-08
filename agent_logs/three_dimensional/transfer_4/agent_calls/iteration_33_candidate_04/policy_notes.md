# Response-triggered longitudinal mean-bend allocation

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled solver scores,
  observations, metrics, diagnostics, trajectories, and policies, plus the
  assigned-parent optimizer notes and the completed v19, v24, v25, v26, v32,
  and v33 inherited evaluations. Every current sample is a finite capture from
  direct uniform still water with `U_infinity=(0,0,0)`, no prewarm, no
  cylinders, and no boundary or numerical termination.
- I inspected the combined keyframe sheets for the sampled v31 scalar leader
  and the v26 slip-synchronous mechanism regression, including the top-down
  mid-plane vorticity row and the oblique Lambda2 row from release through
  capture. Both visibly self-propel from rest, form the same coherent
  alternating reverse wake and compact three-dimensional posterior structures,
  and turn toward the target. Neither shows passive advection, a reciprocal
  standing wiggle, wake breakup, boundary interaction, or out-of-plane
  instability. Their useful difference is terminal allocation, not propulsion
  creation or wake topology.
- The current v31 duty-ratio policy has the best sampled score/mean distance at
  `-0.064000/1.950346L`, but its `1.336756L` observed distance integral is not
  better than v20's `1.336706L`; part of the scalar edge comes from the
  discrete terminal hold after a slightly deeper capture crossing. It captures
  at `18.0125T` with center path/head cross-track `13.2149L/0.7327L`, final
  alignment `0.1297`, absolute yaw `0.8077 rad/T`, and near posterior
  acceleration-ceiling residence `75.89%`. Therefore the tiny scalar lead is
  not evidence that course-consensus duty alone solved the approach.
- The sampled v26 one-sided slip feather preserves the same two-view wake and
  improves final alignment/yaw to `0.1728/0.6545 rad/T`, path/cross-track to
  `13.2064L/0.7265L`, and near posterior ceiling residence to `74.11%`, but
  regresses score/mean distance to `-0.064149/1.950469L`. The inherited v32
  balanced slip duty and v33 phase reset also retain capture yet worsen score
  to `-0.064451` and `-0.064554`, widen path to `13.2302L` and `13.2163L`,
  and increase near posterior ceiling residence to `75.25%` and `74.94%`.
  This falsifies another slip-duty gain, balanced-factor tune, or posterior
  phase-reset placement.
- The completed v19 conserved forward allocation is the clean positive bound.
  Moving at most `35%` of the existing signed mean tangent to the anterior
  carrier during only a moving, misaligned approach preserves capture and wake
  coherence, gives the best inherited final alignment/yaw
  (`0.1957/0.2875 rad/T`), narrows cross-track to `0.7207L`, and reduces near
  posterior ceiling residence to `71.97%`; its `-0.064778` score shows that it
  is terminal damping rather than a closure mechanism. The current v25
  force-power-qualified version tightens path/cross-track to
  `13.1972L/0.7189L` but loses that terminal benefit
  (`0.1036/1.1215 rad/T`), so sparse phase-free load selection is not a safe
  replacement for the base conserved allocation.

## Single policy hypothesis

Start from the evaluated v31 odd body-frame route controller, state-feedback
anterior oscillator, posterior lag and emphasis, course-consensus duty ratio,
phase-consistent reserve, v19 conserved base mean-bend allocation, half-cycle
steering, and reversal-preserving rate governor. Add only a response-triggered
extension to the longitudinal allocation. During the established moving,
misaligned approach, when signed body-frame bearing and its co-windowed rate
show that the target is sweeping toward the centerline, transfer one additional
bounded share of the already requested mean tangent to the anterior carrier
and subtract exactly the same share from the posterior mean target. The added
share grows smoothly with normalized bearing-centering rate and proximity to
the centerline; it does not alter the total signed tangent, posterior wave,
cadence, or lag.

This translates the nonsteady redirect invariant "response appears -> change
actuator role" into continuous state feedback: posterior motion remains the
propulsive traveling wave while more of the existing steering bend moves
anteriorly only during an observed target-centering response. The new path is
exactly inactive outside `2.10L`, when the target is sweeping away, at zero
bearing rate, or at zero approach speed. Simultaneous lateral reflection
reverses bearing, bearing rate, turn request, joint state, and both allocated
means while preserving the allocation magnitudes.

Expected evidence is v31-identical far/middle action and coherent two-view
wake, retained capture and distance-integral class, with v19-directed
reductions in path, terminal yaw, cross-track, and posterior ceiling residence.
Falsify the mechanism if pre-approach outputs change; total mean tangent is not
conserved; capture or observed distance integral regresses materially; the
extra share is active while the bearing moves away from center; terminal
alignment, yaw, path, and non-migrating limit residence fail to improve
together; reflection fails; or either coherent wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and nonsteady fish or robotic-fish redirect control
source_mechanism: retain a posterior traveling propulsive wave while changing steering allocation after observed directional response appears
transferable_invariant: preserve cadence, posterior lag, and total signed mean bend while moving a bounded share of steering authority anteriorly only during an observed target-centering response
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body C-start kinematics, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: use normalized body-frame bearing and co-windowed bearing rate to gate an extra approach-only anterior share, subtract the same share from the posterior mean target, and leave the posterior oscillatory wave and total odd curvature unchanged
falsification: reject if transit changes, total mean tangent is not conserved, capture or distance integral worsens materially, terminal path/alignment/yaw and non-migrating actuator residence do not improve together, the gate activates for target-diverging motion, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated checker was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account. Running its immutable checks directly,
  the guidance-materiality check initially found two identical assigned-parent
  markers in the rendered workspace `README.md`. Removing only the duplicate
  made the parent unambiguous; the guidance check then passed. The solver
  boundary check also passed and confirms that `candidate_target_policy.jl` is
  the only solver change.
- Julia is not installed, so the executable include/action probe cannot run.
  No CFD was attempted. Deterministic static checks find one definition of
  each public function, cover all `68` direct `params.FIELD` references with
  the `70` unique fields returned by `target_policy_params`, confirm balanced
  delimiters and a nonempty candidate, and find no explicit clock, elapsed
  time, step count, randomness, file I/O, cylinder coordinate, target
  coordinate, or memorized route input.
- Offline replay of only the new response selector on the evaluated v31 trace
  leaves every sample at or beyond `2.10L` at exactly zero added authority.
  It activates on `220/394` approach samples (`55.84%`), with mean/maximum
  authority `0.09504/0.43643`; the resulting extra anterior share has
  mean/maximum `0.01901/0.08729`. Algebraically, anterior plus posterior mean
  tangent remains the original odd request for every authority, the share is
  bounded, and simultaneous lateral reflection preserves both allocation
  magnitudes while reversing both allocated means. These are contract and
  activation checks on a completed trace, not a claim about the pending CFD
  outcome.
