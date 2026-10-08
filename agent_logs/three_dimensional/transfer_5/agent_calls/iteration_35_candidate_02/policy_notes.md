# Candidate diagnosis and hypothesis

All four sampled rollouts satisfy the frozen direct-uniform still-water contract
(`U_infinity=0`, no prewarm) and capture on the same useful trajectory. In both
the top-down mid-plane and oblique Lambda2 rows, the fish is self-propelled,
turns gradually toward the target, and leaves a coherent alternating wake; no
sample shows passive advection, wake collapse, or a different route topology.
The best finite sample is the active-demand cadence handoff at
`23.375013T`, score `-0.503415`, mean distance `2.400748L`, and final distance
`0.747085L`. The informative regression is the assigned-parent monotone
terminal handoff: it reaches `3L` at the same `20.129997T`, but captures at
`23.391514T` with score `-0.505421`, mean distance `2.402386L`, and final
distance `0.749093L`. The middle-band handoff is later still at `23.435516T`.

The active-demand sample establishes that cadence authority can be coordinated
with the existing terminal stabilizer without losing the full-release arrival
step, and its lower mean/final distance makes it the appropriate carrier. Its
remaining defect is mixed: versus full release it changes inside-`3L` mean
target-line cross-track speed only from `0.235128U` to `0.234855U`, while peak
yaw remains `3.275517 rad/T` and peak moment rises from `0.014507` to
`0.014923`. The code hands cadence only to the continuous course-brake role;
it ignores the independently established phase-selected anterior yaw residual.

Policy hypothesis: preserve the sampled active-demand carrier, split observer,
posterior traveling wave, steering, and smooth command projection. Form one
bounded terminal stabilization envelope as the maximum absolute demand from
the continuous course brake and the phase-selected anterior yaw correction,
and let only the small progress-qualified cadence reserve yield to that
envelope. This is a feedback-role coordination test, not a scalar gain retune.
It should retain the `20.129997T` crossing of `3L` and approximately the
`23.375T` capture while reducing terminal yaw/load relative to the active-demand
sample. Falsify it if capture is materially delayed, mean/final distance loses
the active-demand improvement, cross-track motion or actuator exposure rises,
or either visual wake row loses coherence.

bookshelf_consulted: true
source_domain: robotic-fish sensor-feedback CPG modulation and terminal capture scheduling
source_mechanism: coordinate rhythmic propulsion with bounded feedback correction while retaining the underlying traveling wave
transferable_invariant: extra oscillator energy should yield only while measured stabilization demand is active; base propulsion and route feedback remain intact
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact phases, and task routes
policy_translation: use normalized body-frame course and carrier-rejected yaw demands to gate only the progress-qualified cadence reserve under the two-joint state-feedback contract
falsification: reject if the sampled capture timing or mean/final progress regresses, terminal yaw/cross-track/load does not improve, actuator feasibility worsens, or the coherent alternating wake changes
