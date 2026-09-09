# Carrier-envelope recovery candidate

## Visual and metric diagnosis before editing

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected the combined top-down vorticity and oblique
Lambda2 rows for the best finite capture and the informative full-circle
pursuit failure. The captures self-propel on a direct targetward route behind
a compact body-connected alternating wake. The failure also generates an
organized wake, but curls into a large off-target loop and exits at
`(8.200,15.150)L`; propulsion and vortex production are therefore not the
missing mechanisms.

The prefilled response-gated posterior-pulse policy has two byte-identical
sampled evaluations. Both capture at `15.983--16.044T`, with zero joint-angle
dwell beyond `40 deg`, `17.21%/16.86--16.97%` near-rate-limit occupancy, peak
normalized planar force `0.03421--0.03436`, and peak moment
`0.01728--0.01743`. This resolves the inherited lower-left misses and supports
preserving the predictive-interception composite. It does not isolate the
posterior pulse: the sibling without that pulse also captures at `16.011T`
with indistinguishable joint and load scales.

Across all three captures, the remaining common opportunity is startup. At
`2T` the head has moved only about `0.05L` and speed is below `0.10L/T`; by
`4T`, after the anterior joint phase-plane excursion has grown, speed is about
`0.66L/T` and the compact wake is established. Stronger terminal steering,
static curvature, broad carrier braking, or posterior-pulse gain tuning is not
supported by these samples.

## Single candidate hypothesis

Keep the evidenced traveling-bend carrier, body-frame course and predicted
miss, bounded mean curvature, response-gated half-cycle handoff, and terminal
posterior pulse. Add one state-amplitude recovery channel to the anterior
carrier: compute a normalized phase-plane radius from centered joint angle and
`phi_dot/omega`, and add bounded anti-damping only while that observed radius
is below a minimum carrier envelope. The channel has no clock, is strongest
only during low-amplitude startup or a later loss of rhythm, and becomes
exactly inactive once the carrier is established. The terminal controller and
both rhythmic half-cycles remain unchanged.

Support requires capture earlier than the replicated `15.983--16.044T` band
without changing the direct trajectory class, compact alternating wake, zero
`>40 deg` dwell, or roughly `0.035/0.018` force/moment scale. Falsify on loss of
capture, a route change before `4T`, materially greater rate-limit occupancy or
loads, persistent recovery activation on the established limit cycle, or loss
of wake coherence. The downstream CFD evaluation, not the dry checks in this
workspace, must decide these criteria.

bookshelf_consulted: true
source_domain: fish traveling-wave propulsion and closed-loop robotic-locomotion CPGs
source_mechanism: a rhythmic state oscillator restores its propulsion envelope after low-amplitude initialization or disturbance, then returns to its nominal limit cycle
transferable_invariant: recruit extra carrier energy from observed phase-plane amplitude deficit and remove that authority once the propulsive rhythm is established
nontransferable_details: published oscillator gains, dimensional recovery rates, clock phase, robot linkage geometry, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: normalize anterior joint angle and velocity by the owned carrier amplitude and frequency, gate a bounded anti-damping term below an owned phase-radius threshold, and leave the two-joint target-feedback composite unchanged outside that gate
falsification: reject if startup translation and capture time do not improve together, or if route, wake coherence, joint reserve, load scale, reflection symmetry, or repeat capture degrades

## Dry validation only

After repairing the duplicated assigned-parent marker in the rendered
workspace README, all three mandated check-runner stages pass: guidance
materiality and notes, the lightweight Julia policy contract, and the solver
editable-boundary check. The deterministic schema audit finds all `30/30`
direct `params.FIELD` references owned by `target_policy_params()`.

A `19,683`-state grid over target geometry, body velocity, both joint states,
and heading response produced finite commands strictly inside the smooth
`30 rad/T^2` envelope (maximum magnitude `29.999999999`) with exact left/right
reflection (maximum error `0.0`). Disabling only recovery changed a constructed
low-envelope command by `0.86839 rad/T^2`, while an established-carrier state
changed by exactly `0.0`, confirming the intended gate semantics. These are
algebraic checks, not CFD evidence; the candidate's startup, wake, loads,
trajectory, and capture-time claims remain downstream falsifiers.
