# Wake-policy candidate diagnosis

## Evidence read before editing

- The only sampled rollout is the assigned prefill `solver_2ce3d25ef5a2`; no inherited optimizer-note file is present in this Phase 2 workspace. The inherited guidance is unchanged from parent `optimizer_a83ed6b31a3d` (Elo 1500), so the sampled CFD result is the available behavioral evidence.
- The evidence satisfies the experiment contract: direct uniform quiescent initialization, `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. It is a finite dynamics result (`unstable=false`), not a numerical failure.
- Both the combined and view-specific sheets show self-propulsion and a coherent alternating wake. The propulsive traveling bend therefore survives transfer to L64 3D and should be preserved. The wake is not externally advecting the fish in this still-water case.
- At the best finite portion near 16--17 T, distance has fallen from 12.328 L to 6.127 L, but the body is already moving below the target and its heading has rotated counterclockwise from 0.506 rad to roughly 1.1 rad. By termination at 26.13 T the center is `(14.180,0.799)L`, speed is predominantly downward (`v_y=-0.811 L/T`), heading is 1.383 rad, and distance has reopened to 10.542 L. The top-down sheet shows the route bending away after closest approach; the oblique Lambda2 sheet confirms a compact alternating wake persists through that wrong-way turn.
- The sampled trajectory provides a sign diagnostic absent from the scalar score: the inherited controller maintains a mostly positive cumulative tail tangent (`phi1+phi2`) while net heading rises by 0.877 rad. Its negative target request maps through `negative_turn_curvature_gain < 0` to a positive posterior mean tangent, so the geometry request does not oppose the observed counterclockwise drift. Local-flow crossflow is only about `0.007 U` at termination, hence external wake rejection is not the missing first mechanism.

## Candidate hypothesis

Preserve the naive state-feedback oscillator and posterior phase lag, but replace the inherited many-branch 2D steering translation with one reflection-symmetric 3D mechanism: body-frame bearing maps directly to a bounded posterior mean curvature embedded in the lagged tail target. In this observed sign convention a target at positive body lateral bearing requests negative cumulative tail tangent. This directly reverses the contradicted mapping while avoiding the inherited controller's fast, branch-heavy yaw-rate modulation of the propulsive cycle.

Expected test: the initial positive bearing should make the mean cumulative tail tangent negative and keep heading from drifting above the target direction; the rollout should avoid the lower-boundary exit and improve on the 6.127 L closest approach. This mechanism is falsified if mean tail sign changes as intended but heading still rises, if the coherent wake/thrust collapses, if joint/acceleration limits become persistently active, or if the trajectory preserves the same below-target topology.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and biological mean-curvature/tail-beat bias
source_mechanism: add a bounded, observed direction-dependent mean bend to an otherwise propulsive traveling rhythm
transferable_invariant: persistent body-frame direction error should bias cycle-mean curvature while the posterior joint retains phase lag for thrust
nontransferable_details: published CPG gains, robot geometry, species kinematics, dimensional beat frequency, exact vortex phase, and any world-frame route
policy_translation: use the normalized body-frame bearing as a bounded sign-reversing mean-tail command and place that correction in the posterior lag target of the two-joint state-feedback oscillator
falsification: reject the transfer if the commanded mean-tail sign changes without correcting heading, or if it destroys coherent propulsion, causes persistent saturation, or repeats the lower-boundary exit
