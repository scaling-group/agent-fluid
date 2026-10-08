# Identity-windowed joint-speed viability candidate

## Evidence and visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the direct uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, and no prewarm. All terminate
  in capture. The paired `16.943T` high-knee soft-envelope sheets are the best
  finite examples, while the `18.276T` unsmoothed stopping-barrier sheet is the
  informative high-effort comparison. In both, the top-down row shows a
  sustained alternating vorticity street from release through the curved
  target approach. The oblique row shows compact three-dimensional Lambda2
  structures shed behind the caudal region through capture. The fish is
  self-propelled rather than advected: peak body speed is `1.393U` for the
  soft-envelope policy and `1.329U` for the unsmoothed comparison, whereas
  peak local flow is only `0.0325U` and `0.0315U`.
- The evaluated soft acceleration shoulder is the route and wake baseline. It
  captures at `16.943T`, has `2.090L` mean distance, keeps posterior angle
  within `33.85 deg`, returns both accelerations below `1710 deg/T^2`, and
  limits planar-force/yaw-moment peaks to `0.03609/0.01766`. Its remaining
  mechanical defect is exact `260 deg/T` contact on both joints for about
  `3.80/3.57%` of samples. Those contacts occur throughout the broad route
  (the first is near `7.05T` and `10.94L`), not inside the final `1L`, so
  terminal drive relief would address the wrong regime and would risk the
  already demonstrated capture.
- The sampled two-joint class-K speed barrier is the useful safety contrast.
  It preserves the alternating three-dimensional wake and capture, removes
  both speed-limit contacts, keeps peak joint speeds below
  `251.92/253.18 deg/T`, and holds peak force/moment at `0.03591/0.01768`
  (slightly lower force and effectively unchanged moment relative to the soft
  envelope), while retaining sub-limit acceleration requests. It is also
  measurably intrusive:
  capture moves to `17.435T`, mean distance to `2.111L`, and replaying its
  ceiling on the soft-envelope trace shows that it can alter outward commands
  from speed fractions as low as `0.836`, across 588 joint-samples. This is a
  mechanical improvement with a route-performance cost, not evidence to
  discard joint-speed feedback.
- The assigned-parent scalar history contains two repeated captures, the
  high-knee soft-envelope capture, and an uncharacterized left exit whose best
  distance was `5.621L`. Because the failed policy and wake diagnostics are
  absent, that inherited failure supports a conservative single-mechanism
  edit but does not identify a speed-controller cause.

## Single-candidate policy hypothesis

Preserve the complete evaluated soft-envelope controller: full-quadrant
body-frame target/course feedback, zero-centered anterior state oscillator,
posterior traveling lag, steering-reserve allocation, high-knee acceleration
shoulder, and posterior stopping-margin projection. Replace the sampled
always-active joint-speed ceiling with one C1 identity-windowed class-K
viability projection on both returned accelerations. Below `0.94` of the
owned speed envelope it is exactly the identity. Between that evidence-set
onset and the sampled `0.98` buffered speed boundary, a smoothstep blends from
the full acceleration envelope to the velocity-margin ceiling; braking and
low-speed carrier dynamics pass unchanged. This is an actuator feedback
mechanism, not a carrier-gain change or a target-distance mode.

The `0.94--0.98` transition spans about `10.4 deg/T`, approximately one
maximum-acceleration integration increment in the sampled traces. A static
replay on the captured soft-envelope states changes 377 joint-samples rather
than the unwindowed barrier's 588 and leaves commands unchanged below a
`0.954` speed fraction; this replay is a falsifiable fixed-state prediction,
not a claim about the unevaluated CFD trajectory. The expected rollout retains
capture, alternating shedding, sub-limit acceleration, and the broad route
while eliminating exact speed-limit occupancy with less arrival penalty than
the sampled unwindowed barrier. Reject the candidate if it loses capture,
changes the wake topology, contacts either speed or angle limit, exceeds the
`0.0361/0.0177` load reference, or fails to improve materially on the
unwindowed barrier's `17.435T/2.111L` route cost.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and classical reactive swimming
source_mechanism: bounded sensor feedback preserves a phase-coherent traveling carrier while intervening only near an observed actuator viability boundary
transferable_invariant: retain the productive low-dimensional rhythm over an identity region and continuously project only joint motion that approaches a normalized physical limit
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body wave envelopes, clock phase, exact vortex phase, linkage geometry, and task-specific routes
policy_translation: keep body-frame target_body_L and velocity_body_U course feedback plus joint-state phase; blend each assembled acceleration from identity to a class-K joint-speed margin ceiling only within a normalized high-speed risk window, downstream of the evidenced carrier and angle protection
falsification: reject if capture or alternating three-dimensional shedding is lost, either joint reaches its speed or angle boundary, load peaks rise above the soft-envelope reference, or route cost does not improve over the sampled unwindowed speed barrier
```
