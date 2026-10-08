# Wake-policy candidate notes

## Evidence diagnosis before policy edit

The assigned-parent file is byte-identical to sampled solver
`solver_e584ff748453`. It is a valid direct-uniform still-water rollout
(`U_infinity=[0,0,0]`) that captures at `23.3750T`, scores `-0.503415`, and
has mean/final distance `2.400748/0.747085L`. Its demand-triggered cadence
handoff marginally improves score and final distance over the sampled full
progress release (`solver_a1a04070bc41`, `23.3750T`, `-0.505158`,
`2.402131/0.748882L`), but it does not cleanly improve the terminal load
tradeoff: inside `3L`, mean/peak absolute yaw are `1.71344/3.27552 rad/T`
versus `1.71130/3.29199 rad/T`, peak target-cross-track speed is
`0.62108U` versus `0.61953U`, and peak moment rises from `0.014507` to
`0.014923`. An unconditional monotone terminal withdrawal
(`solver_1fc8cd5b9bd4`) and a middle-band withdrawal with final re-engagement
(`solver_d9c0c79c8666`) lower some yaw/load measures but delay capture to
`23.3915T` and `23.4355T`; the latter also lowers final-band radial closing and
raises final-band cross-track motion. Thus the evidence rejects another
whole-cycle distance handoff or a stronger scalar withdrawal.
No inherited `logs/optimize` artifact was supplied in this rendered workspace;
the parent policy, sampled solver artifacts, and inherited guidance examples
therefore provide the available completed evidence.

Both combined keyframe sheets were inspected from release through capture.
The top-down rows show no imposed advection at release, then an attached onset
and a coherent alternating vorticity street along the same gently curved,
target-directed route. The oblique rows show compact paired Lambda2 structures
remaining organized behind the self-propelled fish through the final turn.
Neither the stronger parent nor the regressed middle handoff visibly loses the
traveling wake; their useful difference is terminal translation and load, not
wake creation or route topology. The parent reaches `3L` at `20.1300T`, while
its largest terminal yaw occurs near `1.54L` and its largest terminal moment
near `1.18L`, so any new relief should leave the established pre-`3L` carrier
untouched and must not coast across the final target crossing.

## Bookshelf transfer and candidate hypothesis

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical propulsive-wave control
source_mechanism: observed half-cycle asymmetry superposed on a posteriorly lagged traveling bend
transferable_invariant: preserve the productive traveling carrier and change only the beat side that reinforces an unwanted turn
nontransferable_details: published gains, dimensional cadence, duty ratios, species envelopes, exact vortex phases, and task-specific routes
policy_translation: use terminal proximity, the normalized carrier-rejected yaw counter, and observed two-joint tangent side to withdraw only the existing target-progress cadence reserve on the yaw-supporting half-cycle; retain base cadence, route steering, posterior lag, and command projection
falsification: reject if CFD loses capture or the pre-3L lead, worsens mean/final distance or actuator exposure, disrupts the coherent alternating wake, or fails to improve the sampled 1-2L yaw/moment tradeoff over the assigned parent

The candidate therefore replaces the parent's whole-cycle
`abs(terminal_yaw_brake)` handoff with a continuous state-derived half-cycle
gate already consistent with the split observer's anterior correction. The
gate has no clock, hidden phase, world coordinate, or new scalar strength: it
uses the signed terminal excess-yaw counter and normalized observed tail
tangent. Only the extra `progress_drive_frequency_gain` reserve yields; the
base oscillator, successful C-bend polarity, posterior traveling wave, and all
steering feedback remain unchanged. This isolates whether phase-selective
carrier relief can retain useful final radial closing while avoiding the
whole-cycle handoff regressions.
