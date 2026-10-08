# Gait-demodulated approach feedback on the yaw-power parent

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled scores,
  observations, metrics, diagnostics, trajectories, and policies, plus the
  inherited optimizer notes. Every sampled episode uses direct uniform still
  water with `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture
  termination. The two `-0.064599` v12 samples are exact-policy repeats, so
  they are determinism evidence rather than distinct mechanisms.
- I inspected the combined keyframe sheets for the best finite parent v20 and
  the informative v16 terminal-allocation comparator, including both the
  top-down vorticity row and oblique Lambda2 row from release through capture.
  Both visibly self-propel from rest, retain a coherent alternating wake and
  compact three-dimensional posterior structures, and show no passive
  advection, boundary interaction, wake breakup, or out-of-plane instability.
  The unresolved distinction is terminal course response, not propulsion or
  gross wake topology.
- The assigned v20 parent is the sampled scalar leader: versus v16 it improves
  arrival from `18.0235T` to `18.0070T`, mean distance from `1.950801L` to
  `1.950358L`, and score from `-0.064545` to `-0.064028`. Inherited completed
  diagnostics show that this gain does not survive as a terminal-control
  lesson: final alignment falls from `0.1818` to `0.1092`, absolute final yaw
  rises from `0.4200` to `0.9840 rad/T`, head cross-track rises from
  `0.7232L` to `0.7317L`, and near posterior acceleration-ceiling residence
  rises to `75.83%`. Instantaneous raw yaw-power selection therefore preserved
  closure while losing the damping/alignment benefit it was intended to keep.
- The inherited phase audit supplies a measured explanation. Across v16, v19,
  v20, and v21, normalized anterior angle and rate explain `99.0%--99.1%` of
  raw yaw-rate variance with stable coefficients, leaving only about
  `0.20 rad/T` residual RMS versus about `2.05 rad/T` raw. Replaying that
  observer on the sampled v20 trajectory gives `2.1696 rad/T` raw and
  `0.1912 rad/T` residual RMS inside `2.10L`. Prior course/yaw-rate variants
  all closed feedback on the raw, phase-dominated quantity and regressed
  terminal alignment/yaw, so another scalar rate gain is not supported.

## Single policy hypothesis

Preserve the evaluated v20 parent's state-feedback oscillator, posterior lag
and emphasis, phase-consistent work reserve, odd body-frame target-to-curvature
map, route controller, yaw-power-selective posterior relief, conserved
longitudinal mean-bend allocation, half-cycle steering, and reversal-preserving
rate governor. Add one observer mechanism to the existing target-yaw-rate
feedback: estimate the fast carrier-locked yaw component from normalized
anterior joint angle and rate, subtract it from measured recent yaw, and blend
from the raw measurement at the `2.10L` approach boundary to the residual near
capture. Use the blended value only in the existing `target_turn_rate -
measured_rate` channel; keep raw yaw in the sampled parent selector, route
brakes, and allocation gates so the rollout isolates the observer.

This is exactly inactive outside approach and is odd under lateral reflection
because joint angle, joint rate, measured yaw, the estimate, and the residual
all change sign. Expected evidence is exact v20 far/middle behavior and the
same coherent two-view wake, retained capture and distance-integral advantage,
but a terminal steering correction that no longer reverses with the carrier
half-cycle. Falsify if pre-approach action changes, capture or score regresses
materially, final alignment and yaw do not improve together, actuator pressure
rises or migrates, the phase residual fails under reflection, or either wake
row deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction control and terminal capture
source_mechanism: separate fast carrier-phase body motion from slower directional response before closing steering feedback
transferable_invariant: preserve the posterior traveling wave while feeding back a body-frame yaw residual with the predictable joint-phase component removed
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phase, full-body joint distributions, world coordinates, capture routes, and task-specific schedules
policy_translation: normalize anterior joint angle and rate by the policy-owned envelope and cadence, subtract their sampled phase-locked yaw estimate from measured recent yaw, and blend that residual into only the existing approach rate-error channel
falsification: reject if transit changes, capture or distance integral worsens, terminal yaw and alignment do not improve jointly, loads or limit residence rise, lateral reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The mandated check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported by this account. Running its immutable checks directly found
  and repaired a duplicated assigned-parent marker in the rendered workspace
  `README.md`; the guidance materiality check then passed. The solver boundary
  check also passes with `candidate_target_policy.jl` as the only solver
  difference.
- Julia is not installed or discoverable, so the executable include/action
  probe could not run. Static checks find one definition of each public
  function, `66` direct `params.FIELD` references all present in the `68`
  returned fields, balanced delimiters, one nonempty candidate file, and no
  explicit time, step, randomness, file I/O, cylinder coordinate, or
  world-route state input.
- Offline replay of only the observer on the completed v20 trace changes none
  of the `2,881` samples at or beyond `2.10L`. Across the `393` approach
  samples, raw/residual/blended yaw RMS is
  `2.1696/0.1912/1.4710 rad/T`; at capture the feedback measurement changes
  from `-0.9840` to `-0.4120 rad/T`. Simultaneously reflecting yaw, anterior
  angle, and anterior rate gives zero numerical oddness error across the
  trace. These are schema, activation, and symmetry checks, not CFD evidence;
  the capture, wake, and terminal-response hypothesis remains for EvE to test.
