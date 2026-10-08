# Wake-policy candidate notes

## Visual and numerical diagnosis before the policy edit

All four sampled rollouts satisfy the released experiment contract: direct
uniform still-water initialization, `U_infinity=(0,0,0)`, no cylinders or
prewarm snapshot, finite `capture` termination, and no reported instability.
The best sampled policy is reproduced by `solver_43e27134a723` and
`solver_c85ef8d2aea3`: their trajectories are byte-identical and capture at
`24.310009T`, with mean distance `2.223959L` and crossing distance
`0.749162L`. The complete sheet for the former shows continuous curved motion
toward the target behind an alternating red/blue mid-plane street; discrete
oblique Lambda2 structures persist at `8T`, `16T`, `24T`, and capture. This is
active propulsion rather than advection or terminal coasting. The latter has
the same top-down sheet and numerical trace but a blank oblique row, which is
a render artifact rather than a second three-dimensional wake observation.

The broad-relief comparison has a complete two-view sheet with the same wake
class, but captures later at `24.326511T` with mean distance `2.224097L`.
Replacing the response with translation alignment is also weaker at
`24.343010T` and `2.224020L`; its blank oblique row cannot support an
independent 3D claim. Peak normalized planar force and yaw moment remain about
`0.031649/0.016385` across these samples, so the useful distinction is the
phase allocation of the terminal posterior-rudder relief, not a new load or
wake regime.

The assigned parent's added carrier-reinforcement intersection is now a
concrete negative result. It retains capture and the same peak load envelope,
but regresses from `24.310009T/2.223959L` to
`24.326511T/2.224136L`; its top-down sheet preserves the route topology, while
its blank oblique row supplies no separate 3D confirmation. Restricting the
successful anterior-stroke relief with another inferred carrier-target phase
therefore removes useful authority. Later workers should not retry that nested
gate or tune its transition width as a surrogate for a measured actuator
phase.

## One candidate hypothesis

Preserve the strongest sampled controller, including its joint-state carrier,
anterior redirect, posterior-rudder sign, one-step closing-deficit response,
and tested 20% relief ceiling. Add one downstream state observation rather
than another modeled-phase intersection: form a smooth posterior useful-stroke
gate from normalized `-geometric_turn * phi_dot[2]`. Combine it with the
evidenced anterior gate using a bounded smooth union. Relief then begins with
the upstream anterior stroke and persists only while the lagging posterior
joint is still moving with the target-signed rudder; it does not extend across
the entire return stroke as broad relief does.

On the completed best trace below `0.9L`, the mean closing-deficit/phase product
is about `0.344` for the existing anterior gate, `0.214` for the posterior gate,
and `0.379` for their union, versus `0.542` for unscheduled broad relief. This
replay does not predict the coupled CFD response, but it establishes that the
candidate is a modest lag-aware extension rather than broad unloading. It is
normalized, bounded, reflection equivariant, and leaves the pre-terminal
controller unchanged whenever the inherited deficit gate is inactive.

Falsify the candidate if capture is lost or later than `24.310009T`, mean
distance exceeds `2.223959L`, the route changes before terminal deficit
activation, or action effort, rate-cap occupancy, force/moment peaks, the
alternating mid-plane street, or the discrete 3D wake worsens. A positive
fixed-pose result would still not establish pose or hydrodynamic robustness.

bookshelf_consulted: true
source_domain: traveling-wave fish models and closed-loop robotic-fish CPG control
source_mechanism: propagate sensory steering allocation through an observed phase-lagged joint chain while retaining the rhythmic propulsive carrier
transferable_invariant: use normalized joint-state phase, rather than clock phase or a modeled vortex phase, to allocate a bounded steering residual without replacing the traveling bend
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: smoothly unite the target-signed anterior joint-rate gate with the oppositely signed lagging posterior joint-rate gate, and apply the result only to the evidenced closing-deficit posterior-rudder relief
falsification: reject if capture is later than 24.310009T or lost, mean distance exceeds 2.223959L, early behavior changes, or wake, saturation, effort, force, or moment envelopes worsen
