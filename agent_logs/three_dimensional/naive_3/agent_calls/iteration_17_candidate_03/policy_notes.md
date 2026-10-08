# Moment-responsive terminal half-cycle candidate

## Visual diagnosis and completed evidence

- Every sampled solver and inherited assigned-parent rollout reports direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. The inspected combined sheets show controller-generated
  motion: both the top-down vorticity rows and oblique Lambda2 rows retain an
  alternating three-dimensional wake rather than passive moving-window
  advection.
- The `2.989L` response-released sampled solver is the strongest useful
  sampled failure. Its top-down row shows a persistent alternating street and
  its oblique row shows coherent three-dimensional structures through the
  approach; peak swimming speed is `1.032U` while peak local flow is only
  `0.032U`. It nevertheless hooks above the target and exits left, so the
  useful carrier is not sufficient steering.
- The `4.859L` anterior stiffness-asymmetry sample is the informative visual
  failure. It still sheds alternately in both views, but peak speed falls to
  `0.947U` and raw acceleration-envelope exceedance rises to about
  `53/64%` for joints 1/2. This rejects an ungated anterior stiffness
  asymmetry around the older bearing-minus-slip observation.
- The assigned parent's phase-sway cancellation is a completed negative
  observation test. Its two visual rows retain a strong alternating wake, but
  closest approach regresses to `4.459L` from the inherited raw
  velocity-course controller's `0.857L`; peak speed drops from `1.052U` to
  `0.902U`, and raw acceleration exceedance remains high at about
  `54/67%`. The fitted `0.11*phi_dot1` term removed the beat-correlated
  course variation that offline replay labeled as sway, yet closed-loop
  steering and trajectory topology became much worse. A single-trajectory
  velocity/joint-rate correlation is therefore not a valid causal
  cancellation law here.
- Inherited evaluated logs still support the unmodified body-frame
  target-ray/velocity-course signal: it is the only observation change that
  moved the repeated `2.96--2.99L` upper-hook floor to a `0.857L` left-exit
  tangent pass while keeping the coherent wake. Terminal posterior curvature,
  carrier relief, and both signs of a static anterior center shift reached
  only about `0.832--0.876L`, with the posterior channel approaching its
  angle stop.
- The inherited `4--19T` near-miss trace gives a bounded hydrodynamic
  calibration for a different phase signal: normalized yaw moment ranges
  roughly `-0.019--0.017` and correlates `0.918` with anterior angle. A
  sampled optimizer continuation using anterior angle as a fixed moment proxy
  preserved the broad approach and reached `0.834L` without exhausting
  anterior angle margin, but did not capture. This supports testing measured
  response in place of another fixed phase assumption, not increasing a
  carrier gain.

## Policy hypothesis written before the solver edit

Restore the demonstrated raw velocity-course controller exactly in the broad
approach: full-quadrant normalized target geometry, measured body-frame
velocity, speed blending, the zero-centered anterior oscillator, the
`12 deg` posterior mean-curvature cap, and the complete lagged posterior
carrier. Remove the failed joint-rate velocity cancellation and do not restore
the posterior terminal-curvature schedule.

Inside `4L`, only while wrapped course error is materially unresolved, use
the normalized measured yaw moment as a bounded hydrodynamic phase-response
signal. Desired yaw has sign opposite the bounded turn request. Decrease
anterior restoring stiffness while moment is aligned with that desired yaw,
and increase stiffness while moment opposes it. This should lengthen the
target-useful response and shorten the counter-response without moving the
oscillator center, attenuating the posterior carrier, copying an exact phase,
or imposing a route. Distance and alignment gates make the allocation vanish
in the broad approach.

The falsifiable expectation is reproduction of the coherent sub-`1L`
approach, followed by a measured target-signed moment imbalance that lowers
the tangent miss below the prior `0.832--0.857L` band without raising the
posterior curvature cap. Reject the mechanism if it loses the alternating 3D
wake, repeats the `4.459L` regression or an upper exit, materially raises
anterior limit occupancy, or preserves the same left-exit tangent topology
without improving closest distance.

```text
bookshelf_consulted: true
source_domain: asymmetric robotic-fish CPG turning and hydrodynamic load-responsive fish control
source_mechanism: allocate half-cycle duration or restoring work according to whether measured yaw response aids or opposes the target-requested turn while retaining the traveling carrier
transferable_invariant: preserve the propulsive rhythm and use bounded measured response to prolong target-useful corrective work and shorten counter-target work
nontransferable_details: published gains and duty ratios, species-specific kinematics, robot linkage geometry, dimensional cadence, exact vortex phase, fixed target geometry, and task-specific routes
policy_translation: retain normalized body-frame target-ray versus raw velocity-course feedback; near the target and at large wrapped course error, combine the bounded turn request with normalized measured moment_z_L2 to modulate zero-centered anterior restoring stiffness while leaving posterior curvature and lag unchanged
falsification: reject if the inherited sub-1L approach or alternating 3D wake is lost, limit occupancy rises materially, the measured moment allocation has no target-signed effect, or closest distance and termination topology do not improve
```
