# Course-consensus forward mean-bend allocation

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled solver scores,
  observations, metrics, diagnostics, trajectories, and policies, plus the
  assigned parent's inherited optimization notes and the other available
  completed inherited rollouts. Every current sample uses direct uniform still
  water with `U_infinity=(0,0,0)`, no prewarm, no cylinders, finite dynamics,
  and capture termination. The two sampled v12 evaluations are exact-policy,
  exact-trajectory repeats, so they are determinism evidence rather than two
  controller mechanisms.
- I inspected the combined sheets from release through capture for the sampled
  v20 scalar leader, v16 prefill, and v12, and for the inherited v19,
  gait-demodulated-feedback, and phase-demodulated-envelope comparisons. In
  both the top-down mid-plane vorticity row and oblique Lambda2 row, each fish
  visibly self-propels from rest, leaves a coherent alternating wake with
  compact three-dimensional posterior structures, and shows no boundary
  interaction, passive advection, wake breakup, or out-of-plane instability.
  The unresolved behavior is terminal steering allocation, not propulsion or
  gross wake topology.
- The sampled v20 raw-yaw-power policy is the scalar leader: relative to v16 it
  improves arrival/mean distance/score from
  `18.0235T/1.950801L/-0.064545` to
  `18.0070T/1.950358L/-0.064028`. That small transit gain is not a terminal
  control success: final course alignment falls from `0.1818` to `0.1092`,
  absolute logged final yaw rises from `0.4200` to `0.9840 rad/T`, head
  cross-track widens from `0.7232L` to `0.7317L`, and near posterior
  acceleration-ceiling residence rises from `72.47%` to `75.83%`.
- The inherited v19 conserved allocation is the useful comparator. Moving at
  most `35%` of the existing signed mean tangent forward during a moving,
  misaligned approach preserves v16 arrival and wake class, shortens
  path/cross-track from `13.2111L/0.7232L` to
  `13.2086L/0.7207L`, raises final alignment to `0.1957`, lowers absolute
  final yaw to `0.2875 rad/T`, and slightly reduces near limit residence on
  both joints. Its mean distance/score regress slightly to
  `1.950985L/-0.064778`, so unconditional approach allocation is supported as
  terminal damping but not as a score improvement.
- Three completed selectors bound the next test. Posterior-half-cycle
  allocation reaches `18.0015T` but regresses mean distance/score to
  `1.951343L/-0.065267` and ends at only `0.0743` alignment with
  `1.3579 rad/T` logged yaw. Gait-demodulating the shared rate-feedback path
  also regresses the distance integral and terminal state. Replacing v16's
  raw-yaw envelope gate with the demodulated residual delays capture to
  `18.0895T` and worsens score to `-0.065436`; although it lowers posterior
  limit residence and raises final alignment to `0.3295`, it does so by
  chronically relieving propulsion. Therefore this candidate does not add a
  course/yaw gain, reuse the residual as another shared request, or replace
  the established posterior-wave envelope.

## Single policy hypothesis

Preserve the v16 state-feedback oscillator, posterior lag and emphasis,
phase-consistent work reserve, odd target-to-curvature map, route controller,
alignment-qualified posterior-wave envelope, half-cycle steering, and
reversal-preserving rate governor. Add the evidenced v19 longitudinal
allocation, but qualify it by agreement between two already normalized odd
signals: the existing signed turn command and the signed body-frame
target-versus-velocity course error. Shift a bounded share of the requested
mean tangent to the anterior carrier only when those signs agree; subtract the
identical share from the posterior mean target and form the lagged wave from
the recentered anterior state. Disagreement leaves the v16 longitudinal
allocation intact instead of making a wrong-course bend act earlier.

This is a selector on where an existing bend acts, not a new course-error
steering gain. The allocation authority remains exactly zero at and beyond
`2.10L`, the total requested mean tangent is conserved, and lateral reflection
negates both odd inputs while leaving their agreement gate unchanged. Expected
evidence is v16-identical transit and coherent two-view wake, retained capture,
less distance-integral cost than unconditional v19, and v19-class terminal
path/alignment/yaw without actuator pressure migrating forward. Falsify if
pre-approach action changes, total mean tangent is not conserved, capture or
mean distance regresses materially, terminal yaw and alignment fail to improve
together, limit residence migrates to the anterior joint, reflection fails, or
either wake view deteriorates.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish mean-curvature turning
source_mechanism: keep the lagged posterior body wave primarily propulsive while applying an observed target-consistent mean steering bend farther forward
transferable_invariant: redistribute a bounded existing signed mean bend longitudinally only when independent body-frame route and course signals agree, without changing total bend or posterior lag
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: form a normalized signed target-versus-velocity course error in the body frame, multiply a smooth same-sign consensus gate into the approach-only anterior share, subtract that share from the posterior mean target, and derive the traveling wave from the recentered anterior joint
falsification: reject if transit changes, total mean tangent is not conserved, capture or distance integral worsens materially, terminal yaw and alignment do not improve jointly, actuator pressure migrates forward, lateral reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The mandated check-runner was invoked, but its fixed `gpt-5.4-mini` model is
  unavailable on this account. Running its immutable checks directly gives
  `PASS` for the guidance-materiality check and `PASS` for the solver boundary;
  `candidate_target_policy.jl` is the only solver edit. Julia is not installed,
  so the executable include/action smoke probe cannot run. No CFD was run.
- Deterministic static checks find one definition of each public function, all
  `64` direct `params.FIELD` references among fields returned by
  `target_policy_params`, balanced delimiters, a nonempty candidate, and no
  explicit elapsed time, step count, randomness, file I/O, cylinder coordinate,
  target coordinate, or memorized route input.
- Offline replay of only the new selector on the completed v16 trace leaves all
  `2,881` samples at or beyond `2.10L` with exactly zero allocation authority.
  It activates on `53.03%` of the `396` approach samples, versus unconditional
  v19 allocation throughout eligible approach motion, with mean/max anterior
  shares `0.0612/0.2247` of total requested tangent and a `0.2247` share at
  capture. Algebraic probes across both turn/course signs confirm that lateral
  reflection leaves the consensus gate unchanged and that anterior plus
  posterior mean tangent equals the original request to numerical precision.
  These are contract and selectivity checks, not a claim about the pending CFD
  outcome.
