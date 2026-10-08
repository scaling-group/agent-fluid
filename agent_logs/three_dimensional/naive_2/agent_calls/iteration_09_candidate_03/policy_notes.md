# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled rollouts and both inherited completed rollouts satisfy the
released flow contract: direct uniform initialization, `U_infinity=(0,0,0)`,
no cylinders or prewarm, finite dynamics, and `left_domain` termination. In
both rows of the combined sheets the fish self-propels, a coherent alternating
mid-plane vortex street develops, and tail-connected three-dimensional
Lambda2 structures persist through the late excursion. The common failure is
therefore planar route response rather than missing thrust or wake collapse:
every trajectory travels above the target and exits through the upper virtual
boundary.

The scalar-relief descendants preserve that topology while losing approach.
Distance-only anterior amplitude relief reaches `5.126L`, distance-times-course
damping reaches only `6.397L`, and closure-conditioned posterior-wave relief
reaches `4.162L`; the unrelieved three-degree comparison reaches `4.419L`.
The assigned-parent logs add two important completed tests. Closing-aware whole
carrier relief reaches `3.926L` but recedes to `7.891L`, with at least one
acceleration near its soft limit for `75.0%` of samples. Approach-gated
posterior half-cycle asymmetry recovers a strong `3.259L` approach and lowers
that residence to `65.8%`, while retaining peak force and moment near
`0.0200`, `0.0276`, and `0.0175`; however, it still recedes to `7.016L` and
exits high. Its top-down row shows a sharper bend only in the final frames, and
the oblique row confirms that the organized wake survives that bend. Thus the
asymmetric-beat actuator is useful, but its proximity gate applies it after
the course miss is already established.

Reconstruction from the inherited half-cycle trajectory makes the timing
failure explicit. At about `8T` and `10.0L` range, normalized body bearing and
target-versus-velocity course error agree at roughly `-0.46` and `-0.59 rad`,
but the proximity-gated asymmetry is inactive. At `12T` they still agree at
about `-0.07` and `-0.82 rad`, just before the old `6.5L` gate starts. Near the
`3.259L` minimum, course error has saturated at `-pi/2`, speed remains about
`0.76U`, and closure is already negative. Conversely, at `4T` bearing is near
zero while instantaneous course error has the opposite sign; this is exactly
the early conflict that made a prior projected-miss anterior burst unsafe.

## Single candidate hypothesis

Restore the full anterior state-feedback carrier and retain the inherited
four-degree transient anterior redistribution, body-frame bearing, crossflow
residual, course brake, recent-yaw damping, posterior mean-curvature bound,
state-derived posterior lag, and smooth acceleration envelope. Replace the
distance gate on the inherited half-cycle actuator with one response gate:
posterior wave relief is available only when speed-gated course error and
body-frame bearing agree in sign. Their geometric-mean magnitude controls the
amount, their signed sum controls the requested side, and the observed joint
state identifies the opposing half-cycle. Disagreement or restored course
alignment releases the complete wave continuously.

This is a feedback-architecture change rather than scalar drive tuning. It
keeps the useful half-cycle and anterior rhythm, avoids another static or burst
anterior bend, and gives the previously successful asymmetric posterior beat
authority during a persistent mid-course miss instead of waiting for target
proximity. Replaying only this algebra on the inherited history leaves scale
at `1.0` at the misleading `4T`, `6T`, and `10T` disagreement samples; the
mean scale remains about `0.986` for ranges at least `8L`, becomes about
`0.926` from `5--8L`, and about `0.836` inside `5L`, with a bounded minimum
near `0.660`. This audit establishes sign, localization, and boundedness, not
hydrodynamic improvement.

The expected semantic change is an earlier downward redirection of the
propulsive course while preserving the coherent carrier, followed by release
as the velocity aligns with the target. Falsify it if far-field progress or
wake organization materially degrades, closest approach is worse than the
inherited `3.259L` asymmetric-beat result or the sampled `4.162L` closure-tail
result, bearing and course remain strongly negative at closest approach, or
the same receding upper exit persists without better final distance. Also
reject it if near-limit action residence, peak force, or peak moment materially
exceed the inherited half-cycle references of `65.8%`, `0.0276`, and `0.0175`.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological C-start redirect control
source_mechanism: create a transient turn by biasing the propulsive beat only while observed route geometry and motion agree that redirection is still required
transferable_invariant: separate the slow target-directed request from joint-state beat phase, apply asymmetric posterior authority on the opposing half-cycle, and release it when measured course response aligns
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, clocked CPG phase, exact vortex phase, maneuver duration, and task-specific routes
policy_translation: combine bounded normalized body-frame bearing with speed-gated target-versus-velocity course error; when their signs agree, use actual posterior wave state to attenuate only the opposing half-cycle while leaving the anterior carrier and posterior steering mean intact
falsification: reject if the gate responds to early bearing/course disagreement, weakens transit thrust or the alternating 3D wake, fails to redirect before the prior closest-approach interval, or worsens capture distance, upper exit, actuator residence, force, or moment
