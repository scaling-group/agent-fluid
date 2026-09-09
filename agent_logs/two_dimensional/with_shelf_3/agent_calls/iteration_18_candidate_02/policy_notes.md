# Multi-Wake Policy Candidate Notes

## Evidence diagnosis

The shared prewarm sheet is byte-identical across all four samples and shows
the fish held above and downstream of four developed, interacting vortex
streets.  It is common initial-condition evidence, not a policy result.  The
four released sheets, policies, and compact diagnostics are also byte-identical:
each fish turns down and upstream, maintains a coherent posterior-traveling
body wake, crosses the developed cylinder wakes only late in a compact diagonal
approach, and reaches the target without coasting, reversal, collision, or a
visible loss of wave structure.  The sampled set contains no failure sheet, so
the inherited downstream-exit/no-traveling-wave cases remain the adverse visual
boundary rather than a new failure comparison.

All four samples reproduce target capture at `31.56447` release time, mean
distance `1.60525L`, score `0.266663`, mean command energy `1420.86`, mean power
proxy `108.30`, relative-crossflow RMS `0.24105`, and force/moment RMS
`66.32/887.63`.  Both joints still touch the velocity and acceleration limits,
but their peak excursions are `0.5191/0.5555 rad`.  Relative to the assigned
parent's response-supervised result at `32.31796`, mean distance `1.63741L`,
and score `0.234705`, the reproduced target-signed yaw-load gate is a material
navigation improvement on the same direct topology.  Its force/moment RMS is
not jointly lower than the parent's `65.52/881.45`, and crossflow remains in the
same regime, so the evidence supports faster closure—not wake avoidance,
efficiency, desaturation, or held-out wake robustness.

Inherited logs rule out several superficially similar edits: an undirected
physical-limit gate delayed capture to `33.9405`, a response-conditioned
withdrawal added at another controller layer regressed to `32.4555`, and an
unrestricted bearing-trend path destroyed the traveling bend and exited
downstream.  The useful invariant is therefore target-signed withdrawal at the
one optional posterior-residual locus while distributed mean curvature and the
unit-gain traveling wave remain active.

## Policy hypothesis

Extend the reproduced yaw-load gate into one bounded planar-wrench assistance
mechanism.  Preserve the filtered bearing-to-curvature route loop, anterior
oscillator, unit-gain lagged posterior wave, coherent-closure supervisor, and
all existing gait gains.  In body coordinates, lateral force with the same sign
as the persistent target-bearing request translates the fish toward the target
side, just as same-signed yaw moment rotates it toward that side.  Normalize
each load by its rollout-observed order-one scale and let either helpful
component add withdrawal pressure only at the optional posterior half-cycle
residual.  Opposing or absent force and moment leave the reproduced controller
unchanged.  This tests whether avoiding redundant steering while the wake
supplies either targetward lateral translation or yaw can improve arrival or
loads without weakening propulsion.

bookshelf_consulted: true
source_domain: biological Karman-gait and wake-exploitation studies
source_mechanism: swimmers may preserve helpful vortex-induced translation or rotation by yielding optional active effort instead of cancelling every lateral load
transferable_invariant: use only measured body-frame load components that agree with the current target-directed response to withdraw bounded optional control authority
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequencies, published gains, exact vortex phases, and prescribed routes
policy_translation: combine softly bounded target-signed `force_body_L[2]` and `moment_z_L2` as planar-wrench assistance, gated by coherent closure and applied only to the optional posterior half-cycle residual
falsification: reject if target capture or the compact traveling-wave route is lost, if arrival and distance integral regress, or if force, moment, switching, effort, or saturation rises without a compensating navigation benefit

## Scope

The force scale is anchored only to the sampled order of magnitude
(`66.32 / L64 = 1.04`), not copied from the bookshelf.  This candidate does not
infer vortex phase, cancel crossflow, use coordinates, alter the mean curvature
or base wave, or claim a result before EvE's post-worker CFD evaluation.
