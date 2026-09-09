# Candidate diagnosis and hypothesis

The four sampled rollouts satisfy the experiment contract: their observations
and diagnostics report direct uniform initialization at `U_infinity=(0,0,0)`,
no cylinders, and no prewarm.  In both rows of each combined keyframe sheet,
the fish self-propels rather than advects: the top-down row shows a persistent
alternating vorticity street and the oblique row shows compact alternating
Lambda2 structures shed behind the body.  The sheets and trajectories agree
on the failure topology.  Each fish follows a broad target-directed arc, passes
below the target with a coherent wake, and continues under power until the
lower virtual boundary at about `30.9--31.6T`; none is unstable or captured.

The assigned parent `solver_cb10b3fc3e7f` used a posterior half-cycle
counterbend and reached `2.512L` before the same lower exit.  The strongest
sampled finite trajectory, `solver_563a0d75514e`, instead attenuated posterior
oscillation on a yaw-selected half-cycle and improved the minimum to `2.385L`
and mean distance to `8.436L`, but at its minimum it still moved at about
`0.705U`, had essentially zero target closure, a `1.379 rad` full body-frame
direction error, and `2.185 rad/T` heading rate.  The full-direction gate and
response-gated posterior S-bend samples reached only `2.494L` and `2.536L`;
all four retained the same powered lateral miss.  Their near-`3L` posterior
commands were not clamped, while anterior acceleration was clamped for roughly
`0.73--0.75` of near samples.  More posterior equilibrium, posterior gating,
or added acceleration magnitude is therefore poorly supported.

Policy hypothesis: preserve the complete far-field alignment-gated carrier,
but replace the parent's posterior half-cycle counterbend with one
response-released anterior burst redirect.  Large normalized lateral target
error inside a smooth approach envelope adds bounded target-signed curvature
only to the anterior oscillator equilibrium.  Corrective body-frame bearing
response releases that extra curvature continuously; the posterior mean and
lagged oscillatory wave remain on the cruise law and thus retain propulsion.
This is intended to prevent repeated uncorrected yaw half-cycles without
trading away target-ray closure through another persistent posterior bend.
It is falsified by degraded far-field progress, a collapsed or one-sided wake,
tight curling or joint-limit residence, loss of the `2.385L` closest approach,
or the same lower exit without a material distance/trajectory improvement.

bookshelf_consulted: true
source_domain: biological burst turns and sensor-modulated robotic-fish CPG turning
source_mechanism: large observed direction error requests a bounded nonsteady curvature burst, then measured corrective response releases back to the propulsive rhythm
transferable_invariant: allocate transient steering asymmetry to observed target error and release it on observed turn response while retaining a lagged posterior thrust wave
nontransferable_details: species-specific C-start kinematics, published CPG gains and duty ratios, dimensional beat rates, full-body envelopes, exact vortex phases, and prescribed routes
policy_translation: normalized body-frame target geometry and bearing-window response schedule an anterior-only equilibrium offset under the two-joint state-feedback contract; the posterior carrier is unchanged
falsification: reject if cruise changes, wake coherence or closure collapses, actuator-limit residence rises, the fish curls, or closest approach and termination topology do not improve
