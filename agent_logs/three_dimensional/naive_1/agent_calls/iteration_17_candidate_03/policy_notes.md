# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled solver rollouts satisfy the frozen experiment contract:
direct uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders,
finite moving-window dynamics, and `termination=capture`. I inspected the
top-down vorticity and oblique body/Lambda2 rows in the combined sheets for the
best capture, the assigned prefill, and the most informative inherited
failure, then cross-checked them against `wake_metrics.csv`,
`wake_diagnostics.json`, trajectories, executable policy sources, assigned
parent guidance, and inherited optimizer notes.

The sampled captures are one narrow behavior class. Three use the same
geometry-scheduled displacement-half-cycle executable apart from comments;
the fourth adds terminal lateral-velocity and range terms. They capture at
`18.6615--19.0520T` with scored mean distance `2.09362--2.09874L`. The
strongest run captures at `18.6835T` and `2.09405L`; the assigned prefill
captures at `18.7550T` and `2.09542L`. Their top-down rows show a coherent,
target-directed alternating street behind a genuinely self-propelled fish,
and their oblique rows retain compact caudal Lambda2 structures through first
crossing. The terminal compound is slower and does not establish a new useful
route. The carrier is therefore capture-class and wake-coherent, but the
roughly `60.6--61.0%` anterior and `73.0--73.2%` posterior acceleration contact
and `10.9--11.2%` / `14.8--15.1%` rate contact remain high.

The inherited failures sharply constrain the next edit. Scaling down only the
zero-mean posterior wave by at most `15%` left an energetic top-down street and
3D caudal structures, but curved downward after roughly `16T`, reached only
`3.4260L`, and exited at `27.5055T` with final distance `7.2511L`. Earlier
posterior enhancement had the same coherent-wake/wrong-route topology.
Changing cadence is also unsupported: a `15%` geometry-conditioned slowdown
retained capture but delayed it to `19.3875T` and score `-0.25289`, while a
speed-conditioned `6%` onset cadence boost lost capture, reached only
`3.1735L`, and exited at `29.0895T`. Coherent vortices therefore do not rescue
posterior allocation or cadence changes that disturb the captured route.

The capture trace nonetheless identifies a testable onset regime: inherited
analysis reports mean body speed only `0.115L/T` over `0--2T`, before the
carrier settles near its cruise behavior. Unlike the failed cadence boost, a
small amplitude-envelope boost can add slow-speed locomotor authority without
changing oscillator frequency, dimensionless posterior lag, target curvature,
or displacement phase. Speed magnitude will schedule only the gait envelope;
it cannot add to or subtract from route curvature.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: classical traveling-bend propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: bounded locomotor-state modulation of rhythmic amplitude while a coupled oscillator preserves the traveling-wave organization
transferable_invariant: a slow self-propelled onset may receive bounded gait-envelope authority that vanishes continuously at cruise, provided cadence, posterior lag, observed joint phase, and target-owned curvature remain unchanged
nontransferable_details: published amplitudes and gains, dimensional beat rates, robot or species kinematics, clock-driven burst timing, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the captured body-frame curvature and two-joint carrier; use normalized body-speed deficit attenuated by target alignment to increase only the anterior oscillator envelope, recovering the exact parent envelope once the speed deficit vanishes
falsification: reject if capture or either coherent wake view is lost, arrival and mean distance do not improve beyond the sampled repeat band, onset demand becomes persistently projected, the route returns to a downward exit, or rate contact and planar loads materially worsen

## Single-candidate policy hypothesis

Add exactly one phase-preserving onset mechanism. Compute normalized body
speed from `velocity_body_U`, form a bounded deficit below a policy-owned
speed scale, attenuate it by absolute body-frame lateral target fraction, and
use it to raise only the Van der Pol amplitude envelope by at most `6%`.
Preserve the base cadence everywhere, and preserve target-signed differential
mean curvature, one-sided correcting-yaw release, displacement-only half-cycle
redistribution, posterior lag and tracker, and final acceleration projection.
The `6%` bound and `0.35U` speed scale isolate amplitude scheduling against the
completed cadence-onset failure rather than importing a published setting.

The formal CFD evaluation occurs after this worker exits. Accept this mechanism
only if it retains capture and both visual wake structures while improving
outside the `18.6615--18.7550T` / `2.09362--2.09542L` core repeat band, without
turning the initially low-contact regime into sustained saturation. Otherwise
record amplitude-based onset modulation as unsafe around this carrier and
return to geometry-only amplitude scheduling before testing a different
actuator primitive.
