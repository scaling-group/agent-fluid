# Terminal anterior steering allocation

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, all four sampled policies, scores,
  observations, metrics, diagnostics, and trajectories, and the available
  inherited optimizer notes and completed rollout logs. I inspected both the
  top-down vorticity and oblique Lambda2 rows of the combined keyframe sheets
  for the sampled v16 leader and the informative v17 signed-residual and v18
  course-persistent posterior-hold regressions. Every rollout starts directly
  from uniform still water with `U_infinity=(0,0,0)`, no prewarm, and no
  cylinders.
- All inspected policies visibly self-propel from rest. Their top-down rows
  retain a coherent alternating wake through target approach, and their
  oblique rows retain compact three-dimensional posterior structures without
  wake breakup, passive advection, collision, domain interaction, or
  out-of-plane instability. The failed policies do not create a usefully
  different wake or route class, so terminal state and actuator allocation,
  rather than gross wake existence, discriminate the candidates.
- The sampled v16 alignment-qualified posterior-wave envelope is the leader:
  it scores `-0.064545`, captures at `18.0235T`, and, relative to the three
  episode-equivalent v12/v15 samples at `-0.064599`, shortens center
  path/cross-track from `13.2330L/0.7417L` to `13.2111L/0.7232L`, raises
  near/final target-course alignment from `0.6637/0.0678` to
  `0.6722/0.1818`, and lowers near/final absolute yaw from
  `1.9970/1.0891` to `1.8883/0.4200 rad/T`. It nevertheless crosses with
  course-sine magnitude `0.9833` and speed about `0.85U`, so terminal motion
  is not settled.
- The inherited logs supply four concrete negative results. Adding signed
  course error directly to the shared turn request regresses score to
  `-0.064645` and final alignment/yaw to `0.1640/0.5884 rad/T`. Three ways of
  closing that error through a desired yaw-rate loop score `-0.064995`,
  `-0.064888`, and `-0.064862`; all finish with lower alignment and higher
  absolute yaw than v16 (`0.1505`--`0.1642` and
  `0.5698`--`0.7306 rad/T`). Holding the posterior envelope active until
  course slip also settles delays capture to `18.1335T`, widens the path to
  `13.2762L`, regresses score to `-0.065308`, and ends at
  `1.2838 rad/T` yaw. The same coherent wake survives each test. Another
  signed residual, yaw-rate gain, envelope-floor tune, or stronger posterior
  hold is therefore not supported.

## Single policy hypothesis

Start from the evaluated v16 leader. Preserve its odd body-frame
target-to-curvature map, anterior state-feedback carrier, posterior lag and
emphasis, phase-consistent reserve, far/middle route observer, terminal
posterior-wave envelope, half-cycle steering, and reversal-preserving rate
governor. Add one joint-allocation mechanism: during a moving, misaligned
approach, shift a bounded fraction of the *existing* signed mean bend from the
posterior target to the anterior oscillator center. Center the posterior wave
on that shifted anterior state and subtract the same mean amount from the
posterior steering target. Thus the requested total mean tail tangent and its
sign are unchanged; only the longitudinal distribution of steering curvature
changes.

The allocation is exactly zero outside `2.10L`, at rest, and for an aligned
course. It does not add another terminal error request or increase the total
mean bend. The expected signature is exact pre-approach invariance, retention
of capture and the coherent two-view traveling wake, less interference
between posterior propulsion and terminal steering, and lower final yaw and
course error without widening or delaying the route. Falsify it if behavior
moves before approach, total mean curvature is not conserved by construction,
capture or sampled-best score is lost, terminal course/path/yaw does not
improve, actuator pressure merely migrates forward, reflection fails, or
either wake view deteriorates.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish direction control
source_mechanism: keep the lagged posterior motion primarily propulsive while allocating bounded mean steering curvature farther forward
transferable_invariant: longitudinal allocation of curvature can separate steering from posterior thrust without changing the signed total bend or destroying the traveling wave
nontransferable_details: published gains, dimensional cadence, species-specific body envelopes, full-body joint distributions, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: use normalized body-frame approach, velocity alignment, and speed gates to shift part of the existing odd mean-tangent request to the anterior joint while subtracting the same part from the posterior mean target and preserving posterior lag
falsification: reject if pre-approach motion changes, total mean bend is not preserved, capture or score regresses, terminal path/course/yaw does not improve, saturation migrates without benefit, reflection fails, or either coherent wake row worsens

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account. Running its immutable
  checks directly first exposed two identical assigned-parent markers in the
  rendered workspace `README.md`; removing only the duplicate left the
  selected parent unchanged. The rerun passes the material-guidance check, and
  the boundary check passes with `candidate_target_policy.jl` as the only
  solver difference.
- No Julia executable is installed or discoverable, so the exact Julia include
  and action probe cannot run in this shell. The deterministic schema check
  passes independently: all `63` direct `params.FIELD` references resolve
  among the `65` unique fields returned by `target_policy_params`, both public
  functions occur exactly once, the candidate is nonempty, raw delimiters
  balance, and no clock, random source, file I/O, mutable global, cylinder
  coordinate, or world-route input appears.
- Replaying the allocation gate on the sampled v16 trajectory gives exactly
  zero authority for every sample at or beyond `2.10L`. Below approach its
  mean/maximum authority is `0.2863/0.6419`; the `0.35` share therefore moves a
  mean `0.1002` and at most `0.2247` of the existing mean tangent forward. The
  head and posterior means sum algebraically to the unchanged odd total mean
  tangent. Focused probes make allocation zero at rest and on an aligned
  course; lateral reflection preserves the gate magnitude and flips both mean
  contributions. These are contract and activation checks, not CFD evidence;
  EvE must evaluate the trajectory hypothesis after this worker exits.
