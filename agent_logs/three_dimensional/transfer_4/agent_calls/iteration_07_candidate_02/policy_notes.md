# Candidate diagnosis and hypothesis

All inspected evaluations satisfy the Phase-2 flow contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no prewarm, and no
cylinders. The three `002a5b...` sampled solver examples are deterministic
repeats of one rate-governed controller, not three independent mechanisms.
They capture at `23.3640T` with score `-0.51274776`, center path `13.3177L`,
RMS yaw rate `1.5537 rad/T`, and the same `241` moving-window shifts. The
earlier `710675...` controller also captures, but its episode-equivalent
acceleration clamp scores slightly worse (`-0.51527750`), has a longer
`13.4189L` path and higher `1.5749 rad/T` RMS yaw, and spends `9.09/1.62%` of
samples above `99.9%` of the two joint-rate limits. The direction-selective
rate governor removes that last residence while preserving full reversal.

The assigned parent tested a normalized, max-pooled two-joint load gate on the
shared cadence. It retained capture but regressed to `-0.62156406`, delayed
arrival from `23.3640T` to `24.8380T`, increased mean distance from `2.4095L`
to `2.5216L`, and lengthened the center path to `13.4430L`. Its gate was active
for `87.36%` of samples and reduced cadence to `0.8845` of the ungated value on
average. Although tail acceleration-ceiling residence fell from `50.68%` to
`38.24%` and RMS force/moment fell, anterior rate residence above `96%`
increased from `15.68%` to `19.00%`; anterior amplitude also expanded from
`[-25.65,27.48] deg` to `[-28.00,30.42] deg`. Thus a shared max-load gate
mistook ordinary stroke state for an exceptional overload, slowed both joints,
and did not relieve the actual anterior bottleneck.

The top-down sheets for the better baseline and assigned-parent failure both
show self-propelled, target-directed motion from quiescent water and a coherent
alternating wake through capture. Their oblique Lambda2 rows likewise retain a
three-dimensional posterior vortex train without collision, passive advection,
or breakup. The parent's visibly more delayed bend toward the capture circle is
consistent with the numerical loss of closure rather than a stability gain
that compensates for the lower score.

The candidate restores the proven odd body-frame curvature map, guidance,
cadence law, and direction-selective rate governor. It introduces one compact
mechanism: a posterior-priority phase-plane amplitude envelope. The anterior
carrier is pumped or damped from its normalized joint angle/rate energy around
a smaller envelope, while a common gain on both terms of the lagged posterior
target preserves approximately the baseline posterior wave amplitude and phase.
Unlike the failed common cadence gate, this does not lower the carrier
frequency or throttle the posterior joint merely because the anterior joint is
loaded. The expected signature is lower anterior angle/rate and acceleration
residence with a coherent posterior-emphasized wake, no material loss of
arrival or distance integral, and retained capture. Reject the mechanism if it
slows closure like the shared gate, shifts saturation to the tail without
reducing total limit residence, breaks the traveling wake, or loses capture.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and sensor-modulated robotic-fish oscillators
source_mechanism: posterior-emphasized traveling bends regulated by a joint-state amplitude envelope
transferable_invariant: regulate rhythmic energy from normalized phase-plane state while retaining posterior lag and greater posterior wave excursion for thrust
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact phases, and task routes
policy_translation: use normalized anterior joint angle and rate to pump or damp its state-feedback carrier, and preserve posterior excursion and lag with a bounded gain on the whole posterior wave target while leaving body-frame target steering unchanged
falsification: reject if capture or two-view wake coherence is lost, arrival or distance integral regresses materially, anterior limit residence does not fall, or load is merely transferred into worse posterior saturation
