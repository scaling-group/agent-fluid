# Steering-urgency actuator-allocation candidate

## Visual diagnosis and completed evidence

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their translation
  and wake are controller-generated rather than ambient advection or
  moving-window transport.
- The sampled posterior joint-guard rollout is the strongest finite example.
  Its top-down row retains a coherent alternating vorticity street throughout
  the approach, and its oblique row retains discrete three-dimensional
  Lambda2 structures around the undulating posterior body and in the wake. It
  captures at `18.271T` and `0.748232L`, with `1.329U` peak swimming speed
  versus only `0.032U` peak local flow. The three sampled fixed-reserve
  rollouts reproduce capture at `18.265T` and `0.749826L`, so the semantic
  success is attributable to a reproducible course-plus-allocation structure,
  not the guard's small scalar change.
- The inherited unallocated velocity-course rollout is the informative visual
  failure. Its two views show the same self-propelled alternating wake, but it
  passes the capture circle and continues to a left-boundary exit: closest
  distance is `0.857L`, final distance is `8.909L`, peak speed is `1.052U`,
  and peak local flow is only `0.031U`. The assigned-parent notes and sampled
  captures identify the discriminating change as posterior acceleration
  reservation, not stronger drive, a route, or passive advection.
- The captured path remains a fast tangent crossing. Mean speed inside `2L`
  is about `1.14U`; at `1.50L` the instantaneous course is nearly aligned,
  but at `1.00L` wrapped course error is about `-0.69 rad`, predicted
  straight-line miss is about `0.64L`, and the controller still uses the same
  fixed `35%` steering reserve. At capture it is already receding, wrapped
  course error is about `-1.83 rad`, and the posterior joint is near `-44 deg`.
  This supports reallocating the fixed envelope from carrier to steering only
  when the observed terminal turn request is large.
- The sampled `8 deg` posterior joint guard does not satisfy its stated
  contact-avoidance hypothesis: it still records a `45 deg` posterior hard-stop
  sample, and raw acceleration-envelope exceedance remains about `51/46%`.
  It does reduce peak force/moment from `0.208/0.0928` to `0.172/0.0770`, so it
  is a partial load mitigation, not evidence of capture-margin robustness or a
  reason to strengthen an angle barrier in this candidate.

## Policy hypothesis written before the solver edit

Preserve the demonstrated full-quadrant body-frame target ray, measured
body-frame velocity course, speed-gated course error, zero-centered anterior
oscillator, posterior lag and damping, `12 deg` mean-curvature request, and
the fixed physical acceleration envelope. Keep the demonstrated `35%`
posterior steering reserve as the broad allocation baseline. Inside the final
`2L`, smoothly increase the reserved share toward `65%` in proportion to the
magnitude of the already bounded target-signed turn request. The complementary
carrier share shrinks within the same envelope, so the edit changes
carrier-versus-steering allocation rather than any physical limit or nominal
curvature gain. When course alignment is good, the extra priority vanishes and
the demonstrated carrier remains unchanged.

The expected signature is the same broad approach and coherent alternating
three-dimensional wake, followed by a more central capture and less posterior
angle-stop pressure when terminal course error grows. Falsify the mechanism if
it loses capture or the sub-`1L` path, changes the trajectory outside `2L`,
suppresses alternating shedding, increases raw limit occupancy, or merely
repeats the marginal `0.748--0.750L` tangent crossing without reducing
posterior angle contact.

```text
bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated constrained robotic-fish CPG steering
source_mechanism: preserve rhythmic propulsion while continuously shifting bounded actuator authority toward observed terminal direction error
transferable_invariant: a productive traveling carrier should retain most authority when aligned, while large observed terminal course error should reallocate the same fixed envelope toward target-signed correction rather than increase gains or physical limits
nontransferable_details: published gains, robot linkage geometry, species-specific gait envelopes, dimensional cadence, clock phase, exact vortex phases, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and two-joint state-feedback propulsion; inside a normalized distance gate use the magnitude of the bounded turn request to interpolate the posterior steering reserve and leave the complementary envelope to the carrier
falsification: reject if the broad sub-1L approach or alternating 3D wake degrades, capture is lost, raw limit occupancy rises, posterior angle contact persists without a wider capture margin, or the path changes before the terminal gate
```

## Non-CFD contract checks after the edit

- The required lightweight Julia exercise returns two finite accelerations, and
  every direct `params.FIELD` reference resolves to a returned parameter.
- A deterministic state grid confirms reflection equivariance, finite fallback
  behavior, and `|a2| <= 1800 deg/T^2` throughout the priority region.
- Replaying representative recorded states through the command law leaves the
  `4L` command exactly unchanged. At the sampled `1L` high-error state, the
  posterior command changes from carrier-dominated `+9.03` to target-signed
  `-4.18 rad/T^2`; this is only a command-level mechanism check, not CFD
  evidence or a claim that the unevaluated trajectory will capture.
