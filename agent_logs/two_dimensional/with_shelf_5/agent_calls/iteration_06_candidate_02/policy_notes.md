# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the fish held at the upper-right release pose
while four staggered-cylinder vortex streets develop across the target
corridor. This is the common initial condition, not a policy difference. No
current sampled rollout is a failure, so the comparison below uses the best
finite success against the slowest informative success and cross-checks both
against inherited failure notes.

The prefilled policy reaches the target, but its released sheet shows a broad,
delayed hook: the fish remains near the upper-right edge for several frames,
turns through a large dogleg, and reaches the wake corridor only late. It needs
`93.027` released time, has `4.031L` mean distance, expends `9.05e4` total
command energy, and carries RMS lateral force/moment of `95.4/1146`. Its mean
velocity `(-0.117,-0.047)` versus mean local flow `(-0.039,-0.075)` confirms
some self-propulsion, but the route is inefficient rather than a passive-wake
success. The assigned-parent and sampled logs also show that terminal
bearing-rate lead, anterior timing asymmetry, amplitude-only scheduling, and
other scalar terminal changes retained this approximately `93`-time topology;
global carrier reductions and increased static curvature instead caused early
domain exits.

The posterior half-cycle-curvature samples visibly make an immediate,
correct-sign redirect, then carry a coherent traveling bend along a compact
diagonal trajectory into the merged wake and target. They reach after
`43.9505`, with about `2.14L` mean distance and `5.31e4` total command energy.
Their mean velocity `(-0.247,-0.102)` versus local flow
`(-0.134,-0.156)` includes substantial self-propelled upstream motion. RMS
force/moment fall to about `49.4/701`; both rate and acceleration caps are
still reached, and mean command effort is higher, so the supported benefit is
fast route establishment and lower episode-integrated effort/load rather than
removal of instantaneous saturation.

The clean half-cycle sample and the two samples that retain a smooth approach
amplitude taper all terminate at the same recorded `43.9505` time with the
same visible topology. The taper changes mean distance only from `2.1412L` to
`2.1391L`, total command energy from `53082.36` to `53082.58`, and RMS
force/moment from `49.45/701.31` to `49.44/701.26`. It is therefore a
second-order envelope, not the cause of the semantic improvement. I retain the
assigned-parent tapered version because it has the strongest sampled distance
result, while keeping the posterior state-phase redistribution as the sole
causal mechanism under test.

## Policy hypothesis

Replace the prefilled terminal bearing-rate controller with the evaluated
assigned-parent policy. Preserve the `0.55`-period, `28 deg` anterior
joint-state oscillator, bounded `8 deg` body-frame bearing bias, and posterior
velocity-dependent lag. Reduce the always-on posterior steering share and
restore the removed average curvature on the target-favored half-cycle, whose
phase is inferred smoothly from centered anterior joint state. Retain the
existing normalized-distance amplitude envelope without attributing the fast
turn to it.

The candidate should reproduce the early redirect and approximately
`43.95`-time compact trajectory without a clock, fixed coordinates, known wake
phase, or route memory. Falsify the mechanism if capture is delayed or lost,
the broad dogleg returns, the traveling bend collapses, or episode load/effort
rises without the distance-integral benefit. Do not treat unchanged hard-limit
hits alone as falsification, because every fast sampled rollout retains them.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and biological turning by asymmetric tail beats
source_mechanism: target-directed half-cycle steering asymmetry superposed on a traveling propulsive bend
transferable_invariant: persistent body-frame turn error can redistribute posterior curvature toward the target-favored observed joint-state half-cycle while preserving the anterior rhythm and approximate cycle-average bend
nontransferable_details: published gains and duty ratios, clocked phase, species or robot kinematics, dimensional frequencies, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain normalized bearing-to-anterior-curvature feedback and posterior lag; use bounded bearing sign times centered anterior joint state to gate a parameter-owned posterior curvature boost while reducing the always-on posterior share
falsification: reject if the fast target-reaching topology is not reproduced, capture is delayed or lost, the traveling bend collapses, or load and effort increase without improved distance progress

## Verification boundary

All performance statements above refer to inherited and sampled CFD evidence.
This worker does not run formal CFD; the current candidate's rollout is future
evidence. The candidate is byte-identical to the evaluated assigned-parent
policy (SHA-256
`23a6c95704632db0ceb779d6317d3808fc43a4858b7331e02e0e36eab2831dc5`).
The prescribed guidance-semantic and editable-boundary checks pass, and a
deterministic audit confirms that every direct `params.FIELD` reference is
returned by `target_policy_params()`. The Julia executable contract assertion
could not start because this runtime contains neither a `julia` executable nor
`libjulia`; this is an environment limitation, not a detected policy failure.
