# Wake-policy candidate diagnosis

## Evidence diagnosis before the edit

- All four sampled rollouts are contract-valid direct-uniform still water:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and an inertial moving
  window. Their visible motion and wakes therefore come from self-propulsion,
  not background advection.
- The strongest finite sample is the anterior half-cycle policy
  `solver_0334e73ca6df`. Its top-down row shows a persistent alternating
  reverse-street-like wake and strong leftward translation; its oblique row
  confirms a coherent three-dimensional caudal Lambda2 trail through `39T`.
  It changes the failure topology materially: compared with the naive
  carrier's upper exit at `8.547T` and `12.078L` minimum distance, it survives
  to `39.088T` and reaches `5.156L` at `25.036T`.
- That rollout is not yet target controlled. In the top-down sheet the target
  marker migrates from lower-left, to nearly below the fish at `23T`, to
  lower-right after the fish passes its target-aligned x station, while the
  body and wake remain nearly horizontal. The trace agrees: the center moves
  from `(21.000,14.000)L` to `(9.403,14.678)L` at closest approach and then
  leaves the left boundary at `(0.797,14.961)L`; final distance regresses to
  `10.235L`.
- The strong policy's instantaneous `heading_rate` is dominated by the
  propulsive cycle rather than slow course response: after `2T`, its
  correlation with anterior joint velocity is `-0.935`. Reconstructing the
  policy from the trace shows its turn selector agrees with the sign of
  `phi_dot[1]` on `90.3%` of samples and has magnitude above `0.9` on `78.0%`.
  Thus the heading-rate term selects and energizes both alternating
  half-strokes instead of cleanly closing slow yaw. Consistently, at least one
  joint speed sits near the `260 deg/T` cap on `50.1%` of samples and the
  anterior angle reaches `45 deg`, even though the explicit acceleration
  command stays below `1800 deg/T^2`.
- The other sampled mechanisms supply useful negative controls. Tail-only
  mean curvature (`solver_3a74301ccb21`) and posterior half-cycle asymmetry
  closed on recent yaw (`solver_28659f83df74`) remain clear of sampled speed
  and acceleration limits, but both retain the tight upper-exit topology near
  `9T` and finish farther away (`13.084L` and `13.263L`). The inherited notes
  likewise report that repeated static mean-bend variants did not reverse yaw
  after bearing crossed zero. Therefore another mean-curvature or
  posterior-only gain search is not supported.

## Policy hypothesis

Preserve the only sampled mechanism that produced sustained translation: a
sub-limit joint-state oscillator, lagged posterior follower, and anterior
phase-gated half-cycle steering. Replace raw instantaneous yaw-rate closure
with a normalized course error formed from the cross product of body-frame
velocity and body-frame target vectors. This rotation-invariant signal asks
whether the observed translational path passes to one side of the target; it
directly exposes the strong rollout's persistent upward-left velocity while
the target remains below. Blend continuously back to body-frame bearing when
speed is small, when course direction is not yet observable. A soft
joint-angle headroom reduces steering injection near the sampled amplitude
limit without imposing a static curvature.

Expected result: once self-propulsion develops, the strong positive
target-versus-course error should favor the opposite anterior half-stroke,
rotate the velocity vector downward toward the target, and keep the target
marker near the wake centerline instead of letting it pass underneath. The
alternating posterior wake should remain coherent, while joint-speed occupancy
should fall materially below `50.1%`. Falsify the mechanism if the rollout
again travels nearly horizontally past the target station, returns to the
near-`9T` upper exit, loses the coherent traveling wake, or still spends
material time at angle or speed limits.

bookshelf_consulted: true
source_domain: robotic-fish sensor-feedback direction tracking with asymmetric flapping
source_mechanism: bounded target-error modulation of the turn-useful gait half-cycle while a phase-lagged posterior wave supplies propulsion
transferable_invariant: compare observed swimming course with target direction and allocate steering authority to one compatible half-stroke without erasing the traveling propulsive rhythm
nontransferable_details: published gains, robot linkage geometry, clock-driven CPG phase, species-specific amplitude envelopes, exact vortex phase, and task-specific routes
policy_translation: blend normalized body-frame bearing with the normalized cross product of body-frame velocity and target vectors, infer half-cycle from anterior joint velocity, and gate bounded anterior acceleration by remaining joint-angle headroom while retaining the posterior state-feedback lag
falsification: reject if course error stays one-signed while the fish passes laterally by the target, if the same upper or left exit occurs without improved minimum distance, if alternating wake coherence collapses, or if angle and speed saturation remain material
