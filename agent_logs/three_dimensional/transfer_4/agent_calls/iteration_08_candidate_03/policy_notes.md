# Candidate diagnosis and hypothesis

All four sampled evaluations satisfy the Phase-2 flow contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no prewarm snapshot, and
no cylinders. The two `002a5b...` rate-governed examples are exact repeats, so
they provide determinism evidence rather than independent controller evidence.

I inspected both rows of the combined sheets for the strongest finite parent
and the repeated rate-governed comparison. In each top-down row the fish moves
under its own actuation from quiescent water, sheds a coherent alternating
wake, and turns toward the target; neither case shows passive advection,
collision, or wake breakup. The oblique rows retain compact alternating
posterior Lambda2 structures through capture, without visible out-of-plane
instability. The posterior-priority parent reaches the capture circle on a
much straighter, faster trajectory: relative to the rate-governed controller,
score improves from `-0.51274776` to `-0.09355786`, arrival from `23.3640T` to
`17.8585T`, mean score-distance from `2.4095L` to `1.9800L`, center path from
`13.3177L` to `12.8148L`, maximum head cross-track from `2.0139L` to
`0.5347L`, and mean speed from `0.5701` to `0.7178 U`.

That result supports posterior emphasis, but it falsifies the assigned
parent's narrower actuator-relief explanation. Anterior angle remains about
`[-25.93,26.23] deg` and acceleration-ceiling residence remains `69.70%`;
tail acceleration-ceiling residence rises from `50.68%` to `65.17%`, RMS yaw
rate rises from `1.554` to `2.029 rad/T`, and RMS force/moment coefficients
rise from `0.01234/0.00643` to `0.01557/0.00807`. The overload is most
concentrated inside `2.1L`: tail rate residence above 96% increases to
`14.68%` and tail acceleration-ceiling residence to `72.48%`, while mean
speed is `0.8761 U`. Far from the target those values are only `4.76%`,
`64.35%`, and `0.7000 U`.

The sampled line-of-sight observer is not transplanted. On the slower
rate-governed controller it gives a modest positive comparison
(`-0.49332402`, `23.1715T`, `1.9626L` maximum cross-track), but reconstructing
the same co-windowed kinematic residual on the posterior-priority trace gives
only `+0.00051 rad/T` mean with signs nearly balanced (`55.8%` positive),
versus `+0.0214 rad/T` and `90.7%` positive on the slower parent. The new
parent has already removed the persistent route drift; feeding its alternating
residual back would risk reacting to transients rather than correct a measured
bias.

The candidate therefore preserves the successful phase-plane carrier,
posterior gain and lag, odd body-frame curvature map, cadence law, steering,
and direction-selective rate governor. It adds one upstream terminal-load
mechanism. Only inside the established approach corridor, while target
alignment and measured closing speed indicate fast capture-directed motion,
a smooth tail-rate load gate modestly scales the oscillatory posterior target.
Mean curvature is not scaled, the anterior carrier and common cadence are not
throttled, and the gate releases continuously whenever closure, alignment, or
tail rate falls. Expected evidence is unchanged far-field trajectory and wake,
retained capture and arrival scale, but less near-target tail rate and
acceleration residence and no further increase in yaw or loads. Reject the
mechanism if it materially worsens arrival or distance integral, changes the
direct trajectory, loses capture, suppresses posterior wake coherence, or
merely shifts saturation to the anterior joint.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish oscillator modulation and classical posterior-emphasized propulsion
source_mechanism: sensor-conditioned amplitude relief that preserves a traveling bend and keeps route steering distinct from propulsive regulation
transferable_invariant: preserve far-field posterior lag and emphasis, but continuously relieve only the overloaded oscillatory posterior command when normalized state confirms fast aligned terminal closure
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: form bounded approach, alignment, closing-speed, and posterior-rate gates from normalized body-frame observations and scale only the posterior wave target upstream of acceleration limiting while leaving mean curvature and the anterior carrier intact
falsification: reject if capture, arrival, distance integral, direct-course topology, reflection polarity, or two-view wake coherence worsens, or if near-target tail limit residence and load scale do not fall
