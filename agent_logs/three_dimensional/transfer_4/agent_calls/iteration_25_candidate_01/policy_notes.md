# Response-qualified terminal steering allocation

## Evidence read before editing

- All four sampled solver rollouts and the completed inherited rollouts used
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  prewarm, and no cylinders. Every sampled solver captured. I inspected both
  the top-down vorticity and oblique Lambda2 rows of the combined keyframe
  sheets for the sampled `v16` leader, the repeated `v12`/`v15` comparator,
  the assigned-parent `v18` course-yaw-rate regression, and the inherited
  `v19` anterior-allocation regression.
- The top-down rows show self-propelled target closure and a coherent,
  alternating wake from release through capture. The oblique rows show compact
  three-dimensional posterior structures throughout the same interval. The
  regressions do not show passive advection, wake breakup, domain interaction,
  collision, or a meaningfully different trajectory class. The remaining
  distinction is terminal route/yaw regulation, not basic propulsion.
- The sampled `v16` alignment-qualified posterior envelope remains the finite
  leader: score/mean distance `-0.064545/1.950801L`, capture at `18.0235T`,
  near/final alignment `0.6722/0.1818`, and near/final absolute yaw
  `1.8883/0.4200 rad/T`. The three `v12`/`v15` samples are episode-equivalent
  at `-0.064599/1.950823L` and establish that the reserve-work partition is a
  null mechanism, not an additional success.
- The assigned parent converted signed target-course error into a desired yaw
  rate inside the same approach gate. It retained capture and the coherent
  wake, but regressed to `-0.064955/1.951091L`; final alignment fell to
  `0.1161`, final absolute yaw rose to `1.0763 rad/T`, and near posterior
  acceleration-limit residence rose from about `72.22%` to `72.96%`. Together
  with inherited course-rate variants at `-0.064995` and `-0.064888`, this is
  evidence against another course residual, course-derived yaw reference, or
  gain-only retune.
- The inherited `v19` policy instead moved a bounded share of the existing
  odd mean bend from the posterior target to the anterior oscillator center.
  It retained capture at `18.0235T` and improved final alignment/yaw to
  `0.1957/0.2875 rad/T`, with slightly lower near absolute yaw
  (`1.8744 rad/T`). However, its yaw-independent allocation remained active
  whenever approach, misalignment, and speed gates were open; score/mean
  distance regressed to `-0.064778/1.950985L`. This supports longitudinal
  allocation as a terminal-state mechanism but falsifies persistent allocation
  as a route-neutral implementation.

## Single policy hypothesis

Start from the evaluated `v16` leader and retain its odd body-frame curvature
map, anterior state-feedback carrier, posterior lag/emphasis, phase-consistent
reserve, far/middle route observer, terminal posterior-wave envelope,
half-cycle steering, and reversal-preserving rate governor. Retain `v19`'s
curvature-conserving longitudinal allocation, but qualify it by the measured
angular response: shift mean bend forward only while absolute recent yaw
exceeds the magnitude of the controller's existing bounded geometric target
yaw rate. Do not introduce a new course-error request or a new yaw reference.

The allocation remains exactly zero outside `2.10L`, at rest, on an aligned
course, and whenever measured yaw is no stronger than the already requested
response. It releases continuously as the excess yaw settles. The existing
total signed mean tangent is conserved algebraically, while the posterior wave
retains its established target and lag about the shifted anterior center.
Because the existing desired-yaw-rate magnitude is bounded by `0.75 rad/T`,
the gate should retain allocation during the sampled high-yaw approach
(`1.8883 rad/T` mean absolute yaw) but release at the leader's lower-yaw
capture (`0.4200 rad/T`) instead of imposing `v19`'s persistent route cost.

Expected evidence is exact pre-approach invariance, retention of capture and
the coherent two-view wake, the terminal yaw/alignment benefit of anterior
allocation, and recovery of the sampled-best path/distance integral through
response-based release. Reject the mechanism if behavior changes before
approach, total mean bend is not conserved, capture or mean distance regresses,
terminal alignment/yaw does not improve together, actuator pressure merely
migrates forward, reflection equivariance fails, or either visual wake row
deteriorates.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion, sensor-modulated robotic-fish steering, and biological burst-release turning
source_mechanism: preserve posterior propulsion by allocating bounded mean steering forward, then release the allocation when the observed angular response has reached the requested response
transferable_invariant: longitudinal curvature allocation should be state-qualified and withdrawn when measured turn response is no longer excessive, while total signed bend and the traveling wave remain intact
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body curvature distributions, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: use normalized approach, course-alignment, speed, and measured recent-yaw feedback to gate a curvature-conserving shift of the existing odd mean tangent from the posterior target to the anterior oscillator center; compare yaw only with the controller's existing bounded geometric target rate
falsification: reject if transit changes, capture or sampled-best distance integral is lost, yaw and alignment fail to improve jointly, limit residence only migrates between joints, reflection fails, or either coherent wake view worsens

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account. Running the immutable
  checks directly first found two identical assigned-parent markers in the
  rendered workspace `README.md`; removing only the duplicate left the
  assigned parent unchanged. The rerun passes the material-guidance check, and
  the repository-boundary check passes with
  `candidate_target_policy.jl` as the only solver difference.
- Julia is not installed or discoverable in this shell, so the exact include
  and finite-action probe cannot run here. The deterministic static schema
  guard passes: all `63` direct `params.FIELD` references resolve among the
  `65` unique fields returned by `target_policy_params`; each public contract
  function appears exactly once, raw delimiters balance, the candidate is
  nonempty, and no clock, step, random source, file I/O, cylinder coordinate,
  or world-route input appears.
- The new gate is zero by construction outside approach, at zero speed, on an
  aligned course, and whenever `abs(turn_rate) <= abs(target_turn_rate)`.
  Lateral reflection preserves every gate magnitude while flipping the odd
  total mean tangent; `mean_head_tangent + mean_tail_tangent` remains exactly
  `total_mean_tangent`. These are contract and activation checks, not CFD
  evidence; EvE must evaluate the trajectory hypothesis after this worker
  exits.
