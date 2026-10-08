# Error-qualified far/middle line-of-sight route residual

## Visual and quantitative diagnosis before the policy edit

- All four sampled evaluations and the inherited terminal posterior-relief
  evaluation satisfy the frozen flow contract: direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no prewarm snapshot, no cylinders,
  and capture termination. No true failure rollout is present in the current
  sample, so the weakest-scoring capture and inherited terminal experiment are
  used as negative controls alongside the strongest capture.
- I inspected both the top-down mid-plane row and oblique Lambda2 row in the
  combined sheets for the assigned posterior-priority parent, the strongest
  line-of-sight sample, the weakest terminal-load sample, and the inherited
  posterior-relief rollout. All are self-propelled from quiescent water and
  shed a coherent alternating wake with compact three-dimensional posterior
  structures through capture. None shows passive advection, wake breakup,
  collision, or out-of-plane instability. Their visible wake topology is
  essentially unchanged; route timing and terminal state are the useful
  discriminants.
- The assigned parent captures at `17.8585T`, score `-0.09355786`, mean
  distance `1.980025L`, center path `12.8148L`, and maximum straight-line
  cross-track `0.5347L`. It reaches the `2.1L` approach boundary with only
  `0.010L` cross-track, but its fast posterior-priority gait is tangential at
  capture: approach mean course alignment is `0.870`, capture alignment is
  `0.374`, capture speed is `0.900U`, and capture yaw is `-3.078 rad/T`.
- Three independent terminal-only interventions do not improve that parent.
  Direct course correction scores `-0.09460147`; tail-rate/closing-conditioned
  load relief scores `-0.09585435`; and the inherited blend from `7/6` toward
  neutral posterior gain scores `-0.09547201`. They retain nearly identical
  paths and wakes and modestly improve capture alignment to `0.385`, `0.394`,
  and `0.414`, respectively, but all worsen mean distance. The inherited blend
  reduces terminal tail acceleration-ceiling residence only from `72.48%` to
  `71.25%`. This is evidence against another near-target drive or steering
  adjustment as the present mechanism.
- The sampled co-windowed line-of-sight residual is the only score-positive
  child: score improves to `-0.08710319` and mean distance to `1.973290L`.
  Its early route reaches `4L` at `13.723T` rather than `13.833T`, with
  `0.093L` rather than `0.342L` cross-track. But the unqualified correction
  crosses the direct route and remains influential too long: at entry to
  `2.1L`, cross-track is `0.206L` instead of `0.010L`; center path rises to
  `12.9663L`, approach alignment falls to `0.814`, and capture alignment falls
  to `0.113` with `0.924U` speed and `-3.153 rad/T` yaw. The scalar gain is not
  a generally positive lesson even though the score improves.

## One policy hypothesis

Preserve the parent's measured odd target-to-curvature polarity, anterior
phase-plane envelope, posterior lag and emphasis, cadence, half-cycle steering,
and reversal-preserving rate governor. Add one route-observer mechanism from
the score-positive sample, but qualify its authority by current body-frame
target error and control regime: compute inertial line-of-sight drift as the
co-windowed difference between recent body turn rate and target-bearing rate;
fade the bounded odd correction to zero as bearing/vector error centers; and
also fade it completely before the established `2.1L` approach controller.
This is a feedback-structure change, not scalar-only gain tuning. It uses no
clock, coordinate, case identity, mutable state, or memorized route.

Expected evidence is the sampled residual's earlier far/middle progress without
its route crossing and tangential terminal degradation: retain capture near the
parent's `17.9T` scale, parent-like approach alignment/path/load, and the
coherent two-view posterior wake while improving distance integral. Falsify the
mechanism if the residual remains active with a centered target, if cross-track
still grows after the `4L` milestone, if approach/capture state or actuator
load worsens materially, or if the early score/distance benefit disappears.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical far/middle/near swimming control decomposition
source_mechanism: keep a propulsive traveling-wave carrier separate from a bounded target-relative route correction whose authority requires observable direction error
transferable_invariant: a drift observer may correct the route only while normalized body-frame target error remains and must release before a separately validated terminal controller takes authority
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, transition distances from other tasks, and prescribed routes
policy_translation: subtract co-windowed bearing rate from recent turn rate, pass the odd residual through current bearing/vector-error and far/middle distance gates, and feed it into the existing two-joint curvature path without changing the carrier
falsification: reject if early distance progress is not retained, if route crossing or terminal alignment/load worsens, if reflection symmetry or capture is lost, or if either visual view loses the coherent posteriorly lagged wake
