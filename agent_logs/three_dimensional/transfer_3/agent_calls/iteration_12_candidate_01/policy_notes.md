# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, and capture at `25.11852 T`. Three
  coordinated-release rollouts reproduce score `-0.528339` and final distance
  `0.746410 L`; their policy bodies are the v23/v25 parent behavior despite
  comment or version-label differences.
- The combined sheets for the best finite sample and the repeated parent show
  the same useful topology in both rows. The fish self-propels along a broad
  target-directed curve rather than being advected, sheds a coherent
  alternating mid-plane wake with compact oblique Lambda2 structures, and
  finishes in a quiet curved glide/crab into the capture circle. There is no
  collision, boundary exit, wake breakup, or numerical instability. No failed
  rollout is present in this sample set, so the repeated parent is the most
  informative plateau comparator rather than a failure example.
- The sampled crossflow-supported relief first changes commands below about
  `1.594 L`. It preserves the crossing step, horizon, outer wake, inside-`4 L`
  acceleration maxima (`29.605/26.724 rad/T^2`), and force/moment maxima
  (`0.01547/0.00800`), while improving score from `-0.528339` to `-0.528108`
  and final distance from `0.746410 L` to `0.746168 L`. Full-trajectory mean
  distance changes only from `7.444918` to `7.444915 L`, so this is a small
  active tie-breaker, not a new semantic outcome.
- Higher-rated inherited guidance records that yaw-rate-error curvature hold,
  posterior-only release, stacked departure/release logic, and
  convergence-gated extra carrier all regressed. Residual bearing while strong
  lateral closure persists is therefore not sufficient evidence for more yaw
  authority or a joint-role split.

## Policy hypothesis

Preserve the parent's carrier, geometry redirect, closure preview, and coupled
two-joint settled response release exactly. Add one independently active late
mechanism: when normalized body-frame target geometry and relative crossflow
show lateral translation toward the target, closure remains positive, and the
shared bend has settled, relieve a bounded fraction of corrective allocation
for both joints together. The gate is absent outside the late band and cannot
choose turn sign or beat phase. The falsifiable expectation is exact outer-path
and wake preservation with at least the sampled small terminal-distance gain;
reject it if capture is delayed or lost, closure weakens, or saturation,
joint-stop dwell, force/moment peaks, or wake discontinuity returns.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and closed-loop robotic-fish gait modulation
source_mechanism: preserve target-helpful lateral motion instead of reflexively cancelling all crossflow, and modulate an existing gait through sensed state
transferable_invariant: a sign-consistent body-frame lateral response that contributes to target closure can reduce corrective curvature without becoming a route or phase command
nontransferable_details: cylinder-wake geometry, vortex phase, species kinematics, published gains, dimensional frequencies, and task-specific routes
policy_translation: multiply normalized target-side geometry, body-frame relative crossflow, positive closure, late proximity, and settled joint response to relieve the same bounded allocation on both joints
falsification: reject if the gate changes the outer trajectory, slows or loses capture, fails to improve terminal progress, or restores saturation, joint-stop dwell, load spikes, or wake breakup
```
