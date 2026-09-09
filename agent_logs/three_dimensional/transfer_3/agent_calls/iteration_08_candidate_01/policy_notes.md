# Response-damped half-cycle course candidate

## Evidence diagnosis recorded before the policy edit

All four sampled diagnostics report direct uniform quiescent initialization,
zero cylinders, finite dynamics, and `left_domain` termination. Their motion
is self-propelled rather than imposed-flow or moving-window advection. In both
rows of the combined sheets, `solver_adc862529891`,
`solver_b22e8cf1f277`, and `solver_4c50eba7cd00` shed an alternating
top-down vorticity street and compact oblique Lambda2 structures. The carrier
is therefore worth preserving even though none captures the target.

The strongest finite-score sample `solver_adc862529891` exits upward at
`16.77T` after reaching `5.658L`; its head has risen from `13.74L` to
`15.34L`. The raw-slip prefill and the two-joint lateral-recoil projection
improve minimum distance to `4.158L` and `4.128L`, but both pass the target x
station about `4.22--4.24L` high and exit left near `29.6T`, finishing about
`9.05L` away. Their almost identical topology makes another recoil coefficient
or attenuated-slip gain unsupported.

`solver_7108cd3d3374` is the direct falsification of the assigned parent's
next full-course hypothesis. Despite an intact wake, it travels almost
horizontally near `y=13.9L`, crosses the target x station `4.42L` high, reaches
only `4.358L`, and exits left at `24.99T` with final distance `9.767L`.
Its local-flow RMS is only about `(0.020,0.008)U`, so lack of vertical route
authority is not a wake-disturbance problem. Raw body-lateral velocity has
`0.385U` RMS; the inherited joint-state projection reduces this to `0.140U`,
consistent with the `0.307 -> 0.119U` and `0.306 -> 0.120U` reductions in the
two closest samples. Course response remains a useful demand, but posterior
mean curvature has not converted it into the needed trajectory.

An inherited completed actuator test provides a bounded counterexample:
direct course-driven posterior half-cycle asymmetry generated a tight early
turn and upper exit, whereas the mean-curvature family lacks course authority.
Thus asymmetry can redirect the route, but direct error forcing does not brake
the accumulated yaw. The active carrier is already frequently acceleration
limited in the sampled traces, so this candidate preserves it rather than
claiming a scalar drive fix.

## Policy hypothesis

Preserve the evidenced `28 degree`, `0.55T` joint-state traveling bend.
Project the joint-correlated component out of body-lateral velocity and rigid
yaw, form a bounded low-speed-gated full target-course demand, and compare the
observed yaw residual with that demand. Use only this response excess to
modulate posterior half-cycle strength by at most ten percent. Joint state
identifies beat side without a clock; when yaw outruns the demand, the residual
reverses the asymmetry and supplies the braking absent from direct half-cycle
steering.

Expected evidence is coherent propulsion plus a materially lower target-line
crossing, asymmetry reversal before the inherited tight upper turn, and a
minimum below `4.128L` or a better termination class. Reject the mechanism if
the early upper exit returns, the more-than-`4L` high left pass remains, the
response residual stays gait-dominated, or propulsion/wake coherence degrades.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: sensory yaw-response feedback modulates half-cycle strength on a persistent propulsive rhythm
transferable_invariant: asymmetric steering should reverse when observed turn response outruns the bounded route demand while the traveling-wave carrier remains active
nontransferable_details: published gains, robot linkage geometry, clock phase, dimensional beat rates, species kinematics, exact vortex phases, and task-specific paths
policy_translation: use normalized body-frame target and velocity course, remove evidenced joint-rate recoil from lateral velocity and yaw, and map only bounded yaw-response excess to state-identified posterior half-cycle scaling in the two-joint contract
falsification: reject if the direct-half-cycle upper-turn topology returns, the target-line crossing remains more than 4L high, closest approach does not beat 4.128L, or wake coherence and propulsion weaken
