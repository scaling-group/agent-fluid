# Wake-policy candidate notes

## Evidence diagnosis before edit

The assigned parent is the gated posterior phase-lag policy copied from
`solver_7f1d02b1e9e9`. It captures at `0.748829L` and `26.2955T` with no
angle, rate, or acceleration contacts. The sampled translation-consistent
line-of-sight variant `solver_8e7135ef9173` is the strongest finite comparison:
it also remains limit-free, captures at `0.748338L` and `26.2460T`, and has a
slightly lower mean distance (`2.518971L` versus `2.519671L`). The
turn-priority carrier-relief variant `solver_730e610b0618` is the informative
mechanism failure: it remains limit-free and captures, but arrives later at
`26.3615T`, has mean distance `2.519735L`, and does not create a visibly
different route.

Both combined sheets report direct uniform still-water initialization. Their
top-down rows show self-propulsion, a coherent alternating reverse-street-like
wake, similar lateral body motion, and the same late upward hook into the
capture circle; the oblique Lambda2 rows confirm that the wake remains coherent
and three-dimensional through approach. The common peak planar force and yaw
moment are about `0.01883` and `0.00979`, with peak local crossflow about
`0.01231`, so the small scalar separation is not evidence of a new load or wake
regime. The inherited logs further show that collision-cone re-entry,
posterior redistribution, conflict withdrawal, translation-side selection,
course-priority allocation, and carrier relief all stay in the shallow-capture
topology. Another scalar terminal or waveform retune is therefore unsupported.

## Policy hypothesis

Preserve the parent's carrier, posterior lag modulation, positive-deficit
navigation structure, coordinated acceleration projection, and joint viability
guards. Add the sampled translation-derived line-of-sight observer, but use its
smooth confidence not only to select the late steering side: use the same
phase-rejected rate to set the desired yaw-response magnitude. Outside the
evidenced `4.5L` approach band, at low translational speed, or when target-course
geometry disagrees, the proven history observer passes through. This is an
observer-mechanism change rather than a gain increase: it should stop the
gait-frequency folded-bearing estimate from demanding alternating saturated
response when persistent translation predicts a much smaller one-sided target
line rotation.

Falsification: reject the observer if formal CFD loses capture, loses the
coherent carrier, restores any actuator contact, raises peak loads, or remains
only milliscale-equivalent in route and capture margin. If it is rejected, do
not retune its distance blend or response gain; seek a separately measured
route-response variable.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and reduced-order target tracking
source_mechanism: keep a rhythmic propulsive carrier while a bounded, observation-driven residual modulates steering response
transferable_invariant: separate fast joint-state rhythm from a smooth body-frame route observer and add only the measured response deficit
nontransferable_details: published CPG gains, oscillator frequencies, species envelopes, exact vortex phases, and task-specific routes
policy_translation: blend from folded-bearing history to normalized translational line-of-sight rate only when speed, distance, and target-course agreement make that body-frame observer credible; preserve the two-joint carrier and safety envelope
falsification: reject on lost capture or wake coherence, new actuator contact or load growth, or another milliscale-equivalent shallow hook
