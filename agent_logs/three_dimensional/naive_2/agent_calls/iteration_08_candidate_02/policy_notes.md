# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled rollouts and the inherited closing-aware rollout satisfy the
direct-uniform still-water contract: zero background velocity, no cylinders,
finite state, and `left_domain` termination. In both rows of every combined
keyframe sheet the fish is self-propelled. The top-down views show a persistent
alternating vortex street, and the oblique views show tail-connected 3D
Lambda2 structures through the late excursion. The common failure is therefore
course control, not missing thrust: every path passes above the target and
leaves through the upper boundary while its organized wake continues.

The strongest sampled approach, the unrelieved four-degree course-redistribution
policy (`solver_6d90d1984e81`), reaches `3.161L` at `18.227T`, but at that
instant target bearing is about `-0.985 rad`, target-versus-velocity course
error is `-1.488 rad`, speed remains `0.846U`, and radial closure has fallen to
`0.070U`. Its requested posterior mean is consequently already near the
curvature bound, yet it recedes to `8.569L` and exits. The highest-score sampled
distance-only relief reaches only `5.126L`; the prefilled distance-times-course
damping reaches only `6.397L`; and the unrelieved three-degree comparison
reaches `4.419L`. Thus scalar drive reduction does not solve the delayed
translation-to-turn response even though it can lower loads.

The inherited closing-aware amplitude hold completes the prior hypothesis and
is a negative result. Relative to its full-carrier assigned parent (`3.135L`
minimum), it worsens closest approach to `3.926L`, still has speed `0.837U`,
closure `-0.044U`, and saturated `-pi/2` course error at closest approach, then
exits high at `7.891L`. At least one acceleration remains within five percent
of the soft limit for `75.0%` of samples, compared with the parent's reported
`71.9%`, so the gate neither produced a terminal hold nor relieved command
residence. The top-down and oblique rows likewise show propulsion continuing
along the same upper-exit topology.

## Single candidate hypothesis

Restore the assigned parent's full anterior Van der Pol carrier, posterior
state-derived lag, approach-aware four-degree anterior course redistribution,
body-frame bearing and course signals, relative-crossflow residual, recent-yaw
feedback, bounded posterior mean, and smooth acceleration envelope. Replace
whole-carrier amplitude shedding with one approach-gated half-cycle steering
primitive. A slow target-geometry command identifies the requested turn; the
posterior traveling-wave component is left unchanged on the useful half-cycle
and smoothly attenuated only when its sign opposes that command. This creates a
dynamic turning bias without a static anterior bend, preserves the anterior
rhythm, does not amplify the already near-limit posterior excursion, and is
exactly inactive outside the inherited `6.5L` approach range.

Replaying only the proposed algebra on the strongest sampled and inherited
histories gives carrier scale exactly `1.0` at distances of at least `8L`.
Inside `5L`, the useful posterior half-cycle averages `0.973--0.976` of its
original wave while the opposing half-cycle averages `0.759--0.783`; the
minimum scale is `0.657`, applied to an opposing half-cycle near the strongest
sampled closest approach. This audit establishes localization and boundedness,
not hydrodynamic improvement.

The expected semantic change is earlier conversion of the saturated late
course request into yaw and downward velocity while preserving the parent's
strong transit and closest approach. Falsify it if the early trajectory or
wake changes, minimum distance is materially worse than `3.135--3.161L`, the
target remains roughly `1 rad` off-axis with course error near `-pi/2` at
closest approach, upper-boundary exit and recession persist without a better
final distance, or saturation, peak force, or peak moment exceed the sampled
references of about `74%`, `0.0337`, and `0.0175`.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning control
source_mechanism: create turning moment by making the rhythm's useful half-cycle stronger relative to its opposing half-cycle while retaining the propulsive oscillator
transferable_invariant: separate the slow body-frame route request from beat phase and redistribute posterior wave authority toward the requested-turn half-cycle without installing a static bend
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: infer phase from the state-derived posterior traveling-wave component, form a bounded turn command from body-frame bearing and course error, and attenuate only the opposing posterior half-cycle inside a smooth proximity gate while leaving the anterior carrier unchanged
falsification: reject if far transit changes, thrust or the alternating 3D wake collapses, closest approach worsens, course is not redirected before recession, or joint limits, acceleration residence, force, or moment become less acceptable
