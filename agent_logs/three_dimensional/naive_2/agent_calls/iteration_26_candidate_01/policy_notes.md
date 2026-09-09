# Active redirect-to-cruise yaw-arrest candidate

## Visual and metric diagnosis before editing

All sampled and inherited rollouts used for this decision satisfy the frozen
flow contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the combined
top-down mid-plane vorticity and oblique body/Lambda2 rows for all four sampled
captures, the inherited carrier-phase-pulse capture, and the informative
angle-domain `left_domain` failure. The captures are self-propelled along the
same direct down-left route behind compact, body-connected alternating wakes
with localized posterior three-dimensional structures. The failure retains
that organized propulsion through its `1.1036L` low pass, then turns nearly
vertical and exits left at `27.654T`; it is a terminal course-control failure,
not advection, wake collapse, excessive load, or instability.

The strongest new evidence is a semantic replicate. The unified
response-and-predicted-miss policies in `solver_e0a2513d969f` and
`solver_a92c5ea643fa` differ only by one blank line. Both capture, at
`15.5008T` and `15.6625T`, so the shared consensus handoff now has repeat
success evidence. But their terminal raw constant-course miss changes from
`0.1790L` to `0.5900L`, velocity changes from nearly horizontal
`(-1.286,-0.014)L/T` to `(-1.162,-0.534)L/T`, and score changes from
`-0.02109` to `-0.02425`. Peak normalized planar force/moment remains similar
at `0.0365--0.0366/0.0176--0.0180`, and neither run dwells beyond `40 deg`.
Thus the mechanism repeats capture and preserves the compact wake, but its
apparently centered first crossing was beat-response sensitive rather than a
reproducible margin result.

The inherited carrier-supportive, phase-selective posterior pulse does not
solve that boundary. It also preserves the direct compact wake and captures at
`15.7396T`, but terminal miss widens to `0.7226L`, score worsens to `-0.02503`,
and normalized peak force/moment remains `0.0368/0.0178`. This rejects another
posterior pulse-phase refinement. Together with inherited static-bend,
angle-domain, and broad carrier-braking failures, the remaining testable gap
is the redirect-to-cruise transition: the unified controller only removes
steering after a corrective yaw response; it does not actively arrest the
residual carrier-separated turn that can rotate terminal velocity away from
the centered course.

## Single candidate hypothesis

Use the semantically replicated unified response-and-predicted-miss controller
as the parent architecture, preserving its state-feedback traveling-bend
carrier, far-field pursuit/course blend, constant-course predictor, terminal
mean bend, posterior mid-stroke pulse, shared consensus release, and all owned
gains. Change one feedback mechanism in the shared half-cycle actuator. When
corrective carrier-separated yaw and small predicted miss jointly release a
fraction of target-turn authority, hand that same bounded fraction to
countersteer against the yaw residual instead of leaving it inactive. The
existing minimum course share continues target steering, the base propulsive
carrier remains active on both half-cycles, and the posterior pulse keeps the
unified geometry/response release.

The hypothesis is that active yaw arrest will preserve the replicated direct
capture route while reducing the `0.179--0.590L` terminal-course spread and
preventing the low, strongly lateral crossings seen when steering is merely
released. Support requires capture with raw terminal course miss below
`0.590L` and preferably near `0.179L`, arrival and score no worse than the
semantic replicate without a compensating margin improvement, no `>=40 deg`
dwell, and normalized planar force/moment near or below `0.037/0.019`.
Falsify on any miss or left exit, terminal miss at or above `0.590L`, a slower
or wider low crossing, wake/route change, greater joint/load occupancy,
nonfinite commands, or loss of reflection equivariance. The current
candidate's CFD evaluation occurs only after this worker exits and is not
claimed as evidence here.

bookshelf_consulted: true
source_domain: biological redirect-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve rhythmic propulsion while closed-loop directional feedback arrests residual turn during the return from maneuver authority to cruise
transferable_invariant: redirect completion requires both small target-relative miss and bounded arrest of remaining body yaw; merely removing steering can leave terminal lateral velocity phase-sensitive
nontransferable_details: published gains, robot linkage geometry, species-specific maneuver timing and curvature, clock phase, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use the existing response-plus-predicted-miss consensus to transfer only the released shared half-cycle authority from target steering to countersteer against normalized carrier-separated yaw residual, while retaining the two-joint traveling carrier
falsification: reject if capture margin or termination worsens, or if terminal course spread, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance degrades

## Validation boundary

The prescribed guidance-materiality, lightweight Julia policy-contract, and
solver editable-boundary checks pass. A deterministic `82,944`-state grid over
normalized body-frame target geometry and velocity, both joint angles and
rates, and yaw response produced finite commands strictly inside the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
The active yaw-arrest handoff changed a command by as much as
`5.78776 rad/T^2` relative to the semantically replicated unified parent,
confirming that this is an active mechanism rather than a comment or gain-only
change. These checks are algebraic only. Formal CFD is deferred to EvE after
exit; all rollout values above are sampled or inherited prior evidence.
