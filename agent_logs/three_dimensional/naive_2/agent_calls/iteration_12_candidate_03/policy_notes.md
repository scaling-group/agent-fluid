# Closure-gated yaw-response candidate

## Visual and metric diagnosis before the edit

- All sampled and inherited completed evaluations use direct-uniform still
  water with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. In the
  combined sheets, the top-down rows develop alternating vortex streets and
  the oblique rows retain tail-connected three-dimensional Lambda2 structures.
  The fish are self-propelled, and none of the failures follows wake collapse
  or numerical instability.
- The four assigned samples share an upper-exit trajectory despite different
  approach schedules. The assigned parent reaches `4.162L` at `17.51T` and
  recedes to `6.363L` by its `23.36T` exit. Distance relief reaches `5.126L`,
  course-gated posterior half-cycle relief `5.000L`, and signed-agreement
  half-cycle relief `4.743L`; their visual wake organization remains similar.
  Repeated relief scheduling therefore does not create the missing route
  response by itself.
- The inherited direct `velocity x target` plus
  `desired_yaw - measured_yaw` servo is a completed negative result, not an
  untested algebraic fix. It preserved the wake but reached only `6.850L` and
  exited at `15.68T`, earlier and farther from the target than all four assigned
  samples. Body-positive `x`, bearing, posterior curvature, and physical yaw
  cannot be assigned textbook signs independently.
- The later actuator-calibrated response controller is a semantic improvement.
  It retains the empirical `target x velocity` actuator-coordinate residual,
  maps posterior turn request to opposite-sign desired physical yaw, and
  reaches `2.299L` at `18.41T`, versus the assigned parent's `4.162L`. Its
  top-down row shows a much deeper targetward arc, while the oblique row keeps
  the alternating three-dimensional wake. Reconstructed near-limit action
  residence falls to about `55.0%`, with peak planar force about `0.034` and
  peak yaw moment about `0.017`, within the sampled ranges.
- That improved route still lacks terminal recovery. At closest approach it is
  already losing closure (about `-0.33U` instantaneously), is `2.299L` away,
  and carries about `0.78U` of speed. It crosses past the target in `x`,
  recedes to `8.092L`, and exits high at `28.41T`. The final visual frames show
  a large late turn with an intact wake rather than a capture maneuver.

## Single policy hypothesis

Use the inherited actuator-calibrated yaw-response controller as the route
mechanism, including its full anterior oscillator, bounded posterior mean,
approach-aware anterior redistribution, state-derived posterior lag, and
phase-compatible half-cycle attenuation. Add only the assigned parent's
closure-conditioned terminal separation: while distance is small and measured
closure is lost, reduce the oscillatory posterior wave continuously toward a
nonzero floor, but leave anterior propulsion and the posterior steering mean
outside that gate. While closure is positive, the new gate is effectively
silent, so the completed `2.299L` approach mechanism is preserved.

This is a small mechanism combination, not scalar-only gain tuning. The route
servo supplies the previously demonstrated targetward trajectory; the terminal
gate removes only excess posterior oscillation after that trajectory stops
closing, so bounded mean curvature can redirect without coasting completely.
Replaying the complete scale algebra on the completed yaw-response history
leaves the pre-existing half-cycle scale unchanged at `16T` (`0.886` at
`3.262L`, strong positive closure), changes it only from `0.919` to `0.874` at
`18T`, then from `0.782` to `0.634` at the `18.41T` minimum. Once recession is
established, it changes `0.682` to `0.490` at `19T` and `0.980` to `0.545` at
`20T`. This audit checks scheduling and bounds only; it is not a counterfactual
CFD claim.

Expected result: preserve the deeper targetward arc and connected alternating
wake through the old minimum, then reduce overshoot enough to re-establish
closure or make a tighter targetward turn instead of repeating the long upper
recession. Falsify the combination if it degrades the `2.299L` approach before
closure loss, collapses the carrier, materially exceeds the inherited load or
saturation ranges, or still exits high without a re-approach or a meaningfully
smaller recession.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish rhythmic steering
source_mechanism: preserve the propulsive rhythm during target-directed transit, then separate steering authority from excess oscillatory drive when measured approach is lost
transferable_invariant: schedule a bounded change from normalized body-frame distance and closure while keeping route feedback and the state-derived traveling-wave carrier in distinct channels
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, prescribed maneuver timing, exact vortex phase, and task-specific routes
policy_translation: retain the two-joint actuator-calibrated yaw-response route controller; only after proximity and closure deficit agree, reduce the posterior oscillatory wave toward a nonzero floor while preserving anterior oscillation and posterior mean curvature
falsification: reject if the completed 2.299L route is perturbed before closure loss, wake organization or loads degrade, or terminal recession and upper-exit topology remain materially unchanged

## Evaluation boundary

No CFD result is claimed for this candidate. The later evaluation should first
compare capture and termination class, then minimum distance, any re-approach,
post-minimum recession, speed and closure, acceleration residence, force and
moment peaks, and both wake views.
