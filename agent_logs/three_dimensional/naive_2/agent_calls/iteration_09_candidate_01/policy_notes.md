# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled rollouts and the assigned parent's inherited rollout satisfy
the released direct-uniform contract: `U_infinity=(0,0,0)`, no cylinders or
prewarm, finite dynamics, and `left_domain` termination. In both rows of their
combined sheets the fish self-propels. The top-down views show a persistent
alternating vortex street, while the oblique views show tail-connected 3D
Lambda2 structures through the late excursion. None loses propulsion before
failure; each path passes above the target and exits through the upper virtual
boundary.

The sampled full-carrier prefill reaches `4.419L` at `18.07T` while still
moving at `0.834U`; its target bearing is about `-1.057 rad`, its
target-versus-velocity course error is saturated at `-pi/2`, and its body-frame
lateral velocity is `+0.447U`. Distance-only amplitude relief reaches only
`5.126L`, course-misalignment damping reaches `6.397L`, and closure-gated
posterior-wave relief reaches `4.162L`. These completed results agree with the
inherited negative lesson: shedding carrier energy does not repair the delayed
conversion of a turn request into targetward translation.

The assigned parent's approach-gated posterior half-cycle controller is a
more informative mixed result. Relative to its inherited full-carrier parent,
it nearly preserves closest approach (`3.259L` versus `3.135L`), reduces
acceleration-limit residence (`65.8%` versus `71.9%`), and reduces final
recession (`7.016L` versus `10.210L`). However, at its closest approach it
still has `-pi/2` course error, `+0.406U` body-frame lateral slip, `0.758U`
speed, and essentially zero closure. Its top-down path and oblique wake then
continue into the same upper exit. Posterior half-cycle redistribution has
useful bounded authority, but activating it only inside the inherited
`6.5L` distance gate is too late to change the course topology.

## Single candidate hypothesis

Use the assigned parent's full anterior state-feedback carrier,
approach-aware four-degree anterior course redistribution, crossflow-assisted
posterior mean, yaw-rate damping, posterior lag, and smooth acceleration
envelope. Preserve its posterior half-cycle steering strength, but replace the
distance-only activation of that mechanism with a speed-qualified
target-versus-velocity course-response gate. The state-derived beat side and
slow body-frame route request remain separate; only the posterior half-cycle
opposing the requested turn is attenuated. Thus the mechanism is inactive at
rest or on an aligned translation, can begin before the late proximity window
when measured course has already diverged, and does not amplify the
near-limit useful half-cycle.

The expected semantic change is downward course correction before the
`12--16T` interval, where the sampled full carrier has already developed
negative course error but still carries strong closure, while preserving the
coherent far-transit wake. Falsify it if early leftward progress or wake
coherence weakens, minimum distance is worse than about `3.26L`, the course
error and positive lateral slip remain large through closest approach, the
same upper exit persists without a better final distance, or acceleration
residence, peak force, or peak moment exceed the assigned parent's references
of `65.8%`, `0.0337`, and `0.0175`.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking with asymmetric flapping
source_mechanism: modulate beat asymmetry from observed route response while retaining the underlying propulsive oscillator
transferable_invariant: a turning asymmetry should be gated by normalized directional response and observed beat side, not by a memorized time or route and not solely by target proximity
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: use speed-qualified body-frame target-versus-velocity course error to activate attenuation only on the posterior half-cycle opposing the bounded target-geometry turn request; retain the full anterior oscillator and existing mean-curvature limit
falsification: reject if earlier activation degrades transit or wake coherence, fails to reduce pre-approach course error and lateral slip, worsens closest approach or upper-exit recession, or increases actuator residence and hydrodynamic loads

## Non-CFD gate audit after the edit

Replaying only the new scale algebra on the five completed observation
histories gives mean posterior-wave scales of `0.969--0.982` at distances of
at least `8L`, `0.855--0.911` from `5L` to `8L`, and `0.843--0.850` inside
`5L` where those histories reached that band. The minimum reconstructed scale
is `0.681`; the useful half-cycle is never amplified. This confirms that the
response gate is bounded, mostly preserves far transit, and moves appreciable
authority into the pre-approach interval. It does not establish a
hydrodynamic improvement; that requires the post-worker CFD rollout.
