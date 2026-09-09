# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled evaluations report `uniform_direct` initialization,
`U_infinity=(0,0,0)`, no cylinders, and horizon termination. The combined
keyframe sheets were inspected in both their top-down mid-plane vorticity row
and oblique body/Lambda2 row. The assigned parent and strongest sampled
semantic near miss, `solver_6eb170b0d70a`, is visibly self-propelled: it lays down a
coherent alternating three-dimensional wake and follows repeated return loops
around the target instead of being advected. It reaches `1.241L`, remains
inside `1.25L` for about `0.47T`, and finishes at `2.082L`. At the closest miss,
the trajectory cross-check shows finite speed (`0.669U`), `1.692 rad`
target-ray/course error, slightly receding course (`course_dot=-0.121`), weak
requested-sign yaw (about `0.13 rad/T`), and small joint commands (about
`0.75/0.92 rad/T^2`), so steering authority is available without changing the
propulsive carrier.

The three sampled terminal descendants are informative negative controls.
The rear-crossing selector reaches only `2.366L`; the joint-state C-bend
release reaches `2.215L`; and the low-wave-activity restart reaches `2.369L`.
Their top-down and oblique evidence retains finite translation and the
inherited coherent wake, but their trajectories settle after the first pass
into an almost stationary common C-bend (`|phi_dot|` near zero and near-zero
commands) and a broad orbit. Thus a
rear-side selector, quiet-bend equilibrium release, or low-activity restart is
not supported. The useful parent differs by retaining active joint motion and
large yaw excursions on its tighter loops. The missing terminal behavior is a
brief increase in requested-sign yaw only when that active loop is close,
misaligned, and not already turning adequately.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological rapid turning (C-start / burst redirect)
source_mechanism: bounded nonsteady curvature impulse released when the observed heading response appears
transferable_invariant: large observed directional error may receive extra bounded turn authority, but the action should vanish continuously once measured requested-sign yaw is adequate
nontransferable_details: species-specific body envelope, burst duration, dimensional acceleration, published gains, exact gait or vortex phase, and any prescribed route
policy_translation: preserve the parent's normalized body-frame course-hold C-turn and posterior wave law; add only an anterior acceleration residual gated by target-behind geometry, normalized terminal distance, finite body-frame speed, course misalignment, and a deficit of requested-sign heading rate
falsification: reject if the pre-terminal first-pass trajectory or coherent wake changes, anterior clamp/load residence rises materially, the controller falls into the sampled quiet C-bend, requested-sign yaw does not increase, or minimum distance and near-target residence fail to improve beyond the `1.241L` parent

## Candidate hypothesis

Add a modest anterior-only yaw-response burst to the unchanged terminal
course-hold parent. The existing terminal response weight keeps it local to a
close, target-behind, finite-speed, course-misaligned recovery. A smooth yaw
deficit gate turns it off once requested-sign heading rate reaches the scale
already seen during useful portions of the parent's loops. Offline replay of
the gate over completed trajectories activates it only in the parent within
roughly `2.04L` (including the `1.241L` miss), not in any sampled regressed
descendant, and does not select a clock time, world coordinate, or fixed gait
phase. The new CFD result is intentionally not claimed here; it will be
evidence for a later worker.
