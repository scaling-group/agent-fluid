# Dual-energy terminal posterior relief

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned v20 parent, all
  four sampled scores, observations, metrics, diagnostics, trajectories, and
  policies, and the available inherited optimization notes. Every sampled
  rollout is a finite capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and no boundary or
  out-of-plane failure.
- I inspected the combined sheets from release through capture for the sampled
  v20 scalar leader, the v15 informative allocation failure, and the completed
  target-normal-power test. In both the top-down mid-plane vorticity row and
  the oblique Lambda2 row, all fish visibly self-propel from rest and retain a
  coherent alternating wake with compact three-dimensional posterior
  structures. The visible wake class is effectively unchanged; the useful
  distinctions are terminal path, yaw, and joint allocation.
- The assigned v20 parent remains the score/mean-distance leader at
  `-0.064028/1.950358L` with `18.0070T` capture, but it ends at only `0.1092`
  course alignment and `0.9840 rad/T` absolute yaw, with near posterior
  acceleration-ceiling/rate residence of `75.83/14.50%`. The inherited v19
  result shows why the unqualified turn-rate envelope should not be discarded:
  it ends at `0.1957` alignment and `0.2875 rad/T` yaw with posterior residence
  `71.97/11.11%`, albeit at the slightly worse `18.0235T/-0.064778`.
- The newly sampled target-normal-power selector is a mixed negative result.
  Replacing the turn-rate relief selector with positive target-normal
  hydrodynamic power improves capture time, center path, and cross-track from
  v20's `18.0070T/13.2108L/0.7317L` to
  `17.9960T/13.1921L/0.7269L`, and lowers near posterior
  acceleration/rate residence to `72.38/13.04%`. However, score/mean distance
  regress to `-0.064407/1.950652L`, and final alignment/yaw worsen to
  `0.0975/1.2697 rad/T`. At capture its measured target-normal power is
  negative, so that selector releases the posterior wave and the posterior
  acceleration is saturated; target-normal power alone cannot represent the
  remaining rotational state.
- The completed course-consensus forward-allocation test reaches
  `0.1951` final alignment and `0.2761 rad/T` yaw with lower posterior limit
  residence, but delays capture to `18.0290T` and regresses score/mean distance
  to `-0.064510/1.950783L`. It confirms that selective conserved allocation can
  preserve terminal damping, but does not support another allocation-share or
  scalar-threshold sweep.

## Single policy hypothesis

Preserve the v19 state-feedback carrier, posterior lag and emphasis,
phase-consistent work reserve, odd target-to-curvature route controller,
conserved forward mean-bend allocation, half-cycle steering, and
reversal-preserving rate governor. Restore the completed v16 turn-rate gate as
the baseline selector for the existing approach-only posterior-wave envelope,
because it remains active when the body still rotates at capture. Add one
compatible translational-energy mechanism: take the bounded maximum of that
gate and the completed positive target-normal force-power gate. Thus measured
cross-course energy injection can request extra posterior relief, but can never
cancel the rotational relief already supported by v16/v19.

This changes neither far/middle transit nor total signed mean tangent. Both
selector magnitudes are invariant under lateral reflection, the added branch
is zero at rest and whenever force removes target-normal kinetic energy, and
the maximum adds relief on only the subset where target-normal power is more
informative than current turn rate. On replay of the completed v19 approach,
that subset is `14.65%` of samples and raises mean relief authority only from
`0.2435` to `0.2590`, avoiding the chronic propulsion withdrawal seen in prior
envelope failures. Expected evidence is retained capture and coherent two-view
wake, v16/v19-class final yaw and alignment, and some of the target-power
test's path and non-migrating load benefit. Falsify the mechanism if transit
changes, score or arrival regresses materially from v19, final yaw/alignment
do not improve together over v20 and the target-power test, posterior relief
becomes chronic, limit residence migrates forward, reflection fails, or either
wake row deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture scheduling
source_mechanism: retain the propulsive traveling rhythm while bounded state and load feedback reduce excess terminal motion without replacing route control
transferable_invariant: separate rotational activity and target-normal translational power, and let either request only additional approach allocation while preserving the established traveling wave and mean bend
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: form reflection-invariant gates from normalized recent turn rate and positive target-line-normal velocity-force power, use their bounded maximum only for the existing posterior-wave relief envelope, and preserve the two-joint carrier, posterior lag, and conserved signed mean tangent
falsification: reject if far or middle action changes, capture or distance integral regresses materially, final alignment and yaw do not improve together, relief becomes chronic, saturation migrates without benefit, reflection fails, or either coherent wake row deteriorates

## Lightweight validation after editing

- The mandated `check-runner` role was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account. Running its immutable
  checks directly exposed a duplicate assigned-parent marker in the rendered
  workspace `README.md`; removing only one duplicate left the same parent
  identity and made the guidance-materiality check pass. The solver boundary
  check also passes, with `candidate_target_policy.jl` as the only solver
  change.
- Julia is not installed, so the executable include/action probe cannot run.
  Deterministic static checks find one definition of each public function, all
  `64` direct `params.FIELD` references among `66` fields returned by
  `target_policy_params`, balanced delimiters, a nonempty candidate, and no
  elapsed time, step count, randomness, file I/O, cylinder coordinate, target
  coordinate, or memorized route input.
- Algebraic probes make the added power branch exactly inactive at rest, when
  force removes target-normal energy, and at or beyond `2.10L`; simultaneous
  lateral reflection preserves both gate magnitudes. Replay on the completed
  v19 trace finds positive target-normal power exceeds the turn-rate gate on
  `14.65%` of `396` approach samples, raising mean relief authority from
  `0.243472` to `0.258956` with the same `0.625005` maximum. These are
  contract and selectivity checks, not new CFD evidence; EvE evaluates the
  materialized candidate after this worker exits.
