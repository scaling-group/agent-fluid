# Wake policy candidate notes

## Evidence diagnosis

The assigned parent contributes the fresh-lineage control contract and an Elo
of `1500`, but the workspace contains no inherited `logs/optimize/` material;
there is therefore no earlier candidate mechanism claim to preserve. The only
sampled rollout, `solver_064577d12113`, is both the best available
finite example and the informative failure; no successful comparator is
present in this fresh lineage. It satisfies the experiment contract: direct
uniform still-water initialization, no prewarm, no cylinders, and free planar
yaw/sway/surge. The combined and view-specific sheets show self-propulsion and
an alternating three-dimensional wake, so lack of a carrier is not the first
defect. Instead, the initially small positive body-frame target bearing is not
regulated. The fish passes near alignment around `4T`, continues into a large
yaw excursion, curls upward in both the top-down vorticity and oblique Lambda2
views, and exits the upper virtual boundary at `8.547T`.

The trajectory cross-check agrees: distance falls only from `12.328L` to a
minimum `12.078L` at about `6.36T`, then rises to `12.380L`; center position
moves from `(21.0,14.0)L` to `(20.075,15.200)L`. Body heading changes from
`0.506` rad to `-0.782` rad, while the observed body-frame bearing grows from
about `+0.155` rad to roughly `-1.2` rad after the fish sweeps past alignment.
Joint angles remain within the `45 deg` envelope, but both joint velocities
reach the `260 deg/T` limit and requested accelerations reach about `60` and
`75 rad/T^2`, respectively. Thus more open-loop drive or scalar-only carrier
tuning would not address the failure topology.

## Policy hypothesis

Preserve the seed's autonomous Van der Pol carrier and lagged posterior wave.
Add one bounded mean-curvature mechanism to the posterior target. Its command
uses only normalized body-frame bearing and the available short-window bearing
trend: the trend predicts a small distance ahead in bearing space so curvature
is released or reversed as the target line is being crossed. This should turn
the initially positive bearing in the evidenced corrective direction while
braking the continuing yaw that produced the boundary exit. It is deliberately
bounded to preserve the carrier and coherent wake.

bookshelf_consulted: true
source_domain: classical fish turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: target-feedback mean-curvature or tail-beat bias layered on a propulsive rhythm
transferable_invariant: persistent target-direction error should produce bounded average body curvature while measured error trend releases or reverses that curvature before oversteer
nontransferable_details: published gains, species-specific envelopes, clock-driven CPG phase, exact tail-beat asymmetry, vortex phase, and task-specific routes
policy_translation: map body-frame bearing plus bounded short-window bearing rate to a saturated mean posterior tangent, retaining the two-joint state-feedback oscillator and its posterior lag
falsification: reject if the next rollout still exits the upper boundary without materially lowering minimum distance, if bearing crosses and diverges with the same large yaw arc, or if steering suppresses the alternating propulsive wake or increases limit residence

The new candidate has no same-worker CFD result. Its expected semantic
improvement is a longer target-directed finite trajectory (ideally capture),
not a claimed score improvement.
