# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations satisfy the required direct-uniform still-water
  contract (`U_infinity=[0,0,0]`, no cylinders, no prewarm) and remain
  numerically finite. Their termination is `left_domain`, not capture.
- Both rows of every combined keyframe sheet show self-propulsion rather than
  advection: a long southwest trajectory is paired with a coherent alternating
  mid-plane wake and discrete three-dimensional caudal Lambda2 structures. The
  common deficit is route authority. Each fish passes below the target, bends
  into a steep downward track, and exits through the lower boundary near
  `y=0.8L`.
- The assigned prefill's anterior phase-speed residual without posterior
  relief reaches only `4.859L`, has the shortest episode (`28.74T`), and raises
  mean tail acceleration and tail rate-cap occupancy to about `46.25` and
  `12.3%`. Adding a much stronger anterior residual to the posterior-relief
  base reaches `4.018L`, but does not beat the simpler posterior half-stroke
  mechanism and retains the same lower-exit topology. These two results
  falsify further scalar tuning of an anterior acceleration residual as the
  next step.
- Bearing-gated symmetric tail relief reaches `4.233L` at `19.25T`. The
  sampled posterior half-stroke redistribution is the only descendant that
  improves this closest approach, reaching `3.909L` at `19.94T` while keeping
  a coherent wake, similar mean force/moment magnitudes (`0.01053/0.00548`),
  and low tail rate-cap occupancy (`4.8%`). This is a narrow positive result,
  not task success: its bearing is still `1.410 rad` at closest approach,
  peaks near `1.512 rad`, distance then increases, and the fish exits low at
  `9.261L`.
- Inherited logs explain the sign of that result: during large bearing, the
  posterior stroke associated with motion into the requested anterior bend
  has desired-sign instantaneous yaw, while the return stroke largely cancels
  it. The sampled redistribution only scales the centered posterior carrier
  to about `0.65` on the useful stroke and `0.05` on the return stroke at full
  gate. Its improvement without a load or saturation regression supports
  testing the duty-ratio invariant more cleanly, while earlier shared or
  tail-biased static means and yaw-response unloading remain falsified.
- A proposed bearing-trend lead was checked and rejected before coding.
  `bearing_window_rate` spans only seven solver steps and oscillates at the
  beat scale (roughly `-3` to `+3 rad/T` in representative samples), so it is
  not the slow route signal needed to anticipate the miss.

## One candidate hypothesis

Start from the evidence-leading anterior mean-curvature controller and keep
its slip-aware body-frame route request, centered posterior lag, and
large-bearing smooth gate. Replace partial posterior amplitude redistribution
with a continuous duty-ratio handoff: at small bearing the full symmetric
traveling carrier remains; at large bearing the target-turning half-stroke
retains full posterior authority while only the cancelling return half-stroke
is smoothly suppressed. Joint-1 rate supplies observable gait phase, and
geometric bearing supplies the reflection-equivariant turn side. No steering
mean is inserted into the posterior target.

This tests whether the positive `3.909L` result was limited by weakening the
useful stroke along with the cancelling stroke. The expected semantic change
is stronger sustained target-signed yaw before the fish passes below the
target, without the high tail saturation of the anterior-residual prefill.
Reject the mechanism if it loses the `3.909L` closest-approach benchmark,
collapses or disorders the alternating 3D wake, materially increases tail
rate/acceleration saturation or hydrodynamic loads, or preserves the same
large-bearing lower-boundary exit without a stronger mean turn.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: preserve propulsive authority on the turn-producing half-cycle while suppressing the hydrodynamically cancelling return half-cycle
transferable_invariant: observed gait phase and target-relative turn side can redistribute a zero-mean rhythmic actuator across half-strokes to create net yaw without imposing a static posterior bend
nontransferable_details: published gains, clock-driven CPG phase, robot linkage geometry, species-specific kinematics, exact vortex phase, dimensional frequency, and task-specific routes
policy_translation: use normalized joint-1 rate and bounded body-frame bearing to retain the full centered posterior carrier on the requested half-stroke and smoothly gate off only its return stroke as bearing grows
falsification: reject if closest approach does not beat 3.909L, the alternating wake degrades, saturation or loads materially rise, or large bearing and the lower-exit topology remain
