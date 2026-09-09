# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
moving-window dynamics, and `termination=capture`. I inspected the combined
top-down vorticity and oblique body/Lambda2 sheets for every sample and
cross-checked them against `wake_metrics.csv`, `wake_diagnostics.json`, the
trajectory histories, executable policies, assigned parent guidance, and the
inherited optimizer log.

The two geometry-only executables differ only in comments and capture at
`18.65050T`/`18.68350T`, with scored mean distance
`2.09340L`/`2.09405L`. Coupling the same amplitude schedule to the existing
yaw-response gate captures at `18.66150T` and `2.09362L`, inside that repeat
band. The prefill also captures at `18.75500T` and `2.09542L`. In all four
top-down rows the fish creates a coherent, target-directed alternating street;
the oblique rows retain compact caudal Lambda2 structures through first
crossing. Direct-uniform initialization, a zero imposed flow, and speeds near
`0.92L/T` confirm self-propulsion rather than advection. Geometry-only action
histories still contact the joint-rate envelope on about `10.9--11.2%` and
`14.8--15.1%` of anterior/posterior rows and the acceleration envelope on
about `60.7--61.0%` and `73.1--73.2%`; the current improvement is route and
arrival evidence, not actuator relief.

The most informative inherited failure independently released posterior mean
curvature during correcting yaw. Its top-down street and oblique caudal
structures remain coherent, but the route stays roughly horizontal above the
target and then bends downward: it reaches only `4.52178L`, exits left at
`24.82152T`, and ends `6.63358L` away. Its lower speed (`0.828L/T` peak) and
lower `10.2%/13.3%` rate contact do not constitute relief because capture is
lost. Together with the earlier posterior-wave compensation failure
(`3.14646L` closest approach, `left_domain`), this rules out another
posterior-specific allocation change. The target-signed coupled curvature
ratio, displacement-only phase, one-sided common response release, geometry
amplitude schedule, posterior lag, and final acceleration projection remain
unchanged.

The captured trace has one distinct opportunity that does not require changing
route feedback: over `0--2T`, mean body speed is only `0.115L/T` and
acceleration contact is `21.2%/34.2%`, versus roughly `61--80%` after `2T`.
The controller can therefore test a small state-observed locomotor onset boost
before cruise saturation dominates. This diagnosis does not claim that higher
frequency is generally more efficient or that a constant frequency retune is
supported.

## Single-candidate policy hypothesis

Add one coupled gait mechanism: multiply the oscillator frequency by a small,
bounded boost only when normalized body speed is below a policy-owned scale,
and attenuate that boost with absolute body-frame target misalignment. Use the
same instantaneous frequency in the anterior oscillator, posterior phase-lag
coordinate, and posterior tracker. Thus the policy gives a nearly aligned,
slow fish extra locomotor onset authority without a clock or stage counter,
then recovers the exact evidenced carrier continuously as speed rises. The
route sign, mean-curvature shares, gait envelope, phase observation, and hard
action projection are untouched.

The falsifiable expectation is earlier speed buildup and capture outside the
rough `0.033T` geometry-duplicate repeat floor while retaining the current
`2.0934--2.0941L` route band and both coherent wake views. Reject the mechanism
if capture is lost, improvement stays inside repeat variation, early
acceleration contact becomes persistent bang-bang demand, cruise rate contact
or planar loads materially worsen, the route leaves the target-directed
family, or either wake view loses its traveling structure.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and classical traveling-bend propulsion
source_mechanism: use observed locomotor state to modulate rhythmic cadence while preserving the coupled oscillator phase relationship and posterior traveling-wave role
transferable_invariant: a slow self-propelled onset may receive bounded state-dependent cadence authority that vanishes continuously at cruise, provided every joint uses the same instantaneous frequency and target geometry still owns steering
nontransferable_details: published frequencies, amplitudes, CPG gains, motor models, species-specific startup kinematics, full-body waveforms, exact vortex phases, world-frame routes, and elapsed-time burst schedules
policy_translation: retain the captured body-frame curvature and geometry-envelope carrier; derive a bounded boost from normalized body speed and alignment, apply it to one shared oscillator frequency, and recover the original frequency exactly once the speed deficit vanishes
falsification: reject if capture or wake coherence is lost, arrival does not beat the duplicate repeat floor, the scored route band is left, onset demand becomes persistently projected, or rate contact and planar loads materially worsen
