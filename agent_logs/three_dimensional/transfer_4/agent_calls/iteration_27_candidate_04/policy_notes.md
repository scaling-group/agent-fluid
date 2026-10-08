# Gait-demodulated terminal posterior relief

## Visual and quantitative diagnosis before editing

- I read the workspace contract, assigned guidance, all four sampled solver
  policies and rollout artifacts, and the inherited v19--v22 policies, notes,
  and completed evaluations. Every inspected case uses direct uniform still
  water with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture
  termination.
- I inspected the combined keyframe sheets for the sampled v16 semantic leader,
  sampled v20 scalar leader, and the inherited v21 and v22 mechanism failures.
  In every top-down row the fish self-propels from rest and leaves a coherent
  alternating wake through capture. Every oblique row retains compact
  three-dimensional posterior Lambda2 structures without passive advection,
  wake breakup, boundary interaction, or out-of-plane instability. The useful
  distinction is therefore approach feedback and allocation, not gross wake
  formation.
- The sampled v20 yaw-power selector is the scalar leader: relative to v16 it
  improves arrival/mean distance/score from
  `18.0235T/1.950801L/-0.064545` to
  `18.0070T/1.950358L/-0.064028`. It nevertheless loses v16's terminal
  alignment/yaw benefit (`0.1092/0.9840 rad/T` versus
  `0.1818/0.4200 rad/T`), widens head cross-track from `0.7232L` to
  `0.7317L`, and restores near posterior acceleration-ceiling residence from
  `72.22%` to `75.83%`. Its instantaneous raw yaw-power sign is therefore a
  useful propulsion selector but not a supported slow-response measure.
- Both completed step-26 tests retain capture but regress the objective. The
  posterior-half-cycle allocation scores `-0.065267`; the assigned v22
  gait-demodulated rate-feedback parent scores `-0.065191`, versus v20's
  `-0.064028`. Full v22 diagnostics show a shorter path and head cross-track
  (`13.1847L/0.7168L`) and slightly earlier capture (`17.9960T`), but worse
  mean distance (`1.951273L`) and final alignment/yaw
  (`0.1287/1.0486 rad/T`). Thus subtracting carrier yaw inside the existing
  target-rate feedback changes route response but does not establish terminal
  damping.
- Across v12, v16, v19, v20, v21, and v22, normalized anterior angle and rate
  explain about `99%` of raw yaw-rate variance with stable zero-intercept
  coefficients near `0.568` and `-3.289`. The residual is about
  `0.19--0.21 rad/T RMS` on approach. Replaying a residual-magnitude envelope
  with scale `0.40 rad/T` leaves it identically inactive at and beyond `2.10L`
  and gives mean posterior relief `0.094--0.096` on the v19/v20/v22 approach
  traces, close to v20's evaluated `0.0877`. This permits a selector test at
  similar average posterior authority rather than a scalar-only relief sweep.

## Single policy hypothesis

Start from the evaluated v20 scalar leader. Preserve its odd target-to-curvature
map, carrier cadence, posterior lag/emphasis and work reserve, v16 approach
geometry, v19 curvature-conserving anterior steering allocation, raw-yaw route
feedback, half-cycle steering, and reversal-preserving rate governor.

Replace only the terminal posterior-wave selector. Estimate the predictable
carrier-phase yaw from normalized anterior angle and rate, subtract it from
measured recent yaw, and use the bounded magnitude of this secular residual in
the already established approach/misalignment envelope. Do not feed the
residual into the route request and do not use instantaneous hydrodynamic
moment. The approach gate makes the mechanism exactly inactive outside
`2.10L`; simultaneous lateral reflection flips the phase estimate and residual
but preserves envelope magnitude.

Expected evidence is unchanged far/middle trajectory and both coherent wake
views, retained capture and v20-class mean distance, and a terminal relief
decision that does not reverse with gait phase, improving final yaw/alignment
without losing v20's closure. Falsify it if pre-approach actions change,
capture/score/mean distance regress materially, final yaw and alignment do not
improve together, limit residence rises or migrates, coefficients fail under
reflection or disturbance, or either wake row deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction control and wake/load feedback
source_mechanism: separate predictable fast carrier motion from slower directional response before modulating an existing propulsive envelope
transferable_invariant: preserve the traveling posterior wave while making terminal allocation respond to a normalized body-frame course-response residual rather than raw gait-phase yaw
nontransferable_details: published CPG gains, dimensional cadence, species-specific envelopes, exact vortex phase, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: subtract a rollout-evidenced anterior angle/rate yaw estimate and feed only the bounded residual magnitude into the existing approach-only posterior-wave relief; retain raw route feedback and conserved mean bend
falsification: reject if transit changes, capture or distance integral worsens, yaw and alignment do not improve jointly, loads or limit residence rise, reflection fails, or either wake view loses coherence

## Lightweight validation after editing

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported on this account. Running its immutable checks directly first
  exposed two identical assigned-parent markers in the rendered workspace
  `README.md`; removing only the duplicate marker left the selected parent
  unchanged. The guidance-materiality and solver-boundary checks then pass.
- Julia is not installed or discoverable, so the executable include/action
  probe cannot run. The deterministic static guard passes: all `65` direct
  `params.FIELD` references resolve among the `67` fields returned by
  `target_policy_params`; both public functions occur exactly once; the
  candidate is nonempty; raw delimiters balance; and no clock, elapsed time,
  step, randomness, file I/O, mutable global, cylinder coordinate, or
  world-route input appears.
- Replaying the exact new envelope on the completed v19, v20, and v22 traces
  gives zero relief at and beyond `2.10L`. Mean/max approach relief is
  `0.0963/0.4852`, `0.0958/0.3839`, and `0.0945/0.4706`, respectively, so
  mean posterior-wave authority remains `0.9615--0.9622`, close to the
  evaluated v20 mean authority rather than imposing a chronic amplitude cut.
  Simultaneous reflection of yaw, anterior angle, and anterior rate negates the
  residual with zero algebraic error while leaving relief magnitude unchanged.
  These are contract and activation checks, not new CFD evidence; EvE must
  evaluate the capture, wake, and terminal-state hypothesis after this worker
  exits.
