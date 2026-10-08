# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled evaluations report direct uniform initialization with
`U_infinity=(0,0,0)`, so their motion and wakes are policy generated rather
than inherited from a prewarm or imposed flow.  The combined keyframes of the
strongest finite rollout (`solver_807c205ad607`) show a coherent alternating
top-down wake and an organized three-dimensional Lambda2 train while the fish
advances left.  Its center moves from `x=21.000L` to `19.253L`, and distance
falls from `12.328L` to `11.512L`; the same sheet also shows the path bending
upward until the fish leaves at `y=15.203L`, `9.823T`.  This is productive
self-propulsion with failed route regulation, not passive advection or wake
collapse.

The assigned parent's `solver_61a3d44af66b` retains an alternating wake in
both visual rows, but its bearing/crossflow/yaw-driven posterior half-cycle
asymmetry makes a tighter upward hook.  It exits at `8.701T`, reaches only
`11.949L`, and finishes at `12.181L`.  The other two sampled half-cycle
variants repeat that topology at `8.585--8.772T` with minima
`12.038L` and `11.989L`.  In comparison, the posterior mean-tangent policy
above survives about `1.1T` longer and reaches `0.437L` closer.  All preserve
posterior zero crossings (27--30 observed) and joint-speed maxima near the
`4.54 rad/T` limit, so the half-cycle failures cannot be attributed to the
static-anterior quenching already rejected by inherited guidance.  Adding
instantaneous relative crossflow or target-versus-velocity course to that
half-cycle primitive has not arrested the common upper exit.

The traces expose a more specific feedback defect.  Over `1--5T`, heading
rate and anterior joint rate have correlations `-0.863` in the assigned
parent and `-0.804` in the strongest comparator, with regression slopes
`-0.429` and `-0.373`.  After `5T`, the correlations strengthen to `-0.914`
and `-0.919`, with slopes `-0.525` and `-0.570`.  Bearing likewise contains a
repeatable component opposite anterior angle.  Thus the existing yaw and
bearing terms respond substantially to carrier-phase body wobble rather than
only to route-scale rotation.  In the strongest rollout, instantaneous
bearing changes sign around `4T`, but the phase-averaged route error then
grows and the mean clockwise turn is not arrested before lateral velocity
carries the fish through the upper boundary.

## Policy hypothesis

Preserve the naive anterior Van der Pol oscillator, posterior traveling-wave
target, and smooth acceleration envelope.  Replace half-cycle steering with
the empirically stronger bounded posterior mean tangent, but drive it from a
new proprioceptive phase-cancelled target-rate loop.  Estimate route bearing
as `bearing + k_q*q1` and route yaw rate as
`heading_rate + k_qdot*qdot1`; the positive signs cancel the measured
negative gait correlations without a clock or mutable filter.  Map the
compensated bearing to a bounded desired yaw rate, then use the signed
difference between compensated actual and desired yaw rate to request tail
curvature.  This should countersteer before the body-wobble bearing crosses
can reverse a slow route command, while retaining the useful carrier.

The primary semantic test is remaining inside the field beyond `9.823T` with
the upper-drift velocity reduced.  Quantitatively, the candidate should beat
`11.512L` minimum distance without reducing posterior zero crossings or
increasing joint-limit residence and load excursions.  Falsify the mechanism
if compensation reinforces the carrier-rate oscillation, the first mean turn
has the wrong sign, the same upper exit recurs without a meaningfully
different trajectory, target progress falls to the half-cycle range, or the
alternating 3D wake loses coherence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual control around rhythmic locomotion
source_mechanism: separate the propulsive oscillator phase from slower sensor-driven route modulation
transferable_invariant: preserve a posteriorly lagged traveling bend while preventing phase-periodic body wobble from masquerading as mean heading error or mean yaw response
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, clocked CPG phase, exact vortex phase, species envelopes, and task-specific routes
policy_translation: use normalized body-frame bearing and heading rate together with observed anterior joint angle and rate to cancel gait-phase components, then map the residual target-yaw-rate error to one bounded posterior mean tangent
falsification: reject if phase compensation increases beat-synchronous command reversal, destroys posterior wave crossings, fails to improve on the `11.512L` comparator or its `9.823T` exit, or increases actuator and hydrodynamic load extremes
