# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled diagnostics report direct uniform initialization in still
water, zero background velocity, no cylinders, and finite `left_domain`
termination. The combined keyframe sheets show self-propulsion rather than
advection in both required views: the top-down rows develop alternating
mid-plane vortex streets, while the oblique rows show tail-connected
three-dimensional Lambda2 structures. Wake formation remains coherent to
termination. The common failure is route geometry: the visible tracks remain
above the target and ultimately turn into the upper boundary.

The two course-triggered anterior-redistribution rollouts are a semantic
improvement over the assigned-parent evidence. The `3 deg` candidate
(`solver_c0a67102cc0a`) survives to `23.260T` and reaches `4.419L`; the `4 deg`
candidate (`solver_6d90d1984e81`) survives to `27.572T` and reaches `3.161L`.
Both retain long coherent wakes and beat the posterior-only course brake
(`solver_80d41cb1405d`, `9.880L` at `11.594T`). The prefilled `7 deg`
large-bearing redirect (`solver_bff3d6a0f652`) is the opposite control: it
slows the carrier, reaches only `11.081L`, and exits at `10.324T`. Thus small
course-triggered redistribution is useful, but a large early bearing bend is
not. The inherited log for separately bounded yaw recoil
(`solver_9ffd27c690f3`) reports only `10.738L` minimum/final distance and does
not beat the posterior-only course baseline, so that saturation decomposition
is not a supported substitute for the completed redistribution evidence.

Trajectory histories isolate the residual miss. The `4 deg` run moves the head
from `(20.575,13.741)L` to `(9.511,12.619)L` by its closest approach, so it
solves most of the streamwise distance while remaining `3.119L` above the
target. At that instant distance is `3.161L`, body-frame course error is about
`-1.49 rad`, bearing is `-0.99 rad`, and speed is about `0.85U`. The `3 deg`
run is analogous: at its `4.419L` minimum the head is `(10.082,13.785)L`,
course error is saturated near `-pi/2`, and speed is about `0.83U`. In both
policies the anterior course lever is suppressed by its small-bearing window
just when lateral correction is most necessary; the fish then crosses the
target's streamwise station and recedes. This is a fast lateral miss, not a
wake collapse or insufficient forward drive. The `4 deg` run does incur
higher sampled peak force/moment coefficients (`0.0276/0.0175`) than the
posterior-only baseline (`0.0244/0.0138`), so the new gate must not increase
curvature amplitude.

## Single candidate hypothesis

Return to the `4 deg` candidate's zero-mean anterior oscillator, full posterior
lag, relative-crossflow residual, centerline course brake, yaw damping,
`12 deg` tail-end mean, and smooth acceleration bounds. Add one continuous
approach-scheduling mechanism only to the anterior redistribution gate. Far
from the target, preserve the tested small-bearing window exactly. As
normalized head distance falls, blend that window toward admitting the same
speed-gated body-frame course cue at larger bearing, while retaining the
existing `4 deg` bound and compensating the posterior target with the actual
anterior angle. The total requested tail-end mean is therefore unchanged; the
controller only keeps the already useful steering lever active during the
lateral approach instead of adding more curvature or reducing the propulsive
wave.

The expected semantic change is downward correction before the target becomes
aft, with the long coherent wake and leftward progress of `solver_6d90d1984e81`
retained. Falsify the mechanism if minimum distance does not beat `3.161L`, if
the fish again crosses the target's streamwise station more than `3L` above it,
if termination is no better than the same upper exit, if the anterior carrier
slows toward the failed `7 deg` redirect, or if acceleration residence and
force/moment peaks materially exceed the `4 deg` baseline. The new CFD result
is not available to this worker and is not claimed here.

A gate-only replay over the completed `4 deg` history confirms that the new
mapping is identical to that baseline at and beyond `6.5L`. Inside the
approach range it raises anterior-center RMS magnitude from `1.14` to
`2.03 deg`, but the maximum remains `3.81 deg`; representative requests are
`-0.62 deg` at `5.07L`, `-2.69 deg` at `3.77L`, and `-3.80 deg` at `3.19L`.
This check establishes boundedness and localization only, not a hydrodynamic
outcome.

bookshelf_consulted: true
source_domain: terminal capture scheduling and closed-loop robotic-fish CPG curvature modulation
source_mechanism: retain a propulsive rhythm while continuously shifting steering authority from a narrow far-field course correction to stronger observed-course correction during approach
transferable_invariant: once broad target-directed propulsion exists, normalized distance may schedule a bounded steering-shape lever so a fast lateral miss is corrected without replacing the carrier or increasing total curvature
nontransferable_details: published gains, dimensional approach distances, oscillator clocks, robot or species kinematics, exact vortex phases, and task-specific routes
policy_translation: preserve the joint-state traveling wave and posterior route command; use `distance_L` only to relax the bearing window on the existing speed-gated body-frame course signal that shifts the anterior equilibrium by at most four degrees
falsification: reject if closest approach does not beat 3.161L, lateral error near the streamwise crossing remains above 3L, the long alternating 3D wake degrades, or actuator and hydrodynamic load excursions grow materially
