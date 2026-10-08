# Closing-stride carrier-energy envelope

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned-parent optimizer
  notes and completed rollout, and all four sampled scores, observations,
  metrics, diagnostics, trajectories, and policies. Every evaluated case is a
  finite capture from direct uniform still water with `U_infinity=(0,0,0)`, no
  prewarm, no cylinders, and no boundary or numerical failure. Three sampled
  policies are exact v31 reruns; the fourth is the v26 one-sided slip-feathering
  variant, so repeated v31 outcomes are determinism evidence rather than three
  controller mechanisms.
- I inspected the combined keyframe sheets for sampled v31, the informative
  v26 regression, and the assigned-parent v36 cadence governor from release
  through capture. In both the top-down mid-plane vorticity row and the oblique
  Lambda2 row, all fish self-propel from rest, turn toward the target, maintain
  a coherent alternating traveling wake, and retain compact three-dimensional
  posterior structures. There is no passive advection, standing reciprocal
  wiggle, wake breakup, boundary interaction, or out-of-plane instability.
  The remaining limitation is terminal carrier state, not propulsion creation
  or route-sign failure.
- Sampled v31 is the scalar leader at `18.0125T`, score/mean distance
  `-0.064000/1.950346L`, observed distance integral `1.336756L`, center path
  `13.2149L`, and head cross-track `0.7327L`. It crosses quickly but obliquely:
  final course alignment is `0.1297`, absolute yaw is `0.8077 rad/T`, speed is
  `0.8806U`, and near posterior acceleration-ceiling residence is `75.89%`.
- Sampled v26 retains the same wake and arrival but trades a small score/mean-
  distance regression (`-0.064149/1.950469L`) for better final alignment/yaw
  (`0.1728/0.6545 rad/T`) and lower near posterior ceiling residence (`74.11%`).
  Inherited evidence already rules out another slip-duty, phase-reset,
  posterior-hold, mean-share, bearing-rate, headroom, or yaw-rate variant.
- The assigned parent tested the requested distinct progress-selected carrier
  mechanism by reducing common cadence when normalized closing stride was high.
  V36 retained capture and the coherent two-view wake, reduced final absolute
  yaw from `0.8077` to `0.5049 rad/T`, raised final alignment to `0.1614`, and
  lowered near posterior ceiling residence to `74.31%`. Those crossing-phase
  improvements did not survive the full trajectory evidence: capture slipped
  to `18.0290T`, score/mean distance to `-0.065162/1.951313L`, observed distance
  integral to `1.336912L`, center path to `13.2244L`, head cross-track to
  `0.7336L`, and mean near alignment to `0.6656` from `0.6688`. Therefore the
  closing-stride selector is observable and useful, but common frequency is the
  wrong actuation channel for this already productive approach.

## Single policy hypothesis

Start from evaluated v31. Preserve its odd body-frame route controller,
state-feedback cadence, posterior lag and emphasis, phase-consistent reserve,
approach posterior relief, conserved mean-bend allocation, course-consensus
duty surface, half-cycle steering, and reversal-preserving rate governor. Reuse
only v36's dimensionless closing-stride event, but translate it into a new
state-feedback energy-envelope mechanism: while the approach is moving,
misaligned, and closing a large fraction of remaining range per nominal beat,
continuously reduce the common carrier amplitude used by the anterior
phase-plane oscillator and lagged posterior target while leaving `omega`
unchanged. This asks the oscillator to dissipate excess terminal carrier energy
without changing beat timing, mean curvature, posterior/anterior amplitude
ratio, or phase lag.

The mechanism is exactly inactive outside `2.10L`, while receding or at rest,
and in the aligned capture corridor. Distance, closing speed, course alignment,
and the resulting envelope magnitude are invariant under lateral reflection;
the signed joint states, wave targets, and commands still reflect. Expected
evidence is v31-identical far/middle output and wake, retained capture and
observed-closure class, with lower terminal speed/yaw and non-migrating joint
limit residence without the cadence governor's path and arrival penalty.
Falsify if any pre-approach output changes; cadence changes; capture is lost;
arrival, observed distance integral, path, or cross-track regress materially;
the envelope activates while receding or aligned; terminal alignment, yaw,
speed, and limit residence do not improve together; reflection fails; or either
coherent wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological terminal-approach gait modulation
source_mechanism: preserve a coupled traveling rhythm while sensory progress feedback reduces its oscillation-energy envelope near a target
transferable_invariant: retain state-derived cadence, posterior lag, and signed mean curvature while continuously reducing carrier excursion when one nominal beat would close a large fraction of remaining range during a misaligned approach
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, linkage geometry, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: use normalized windowed target-closing speed times nominal period divided by remaining distance to lower the common state-feedback amplitude envelope only inside the moving misaligned approach, without changing omega, turn request, posterior lag, or mean-bend allocation
falsification: reject if transit or cadence changes, capture or observed closure regresses materially, the envelope activates while receding or aligned, terminal alignment/yaw/speed and non-migrating limit residence do not improve together, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  checks directly first exposed two identical copied-parent markers in the
  rendered workspace `README.md`; removing only the duplicate made the parent
  unambiguous. The guidance-materiality check then passed, and the solver
  boundary check passed with `candidate_target_policy.jl` as the only solver
  change.
- Julia is not installed, so the executable include/action probe cannot run.
  No CFD was attempted. Static checks find one definition of each public
  function, cover all `69` direct `params.FIELD` references with the `71`
  unique fields returned by `target_policy_params`, confirm balanced
  delimiters and a nonempty candidate, and find no explicit elapsed time, step
  count, randomness, file I/O, cylinder observation, fixed target coordinate,
  or memorized-route input.
- Offline replay of the new selector on the evaluated v31 trace gives exactly
  zero authority on every sample outside `2.10L`. It is positive on `68.27%`
  of approach samples, reaches `0.6316` authority, and schedules a minimum
  amplitude scale of `0.8863`. Across v26 and the evaluated v36 trace,
  approach activity remains `68.77%--69.29%` and minimum scheduled amplitude
  remains `0.8884--0.8898`. Focused algebraic cases give exact inactivity far
  from the target, while receding, at rest, and in the aligned corridor; the
  selector is unchanged by lateral reflection. These are reachability and
  contract checks on completed traces, not claims about the pending CFD
  response.
