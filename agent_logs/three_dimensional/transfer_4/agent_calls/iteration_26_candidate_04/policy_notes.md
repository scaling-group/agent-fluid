# Gait-demodulated terminal yaw feedback

## Visual and quantitative diagnosis before editing

- I read the assigned guidance, all four sampled solver policies, scores,
  observations, diagnostics, trajectories, and combined keyframe sheets, plus
  the inherited v18--v21 optimizer rollouts and notes. Every inspected episode
  uses direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  prewarm, no cylinders, and capture termination.
- In both views, the v16 leader, v19 anterior-allocation result, v20 yaw-power
  result, and v21 response-qualified allocation self-propel from rest. Their
  top-down rows retain the same coherent alternating street and their oblique
  rows retain compact three-dimensional posterior structures through capture.
  The informative v18/v20/v21 mechanism failures show no passive advection,
  boundary interaction, wake breakup, or out-of-plane instability. The useful
  distinction remains terminal response, not gross wake topology.
- The completed yaw-power selector is a scalar improvement but a semantic
  terminal failure. Relative to v19, it improves score/mean distance from
  `-0.064778/1.950985L` to `-0.064028/1.950358L` and arrives slightly earlier
  (`18.0070T` versus `18.0235T`), but degrades final alignment/absolute yaw
  from `0.1957/0.2875 rad/T` to `0.1092/0.9840 rad/T`. Its head cross-track
  also rises from `0.7207L` to `0.7317L`, and near posterior acceleration-limit
  residence rises from `71.97%` to `75.83%`. Selecting relief from the
  instantaneous sign of hydrodynamic yaw power therefore preserves useful
  closure at the cost of the claimed damping/allocation benefit.
- The inherited v21 response-qualified allocation also fails its joint
  yaw/alignment expectation: although path/cross-track improve to
  `13.1991L/0.7187L`, final alignment falls to `0.1687` and absolute yaw rises
  to `0.5766 rad/T`, both worse than v19 and with score below v16. A direct
  target-course yaw-rate controller had already ended at
  `0.1161/1.0763 rad/T`. These failures all qualify terminal mechanisms with
  raw measured yaw.
- A phase regression supplies a different diagnosis. Across v16, v19, v20,
  and v21, the normalized anterior carrier angle and rate explain
  `99.0%--99.1%` of the full raw yaw-rate variance with stable coefficients
  `0.567--0.568` and `-3.288--3.290`; removing that phase-locked estimate lowers
  yaw RMS from about `2.05` to `0.20 rad/T`. Near-target fits remain
  `R^2=0.992--0.993`. At v19's `2.10L` approach crossing, for example, raw yaw
  is `-3.092 rad/T` while the phase-locked estimate is `-3.078 rad/T`. Thus the
  signal used by prior terminal response gates is predominantly gait phase,
  not the slower course response those gates intended to measure.

## Single policy hypothesis

Start from the completed v19 policy because it preserves the coherent transit
and gives the best evidenced final alignment/yaw pair. Preserve its odd total
curvature, posterior-priority wave and work reserve, v16 terminal posterior
envelope, persistent curvature-conserving anterior allocation, half-cycle
steering, and reversal-preserving rate governor.

Add one observer mechanism to the existing target-yaw-rate feedback. Estimate
the fast, phase-locked yaw component from normalized anterior joint angle and
rate, subtract it from measured recent yaw, and blend from raw yaw at the
`2.10L` approach boundary to the demodulated residual near capture. Use this
blended measurement only in the existing `target_turn_rate - measured_rate`
feedback. Keep raw yaw in the already successful posterior-wave envelope and
do not add a course request, change total mean bend, or condition the v19
allocation. The architecture is exactly inactive outside approach and is odd
under lateral reflection because joint angle, joint rate, yaw, and the
demodulated residual all change sign.

Expected evidence is unchanged far/middle trajectory and both wake views,
retained capture and v19 allocation, and a terminal rate correction that does
not reverse merely because the anterior carrier changes half-cycle. Falsify
the mechanism if pre-approach actions change, capture or mean distance regresses
materially, final alignment and yaw do not improve together, limit residence
migrates or rises, the phase residual fails to generalize under reflection, or
either coherent wake row deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction control and terminal capture
source_mechanism: separate fast carrier-phase motion from slow directional response before feeding measured body motion back into the steering loop
transferable_invariant: preserve the traveling posterior wave while closing terminal feedback on a body-frame response residual that removes the predictable joint-phase component
nontransferable_details: published CPG gains, dimensional cadence, species-specific envelopes, exact vortex phase, full-body kinematics, world coordinates, and task-specific routes
policy_translation: estimate phase-locked yaw from normalized anterior joint angle and rate using sampled-rollout scaling, subtract it from recent yaw, and blend that residual into only the existing approach yaw-rate error while preserving the two-joint wave and total odd bend
falsification: reject if transit changes, capture or distance integral worsens, yaw and alignment do not improve jointly, loads or limit residence rise, reflection fails, or either wake view loses coherence

## Lightweight validation after editing

- The guidance-materiality check and solver-boundary check pass. The dedicated
  checker was invoked as required, but its pinned `gpt-5.4-mini` model is not
  supported by this account. Julia is also absent, so the executable
  include/action probe could not run.
- The deterministic static guard passes: all `65` direct `params.FIELD`
  references resolve among the `67` fields returned by
  `target_policy_params`; both public functions occur exactly once, the
  candidate is nonempty, raw delimiters balance, and no clock, step, random
  source, file I/O, cylinder coordinate, or world-route input appears.
- Algebraic probes make the new observer exactly inactive at and beyond
  `2.10L` and odd under simultaneous lateral reflection. Replaying the observer
  on the completed v19 trajectory leaves every pre-approach yaw measurement
  unchanged. Inside approach it reduces the feedback measurement RMS from
  `2.0871` to `1.4133 rad/T` while the fully demodulated residual is
  `0.1910 rad/T` RMS; at the sampled capture state, feedback yaw changes from
  `-0.4340` to `-0.0252 rad/T`. These are activation and contract checks, not
  CFD evidence; EvE must evaluate the trajectory and wake hypothesis after
  this worker exits.
