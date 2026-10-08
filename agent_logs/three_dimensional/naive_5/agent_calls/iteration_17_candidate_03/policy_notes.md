# Joint-envelope-filtered line-of-sight candidate

## Visual and trace diagnosis before the edit

- All four sampled solvers are contract-valid direct-uniform still-water
  evaluations (`U_infinity=(0,0,0)`, no cylinders, no prewarm) of the same
  policy SHA.  Each independently reports capture at `27.604519T` and
  `0.749769L`.  In the top-down vorticity row, the path keeps rotating toward
  the target instead of straightening into the inherited left-exit pass-by;
  in the oblique body/Lambda2 row, an organized body-attached wake persists
  through capture.  The outcome is repeatable controlled self-propulsion, not
  moving-window advection or a scalar-only near miss.
- The sampled capture remains thin dynamically.  It crosses the radius at
  about `0.642L/T`, reaches peak planar force/yaw moment near
  `0.03397/0.01548`, and retains the line-of-sight response that changed the
  prior termination class.  However, joint 2 contacts the `45 deg` angle
  boundary at three samples between `16.918T` and `18.837T`, joint 1 reaches
  about `44.84 deg`, and `1183` of `10038` joint samples (about `11.8%`) lie
  at the `260 deg/T` speed cap.  Repeated capture therefore validates the
  navigation mechanism but not actuator-envelope robustness.
- The combined sheet for the informative instantaneous-intercept failure
  remains coherent but visibly straightens past the target and exits left
  after a `1.096087L` minimum.  Its failure, together with the inherited
  `0.828--1.111L` terminal scalar variants, argues against changing the
  line-of-sight, redirect, or approach semantics that now capture.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, posterior lag, same-sign
redirect, terminal miss veto, and inertial line-of-sight response exactly up
to their two raw joint commands.  Add one symmetric output safety mechanism:
when a joint is moving outward faster than its remaining angle margin can
brake, smoothly blend its command toward bounded inward acceleration; when a
command would add kinetic energy near the speed cap, smoothly remove only that
outward component.  Both gates use normalized joint angle and velocity state,
are reflection-equivariant, and leave braking and ordinary carrier motion
unchanged.

The falsifiable expectation is repeat capture with the same coherent broad
route and low-load terminal turn, no `45 deg` contact, and materially less
speed-cap residence.  Reject the filter if capture is lost, arrival or route
rotation materially worsens, the wake loses its traveling structure, or force,
moment, acceleration-clamp residence, or switching increases.  If it fails,
later workers should retain the repeated line-of-sight success and test a
narrower smooth envelope projection rather than retuning navigation gains.

bookshelf_consulted: true
source_domain: robotic-fish CPG and residual-control studies, with classical traveling-wave propulsion guardrails
source_mechanism: preserve an effective rhythmic carrier and place bounded sensor feedback around it instead of replacing it with raw high-frequency control
transferable_invariant: modify only the state-observed constraint-threatening residual while retaining the phase-separated traveling bend and established navigation response
nontransferable_details: published gains, dimensional frequencies, linkage geometry, species-specific envelopes, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalized joint angle margin and joint speed gate only outward acceleration near the actuator envelope after the body-frame line-of-sight controller forms its two commands
falsification: reject if repeated capture is lost, the coherent wake or target-line rotation changes materially, angle contact remains, speed-cap residence is not reduced, or load and command exposure worsen

## Non-CFD implementation audit

- The guidance-semantic check, lightweight Julia policy contract, parameter
  schema guard, and solver editable-boundary check pass.  Exactly one
  `candidate_target_policy.jl` exists under `solver/`, and it is materially
  different from the sampled capture policy.  No CFD was run.
- A nominal state below both safety gates gives bit-identical commands to the
  sampled controller.  Separate representative angle-guard and speed-guard
  states change the affected command by about `1.27` and `6.52 rad/T^2`,
  respectively; reflection of target, velocity, yaw, joint angle, and joint
  velocity negates both output commands with zero algebraic error.
- Applying only the new projection to the sampled executed-command trace
  changes `1161/5019` joint-1 rows and `578/5019` joint-2 rows, chiefly around
  the observed `939/244` joint-speed-cap samples.  This frozen-trace audit
  establishes that the safety hypothesis is material and localized by joint
  state; it is not a dynamical replay and does not predict the unevaluated CFD
  outcome.
