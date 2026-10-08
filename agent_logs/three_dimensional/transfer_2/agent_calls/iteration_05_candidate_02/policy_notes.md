# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The assigned parent, all four sampled solvers, and the inherited optimizer
  rollouts report direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), no cylinders, and no prewarm. Their translation and
  wakes are self-generated rather than imposed advection.
- Both top-down vorticity and oblique Lambda2 rows were inspected for the
  strongest sampled rollout (`solver_e3aa71fd7b95`) and the contrasting
  globally softened failure (`solver_a1d9e06dfe8a`), then cross-checked
  against metrics, diagnostics, and trajectories. The softened controller
  develops a weaker but coherent wake, curls upward immediately, reaches only
  `8.752L`, and exits the upper edge at `14.911T`. The strong carrier in the
  sampled phase-selective child remains a coherent alternating wake with
  compact three-dimensional structures, so neither absent thrust nor wake
  instability explains its miss.
- Opposing-half-cycle relief is the first sampled steering mechanism to
  produce a meaningfully different useful route. Relative to the curvature-
  release reference (`solver_045019f39c2a`), it improves minimum distance
  from `4.141L` at `20.669T` to `3.033L` at `23.238T`, extends survival from
  `32.197T` to `40.331T`, and changes the physical exit from the lower edge
  `(6.207,0.797)L` to the left edge `(0.797,5.995)L`. At `20T` the lateral
  target offset is reduced from about `3.90L` to `3.05L`. The fish then passes
  the target laterally rather than capturing it, with target offset about
  `(+0.67,+2.96)L` in its body frame at closest approach.
- The assigned parent's symmetric strengthen/weaken phase allocation
  (`solver_6d38e9b1f687`) retains the lower-exit topology and worsens final
  distance to `10.163L`; its small `[0.922,1.078]` allocation therefore does
  not justify replacing the evidenced opposing-only relief with bilateral
  amplitude modulation. The reusable part is the need to put phase steering
  upstream of clipping, not that both half-cycles should be changed.
- Recorded-state reconstruction exposes the remaining semantic fault. In the
  sampled phase-selective child, normalized body-frame route error stays
  strongly positive (`1.125` after clamping) at `22--24T`, but the aggregate
  turn request flips positive because the evaluator's subcycle yaw response
  enters rate feedback. That makes the wrong-polarity curvature release and
  its phase gate fall from near full strength to zero exactly around closest
  approach. The target is still about `3L` to the requested side, so this is
  a route/response channel-confounding failure rather than evidence that the
  route correction has completed.

## Policy hypothesis

Preserve the evaluated phase-selective child's `0.55T/28 deg` posterior-
lagged carrier, geometry-gated curvature release, and opposing-only posterior
relief. Add one compact controller mechanism: derive the sign and persistence
of that phase relief directly from normalized body-frame route geometry, while
leaving fast yaw-rate feedback to the existing direct steering and mean-
curvature channels. The phase branch still turns on only beyond the inherited
off-axis gate, but it no longer disappears merely because a subcycle yaw
sample temporarily reverses the aggregate request. This is a two-timescale
channel separation, not an added mean bend or a scalar gain-only edit.

Expected evidence is the sampled coherent wake and early trajectory through
the onset near `10.6T`, continued targetward phase allocation through the
`22--24T` lateral pass, and either capture or a closer/better-class
termination than the `3.033L` left-exit reference. Falsify the mechanism if it
recreates either immediate upper exit, loses the deep approach or alternating
wake, increases acceleration/load exposure materially, or still passes about
`3L` off-axis without a useful topology change.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual path following over rhythmic locomotion
source_mechanism: separate persistent route error from faster body-response feedback and express the route correction as bounded half-cycle gait asymmetry
transferable_invariant: a slow normalized target-geometry channel should retain route authority until geometric alignment, while fast measured yaw response may damp transients without declaring the route complete
nontransferable_details: published gains, motor timing, clock-driven oscillator phase, species-specific bend envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: use signed body-frame bearing/vector error and the existing off-axis gate to drive opposing-only posterior-wave relief from observed joint phase; keep yaw-rate feedback in the direct steering stack
falsification: reject the transfer if wake coherence or early progress is lost, the upper-exit overturn returns, actuation or loads worsen materially, or the same lateral pass and left exit persist without a closer or semantically better trajectory

## Pre-evaluation checks

- Fixed-state replay over all `7333` sampled phase-selective states leaves the
  action bit-for-bit unchanged until the inherited off-axis gate first opens
  at `10.626T`. Unlike the evaluated child, whose curvature/phase gate falls
  to zero around `22--24T`, the new route phase gate remains fully available
  there because route error is still clamped at `1.125`; only the posterior
  action is changed.
- On that counterfactual fixed trace, exposure to at least one raw command
  beyond `1800 deg/T^2` changes from `93.65%` to `93.60%`, and peak raw
  command remains `112.97 rad/T^2`. Tail-only exposure rises from `55.15%` to
  `57.56%`, so this replay establishes selectivity and unchanged peak, not a
  claim of improved actuator burden; a closed-loop tail-load increase remains
  an explicit falsification risk. Formal CFD is deferred to EvE.
- The lightweight contract and solver editable-boundary checks pass. All `59`
  direct `params.FIELD` references resolve among the `61` returned fields,
  and a `675`-state grid over mirrored target error, yaw rate, and joint state
  is finite. The configured check-runner was invoked but its pinned model is
  unavailable for this account, so its three prescribed non-CFD commands were
  run directly and separately. The guidance check initially exposed and then
  passed after removal of an identical duplicate assigned-parent marker in
  the rendered workspace `README.md`.
