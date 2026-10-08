# Candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no cylinders or prewarm snapshot, finite dynamics, and
`capture`. I inspected both rows of the combined keyframe sheets for the
highest-scoring assigned-parent course observer (`solver_a95f7416a3de`,
independently reproduced by `solver_343870fd8107`) and the informative weaker
role-separated observer (`solver_89e2a212c5d1`), with the union-only
`solver_477c7f626e4f` as the mechanism baseline. The top-down rows show the fish
self-propelling on the same broad left-and-down capture arc while shedding a
compact alternating vorticity street. The oblique rows confirm a coherent
three-dimensional Lambda2 wake, continued undulation, and no out-of-plane
instability. The visual topology is essentially unchanged, so the small
ordering is a trajectory/load effect rather than a new wake class.

Relative to the union-only baseline, the carrier-rejected target-course
observer improves score/mean distance from `-0.502603/2.400102L` to
`-0.501691/2.399184L`. Inside `3L`, it reduces mean absolute yaw from
`1.70656` to `1.68733 rad/T`, mean/peak target-line cross-track speed from
`0.23432/0.62616U` to `0.22592/0.58298U`, and mean/peak absolute moment from
`0.006564/0.015118` to `0.006393/0.013886`. It also crosses `6L` earlier
(`15.3065T` versus `15.3670T`) with essentially unchanged angle and smoothly
projected command envelopes. The cost is later capture (`23.4410T` versus
`23.3750T`) and higher peak yaw (`3.34971` versus `3.28817 rad/T`). The
role-separated sampled follow-up retains the same `6/3/2/1L` crossing samples
as the parent through `1L`, but regresses score/final distance to
`-0.502841/0.748139L` and raises peak moment to `0.014017`; restoring the old
terminal desired-yaw reference therefore does not resolve that trade.

The remaining defect is within the successful observation rather than the
propulsive carrier. On the reproduced parent trajectory, the current
target-course residual subtracts only the anterior rate coordinate
`0.8*phi_dot[1]/omega`. It remains correlated with anterior joint angle by
`-0.738` over `6--12L`, `-0.758` over `3--6L`, and `-0.803` inside `3L`.
Adding the observed angle quadrature to the carrier estimate at the
trajectory-calibrated scale changes residual RMS from `0.1363U` to `0.1055U`
outside `3L` and from `0.1302U` to `0.0842U` inside `3L`, while preserving the
signed slow component (`-0.0839U` to `-0.0760U` outside and `+0.0296U` to
`+0.0272U` inside). This is diagnostic evidence for a missing carrier
quadrature, not evidence of the unevaluated candidate's CFD outcome.

## Policy hypothesis

Preserve the captured C-bend, posterior-lagged traveling wave, normalized
target-course route feedback, split terminal yaw observer, stabilization-
envelope cadence handoff, and smooth command projection. Make one observer
change: model the beat-synchronous cross-track carrier with the anterior joint
angle as well as its normalized rate, and subtract that two-coordinate
quadrature before the residual is normalized or used by any route/stabilizer
role. The extra coordinate should suppress phase-dependent false course
corrections without reducing steering authority or modifying the actuator.
Falsify it if CFD loses capture or the coherent wake, gives back the parent's
score/mean-distance and cross-track/moment gains, further delays capture without
a multi-metric benefit, raises peak yaw/load, or worsens joint-speed/command
feasibility.

bookshelf_consulted: true
source_domain: sensor-feedback modulation of robotic-fish coupled oscillators and wake-interaction control
source_mechanism: estimate and separate the rhythmic propulsive carrier from a slower directional error before applying bounded route feedback
transferable_invariant: a joint-state oscillator has angle and normalized-rate phase quadratures, so both observable coordinates may be removed from target-relative course motion while the traveling bend remains intact
nontransferable_details: published CPG gains, clock phase, robot morphology, species-specific envelopes, dimensional cadence, exact vortex phase, and prescribed paths
policy_translation: augment the normalized body-frame target-course carrier estimate with a bounded anterior-angle quadrature calibrated from completed rollout residuals; keep the two-joint actuator and all existing route, terminal, cadence, and projection layers unchanged
falsification: reject if formal CFD loses capture or wake coherence, regresses integrated progress/cross-track/moment relative to the reproduced parent, worsens the isolated peak-yaw or arrival costs, or increases actuator-limit exposure
