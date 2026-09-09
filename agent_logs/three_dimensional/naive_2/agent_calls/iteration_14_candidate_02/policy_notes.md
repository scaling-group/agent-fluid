# Capture-corridor authority-reserve candidate

## Evidence and visual diagnosis before editing

All sampled and inherited evaluations used direct uniform still-water
initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I
inspected the combined top-down vorticity and oblique Lambda2 rows for the
sampled capture, the prefilled approach-hold failure, the assigned parent's
repeat miss, and the rate-barrier sibling. In all four, a body-connected
alternating wake develops and three-dimensional caudal structures remain
visible during translation. The control problem is terminal interception, not
passive advection, absent propulsion, or numerical instability.

The sampled predicted-miss policy is the only semantic success: it captures at
`16.011T` and `0.74772L` with a compact alternating wake, no joint-angle dwell
above `40 deg`, and peak normalized planar force/moment of `0.030/0.017`.
However, the assigned parent's evaluation of the byte-identical policy misses
at `0.96311L`, turns nearly vertical after passing the target, and exits left at
`28.215T`. At about `14.00T`, its constant-course signed miss is already
`0.834L` versus `0.416L` in the captured trace, while its terminal handoff has
reduced half-cycle steering share to about `0.41`; inside `3L` that share falls
to the fixed `0.35` floor even when the predicted miss remains outside the
capture corridor. The repeat reaches closest approach at head
`(9.712,8.852)L`, still moving at about `1.12L/T`, with a `0.787L` predicted
cross-track miss.

The rate-barrier sibling is a concrete negative control. It cuts outward
near-rate-limit commands from about `12%` per joint in the captured trace to
`2.7%`, but still misses at `0.87559L` and follows the same left-exit topology.
The prefilled symmetric-drive hold is much weaker (`2.703L` minimum), pins both
joints at `45 deg`, and raises peak normalized force/moment to
`0.713/0.300`. Neither actuator reserve alone nor broad carrier relief is the
missing mechanism.

## Single candidate hypothesis

Preserve the evidenced predicted-miss mean-curvature controller, complete
traveling-bend carrier, and course-residual half-cycle steering. Add one
terminal capture-corridor authority reserve: while the body-frame
constant-course miss exceeds a controller-owned corridor and time-to-closest
still leaves a bounded response window, continuously restore the half-cycle
steering share that the mean-curvature handoff would otherwise remove. Fade
the reserve when the course enters the corridor, when response time is spent,
or when the target is no longer closing. This is a geometric feedback and
actuator-allocation change, not carrier braking or scalar-only gain tuning.

The primary falsifier is loss of capture. Also reject the mechanism if it does
not improve repeat margin below the inherited `0.8756--0.9631L` misses, if the
same post-pass left exit remains, if exact rate/angle-limit occupancy or loads
grow materially, or if the alternating wake loses coherence. A later reflected
or perturbed-pose test must determine whether the corridor and response window
generalize beyond this initial geometry.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and fish terminal prey capture
source_mechanism: preserve an undulatory carrier while target-relative terminal feedback retains steering authority until an interception corridor is established
transferable_invariant: a predictive mean bend should not displace the faster steering channel while measured cross-track miss remains outside the capture corridor and sufficient response time remains
nontransferable_details: published gains, robot geometry, species-specific envelopes, dimensional response times, exact capture radius, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity to form signed constant-course miss and time-to-closest, then smoothly restore two-joint half-cycle steering outside a controller-owned corridor while leaving the traveling carrier and predictive mean bend intact
falsification: reject on lost capture, no margin below the repeated near misses, repeated left escape, increased joint-limit occupancy or loads, false redirect on an aligned approach, or loss of the coherent alternating wake

## Validation status

This diagnosis and hypothesis were recorded before the policy edit. Formal CFD
is deferred to downstream evaluation. After editing, the mandated guidance
materiality check, lightweight Julia policy-contract check, parameter-schema
exercise, and solver editable-boundary check all passed. A `34,992`-state grid
over joint state, normalized target geometry, body velocity, and distance found
finite commands inside the smooth `30 rad/T^2` envelope and exact left/right
reflection (maximum error `0.0`). In a constructed `2.7L` approach with a
`0.8L` predicted miss, the candidate differs from its captured parent by more
than `0.1 rad/T^2`; on aligned geometry it is identical. These are algebraic
mechanism checks, not new CFD evidence.
