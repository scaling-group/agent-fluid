# Candidate diagnosis and hypothesis

The assigned parent `solver_0061f1229104` and its two byte-identical sampled
repeats all captured from direct uniform still water at `27.6045T` and
`0.749769L`. The top-down row shows self-propulsion from rest, a coherent
alternating wake, sustained translation toward the target, and a late
correct-sign turn into the capture circle. The oblique Lambda2 row confirms a
coherent three-dimensional wake rather than window advection. The trajectory
cross-check nevertheless shows fragile envelope use: maximum joint angles
were `0.7826/0.7854 rad`, acceleration commands sat at the `30 rad/T^2` policy
limit for about `23.7/13.7%` of samples, and peak planar force/yaw moment were
`0.03397/0.01548`.

The most informative contrast is sampled solver `solver_3ffc6d12db60`. Its
visual route and wake topology remain effectively the same and it also
captures, but a symmetric acceleration-limited stopping-margin guard reduces
maximum joint angles to `0.7655/0.7632 rad`, acceleration-limit residence to
about `21.7/11.9%`, and peak planar force/yaw moment to `0.02212/0.01041`.
Mean distance improves slightly from `2.615648L` to `2.615460L`, yielding the
best sampled score (`-0.709920` versus `-0.710392`) despite capture occurring
`0.165T` later. Thus the useful change is lower envelope/load exposure with
repeat capture, not a scalar terminal-accuracy claim.

The candidate hypothesis is to preserve the successful inertial
line-of-sight response closure and its anterior-only positive-deficit
allocation exactly, then promote the sampled two-joint stopping-margin guard.
For each joint, only outward motion is guarded; angle plus the normalized
constant-deceleration stopping excursion activates a smooth inward-only
residual near the hard joint envelope. This should reproduce capture while
retaining the observed reductions in angle, force, moment, and clipped-command
residence. Falsify the mechanism if formal evaluation loses capture, changes
the coherent target-directed route, increases any of those envelope/load
measures, or merely shifts saturation elsewhere.

bookshelf_consulted: true
source_domain: rhythmic locomotion with sensor-feedback residuals and swimming-efficiency guardrails
source_mechanism: preserve a stable propulsive rhythm while a bounded state-feedback residual enforces a physical envelope
transferable_invariant: intervene only when normalized observed state predicts loss of actuator headroom, and otherwise leave the evidenced traveling bend unchanged
nontransferable_details: published CPG gains, species kinematics, dimensional frequencies, Strouhal targets, exact vortex phase, and task-specific routes
policy_translation: apply the same smooth angle-plus-stopping-excursion guard to each observed joint, with an inward-only acceleration residual and no clock, coordinates, or wake-phase assumption
falsification: reject if repeat capture, coherent propulsion, load reduction, or joint-envelope reduction fails relative to the unguarded sampled parent
