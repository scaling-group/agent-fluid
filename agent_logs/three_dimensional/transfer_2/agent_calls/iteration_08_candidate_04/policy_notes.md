# Distributed recapture-curvature candidate

## Evidence diagnosis before the policy edit

All four sampled evaluations are stable, finite, direct-uniform still-water
rollouts with `U_infinity=0` and no cylinders.  In both required visual rows,
the fish is self-propelled: the top-down sheets show an alternating wake laid
behind the translating body, and the oblique Lambda2 sheets show coherent
three-dimensional structures through both the approach and turn.  The failure
is therefore route topology rather than passive advection, wake collapse, or
numerical instability.

The basic target-behind recapture reaches `3.031L`, then makes the sampled late
hairpin and leaves the upper boundary at `49.319T`.  Persistent route relief
does not change that topology (`2.996L`, upper exit at `49.412T`).  Unloading
the posterior carrier during recapture preserves the hairpin, reduces raw
acceleration-envelope exposure from `92.77%` to `82.97%`, and improves
mean/final distance from `7.107/7.528L` to `7.021/7.417L`, but its tail-only
mean curvature still leaves the target behind at the upper exit.

The assigned sector-intercept/recapture handoff is the strongest finite sample:
it preserves the pulse's deep approach and improves minimum distance to
`2.579L` with about `82.76%` raw acceleration-envelope exposure.  It does not
complete recapture.  The target-behind request is already near full at closest
approach and remains near full thereafter, while the fish leaves the upper
boundary earlier at `45.331T` and `7.435L`.  The top-down and oblique views show
the same coherent beat turning onto an earlier northbound arc, not a tight
redirect toward the target.  Thus another gate threshold, persistence edit, or
larger tail-only bias is not supported; the missing test is whether the same
bounded recapture curvature needs body-distributed rather than posterior-only
allocation.

## Policy hypothesis

Use the evaluated sector-intercept/recapture policy as the parent behavior and
change only the recapture actuator allocation.  When normalized body-frame
geometry puts the target behind and laterally displaced, shift the anterior
state-feedback oscillator's equilibrium in the same signed direction as the
existing posterior recapture curvature.  Keep the posterior target referenced
to the observed anterior angle, so the requested mean tail tangent remains the
same bounded value while the mean bend is shared by both joints.  Preserve the
evidenced nonzero posterior carrier floor and release both offsets continuously
when the target returns ahead or lateral error closes.  Intercept and all
target-ahead states remain unchanged.

Expected result: retain a closest approach below the recapture family's
`~3.0L`, but turn more tightly after passage and either reacquire a target-ahead
state or materially improve the upper-exit topology without exceeding the
assigned parent's saturation and load class.  Falsify the mechanism if it
loses the deep approach, keeps the target behind at a comparable upper exit,
destroys the coherent traveling wake, or materially increases joint-limit
exposure, force, or moment.

bookshelf_consulted: true
source_domain: biological C-start redirection and robotic-fish mean-curvature control
source_mechanism: large observed route error produces a bounded body-distributed bend while propulsive posterior motion is retained and restored on geometric reacquisition
transferable_invariant: allocate reorientation curvature across available body joints instead of requiring a tail-only offset to turn the whole swimmer
nontransferable_details: species-specific C-start shapes, published gains and timing, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: use the signed normalized body-frame target-behind request to shift the anterior oscillator equilibrium while the posterior target preserves the same bounded net tail tangent and carrier floor
falsification: reject if the deep intercept is disturbed, post-pass yaw does not tighten the route, the target remains behind at exit, or saturation and hydrodynamic loads worsen materially
