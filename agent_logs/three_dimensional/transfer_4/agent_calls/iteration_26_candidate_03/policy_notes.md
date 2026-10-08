# Posterior-half-cycle terminal steering allocation

## Visual and quantitative diagnosis before editing

- I read the workspace contract, assigned-parent guidance, all four sampled
  policies, scores, observations, metrics, diagnostics, and trajectories, plus
  the inherited v19 and v20 optimization logs. Every sampled rollout uses
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  prewarm, no cylinders, and capture termination.
- I inspected both the top-down vorticity and oblique Lambda2 rows in the
  combined sheets for the sampled v16 assigned parent and the v20 scalar
  leader. Both visibly self-propel from rest, maintain a coherent alternating
  top-down street and compact three-dimensional posterior structures, and show
  no passive advection, wake breakup, domain interaction, or out-of-plane
  instability. Their distinction is terminal kinematics and allocation, not
  wake existence.
- The two sampled v12 files are exact-policy repeats at `18.0125T`, score
  `-0.064599`, mean distance `1.950823L`, path `13.2330L`, head cross-track
  `0.7417L`, final alignment `0.0678`, and final absolute yaw
  `1.0891 rad/T`; they provide determinism rather than two mechanisms. The
  v16 parent preserves capture and improves path/cross-track to
  `13.2111L/0.7232L`, near/final alignment to `0.6722/0.1818`, and near/final
  absolute yaw to `1.8883/0.4200 rad/T`, with score `-0.064545` and arrival
  `18.0235T`.
- The inherited evaluated v19 shift of a conserved mean bend toward the
  anterior joint improves v16 path/cross-track to `13.2086L/0.7207L`, final
  alignment to `0.1957`, final absolute yaw to `0.2875 rad/T`, and slightly
  lowers limit residence, but mean distance/score regress to
  `1.950985L/-0.064778`. This is positive evidence for longitudinal steering
  allocation, but also evidence that shifting the bend throughout both
  posterior half-cycles costs useful closure.
- The sampled v20 selector releases posterior-wave relief when instantaneous
  yaw power is not positive. It becomes the scalar leader at `18.0070T`, mean
  distance `1.950358L`, and score `-0.064028`, but gives back the v19 terminal
  benefit: cross-track rises to `0.7317L`, near/final alignment falls to
  `0.6707/0.1092`, near/final absolute yaw rises to
  `1.9577/0.9840 rad/T`, and near posterior acceleration-ceiling residence
  returns to `75.83%` from v16's `72.22%`. Thus instantaneous positive yaw
  power is not a sufficient half-cycle selector for terminal damping even
  though it marginally improves distance integral and arrival.

## Single policy hypothesis

Start from the completed v19 policy, preserving the odd target-to-curvature
map, anterior state-feedback carrier, posterior lag/emphasis, phase-consistent
reserve, route controller, v16 symmetric terminal posterior envelope,
half-cycle steering, and reversal-preserving rate governor. Keep v19's exact
conservation of total requested mean tangent, but shift its bounded steering
share forward only on the posterior half-cycle whose measured joint velocity
opposes the signed mean bend. When posterior motion already advances the mean
bend, leave that bend posterior rather than loading the anterior carrier.

The new selector is a smooth bounded product of normalized posterior joint
rate and the existing odd turn command. It has authority only inside v19's
moving, misaligned approach gate, vanishes with either zero turn request or
zero posterior rate, and changes sign-equivariantly under lateral reflection.
It is not a new route or yaw request and preserves the total mean tangent
algebraically on every call. Expected evidence is exact v16 pre-approach
behavior and two-view wake coherence, retention of v19's terminal path/yaw
gain, and recovery of its small distance-integral penalty by avoiding chronic
forward allocation. Falsify it if capture or score regresses from v16, the v19
terminal benefit disappears, path or actuator pressure widens, reflection
fails, or either wake row becomes one-sided or incoherent.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and robotic-fish half-cycle asymmetric steering
source_mechanism: preserve the lagged posterior traveling wave for thrust while applying steering asymmetry only on the stroke portion that conflicts with the requested bend
transferable_invariant: allocate a conserved steering bend away from the posterior propulsor only when normalized observed posterior motion opposes that bend
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body joint distributions, exact vortex phases, world coordinates, and task-specific routes
policy_translation: multiply the evaluated approach-only conserved anterior steering share by a smooth reflection-invariant opposition gate formed from the odd turn command and normalized posterior joint rate; retain v16 posterior-wave relief and all transit logic
falsification: reject if pre-approach behavior changes, total mean tangent is not conserved, capture or score regresses, terminal path/course/yaw loses the v19 benefit, actuator pressure migrates without benefit, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account. Running its immutable
  commands directly initially found that the rendered workspace `README.md`
  marked the same assigned parent twice. Removing only that duplicate marker
  leaves the selected parent unchanged; the material-guidance check now passes,
  and the boundary check passes with `candidate_target_policy.jl` as the sole
  solver difference.
- Julia is not installed or discoverable, so the executable include/action
  probe cannot run in this shell. The deterministic static guard passes: all
  `64` direct `params.FIELD` references resolve among the `66` fields returned
  by `target_policy_params`, both public functions occur exactly once, the
  candidate is nonempty, raw delimiters balance, and no clock, random source,
  file I/O, mutable global, cylinder coordinate, or world-route input appears.
- Reconstructing the new selector on the completed v19 trajectory gives zero
  anterior-allocation authority at and beyond `2.10L`. Below that boundary the
  posterior opposition gate is active on `51.52%` of samples, as expected for
  a half-cycle mechanism. Mean/maximum anterior share become
  `0.0483/0.2122`, versus `0.1006/0.2246` for v19's chronic allocation. The
  anterior and posterior means sum algebraically to the unchanged total mean
  tangent on every call; simultaneous reflection of turn command and posterior
  rate leaves gate magnitude unchanged and flips both allocated bends. These
  are contract and activation checks, not new CFD evidence; EvE must evaluate
  the capture, wake, and terminal-motion hypothesis after this worker exits.
