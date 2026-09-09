# Candidate diagnosis and hypothesis

The assigned parent is the prefilled `optimizer_5622292d915a` guidance and
its `solver_072da2f3a45e` candidate. All four sampled evaluations are valid
direct-uniform, zero-inflow still-water captures. The strongest-score combined
sheet (`solver_072da2f3a45e`) and weakest-score combined sheet
(`solver_2a49b91aea58`) show the same control class in both views: the fish
self-propels, turns toward the target, leaves an alternating coherent
top-down street, retains compact caudal Lambda2 structures, and reaches the
capture circle without a visible instability. The inherited failed terminal
course residual is therefore the informative failure record; no sampled
keyframe sheet depicts a failed rollout.

The sampled diagnostics do not establish the parent's terminal amplitude
relief as demand relief. Its capture at `19.0520T` and mean distance
`2.09874L` is slightly better in distance integral but later than the two
identical no-relief terminal-velocity repeats at `18.8650--19.0080T` and
`2.09994--2.10468L`. Those duplicate repeats span more score variation than
the parent's margin. The parent's acceleration contact (`60.94%/73.12%`),
rate contact (`10.91%/14.75%`), and RMS action (`27.15/28.61 rad/T^2`) also
overlap the no-relief repeats. A compound of terminal velocity release and
amplitude scheduling is consequently not attributable as an improvement.

Policy hypothesis: return to geometry-owned differential curvature with the
validated final acceleration projection, remove both unestablished terminal
qualifiers, and test one phase-preserving actuator mechanism. Infer a
short-horizon anterior phase coordinate from normalized joint displacement
plus normalized joint velocity, then apply the existing positive bounded
half-cycle scale to both curvature shares. Compared with displacement-only
phase steering, this should begin the target-side redistribution before the
joint reaches that bend, reducing route lag while preserving carrier
frequency, posterior lag, mean-curvature sign, and wake class.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: half-cycle amplitude asymmetry inferred from joint state
transferable_invariant: redistribute an existing target-owned turn request over observed beat phase with a positive bounded factor so steering can strengthen without reversing route sign or replacing the traveling wave
nontransferable_details: published duty ratios, gains, clock phase, robot geometry, species kinematics, exact vortex phases, and task routes
policy_translation: use body-frame target lateral fraction for curvature sign and the normalized pair `(phi1-bias, phi1_dot/omega)` for a short-horizon phase lead; modulate anterior and posterior curvature shares together within a positive bound
falsification: reject if capture is lost, the coherent top-down and caudal 3D wake class changes, mean distance fails to improve beyond the sampled `2.0987--2.1047L` band on replication, or rate contact and planar load exceed the successful phase-steered family
