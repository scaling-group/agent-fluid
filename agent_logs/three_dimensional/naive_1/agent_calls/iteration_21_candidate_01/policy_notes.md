# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
finite moving-window transport, and capture. I inspected both the top-down
mid-plane vorticity and oblique body/Lambda2 rows for the two sampled policy
classes and compared them with the inherited `solver_2007aefde8b5`
`left_domain` failure, then cross-checked the images against scores,
`wake_metrics.csv`, diagnostics, trajectories, executable hashes, assigned
guidance, and inherited optimizer notes.

The captured policies are genuinely self-propelled. Their top-down sheets grow
a body-attached alternating street along the target-directed curve, and their
oblique sheets retain compact caudal Lambda2 structures through first
crossing. The two prefill-class policies capture at `18.65050--18.68350T` with
mean scored distance `2.093400--2.094046L` and score
`-0.206060-- -0.205783`. The common displacement-half-cycle envelope policy
has identical executable hash `8634990c...` in two independent evaluations;
both retain the same two-view wake class and capture at
`18.82649--18.88149T`, while improving mean scored distance to
`2.088545--2.088964L` and score to `-0.201056-- -0.200406`. This is replicated
far/middle progress, not faster arrival or demand relief: anterior/posterior
acceleration contact remains `60.85--61.00%` / `72.97--73.27%`, and rate
contact remains `11.04--11.07%` / `14.88--14.93%`, overlapping the parent.

The informative failure prevents wake-only reasoning. Its direct-uniform
top-down street remains energetic and its oblique caudal structures remain
compact, but after reaching only `2.24855L` it bends down and away in the late
frames, exits left at `31.295T`, and finishes `9.88895L` from the target.
Coherent propulsion therefore does not establish useful route control. The
replicated half-cycle policy should be transferred exactly, without the
inherited distance/alignment release gates, posterior-only allocation,
velocity phase, or terminal residuals that did not establish a better route.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric flapping
source_mechanism: sensor-modulated half-cycle amplitude or duty redistribution for turning
transferable_invariant: redistribute a bounded common rhythmic envelope between observed displacement half-cycles while preserving the traveling wave and target-owned mean curvature
nontransferable_details: published gains, clock phase, robot geometry, species-specific kinematics, duty ratios, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: start from the captured geometry-scheduled carrier and redistribute only its existing common amplitude relief using normalized body-frame target side and anterior joint displacement; preserve both curvature shares, posterior lag, response release, and acceleration projection
falsification: reject the mechanism if a further exact repeat loses capture or either coherent wake row, fails to stay below the parent mean-distance band of `2.093400--2.094046L`, repeats a left-exit topology, or materially worsens the established demand or planar-load boundary

## Single-candidate policy hypothesis

Replace the prefilled geometry-scheduled carrier with the exact twice-evaluated
half-cycle redistribution architecture. Add the parameter-owned
`half_cycle_relief_redistribution=0.50`. Use the already normalized target side
and displacement-only `phase_alignment` to apply less of the existing common
rhythmic relief on the target-aligned half-cycle and more on the opposed half.
Keep its mean geometry-owned relief, target-signed anterior/posterior curvature,
one-sided correcting-yaw release, posterior lag, and final acceleration
projection unchanged.

This is replication of one shelf-translated feedback mechanism, not scalar
gain tuning or a new compound. Formal CFD occurs only after this worker exits.
The next evaluation should test whether a third exact execution retains
capture, both wake views, and the replicated `2.088545--2.088964L` mean-distance
band. Its slightly later capture and unchanged demand statistics must not be
misreported as arrival or actuation improvement.
