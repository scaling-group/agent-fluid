# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

The shared prewarm sheet shows the fish held above and downstream of four
developed, interacting vortex streets. It is the certified common initial
condition, not evidence that any controller selected a wake phase or route.
The sampled set contains two unique controller outcomes, each repeated exactly
in independent evaluation workspaces, and no released failure sheet. The
inherited downstream-exit/no-traveling-wave results therefore remain the
adverse boundary rather than a newly inspected visual failure.

Both unique released sheets show the same useful topology: the fish turns down
and upstream, sustains a coherent posterior-traveling body wake, follows one
compact diagonal with ample cylinder clearance, and enters the dense merged
wakes only near nose-first capture. Head motion is much faster upstream than
the mean local flow, so this is active propulsion rather than passive
advection. The sampled yaw-only fluid-assistance gate captures at `31.56447`,
with mean distance `1.60525L`, mean command energy `1420.86`, mean power proxy
`108.30`, relative-crossflow RMS `0.24105`, and force/moment RMS
`66.32/887.63`. Extending that same optional-residual gate with target-signed
lateral force captures at `30.48645`, lowers mean distance to `1.56766L`, mean
command energy to `1416.41`, mean power proxy to `107.80`, relative-crossflow
RMS to `0.23534`, and force/moment RMS to `65.80/872.96`. Peak joint excursions
also fall from `0.5191/0.5555` to `0.5094/0.5190 rad`, although both branches
still touch the velocity and acceleration limits. Thus the positive evidence
is for withdrawing only redundant incremental steering when the measured
fluid wrench assists target motion; it is not evidence of wake avoidance,
desaturation, energy-optimality, or held-out wake-phase robustness.

The inherited logs sharpen the boundary: undirected physical-limit damping
delayed capture, adding more response-conditioned withdrawal at another layer
regressed, and unrestricted target-rate feedback at the oscillator centers
destroyed the traveling bend and exited downstream. The new candidate must
therefore preserve distributed mean curvature, the unit-gain lagged wave, and
the single optional posterior-residual locus. Scalar gain escalation and a new
response supervisor are not supported.

## Policy hypothesis

Generalize the evidenced lateral-force cue into a target-axis fluid-assistance
cue. Normalize the instantaneous body-frame target vector and project the
normalized body-frame force onto it; only a positive projection counts as
translational assistance. Combine that cue with the existing target-signed yaw
moment at the same bounded optional posterior half-cycle residual, under the
same coherent-closure supervisor. This preserves the sampled behavior when a
lateral load points toward the target, also recognizes helpful axial loading,
and rejects a nominally correct lateral load when its full force vector points
away from the target. Opposing or absent loads recover the evaluated
controller. Falsify the candidate if it loses capture or the compact traveling
wave, arrives later or increases distance integral, force, moment, switching,
effort, or saturation without a navigation benefit, or fails under a later
held-out wake.

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: swimmers may yield optional active effort when organized fluid loading already assists task-directed motion instead of cancelling all wake-induced motion
transferable_invariant: preserve the propulsive wave and route controller while recognizing assistance only from measured body-frame wrench components aligned with the instantaneous task direction
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequencies, published gains, species morphology, exact vortex phases, and prescribed routes
policy_translation: project normalized `force_body_L` onto normalized `target_body_L`, combine its positive part with target-signed normalized yaw moment, and apply the cue only to withdrawal of the optional posterior half-cycle residual during coherent closure
falsification: reject if direct capture or the traveling wake is lost, if arrival and distance integral regress, or if force, moment, effort, switching, or saturation rises without compensating navigation benefit

## Scope

This is one observation-geometry change, not a route, vortex-phase estimator,
or gain sweep. Formal CFD evaluation remains downstream, so no same-worker
performance claim is made.
