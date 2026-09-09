# Terminal course-to-phase-lag candidate

## Visual and metric diagnosis before editing

All sampled and inherited rollouts used here satisfy the frozen experiment:
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders, and no prewarm. I inspected the combined top-down mid-plane
vorticity and oblique body/Lambda2 sheets for every sampled solver, the assigned
parent, and the latest inherited course-confirmed release. From release through
capture, each fish self-propels on essentially the same direct down-left route
behind a compact alternating mid-plane wake and localized three-dimensional
posterior structures. There is no visible passive advection, wake collapse,
broad loop, boundary contact, or numerical instability. The carrier and
far-field steering are useful and should remain intact.

The strongest sample, `solver_e0a2513d969f`, captures at `15.5008T`, scores
`-0.02109`, and crosses with velocity `(-1.286,-0.014)L/T`, heading
`0.259rad`, and about `0.179L` raw constant-course miss. The assigned parent's
centered-closing amplitude envelope, `solver_6a4dfc32a317`, also captures but
does not realize its proposed approach hold: arrival slows to `15.6738T`, score
worsens to `-0.02289`, terminal speed remains `1.300L/T` rather than falling
below the strongest sample's `1.286L/T`, and per-joint near-rate occupancy is
essentially unchanged. It crosses with velocity `(-1.128,-0.647)L/T` and
heading `0.746rad`. This is evidence against another drive-envelope edit on
the present carrier, not against the direct route.

The latest inherited course-confirmed release, `solver_2932eea9feca`, closes a
second branch. It retains capture, the direct route, compact wake, and low
`0.0355/0.0175` peak normalized planar force/moment, but slows to `15.8926T`,
scores `-0.02329`, crosses at velocity `(-0.721,-1.072)L/T`, and leaves about
`0.719L` raw course miss. Together with the sampled yaw-arrest result
(`15.8061T`, about `0.746L` raw miss), this shows that adding yaw/course terms
to the redirect-release consensus does not make terminal crossing less
phase-sensitive. The inherited pulse variants likewise were neither necessary
nor sufficient for capture. The next test should change the actuator through
which target-relative course feedback enters, rather than another release gate,
pulse refinement, amplitude schedule, or scalar gain.

## Single candidate hypothesis

Use the strongest sampled unified response-and-predicted-miss controller as the
base. Preserve its joint-state traveling carrier, far-field pursuit/course
blend, constant-course predictor, bounded mean bend, carrier-separated response
gate, shared half-cycle steering, frequency, amplitude, and acceleration
envelope. Replace the inconclusive posterior mid-stroke pulse with one new
actuator mechanism: during a reliable closing terminal approach, map the
bounded target-relative course error into a small posterior lag change whose
half-cycle sign comes from normalized anterior joint angle. The product of the
two odd signals is reflection-even, so it modulates the lag coefficient while
the resulting tail target and accelerations remain reflection-odd. Low speed,
non-closing motion, or far-field geometry continuously returns to the proven
base lag without a clock, hidden state, or route.

The hypothesis is that course feedback expressed through posterior wave shape
will retain the productive carrier while correcting lateral terminal travel
without depending on instantaneous body yaw or merely withholding shared
steering. Support requires capture with raw terminal course miss below
`0.590L` (preferably near `0.179L`), arrival/score comparable to the strongest
sample, the same direct compact-wake route, negligible `>40deg` dwell, and peak
normalized planar force/moment no higher than about `0.037/0.019`. Falsify on
a miss or domain exit, terminal miss at or above `0.590L`, slower/lateral
crossing without a repeatable margin gain, loss of translation or wake
coherence, more joint-limit occupancy or loads, nonfinite commands, or broken
left/right reflection. The candidate's CFD evaluation is deferred to EvE and
is not claimed as evidence here.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and asymmetric wave-shape control
source_mechanism: preserve an autonomous propulsive oscillator while sensor feedback modulates a low-dimensional posterior phase relationship for directional correction
transferable_invariant: target feedback can change posterior wave timing through observed oscillator state while leaving the base traveling rhythm active; maneuver direction and beat side must jointly determine the modulation
nontransferable_details: published CPG gains, robot linkage geometry, species-specific kinematics, dimensional frequency, exact vortex phase, task coordinates, and fixed routes
policy_translation: gate a bounded target-relative body-frame course request by measured closing reliability, multiply it by normalized anterior joint-angle side, and use the reflection-even product to modulate the posterior lag in the two-joint state-feedback carrier
falsification: reject if capture margin, arrival, direct routing, compact wake, joint reserve, normalized loads, finite bounded output, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia policy contract/schema,
and solver editable-boundary checks pass. A deterministic `186,624`-state grid
over normalized body-frame target and velocity geometry, distance, heading
response, and both joint angles and rates produced finite commands strictly
inside the smooth `30rad/T^2` envelope with exact left/right reflection
(maximum error `0.0`). Against the same candidate with only the new lag shift
disabled, the mechanism changed a command by as much as
`12.0823rad/T^2`; a constructed near-target receding state changed by exactly
`0.0`, confirming both active terminal authority and the non-closing fallback.
These checks are algebraic only. Formal CFD remains deferred to EvE.
