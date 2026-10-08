# Cascaded line-of-sight route candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  prewarm snapshot, no cylinders, and capture termination. I inspected the
  top-down vorticity and oblique Lambda2 rows of the combined keyframe sheets
  for the best sampled policy and the lower-scoring line-of-sight variant,
  plus both rows for the assigned parent's inherited evaluation. In every
  case the fish self-propels from rest and leaves a coherent alternating
  mid-plane wake with compact posterior three-dimensional structures through
  capture. There is no passive advection, wake breakup, collision, or
  out-of-plane instability to repair.
- Three sampled copies of the error-qualified far-only line-of-sight policy
  are deterministic repeats and form the strongest current evidence: capture
  at `17.7265T`, score/mean score-distance `-0.0813954/1.967391L`, observed
  distance integral `1.352572L`, center path `12.8468L`, maximum straight-line
  head cross-track `0.5120L`, and approach/final course alignment
  `0.8993/0.6010`. The unqualified residual remains coherent but captures at
  `17.8750T`, scores `-0.0871032`, and has a longer `12.9663L` path,
  `0.5454L` cross-track, and only `0.1134` final course alignment. Current
  target-error qualification and approach release therefore survive the
  sampled evidence and should be preserved.
- The assigned parent's inherited rollout supplies the informative new
  negative result. Multiplying the winning residual by an instantaneous
  target-course-alignment gate preserves the visible wake and similar yaw/load
  scale, but delays capture to `18.4800T`, worsens score/mean score-distance to
  `-0.0926605/1.979771L`, lengthens the path to `13.4038L`, and raises
  cross-track to `0.7397L`; approach/final alignment fall to
  `0.6693/-0.3762`. A beat-scale velocity direction is therefore not a safe
  authority signal for persistent route correction in this gait.
- The remaining structural mismatch is inside the sampled winner. Its
  line-of-sight residual is added to the steering request only after the
  desired turn rate has been computed from geometric target error. The inner
  yaw-rate feedback can consequently oppose a route correction that its own
  reference does not contain. This is distinct from the rejected course gate,
  terminal course injection, carrier attenuation, and gait-yaw projection.

## One policy hypothesis

Preserve the sampled winner's phase-plane carrier, posterior lag and emphasis,
odd curvature map, line-of-sight estimator, current-error and distance gates,
approach controller, cadence schedule, half-cycle steering, and
reversal-preserving rate governor. Change only the feedback composition: form
one `route_request` by adding the qualified line-of-sight residual to the
geometric request before computing the bounded desired turn rate. Let the
existing yaw-rate loop track that combined outer-loop request, and pass the
same request through the established two-joint steering path. This is a
cascaded state-feedback mechanism and introduces no time, coordinates, route,
mutable state, or new scalar gain.

Expected evidence is retention of capture and both coherent wake views with a
shorter or lower-cross-track route than `12.8468L/0.5120L`, no regression from
the `17.7265T` arrival or `1.967391L` mean score-distance, and no material
increase in yaw, force/moment, or joint-limit residence. Falsify the mechanism
if the inner loop's added agreement produces oversteer, longer path or arrival,
worse approach alignment, loss of capture, higher load class, or degraded
top-down/oblique wake coherence.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and hierarchical far/middle/near swimming control
source_mechanism: preserve a stable rhythmic carrier while a slow target-route loop supplies the reference followed by a bounded inner turning loop
transferable_invariant: an inner response-feedback loop should track a reference containing the active normalized outer-loop route correction rather than oppose an omitted correction
nontransferable_details: published gains, oscillator equations, dimensional cadence, species-specific kinematics, exact vortex phases, target coordinates, and task-specific routes
policy_translation: combine body-frame geometric error and error-qualified co-windowed line-of-sight drift before forming desired turn rate, then reuse the existing odd two-joint curvature and half-cycle steering path
falsification: reject if capture, distance integral, path, cross-track, approach alignment, load class, reflected-case route-reference behavior, or top-down and oblique wake coherence regress
```
