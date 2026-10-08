# Course-adverse gait-demodulated posterior relief

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned v16 parent, all
  four sampled policies and rollout artifacts, and the inherited v22/v23
  optimizer logs. Every inspected rollout uses direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- I inspected the combined keyframe sheets for sampled v16 and scalar-leading
  v20 and for both inherited v23 tests, reading the top-down vorticity and
  oblique Lambda2 rows from release through capture. All four fish visibly
  self-propel from rest and retain a coherent alternating traveling wake with
  compact three-dimensional posterior structures. There is no passive
  advection, wake breakup, boundary interaction, or out-of-plane instability;
  the useful distinction is terminal allocation and course response.
- The assigned v16 parent captures at `18.0235T` with score/mean distance
  `-0.064545/1.950801L`, path/cross-track `13.2111L/0.7232L`, final course
  alignment `0.1818`, and final absolute yaw `0.4200 rad/T`. Sampled v20 is the
  scalar leader at `18.0070T` and `-0.064028/1.950358L`, but its instantaneous
  yaw-power selector loses terminal quality: alignment falls to `0.1092`, yaw
  rises to `0.9840 rad/T`, cross-track widens to `0.7317L`, and near posterior
  acceleration-ceiling residence rises from v16's `72.22%` to `75.83%`.
- The newly completed v23 posterior-relief placement is informative despite
  its worse `-0.064938/1.951124L` objective. Removing the phase-locked anterior
  component only for the existing terminal posterior-wave envelope raises
  final alignment to `0.2094`, lowers final absolute yaw to `0.1308 rad/T`, and
  lowers near posterior acceleration-ceiling residence to `70.78%`, while
  retaining capture and both coherent wake views. It also delays capture to
  `18.0290T` and slightly lengthens the path to `13.2146L`. Thus the
  demodulated residual is useful for terminal allocation, but relieving for
  its absolute magnitude suppresses posterior work during helpful as well as
  harmful slow course response.
- A read-only replay on the completed v23 trajectory confirms placement and
  scale, not CFD performance: the absolute-residual envelope is active on
  `79.60%` of samples below `2.10L` with mean relief `0.0921`. Qualifying the
  same inherited residual scale by its signed opposition to target-relative
  velocity course is active on `41.06%` with mean relief `0.0488`, and remains
  exactly inactive outside the established approach region. The proposed
  selector therefore changes mechanism and allocation, not a scalar gain.

## Single policy hypothesis

Start from the completed v23 posterior-relief controller. Preserve the odd
body-frame route map, raw-yaw route feedback, state-feedback carrier, posterior
lag/emphasis and work reserve, v19 curvature-conserving forward mean-bend
allocation, half-cycle steering, and reversal-preserving rate governor.

Replace only the absolute-value terminal posterior-wave selector. Form the
signed sine from measured body-frame velocity toward the body-frame target,
subtract the rollout-evidenced anterior carrier component from recent yaw, and
relieve the posterior wave only when their product says the secular yaw is
rotating the velocity course away from the target. This retains posterior work
while secular yaw is already correcting course and damps only course-adverse
response. The course sine and residual are both odd under lateral reflection,
so their opposition product and the envelope authority are even; no world
coordinate, route, clock, or vortex phase is introduced.

Expected evidence is exact pre-approach behavior and the same coherent wake,
retained capture and v20/v16-class closure, plus v23-class terminal yaw,
alignment, and posterior-limit relief. Falsify if transit actions change,
capture or mean distance regresses, final yaw and alignment do not improve
together, limit residence rises or migrates, the sign rule fails under
reflection/disturbance, or either wake row deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction control and selective wake/load rejection
source_mechanism: separate fast carrier motion from slow target response and avoid cancelling lateral motion that already helps the route
transferable_invariant: preserve the traveling posterior wave while allocating terminal relief only to a demodulated body-frame course response that opposes the target-relative velocity correction
nontransferable_details: published CPG gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, and task-specific routes
policy_translation: use the signed product of carrier-demodulated recent yaw and normalized target-versus-velocity course sine to gate the existing approach-only posterior-wave envelope; retain raw route feedback and conserved total mean bend
falsification: reject if pre-approach action changes, capture or distance integral worsens, yaw and alignment fail to improve jointly, loads or limit residence rise, reflection fails, or either wake view loses coherence

## Lightweight validation after editing

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Running its immutable checks directly found
  the inherited duplicate assigned-parent marker in the rendered `README.md`;
  removing only one duplicate marker left the same assigned parent and made the
  guidance-materiality check pass. The solver boundary check also passes with
  `candidate_target_policy.jl` as the only solver difference.
- Julia is not installed, so the executable include/action probe cannot run.
  The deterministic static guard passes: all `65` direct `params.FIELD`
  references resolve among the `67` fields returned by
  `target_policy_params`; each public function is defined exactly once; raw
  delimiters balance; and no clock, elapsed time, step, randomness, file I/O,
  mutable global, cylinder coordinate, or world-route input is present.
- Replaying the exact selector on the inherited v23 trajectory leaves relief
  identically zero at and beyond `2.10L`; below that boundary its mean/max
  relief is `0.0488/0.4665`, versus `0.0921/0.4676` for v23's unqualified
  absolute-residual envelope. Simultaneously reflecting lateral target and
  velocity components, yaw, anterior angle, and anterior rate negates course
  sine and secular yaw while preserving their product and the relief authority
  to machine precision. These are placement, scale, and symmetry checks, not
  new CFD evidence; EvE must evaluate capture, closure, terminal state, loads,
  and both wake views after this worker exits.
