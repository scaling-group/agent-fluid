# Shared-dissipation joint-speed governor candidate

## Evidence diagnosis before edit

All four sampled rollouts are valid direct-uniform still-water episodes
(`U_infinity=0`) and terminate in capture.  The best-score sheet
(`solver_02eaf03fe1d2`, `-0.20606`, `18.6505T`, mean distance `2.09340L`)
and the prefilled parent sheet (`solver_2e35da543303`, `-0.21389`,
`18.8815T`, mean distance `2.10234L`) show the same useful control topology:
the fish self-propels toward the target rather than advecting, lays down a
coherent alternating top-down street, and retains compact caudal Lambda2
structures through approach.  There is no sampled visual failure sheet; the
only inherited failure record is `solver_4b5a9b1731af`, which exited left after
a `3.5687L` closest approach.  It cannot support a new visual claim.

The common unresolved weakness is actuator demand, not route authority.  In
the four sampled captures, policy-side acceleration projection occupies about
`60.7--61.1%` of anterior rows and `73.1--73.4%` of posterior rows; rate contact
occupies about `10.7--11.1%` and `14.7--15.2%`, respectively.  Action RMS stays
near `27.89 rad/T^2`, and the wake/load histories are nearly coincident.
Target-side velocity and terminal amplitude compounds therefore did not
establish demand relief, while inherited pointwise rate tapers removed rate
contact but destroyed capture.  Preserve the captured half-cycle differential-
curvature carrier and test a single different actuator mechanism.

## Policy hypothesis

Use maximum observed joint-speed fraction to activate one smooth dissipative
channel near the known rate envelope.  Apply the same damping coefficient to
both measured joint velocities.  This is gait-level state feedback, not
independent pointwise outward-action clipping: target-owned bias, displacement
phase, half-cycle steering, frequency, amplitude, lag gain, and final
acceleration projection are unchanged.  It should lower rate contact and
acceleration RMS without the route/phase distortion that invalidated the
sampled tapers and velocity-led phase estimator.

A non-CFD joint-only screen rejected the first frequency-scheduling
translation: it reduced acceleration contact and RMS but increased combined
rate contact at the proposed setting.  The final shared-dissipation translation
retained the same bookshelf invariant and, in the same deliberately reduced
screen, reduced both rate contacts to zero while lowering acceleration contact
and RMS.  This is only a policy safety screen, not hydrodynamic evidence or an
improvement claim; the later formal rollout must still test capture, route,
wake, and load consequences.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and low-dimensional residual gait modulation
source_mechanism: modulate a coherent oscillator-level gait envelope from sensor feedback instead of issuing unrelated high-frequency joint corrections
transferable_invariant: actuator-aware gait modulation must preserve the shared traveling-bend phase relation and target-owned mean curvature
nontransferable_details: published gains, clock phase, species-specific frequency and amplitude, full-body kinematics, exact vortex phases, and task routes
policy_translation: compute a bounded speed fraction from both observed joint rates and the parameter-owned rate limit, then activate one smooth common dissipative coefficient on both joint velocities without altering route sign or displacement phase
falsification: reject if capture or the target-directed wake topology is lost, if arrival/mean distance materially exceed the sampled capture band, or if rate contact and RMS demand do not fall together without larger force or moment peaks
