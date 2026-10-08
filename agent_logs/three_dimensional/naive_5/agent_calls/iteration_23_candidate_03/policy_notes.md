# Wake-policy candidate notes

## Evidence diagnosis before editing

All four sampled rollouts use direct uniform still-water initialization with
`U_infinity=(0,0,0)` and terminate in capture; the sampled set contains no
`left_domain` or unstable keyframe sheet, so the lower-performing capture is
the available informative counterexample rather than a true failure rollout.
The two pairs are deterministic visual duplicates.  In both unique combined
sheets, the top-down row shows self-propelled motion with a coherent alternating
vorticity street through the turn, and the oblique row shows a compact 3D
Lambda2 wake that remains attached to the swimming trajectory rather than
passive advection or wake collapse.

The speed-viability-only pair captures at `27.577T`, minimum `0.749366L`, mean
distance `2.613L`, and peak planar force/yaw moment `0.02218/0.01034`.  The
coordinated command-envelope pair adds a common, ratio-preserving acceleration
compression and captures at `26.296T`, minimum `0.749242L`, mean distance
`2.520L`, and peak planar force/yaw moment `0.01883/0.00979`; its trace has no
angle, exact speed, or acceleration-limit contacts.  The visual route and wake
remain coherent, so the command projection is a supported carrier improvement.

The stronger pair still enters the `0.75L` capture disk by only `0.000758L`.
At capture its head is `(8.5767,10.1182)L`, its speed is about `0.648L/T`, and
the body-frame target/course cross product implies a projected miss near
`0.705L`.  The terminal sheet likewise shows a fast tangential crossing, not a
centered approach.  The current line-of-sight response mechanism is therefore
productive but geometrically fragile; propulsion gain or another command-limit
threshold is not the missing mechanism.

## Policy hypothesis

Preserve the evaluated carrier, redirect, line-of-sight response, coordinated
command projection, and viability guards exactly.  Add one continuous
capture-corridor response: inside the existing approach window, use the
existing normalized projected-miss gate to request same-side body yaw from the
body-frame velocity/target cross product.  Compare that request with measured
phase-rejected yaw and inject anterior half-cycle authority only for a positive
response deficit.  This differs from another terminal pulse or residual-gain
retune: observed course geometry owns the request, adequate turns are never
cancelled, and the mechanism is inactive outside the approach/miss corridor.

Expected result: retain coherent self-propulsion and the earlier capture while
crossing materially deeper than the sampled `0.74924--0.74937L` boundary
cluster.  Reject the mechanism if it loses capture, delays arrival materially,
over-turns before the disk, changes the far route, restores any limit contact,
or raises peak loads above the speed-guard-only pair.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG path following and terminal capture control
source_mechanism: sensor-feedback residual modulation of a rhythmic carrier with far/middle/near separation
transferable_invariant: preserve the propulsive rhythm while a bounded observed path-error response supplies only missing steering authority near the goal
nontransferable_details: published CPG gains, robot kinematics, dimensional approach radii, exact beat phase, and task-specific routes
policy_translation: map normalized body-frame projected miss and course side to a smooth approach gate, compare desired yaw with phase-rejected measured yaw, and add only the positive deficit through the calibrated anterior half-cycle channel
falsification: reject if wake coherence or capture is lost, the far trajectory changes, the fish over-turns, limit exposure returns, or capture clearance does not materially exceed the sampled boundary cluster

## Non-CFD implementation audit

Re-evaluating the parent and candidate on reconstructed states from the
stronger sampled trace changes `282/4781` commands, all at distances below
`1.75L`; the largest command difference is `0.608 rad/T^2` near `1.090L` and
the terminal difference is `0.310 rad/T^2`.  A separate synthetic check makes
the far command exactly equal to the parent, activates the corridor on a near
miss, and confirms that reflected observations negate both joint commands.
These are contract/locality checks only, not a claim about the unevaluated CFD
outcome.
