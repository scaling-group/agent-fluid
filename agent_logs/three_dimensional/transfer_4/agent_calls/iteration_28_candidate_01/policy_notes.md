# Conserved forward mean-bend allocation

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled solver scores,
  observations, metrics, diagnostics, trajectories, and policies, and the
  available inherited optimizer notes. Every sampled episode is a direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm,
  no cylinders, and capture termination. The sampled v12 and v15 rollouts have
  exact trajectories despite v15's terminal-only work-reference partition;
  they are determinism/inactivity evidence rather than distinct positive
  controller mechanisms.
- I inspected the combined keyframe sheets for the sampled v20 scalar leader,
  the v16 terminal-allocation comparator, and v12, including the top-down
  mid-plane vorticity row and oblique Lambda2 row from release through capture.
  All visibly self-propel from rest, retain a coherent alternating wake and
  compact three-dimensional posterior structures, and show no passive
  advection, boundary interaction, wake breakup, or out-of-plane instability.
  The useful distinction is terminal curvature allocation rather than gross
  propulsion or wake topology.
- The sampled v20 improves arrival/mean distance/score over v16 from
  `18.0235T/1.950801L/-0.064545` to
  `18.0070T/1.950358L/-0.064028`, but its raw-yaw-power selector loses the
  terminal benefit: final alignment falls from `0.1818` to `0.1092`, absolute
  yaw rises from `0.4200` to `0.9840 rad/T`, head cross-track widens from
  `0.7232L` to `0.7317L`, and near posterior acceleration-ceiling residence
  rises to `75.83%`. The two visual rows remain coherent, so this is a selector
  and terminal-state regression rather than failed swimming.
- The inherited completed v19 comparison isolates a positive allocation
  mechanism on v16. Shifting at most `35%` of the already requested signed mean
  tangent forward during only a moving, misaligned approach preserved the
  `18.0235T` capture and coherent wake, shortened center path/head cross-track
  from `13.2111L/0.7232L` to `13.2086L/0.7207L`, raised final alignment to
  `0.1957`, lowered absolute final yaw to `0.2875 rad/T`, and slightly reduced
  near limit residence on both joints rather than migrating it forward. Its
  small mean-distance/score regression to `1.950985L/-0.064778` bounds the
  claim: this is evidenced terminal damping, not an evidenced score gain.
- The assigned parent proposes a gait-demodulated shared rate-feedback
  observer, but its CFD is not available here. Completed related v22 evidence
  is negative: shared demodulated rate feedback retained capture and shortened
  path, yet regressed mean distance/score to `1.951273L/-0.065191` and ended at
  only `0.1287` alignment with `1.0486 rad/T` yaw. I therefore do not compound
  the prefill with another yaw observer, raw-yaw selector, or scalar gain sweep.

## Single policy hypothesis

Preserve the evaluated v16 state-feedback oscillator, posterior lag and
emphasis, phase-consistent work reserve, odd body-frame route controller,
alignment-qualified terminal posterior envelope, half-cycle steering, and
reversal-preserving rate governor. Add only the completed v19 longitudinal
allocation mechanism: during a moving, misaligned approach, center the
anterior carrier on a bounded share of the existing signed mean tangent and
subtract exactly that share from the posterior mean target. Derive the
posterior traveling wave from the recentered anterior state, so total requested
mean tangent and posterior lag remain unchanged. The authority is exactly zero
outside `2.10L` and the whole map remains odd under lateral reflection.

The expected result is v16-identical far/middle action and coherent two-view
wake, retained capture, and the inherited v19-class terminal path,
alignment/yaw, and non-migrating actuator residence. Falsify the reusable
mechanism if pre-approach actions change, total signed mean tangent is not
conserved, capture or distance integral regresses materially, terminal yaw and
alignment do not improve together, pressure migrates to the anterior joint,
reflection fails, or either wake view deteriorates. A repeated v19-class CFD
result is determinism evidence, not a new mechanism claim.

bookshelf_consulted: true
source_domain: elongated-body propulsion and robotic-fish mean-curvature turning
source_mechanism: let the anterior body sustain and steer a traveling bend while the lagged posterior joint retains its propulsion role
transferable_invariant: redistribute a bounded existing signed mean bend longitudinally without changing its total or destroying the posterior traveling wave
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phase, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: map normalized body-frame target geometry to one odd total mean tangent, move an approach-qualified share to the anterior carrier center, and subtract the same share from the posterior mean target while preserving posterior lag
falsification: reject if transit changes, total mean tangent is not conserved, capture or distance integral worsens materially, terminal yaw and alignment fail to improve jointly, saturation migrates forward, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The mandated check-runner role was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account. Running its immutable checks directly
  exposed two identical assigned-parent markers in the rendered workspace
  `README.md`; removing only the duplicate preserved the selected parent. The
  guidance-materiality check then passed, and the solver boundary check confirms
  that `candidate_target_policy.jl` is the only solver change.
- Julia is not installed, so the executable include/action probe cannot run.
  Deterministic static checks find one definition of each public function,
  resolve all `63` direct `params.FIELD` references among the `65` fields
  returned by `target_policy_params`, confirm balanced delimiters and a nonempty
  candidate, and find no explicit clock, elapsed time, step count, randomness,
  file I/O, cylinder coordinate, target coordinate, or memorized route input.
- Algebraic probes across both turn signs and far/near distances confirm that
  anterior plus posterior mean tangent equals the original request to numerical
  precision, the allocation is exactly inactive at and beyond `2.10L`, and
  simultaneous lateral reflection negates both allocated means. Diffing against
  the inherited v22 policy confirms that the completed v19 allocation is
  retained while its later demodulated shared-feedback mechanism is absent.
  These are contract checks and inherited-evidence reconstruction, not a new
  CFD result; EvE evaluates this materialized candidate after the worker exits.
