# Target-opposed body-slip rejection candidate

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the four sampled solver scores,
  observations, diagnostics, traces, policies, and combined keyframe sheets,
  plus the assigned-parent notes and its completed evaluation. Every inspected
  rollout is a finite capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and no boundary or numerical
  termination.
- I inspected both the top-down mid-plane vorticity row and the oblique
  Lambda2 row for the sampled v31 leader, the informative v26 regression, and
  the assigned-parent v35 headroom allocator. All visibly self-propel from
  rest, turn toward the target, and retain the same coherent alternating wake
  and compact three-dimensional posterior structures through capture. There
  is no passive advection, standing reciprocal wiggle, wake breakup, boundary
  interaction, or out-of-plane instability. The remaining problem is control
  of the terminal trajectory, not creation of propulsion.
- V31 is the sampled scalar leader at score/mean distance
  `-0.064000/1.950346L` and captures at `18.0125T`. Its route remains fast and
  coherent, but it enters `2.10L` at `0.900U` and reaches capture at `0.881U`
  with only `0.1297` course alignment, `0.8077 rad/T` absolute yaw, and
  `0.873U` target-normal speed. Near-target body-frame lateral speed has
  `0.354U` RMS and ranges from `-0.398U` to `0.614U`; `41.6%` of approach
  samples move laterally opposite the body-frame target side.
- The inherited controller divides the already normalized observation
  `velocity_body_U[2]` by `params.L` before applying its lateral-velocity
  feedback. Thus the measured `0.354U` approach RMS becomes only `0.00553` at
  the controller input. The nominal lateral feedback term is consequently
  almost inactive even though the body-frame target and distance adapters
  legitimately retain their historical `L` conversion.
- Indiscriminate lateral damping is not supported. V26's one-sided posterior
  slip feathering improves final alignment/yaw to `0.1728/0.6545 rad/T` and
  lowers near posterior acceleration-ceiling residence from `75.89%` to
  `74.11%`, but regresses score/mean distance to
  `-0.064149/1.950469L`. Helpful targetward lateral motion and the posterior
  propulsive wave should therefore be retained.
- The assigned parent's v35 pre-clamp steering-headroom allocator preserves
  capture and the coherent two-view wake but regresses score/mean distance to
  `-0.064495/1.950735L`, final alignment/yaw to
  `0.1150/0.9445 rad/T`, and leaves near acceleration-ceiling residence
  essentially unchanged at `69.21/75.83%`. The separately inherited
  posterior phase-energy envelope likewise scores `-0.064963` with unchanged
  near ceiling residence and worse `0.1101/0.9794 rad/T` terminal
  alignment/yaw. Another pre-clamp saturation allocator or posterior-energy
  withdrawal is not justified.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd target-to-curvature map,
state-feedback anterior oscillator, posterior lag and emphasis, phase-
consistent reserve, cadence, terminal posterior envelope, course-qualified
duty surface, conserved mean-bend allocation, and reversal-preserving rate
governor. Add one bounded approach mechanism in the existing geometric turn
request: normalize `velocity_body_U[2]` directly by its observed `U`-scale,
and admit the resulting slip correction only when the current lateral motion
is opposite the body-frame target side. Targetward lateral motion receives
exactly zero new correction, and the new term is exactly inactive outside the
established `2.10L` approach region.

This is not a scalar gain sweep. It repairs an observation-unit mismatch and
adds a sign-consensus gate so the feedback rejects only counterproductive
slip instead of damping the productive carrier. Under lateral reflection the
target-side and slip signals both reverse, their opposition gate is invariant,
and the selected correction reverses with the final two-joint commands.

Expected evidence is v31-identical far/middle action and wake topology,
retained capture and distance-closure class, reduced target-opposed approach
slip and head cross-track, and improved terminal alignment/yaw without loss of
targetward lateral motion or posterior propulsion. Falsify if any output
changes outside `2.10L`; capture, observed distance integral, or arrival
regresses materially; the coherent two-view wake weakens; targetward slip is
damped; loads or limit residence rise; terminal path, alignment, and yaw do
not improve together; or lateral reflection fails.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish steering and wake-interaction control
source_mechanism: preserve a posterior-emphasized traveling wave and useful lateral motion while applying bounded feedback only to lateral motion that conflicts with the current target direction
transferable_invariant: separate productive targetward lateral motion from target-opposed slip before adding a small state-feedback steering residual
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, robot linkage geometry, full-body CPG state, exact vortex phases, world coordinates, and task-specific routes
policy_translation: use normalized body-frame target side and velocity_body_U lateral speed to gate a bounded approach-only slip correction into the existing odd two-joint steering request, with exactly zero correction for targetward motion
falsification: reject if transit changes, helpful targetward motion or the coherent traveling wake is weakened, capture or closure regresses materially, terminal path/alignment/yaw do not improve together, loads rise, or reflected observations do not produce reflected commands
```

## Lightweight validation after editing

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Running its immutable checks directly gives
  `PASS` for guidance materiality and `PASS` for the solver editable boundary.
  Julia is not installed, so the executable include/action smoke check could
  not run. No CFD was attempted.
- Static checks find one definition of each public function, resolve all `67`
  direct `params.FIELD` references among the `69` fields returned by
  `target_policy_params`, confirm balanced delimiters, and find exactly one
  nonempty `candidate_target_policy.jl` under `solver/`.
- Replaying only the new selector on the evaluated v31 observations gives
  exact zero outside `2.10L` and exact zero on every targetward lateral sample.
  It activates on `164/394` approach samples; its bounded added turn-request
  magnitude averages `0.0109` and peaks at `0.0910`. Algebraic reflection
  probes preserve the opposition gate and negate the selected slip request.
  These are contract and reachability checks, not claims about the pending CFD
  response.
