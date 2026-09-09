# Phase-separated terminal-bearing candidate

## Visual and metric diagnosis before editing

All four sampled solver episodes report direct uniform initialization in still
water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the
combined top-down mid-plane vorticity and oblique Lambda2 rows for every
sample, using the direct captures and the full-circle pursuit domain exit as
the primary comparison. The three captures self-propel down-left on nearly the
same direct route behind a compact, body-connected alternating wake; their
oblique sheets retain localized three-dimensional structures through the
capture sphere. The older failure also self-propels and sheds an organized
wake, but curls upward, reaches only `4.64998L`, and exits the upper boundary.
Wake production is therefore established; terminal route regulation, not more
propulsion or a larger vortex, is the remaining problem.

The assigned parent reinstated the exact response-gated predicted-miss policy
that captured twice in the sampled set at `15.983--15.994T`, but its subsequent
evaluation missed at `1.01564L` and exited left with final distance `9.44621L`.
Inherited parallel logs record the same exact composite also missing at
`1.12140L` and `1.21644L`. Thus byte identity and two threshold crossings do
not establish repeat capture, and the joint-phase posterior pulse still has no
isolated benefit because the sampled no-pulse sibling captured at `16.0105T`.
The useful invariant is the direct predictive-interception route; the fragile
boundary is its beat-sensitive terminal handoff.

Replay of the three sampled capture trajectories identifies a concrete source
of that sensitivity. During the final `2.5T`, raw body-frame target bearing
flips sign five times in each run even though the world trajectory stays on
the same side of the target. The current distance/prediction blend consequently
flips its terminal turn request six times, with standard deviation
`0.513--0.517`. Subtracting the angle-domain integral of the already-owned
two-joint carrier-yaw model from terminal bearing reduces request deviation to
`0.340--0.351`, increases the persistent corrective mean from
`0.419--0.448` to `0.595--0.627`, and leaves only two brief sign crossings.
This is a dry diagnostic over evaluated trajectories, not a new CFD result.

## Single candidate hypothesis

Preserve the evidenced traveling-bend carrier, far-field pursuit/course blend,
constant-course time-to-closest and signed-miss gate, bounded terminal mean
curvature, response-gated half-cycle handoff, and posterior pulse. Change one
feedback mechanism only: before terminal target bearing recruits mean bend,
subtract the joint-angle carrier-yaw estimate whose derivative is already used
to separate measured heading response. This makes slow target geometry, rather
than beat-correlated body yaw, set the near-target fallback sign. The raw
course predictor remains intact, and the phase-separated bearing is not used
for far-field routing because the sampled full-circle pursuit mechanism failed.

Support requires repeat capture rather than another `1.0--1.22L` left-domain
miss, while retaining the direct compact-wake route, zero `>40 deg` joint dwell,
roughly `0.037/0.019` peak normalized planar force/moment scale, and comparable
far-field translation. Falsify on a worse closest pass, a changed trajectory
or termination class, persistent wrong-sign terminal curvature, wake loss,
material joint/load growth, or loss of reflection symmetry.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological redirect-to-cruise transitions
source_mechanism: distinguish slow directional error from fast rhythm-correlated body response before handing steering authority between a propulsive beat and a redirect
transferable_invariant: let persistent target geometry, after removing the observable carrier contribution, control the terminal steering sign while preserving the established traveling rhythm
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, C-start timing and curvature, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target geometry and the two observed joint angles to remove the angle-domain carrier-yaw estimate only from terminal pursuit; retain the measured joint-rate residual for the existing response gate and leave far-field course prediction unchanged
falsification: reject if same-policy capture does not become more reliable or if the direct route, compact wake, joint reserve, normalized load scale, boundedness, or reflection equivariance degrades

## Dry validation only

All three mandated check-runner stages pass: the notes/guidance materiality
check, the lightweight Julia policy contract, and the solver editable-boundary
check. A separate deterministic audit confirms that every direct
`params.FIELD` reference is owned by `target_policy_params()`.

A `2,187`-state reflected grid spanning terminal target side, lateral course,
both joint angles and rates, and measured heading response produced finite
commands strictly inside the smooth `30 rad/T^2` envelope (maximum magnitude
`29.9999999951`) with exact left/right reflection error `0.0`. These checks
establish executable semantics, boundedness, schema ownership, and symmetry;
they are not a CFD evaluation. Repeat capture, trajectory topology, wake,
joint use, and load scale remain downstream falsifiers.
