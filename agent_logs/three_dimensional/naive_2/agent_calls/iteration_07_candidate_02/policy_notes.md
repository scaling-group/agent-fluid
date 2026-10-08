# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled rollouts satisfy the direct-uniform still-water contract:
`uniform_direct` initialization, zero background velocity, no cylinders, and
finite `left_domain` termination. In both rows of every combined keyframe
sheet, the fish is self-propelled rather than advected. A coherent alternating
mid-plane vortex street and tail-connected three-dimensional Lambda2
structures develop and persist. The visible common failure is route/capture
control: each trajectory passes above the target and exits the upper virtual
boundary.

The assigned parent preserves the strongest route mechanism. Its transient
anterior course redistribution reaches `3.135L` at `18.249T`, slightly better
than the sampled `3 deg` redistribution's `4.419L`, while retaining a speed of
`0.852U` and a target-versus-velocity course error of about `-1.410 rad` at
closest approach. It then keeps the full rhythmic carrier, recedes to
`10.210L`, and exits at `30.113T`; at least one action is within five percent
of the soft acceleration limit for `71.9%` of its samples. The top-down sheet
shows the resulting long coherent wake continuing past the target rather than
a loss of propulsion, and the oblique row confirms that the three-dimensional
wake remains organized through the late excursion.

The sampled approach variants constrain the next test. Smooth distance-only
amplitude relief (`solver_4482d3d05d9c`) reaches only `5.126L`, and
distance-times-course-error damping (`solver_a763085dcb98`) reaches only
`6.397L`; both are worse than the unrelieved `3 deg` comparison's `4.419L`.
The inherited notes predicted that these mechanisms should preserve the far
route, but their completed rollouts show that proximity or misalignment alone
activates relief too early. Conversely, the assigned parent's strong minimum
followed by `7.074L` of recession shows that never changing propulsion after
radial closure deteriorates is also inadequate.

## Single candidate hypothesis

Retain the assigned parent's joint-state Van der Pol carrier, posterior lag,
body-frame bearing, relative-crossflow residual, speed-gated course brake,
approach-aware four-degree course redistribution, recent-yaw term, posterior
mean-curvature bound, and smooth action envelope. Add one approach-hold
mechanism: compute radial closing directly from the normalized body-frame
target vector and body velocity, then reduce only the oscillator amplitude
when both target proximity and a smooth radial-closing deficit are present.
Full amplitude remains available while the fish is far away or translating
decisively toward the target, even at large course error; as closure weakens
near the target, propulsion is relieved relative to the unchanged steering
authority. The gate is memoryless, bounded, rotation-invariant, and requires
neither elapsed time nor a route coordinate.

The expected semantic change is to retain the parent's approximately
`3.135L` closest approach while reducing its long post-minimum recession and
upper drift. Falsify the mechanism if the early wake or leftward progress
weakens, minimum distance worsens materially, radial closure still becomes
negative without drive relief, the `left_domain` topology is unchanged
without a better final distance, or joint saturation and peak force/moment
exceed the parent's `71.9%`, `0.0337`, and `0.0175` reference levels.

bookshelf_consulted: true
source_domain: fish terminal capture and closed-loop robotic-fish CPG modulation
source_mechanism: continuously trade propulsive-rhythm amplitude for steering authority only when measured target approach has weakened
transferable_invariant: preserve the traveling wave during productive closure, but relieve its carrier when normalized proximity and a body-frame radial-closing deficit jointly indicate impending overshoot or recession
nontransferable_details: published gains, dimensional approach speeds and distances, species or robot kinematics, oscillator clocks, exact vortex phases, and task-specific routes
policy_translation: form a bounded gate from `distance_L` and the projection of `velocity_body_U` onto `target_body_L`; use it only to lower the anterior oscillator amplitude while retaining actual-state posterior lag and all bounded steering terms
falsification: reject if far-field propulsion changes, closest approach degrades, post-minimum recession and upper exit do not improve, or the wake, actuator residence, force, or moment becomes less acceptable

## Non-CFD gate audit

Replaying only the new algebraic gate on the assigned parent's observation
history gives a minimum carrier scale of `0.969` whenever body-frame radial
closure is at least `0.5U`, versus about `0.527--0.572` around the
`18.0--18.25T` closest-approach interval as radial closure falls below the
configured reference. The mean scale is `0.984` for samples at least `8L`
away and `0.729` inside `5L`. This confirms that the mechanism is bounded and
primarily response-localized; it does not establish hydrodynamic improvement,
which requires the post-worker CFD evaluation.
