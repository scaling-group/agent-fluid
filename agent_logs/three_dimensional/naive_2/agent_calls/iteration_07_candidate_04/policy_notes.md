# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled diagnostics confirm direct uniform initialization in still
water, `U_infinity=(0,0,0)`, no cylinders, and finite `left_domain`
termination. The best-score amplitude-relief rollout and the most informative
closest-approach failure both show self-propulsion in their combined sheets:
alternating mid-plane vorticity and tail-connected three-dimensional Lambda2
structures form by about `4T` and persist to exit. Neither is advected, and
neither loses its wake immediately before failure. Both instead carry a
coherent propulsive axis upward while the target remains below it.

The assigned parent's distance-only amplitude relief is now a negative result.
Reducing the carrier toward 60% inside roughly `5L` reaches only `5.126L`,
versus `4.419L` for the full-wave `3 deg` course redistribution, and still
leaves through the upper boundary at `20.861T`. Course-misalignment damping is
worse (`6.397L` minimum, `16.830T` exit). In contrast, extending transient
anterior redistribution to `4 deg` and relaxing its course window during
approach reaches `3.135L` at `18.249T`, but then recedes to `10.210L` before
its `30.113T` upper/left exit. At that minimum its reconstructed normalized
body-frame target vector is about `(-1.784,-2.578)`, bearing is `-0.965 rad`,
target-to-velocity course error is `-1.410 rad`, speed is `0.852U`, and recent
yaw rate is `-0.458 rad/T`: the fish is turning toward the target but its
velocity is still nearly transverse. The full-wave rollout remains finite
with peak force/moment coefficients `0.03368/0.01750`; either action is within
5% of the soft limit on `71.9%` of samples. This is a terminal redirection
failure, not evidence for less far-field propulsion or another global
curvature gain.

## Single candidate hypothesis

Start from the `4 deg` approach-redistribution controller because it provides
the best sampled closest approach. Preserve its Van der Pol carrier, full
posterior lag, crossflow residual, centerline course brake, recent-yaw term,
bounded posterior mean, and soft action envelope. Add one terminal burst-
redirect mechanism. A compact smooth distance gate is exactly zero outside
`4.5L`; inside it, large body-frame target-to-velocity misalignment adds a
bounded transient anterior equilibrium shift in the requested turn direction.
The existing posterior target remains referenced to actual anterior angle, so
the maneuver redistributes curvature without increasing the commanded tail-end
mean. The added shift releases continuously when course alignment returns and
the original full carrier then remains.

The extra terminal shift is bounded at `6 deg`; together with the sampled
`4 deg` approach shift and `28 deg` carrier it keeps the nominal anterior
angle envelope below the released `45 deg` joint limit. Because its compact
gate is zero until after the inherited route has already crossed `4.5L`, this
test isolates terminal redirection from the earlier failed global static-bend,
damping, and amplitude-relief mechanisms. Falsify it if closest approach does
not beat `3.135L`, post-minimum recession and upper/left exit remain unchanged,
the alternating 3D wake collapses before the gate, anterior speed collapses
toward the static-centering failures, or saturation and force/moment peaks
materially exceed the route-best rollout.

bookshelf_consulted: true
source_domain: biological C-start redirection and closed-loop robotic-fish rhythmic steering
source_mechanism: a large target-error-triggered curvature burst that releases into the propulsive rhythm when observed course response appears
transferable_invariant: retain the established traveling wave during transit, but use observed target proximity and target-relative course misalignment to gate a bounded nonsteady redirect and release it on alignment
nontransferable_details: species-specific C-start bends, published gains, dimensional distances, clock timing, robot kinematics, exact vortex phases, and prescribed routes
policy_translation: combine normalized `distance_L` with the body-frame target-to-velocity angle to add a compactly gated anterior equilibrium shift while retaining the two-joint state-feedback oscillator, actual-state posterior lag, and bounded tail mean
falsification: reject if the rollout fails to beat 3.135L, repeats the same post-minimum recession, disturbs the far route or coherent wake before 4.5L, collapses joint speed, or worsens actuator and hydrodynamic load excursions
