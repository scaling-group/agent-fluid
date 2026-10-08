# Conserved course-slip bend allocation

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled scores,
  observations, metrics, diagnostics, trajectories, and policies, and the
  assigned parent's inherited optimizer notes and completed v23/v21 results.
  Every compared episode uses direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
  The sampled v12 pair is an exact-policy repeat and therefore determinism
  evidence rather than two controller mechanisms.
- I inspected the combined keyframe sheets for sampled v20, sampled/current
  v16, inherited v19, and the inherited v23/v21 comparators. In both the
  top-down mid-plane row and oblique Lambda2 row, each fish self-propels from
  rest, leaves a coherent alternating wake, and retains compact
  three-dimensional posterior structures through capture. There is no passive
  advection, wake breakup, boundary interaction, or out-of-plane instability.
  The unresolved failure is terminal course response and actuator allocation,
  not propulsion or gross wake topology.
- The sampled v20 yaw-power selector is the scalar leader at
  `18.0070T/1.950358L/-0.064028`, but relative to current v16 it reduces final
  alignment from `0.1818` to `0.1092`, raises final absolute yaw from `0.4200`
  to `0.9840 rad/T`, widens head cross-track from `0.7232L` to `0.7317L`, and
  raises near posterior acceleration-ceiling residence from `72.47%` to
  `75.83%`. The coherent wake therefore does not rescue instantaneous yaw
  power as a terminal response signal.
- The inherited v19 conserved forward-mean-bend allocation is the strongest
  semantic comparator: against v16 it preserves the `18.0235T` capture,
  shortens path/cross-track from `13.2111L/0.7232L` to
  `13.2086L/0.7207L`, improves final alignment/yaw from
  `0.1818/0.4200` to `0.1957/0.2875 rad/T`, and slightly reduces near limit
  residence on both joints. Its score/mean-distance regression to
  `-0.064778/1.950985L` bounds this as a damping/allocation result rather than
  a score result.
- Newly inherited completed evidence rules out another phase-demodulation
  placement or scale sweep. Moderate v23 residual-qualified posterior relief
  improves v19 final alignment/yaw to `0.2094/0.1308 rad/T` and posterior near
  acceleration residence to `70.78%`, but lengthens path to `13.2146L` and
  regresses mean distance/score to `1.951124L/-0.064938`. Stronger v21 relief
  further reduces near posterior rate/acceleration residence to
  `4.66%/63.97%`, yet delays capture to `18.0895T`, lengthens path to
  `13.2309L`, and regresses mean distance/score to
  `1.951618L/-0.065436`; its final yaw is still `0.8403 rad/T`. Stable fitted
  carrier coefficients therefore did not make residual magnitude a supported
  course selector.

## Single policy hypothesis

Preserve current v16's odd body-frame route controller, state-feedback
carrier, posterior lag/emphasis and work reserve, alignment-qualified terminal
posterior envelope, half-cycle steering, and reversal-preserving rate
governor. Add one longitudinal allocation mechanism only during a moving,
misaligned approach. Compute signed course slip as the normalized body-frame
cross product of target direction and fish velocity. Center the anterior
carrier on a small bend opposite that slip and subtract exactly the same bend
from the posterior mean target before constructing the lagged wave. This keeps
the total requested mean tangent unchanged, preserves posterior wave shape,
and is exactly inactive at and beyond `2.10L`.

This differs from the failed shared course-curvature and yaw-rate loops: course
slip changes only the moment-arm distribution of existing curvature, not the
route request or total mean bend. It also avoids a fitted gait observer. On the
completed v16/v19/v20/v23/v21 traces, the approach mean signed course sine is
consistently `0.592--0.607`; the proposed bounded map is exactly zero outside
approach and would request only `0.89--0.96 deg` mean absolute anterior offset
inside approach, with a `2.17 deg` maximum. That is comparable to the already
successful v19 redistribution rather than a new high-authority turn.

Expected evidence is unchanged far/middle commands and coherent two-view wake,
retained capture and v16-class distance integral, and a terminal reduction in
course-sine magnitude, path/cross-track, yaw, and non-migrating actuator
residence. Falsify the mechanism if transit changes, total signed mean tangent
is not conserved, capture or mean distance regresses materially, terminal
alignment/yaw do not improve together, pressure migrates forward, reflection
fails, or either wake view deteriorates.

bookshelf_consulted: true
source_domain: elongated-body propulsion and robotic-fish mean-curvature turning
source_mechanism: preserve a lagged posterior traveling wave while changing where a bounded steering bend is carried along the body
transferable_invariant: redistribute existing mean curvature longitudinally using normalized target-relative course response without changing total curvature or posterior wave shape
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phase, world coordinates, target location, and task-specific routes
policy_translation: use the signed body-frame target-velocity cross product to add an approach-qualified anterior carrier center and subtract the identical tangent from the posterior mean target
falsification: reject if pre-approach action changes, total tangent or reflection oddness fails, capture or distance integral worsens materially, terminal yaw/alignment and actuator residence do not improve together, or either wake view loses coherence

## Non-CFD validation after editing

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. I ran its immutable checks directly: the
  guidance-materiality check passes, and the boundary check confirms that
  `candidate_target_policy.jl` is the only solver difference.
- Julia is not installed or discoverable, so the executable include/action
  probe could not run. The deterministic static guard passes: the nonempty file
  contains one definition of each public function, all `64` direct
  `params.FIELD` references resolve among the `66` fields returned by
  `target_policy_params`, raw delimiters balance, and no explicit clock,
  elapsed time, step count, randomness, file I/O, cylinder coordinates, or
  memorized world route appears.
- Algebraic probes confirm that the new allocation is exactly zero at and
  beyond `2.10L`, negates under simultaneous reflection of target and velocity
  lateral components, and leaves anterior plus posterior mean tangent equal to
  the original route request to numerical precision. These are contract and
  activation checks, not CFD evidence; EvE must evaluate capture, wake, and
  terminal-response effects after this worker exits.
