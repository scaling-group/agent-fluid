# Response-excess / yaw-power posterior relief

## Visual and quantitative diagnosis before editing

- I read the workspace contract, assigned-parent guidance, sampled solver
  scores, observations, metrics, diagnostics, trajectories, and policies, plus
  the available inherited optimizer notes and completed parent rollout. Every
  relevant episode uses direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- I inspected both rows of the combined keyframe sheets for the sampled-best
  yaw-power policy, the `v16` terminal-envelope comparator, and the inherited
  response-qualified-allocation regression. The top-down views show direct
  self-propulsion from rest and a coherent alternating reverse-vortex street
  from release through capture. The oblique views show compact, genuinely
  three-dimensional Lambda2 structures following the posterior wave. None
  shows passive advection, wake breakup, boundary interaction, collision, or
  out-of-plane instability. The images are nearly indistinguishable at their
  sparse sample times, so trajectory, yaw, and actuator histories—not vortex
  prominence—must distinguish the terminal mechanisms.
- Two sampled `v12` examples are exact policy/evidence duplicates at
  `18.0125T`, score `-0.064599`, and mean distance `1.950823L`; they establish
  determinism, not separate mechanisms. The sampled `v16` policy's bilateral
  alignment/yaw-qualified posterior relief captures at `18.0235T`, score
  `-0.064545`, and mean distance `1.950801L`, with final alignment/yaw
  `0.1818/0.4200 rad/T` and near posterior acceleration-ceiling residence
  `72.22%`.
- The assigned parent's completed response-qualified forward mean-bend
  allocation retained exact transit and the coherent wake and shortened center
  path from `13.2111L` to `13.1991L`, but regressed score/mean distance to
  `-0.064760/1.950950L` and final alignment/yaw to
  `0.1687/0.5766 rad/T` versus `v16`. Thus applying response excess only to
  release anterior allocation is not a route-neutral terminal solution.
- The sampled yaw-power-selective policy is the finite score leader: versus
  `v16`, it improves capture time from `18.0235T` to `18.0070T`, score from
  `-0.064545` to `-0.064028`, mean distance from `1.950801L` to
  `1.950358L`, and observed distance integral from `1.336838L` to
  `1.336706L`, while preserving the path (`13.2108L`) and both wake views.
  However, preserving every moment-opposing posterior half-cycle lowers final
  alignment from `0.1818` to `0.1092`, raises near/final absolute yaw from
  `1.8883/0.4200` to `1.9577/0.9840 rad/T`, and raises near posterior
  acceleration-ceiling residence from `72.22%` to `75.83%`. Signed-load
  selectivity therefore survives as a progress/propulsion mechanism, but is
  falsified as sufficient terminal damping.

## Single policy hypothesis

Start from the sampled yaw-power leader and preserve its odd body-frame
curvature map, state-feedback carrier, posterior lag and priority, full
far/middle route controller, conserved anterior mean-bend allocation,
reversal-preserving governor, and positive-yaw-power selector. Add no target
course residual and no new desired yaw rate. Instead, compare absolute measured
recent yaw with the magnitude of the controller's existing bounded geometric
target rate. Use a smooth response-excess gate as a second reason for the
already established posterior-wave relief, combined with the positive-power
gate by a continuous union. Thus a moment-opposing half-cycle is preserved when
angular response is still within demand, but bilateral relief returns when the
body is already rotating faster than requested. Both reasons remain multiplied
by the existing normalized approach, misalignment, and yaw gates, so the edit
has exactly zero authority outside `2.10L` and does not change transit or total
mean tangent.

Expected evidence is retention of the yaw-power policy's capture, distance
integral, route, and two-view traveling wake while recovering part of `v16`'s
terminal yaw/alignment and posterior-limit benefit. Reject the mechanism if
pre-approach action changes, capture or mean distance regresses materially,
terminal yaw and alignment do not improve together, posterior limit residence
does not fall, limit pressure merely migrates anteriorly, reflection changes
gate magnitude, or either wake row deteriorates.

bookshelf_consulted: true
source_domain: terminal capture control, sensor-modulated robotic-fish steering, and wake/load-feedback control
source_mechanism: preserve a propulsive traveling wave and moment-opposing half-cycles, but restore bounded bilateral yaw relief after measured angular response exceeds demand
transferable_invariant: separate instantaneous load injection from accumulated response excess, and reduce posterior excursion when either shows that the current approach rotation is dynamically harmful
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body curvature distributions, exact vortex phase, world coordinates, capture radius, and task-specific routes
policy_translation: in the normalized body-frame approach regime, continuously union the reflection-invariant positive product of recent yaw and yaw moment with excess absolute recent yaw over the existing bounded geometric target rate; use that state gate only on posterior-wave relief under the unchanged two-joint carrier
falsification: reject if transit changes, capture or distance integral is lost, terminal yaw/alignment and posterior limit residence do not improve, actuator pressure migrates forward, reflection fails, or either coherent wake view worsens

## Lightweight validation after editing

- I invoked the required dedicated check-runner, but its pinned
  `gpt-5.4-mini` model is unsupported on this account, so it failed before
  executing a check. I then ran its immutable commands directly. The guidance
  check first exposed two identical assigned-parent markers in the rendered
  workspace `README.md`; removing only the duplicate left the assigned parent
  unchanged, and the rerun passes. The repository-boundary check passes with
  `candidate_target_policy.jl` as the only solver difference.
- Julia is not installed or discoverable in this shell, so the executable
  include and finite-action probe cannot run. The deterministic static guard
  passes: all `64` direct `params.FIELD` references resolve among the `66`
  fields returned by `target_policy_params`; each public contract function
  appears exactly once; delimiters balance; the candidate is nonempty; and no
  clock, step, randomness, file I/O, mutable global, cylinder input, or
  memorized wake/route input appears.
- Replaying the new selector on the completed sampled yaw-power trajectory
  makes posterior relief exactly zero at and beyond `2.10L`. Within approach,
  response excess is present on about `86.77%` of samples and changes mean
  posterior-wave authority from about `0.9681` under yaw-power selection alone
  to `0.9171`, while leaving minimum authority nearly unchanged
  (`0.7572` versus `0.7527`). This is an intermediate state envelope rather
  than restoration of unconditional bilateral suppression. Simultaneous
  lateral reflection flips geometric request, yaw, and moment, while preserving
  both selector magnitudes and the conserved total mean tangent. These are
  static/replay activation checks, not CFD evidence; EvE must evaluate capture,
  trajectory, actuation, and wake outcomes after this worker exits.
