# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled solver rollouts and the assigned parent's completed step-7,
step-8, and step-9 rollouts satisfy the released experiment contract: direct
uniform initialization, zero background velocity, no cylinders or prewarm,
finite dynamics, and `left_domain` termination. The top-down and oblique rows
of their combined sheets show self-propulsion rather than advection. A coherent
alternating mid-plane street and tail-connected three-dimensional Lambda2
structures persist through approach and recession. The shared failure is
planar route response: the body and organized wake bend toward the upper
boundary after passing above the target; wake collapse does not precede exit.

The sampled comparison rules out another scalar drive-relief edit. The
unrelieved three-degree course redistribution reaches `4.419L`; distance-only
anterior amplitude relief reaches only `5.126L`; closure-conditioned
posterior-wave relief reaches `4.162L`; and response-gated half-cycle steering
reaches `5.000L`. At closest approach these paths still carry roughly
`0.72--0.84U`, target bearing is about `-0.97` to `-1.30 rad`, and
target-versus-velocity course error is `-1.26 rad` or saturated at
`-pi/2`. Their final distances remain `5.885--6.383L`, with the same upper
exit. The sampled keyframes confirm that their dramatic alternating vortices
are propulsion evidence, not capture evidence.

The inherited sequence isolates the more useful steering foundation. A
closing-aware whole-carrier hold reaches `3.926L`, recedes to `7.891L`, and
has near-limit acceleration in `75.0%` of samples. Approach-gated posterior
half-cycle attenuation improves that tradeoff to a `3.259L` minimum,
`7.016L` final distance, and `65.8%` near-limit residence while retaining
the alternating 3D wake. Replacing its proximity gate with earlier
bearing/course agreement lowers residence again to `61.6%` and shortens the
final distance to `6.629L`, but worsens the minimum to `3.580L`; the target
is still about `-1.35 rad` off-axis with `-pi/2` course error at the
minimum. Thus further retiming or deepening posterior half-cycle attenuation
is not a supported capture mechanism.

The timing record instead shows an unused independent steering channel. In the
best inherited half-cycle rollout, bearing and course disagree at about
`4T` and again near `10T`, but agree on a downward correction by `12--14T`.
The existing four-degree anterior redistribution then grows from about
`0.6 deg` at `14T` to `3.8 deg` at the `18.0T` minimum, too late and too
weak to prevent the course residual saturating. A prior *persistent*
`8--9 deg` anterior center destroyed carrier speed, so any larger anterior
lever must be response-localized and continuously released rather than
installed as a static bend.

## Single candidate hypothesis

Restore the inherited step-8 full-amplitude Van der Pol carrier,
approach-relaxed four-degree course redistribution, body-frame bearing,
relative-crossflow residual, recent-yaw feedback, bounded posterior mean,
state-derived lag, and approach-gated opposing-half-cycle attenuation. Add one
mechanism: a C-start-like anterior redirect capped at another four degrees and
gated by both the existing smooth approach signal and agreement between
bounded body-frame bearing and speed-qualified target-versus-velocity course
error. Its direction comes from those two target-relative signals; it is zero
during their misleading early disagreement and releases as either route error
or course error vanishes. Referencing the posterior wave to actual `q1`
redistributes this transient curvature without increasing the posterior
steering mean or amplifying a tail excursion already close to the hard limit.

This is an actuator-allocation change, not scalar carrier tuning. Replaying the
new algebra on the completed step-8 history leaves extra redirect exactly zero
at ranges of at least `6.5L`, including the misleading `4T` and `10T`
conflicts. It contributes about `-0.9 deg` at `14T`, `-2.7 deg` at `16T`,
and `-3.8 deg` at the `18.0T` minimum; mean extra authority inside `5L` is
about `2.94 deg`, while total anterior centering stays within
`-7.62..+3.74 deg` on that trace. This checks only algebraic localization
and boundedness; it is not a claim of hydrodynamic improvement.

The expected semantic change is a visibly earlier downward redirect with the
step-8 transit and coherent wake intact, a minimum below `3.259L`, and less
negative bearing/course error before recession. Falsify the mechanism if the
far path changes, anterior joint speed collapses as in the persistent static
bend, closest approach worsens materially, the course residual still saturates
near the minimum, or the same receding upper exit persists without improved
final distance. Also reject it if near-limit acceleration, peak planar force,
or peak moment materially exceed the step-8 references of `65.8%`,
`0.0276`, and `0.0175`.

bookshelf_consulted: true
source_domain: biological C-start redirection and sensor-modulated robotic-fish direction tracking
source_mechanism: apply a strong but transient body bend when observed route error and translational response agree that redirection is required, then release into the propulsive rhythm as response aligns
transferable_invariant: preserve the established traveling-wave carrier, allocate extra bounded curvature only under normalized target-relative response error, and release that curvature continuously when course correction appears
nontransferable_details: species-specific bend envelopes, published robot gains, dimensional maneuver timing, clocked CPG phase, exact vortex phase, and any world-frame route
policy_translation: combine bounded body-frame bearing with speed-qualified target-versus-velocity course error; inside the existing approach gate, use their agreement to add a capped anterior equilibrium shift while the posterior target remains referenced to actual anterior state
falsification: reject if early transit or the alternating 3D wake changes, the anterior carrier suffers the prior static-bend speed collapse, closest approach and route residual do not improve, or saturation, force, moment, recession, or upper-exit topology worsen
