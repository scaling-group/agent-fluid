# Posterior joint-envelope braking candidate

## Visual diagnosis and completed evidence

- All four sampled solver rollouts and the assigned parent's inherited
  rollouts report direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their translation and
  wakes are controller-generated rather than ambient advection or
  moving-window transport.
- The sampled capture is the strong finite example. Its top-down row shows a
  coherent alternating vorticity street throughout the approach, and its
  oblique row shows persistent three-dimensional Lambda2 structures behind a
  visibly undulating, self-propelled fish. It captures at `18.265T` and
  `0.749826L`; peak body speed is `1.329U`, versus only `0.032U` peak local
  flow. This is the first completed terminal success in the inherited
  sequence and supports preserving its target-ray/velocity-course observation
  and posterior acceleration-reserve mechanism.
- The sampled `3.592L` approach-hold failure is the most informative visual
  contrast. Both views show its initially coherent wake weakening as the
  joints settle, after which the path turns away and exits the left boundary.
  The `4.859L` anterior half-cycle case and `4.459L` phase-compensated-course
  case retain alternating wakes but do not acquire the capture trajectory.
  These failures agree with the inherited negative controls: carrier-wide
  relief, anterior stiffness/asymmetric-center edits, posterior phase
  selectors, and scalar curvature escalation did not improve termination.
- The successful acceleration allocation materially reduces raw posterior
  acceleration exceedance from about `67.5%` in the inherited `0.857L`
  velocity-course near miss to `46.4%`, and mean absolute raw posterior
  acceleration falls from `46.77` to `34.78 rad/T^2`. It also changes the
  repeated `0.834--0.876L` left-exit plateau into capture, so another steering
  authority increase is not the next missing mechanism.
- The capture nevertheless ends against the posterior angle envelope. From
  `18.199T` onward the posterior angle exceeds `44 deg`; at `18.210T` it hits
  `-45 deg` with outward velocity near `-1.97 rad/T`, which the episode
  integrator resets abruptly to zero. The immediately following trace sample
  contains coincident force and yaw-moment peaks of `0.208` and `0.0928`,
  roughly five times the inherited near-miss maxima (`0.037` and `0.0191`).
  Capture occurs only `0.055T` later. The visible terminal arc and these
  synchronized state/load diagnostics identify a hard-stop transient, not a
  need for more drive or curvature.

## Policy hypothesis written before the solver edit

Preserve the captured controller's full-quadrant normalized target ray,
measured body-frame velocity course, zero-centered anterior oscillator,
posterior lag, damping, nominal curvature, distance-conditioned acceleration
reserve, and physical actuator limits. Add one posterior joint-envelope
braking mechanism. When posterior velocity points toward a hard angle limit,
compute the remaining normalized angular margin and smoothly restrict the
outward acceleration as that margin enters an `8 deg` guard band; near the
boundary, require inward braking bounded by the existing acceleration limit.
The guard is inactive when motion is inward or the joint is outside the guard
band, so it does not impose a clocked stage, static bend, new route, or broad
carrier relief.

The expected signature is the demonstrated broad course and alternating wake,
followed by capture without posterior hard-limit contact and without the
single-sample terminal force/moment spike. Falsify the mechanism if it loses
capture or the sub-`1L` approach, changes the broad trajectory before the
guard activates, increases acceleration-limit occupancy, suppresses the
posterior traveling wave, or fails to reduce both `|phi2|` contact and the
terminal load peaks.

```text
bookshelf_consulted: true
source_domain: terminal capture control and constrained rhythmic robotic-fish propulsion
source_mechanism: preserve the target-directed traveling carrier while damping only excess terminal motion that threatens the actuator envelope
transferable_invariant: once broad propulsion and steering achieve capture, protect the useful rhythm with state-dependent braking that activates only when observed joint motion approaches a hard boundary
nontransferable_details: published gains, robot linkage geometry, species-specific joint envelopes, dimensional cadence, clock phase, exact vortex phase, task-specific routes, and source actuator ratings
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint acceleration-reserve carrier; use posterior joint angle and velocity to form a bounded remaining-margin brake that opposes only outward motion near the existing angle limit
falsification: reject if capture or the coherent broad wake is lost, raw acceleration occupancy increases, posterior hard-limit contact remains, or terminal force and moment peaks are not reduced
```
