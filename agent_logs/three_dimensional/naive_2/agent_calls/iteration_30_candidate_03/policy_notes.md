# Released posterior course-pulse candidate

## Visual and metric diagnosis before editing

All sampled and inherited rollouts used direct uniform initialization in still
water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the
combined top-down vorticity and oblique body/Lambda2 sheets for the highest-score
sample, the weakest sampled capture, and the most recent inherited rollout.
Each fish self-propels on the same nearly direct down-left route and leaves a
compact alternating wake attached to the posterior body, with localized 3D
tail structures and no visible passive advection, wake collapse, boundary
interaction, or instability. Propulsion and the far-field route should remain
unchanged; the informative failure is the repeated strongly lateral terminal
crossing, not semantic failure or loss of wake coherence.

The unified response-plus-predicted-miss sample `solver_e0a2513d969f` is the
best terminal-course reference: it captures at `15.5008T`, scores `-0.02109`,
and crosses with velocity `(-1.286,-0.014)L/T` and about `0.179L` raw
head-relative course miss. The highest-score target-line-rate sample
`solver_f792c48d0852` also captures with the compact wake, but crosses at
`(-1.112,-0.671)L/T`; active residual-yaw arrest in the prefilled
`solver_1900be936beb` is more lateral at `(-0.774,-1.012)L/T`, and terminal
duty skew in `solver_11c13c1fcaff` is later and similarly lateral at
`15.9148T` and `(-0.711,-1.038)L/T`.

The assigned parent's three completed inherited tests close two obvious
follow-ups. Course-confirmed release still captured later at `15.8926T`, with
`(-0.721,-1.072)L/T` terminal velocity and about `0.719L` raw course miss.
Two evaluations of the exact same hydrodynamic-moment-residual policy also
captured but scored `-0.02303` and `-0.02716`; both remained lateral at
`(-0.792,-0.954)` and `(-0.721,-1.081)L/T`. Their compact wakes, bounded
`0.0354--0.0375` peak normalized planar force and `0.0175--0.0181` moment,
and roughly `23.7/22.6%` near-rate occupancy show that neither another release
qualifier nor moment rejection fixes the topology. The identical controller's
score spread is also a warning not to promote one scalar outcome as margin
robustness.

## Single candidate hypothesis

Start from the strongest sampled unified response-and-predicted-miss policy,
preserving its state-feedback traveling carrier, pursuit/course blend,
constant-course predictor, terminal mean bend, existing pre-release posterior
pulse, and shared response-plus-miss handoff. Change one actuator mechanism:
after that consensus releases part of shared-joint redirect authority, use the
remaining target-relative course error and observed anterior joint motion to
apply a small posterior-only corrective-half-cycle pulse. This carries course
feedback through a phase-lag/wave-shape channel without delaying release,
countersteering on body yaw, reading hydrodynamic moment, braking the carrier,
or adding static curvature.

The hypothesis is that a phase-selective posterior correction can reduce the
repeated `0.59--0.75L` lateral crossing while preserving the direct compact-
wake capture and the nearly horizontal reference route. Support requires
capture with raw terminal course miss below `0.590L`, preferably near the
`0.179L` reference, arrival/score comparable to the unified parent, negligible
`>40 deg` dwell, and normalized peak planar force/moment no higher than about
`0.038/0.019`. Falsify on a miss or left exit, terminal miss at or above
`0.590L`, a slower or more lateral capture without margin improvement,
persistent command/rate pinning, load growth, wake-route change, nonfinite
commands, or loss of reflection equivariance. Formal CFD is deferred to EvE
and is not evidence in these notes.

bookshelf_consulted: true
source_domain: asymmetric robotic-fish flapping and sensor-modulated CPG direction tracking
source_mechanism: preserve autonomous rhythmic propulsion while steering through bounded half-cycle or posterior wave-shape modulation driven by sensed course error
transferable_invariant: after a shared redirect has produced a corrective response, residual target-relative course error can be corrected through a small phase-selective posterior action instead of prolonging or reversing whole-body steering
nontransferable_details: published gains, robot linkage geometry, species-specific amplitudes and phase lags, dimensional frequency, exact vortex phase, task coordinates, and fixed routes
policy_translation: retain normalized body-frame target and velocity feedback plus the two-joint carrier, then spend only released shared-steering authority on a reflection-equivariant posterior pulse gated by observed joint motion
falsification: reject if capture margin, terminal course, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The prescribed guidance-materiality, Julia policy-contract/schema, and solver
editable-boundary checks pass. A separate deterministic `4,608`-state grid
over normalized body-frame target geometry and velocity, heading response, and
both joint angles and rates produced finite commands strictly inside the smooth
`30 rad/T^2` envelope with exact left/right reflection (maximum error `0.0`).
The posterior course pulse was active in `288` states and changed a command by
as much as `1.35611 rad/T^2` relative to the strongest sampled unified parent,
confirming an active feedback mechanism rather than a comment or scalar-only
edit. These checks are algebraic only; formal CFD remains deferred to EvE.
