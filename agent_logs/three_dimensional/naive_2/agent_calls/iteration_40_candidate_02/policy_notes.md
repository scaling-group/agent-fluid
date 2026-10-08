# Evidence-preserving multi-wake target-policy candidate

## Visual diagnosis before candidate selection

- The assigned parent and all four sampled solvers contain the same policy
  (`452903db...9781`), trajectory CSV, combined keyframe sheet, top-down
  sheet, and oblique sheet byte-for-byte. Each is a direct-uniform still-water
  rollout with no cylinders or prewarm. Each captures at `16.604496T` after
  237 moving-window shifts, crosses at `0.743958L`, has `1.998146L` scored
  distance integral, and scores `-0.113729`. These are deterministic replicas
  of one physical trajectory, not four mechanism comparisons.
- I inspected the shared visual evidence from release through capture. The
  top-down row shows left/down target progress under the fish's own motion and
  an alternating red/blue wake continuously connected to the posterior body.
  The oblique row shows finite three-dimensional Lambda2 structures attached
  to the tail and traveled path through the target crossing. With zero ambient
  velocity this is self-propulsion, not advection. Neither view shows wake
  breakup, a recentering discontinuity, collision, boundary exit, or numerical
  instability.
- The diagnostics agree with the visual reading. Distance falls from
  `12.327720L` to capture; peak planar force components and moment are
  `0.023226/0.029013` and `0.018356`, while both joint speeds touch the
  released `4.537856 rad/T` envelope without loss of the route. Across 3018
  trajectory increments, all 56 momentary distance increases are confined to
  two startup intervals (`0.2915--0.5005T` and `0.9460--1.0340T`), totaling
  only `0.002595L`. None of the 2919 trailing `0.55T` carrier-period windows
  recedes; their worst distance change is still `-0.001398L`. Thus neither
  beat-scale nor post-startup closure supplies a deficit for another terminal
  or disturbance channel.
- No distinct failed visual artifact is present in the supplied sampled or
  inherited files. The closest controlled negative comparison preserved in
  the parent and optimizer notes is closure-qualified yaw-response release:
  it crossed one integration step earlier but regressed to a shallower
  `0.744276L` crossing, `1.998380L` distance integral, and `-0.114037` score
  without a meaningful feasibility or load benefit. Line-of-sight-rate,
  bearing, moment, local-flow, and other terminal descendants likewise did not
  provide a surviving improvement.

## Sole candidate and falsifiable policy hypothesis

Retain `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as this workspace's sole candidate. It keeps the demonstrated
posterior-lagged full-wave carrier, raw target geometry, mean-preserving yaw
and lateral-response demodulation, bounded phase-compatible posterior
steering, smooth acceleration limit, and narrow one-sided speed guard. Three
or more completed iterations without a new mechanism or semantic improvement
triggered the bookshelf review, but the current evidence identifies no
noncapturing route, wake, feasibility, or load error. Adding a scalar change,
terminal gate, or unobserved residual would confound exact nominal replication
with a new mechanism.

Expected result: reproduce capture, the shallow crossing arc, distance cost,
crossing depth, connected two-view wake, joint feasibility, and load envelope.
Falsify preservation if this nominal envelope fails to reproduce. Reopen one
compact bounded primitive only when a completed nonduplicate or held-out pose,
target, inflow, or imposed-wake rollout exposes a persistent body-frame error.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction control
source_mechanism: preserve a posterior-emphasized traveling carrier and recruit a separate bounded feedback residual only for an observed directional or disturbance deficit
transferable_invariant: separate productive beat-scale motion from persistent route error before changing the carrier or adding steering authority
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed schedules, world-frame coordinates, and task-specific routes
policy_translation: null translation; retain the normalized two-joint response-demodulated controller because every supplied physical rollout captures with carrier-period closure and completed residual or terminal additions regress
falsification: test one bounded state-feedback primitive only after nonduplicate evidence isolates its error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All performance claims above belong to completed sampled or inherited
rollouts. The retained candidate receives formal CFD evaluation only after
this worker exits; no same-worker result or held-out robustness is claimed.
