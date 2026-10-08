# Wake-policy candidate notes

## Evidence scope and visual diagnosis

The assigned parent guidance describes a fresh lineage, and no inherited
optimizer notes are present in this workspace.  The only sampled solver is
therefore both the best finite example available and the informative failure;
there is no sampled success with which to make a two-rollout comparison.  Its
diagnostics confirm direct uniform still-water initialization at
`U_infinity=(0,0,0)` with no cylinders or prewarm.

Both visual rows were inspected before proposing the controller.  In the
top-down row the seed develops a compact alternating wake and translates
leftward, so it is self-propelled rather than passively advected.  From roughly
`5T` onward its body and wake bend toward increasing world `y`, away from the
target below-left, and it reaches the upper boundary.  The oblique Lambda2 row
likewise shows organized three-dimensional vortical structures behind the
fish rather than a loss of propulsion or a numerical breakup.  This supports
preserving the state-feedback oscillator and posterior lag while adding the
missing target-dependent steering capability.

The scalar traces agree with that reading: distance falls only from `12.328L`
to a minimum `12.078L` at `6.358T`, then rises to `12.380L` at the
`left_domain` exit at `8.547T`; center `y` rises from `14.0L` to `15.200L`.
The body-frame target bearing starts at `+0.155 rad`, crosses near zero around
`4T`, and becomes strongly negative as the unregulated turn overshoots.  The
seed already asks beyond the acceleration envelope on about 32% and 34% of
the joint samples, so more drive amplitude or frequency is not the supported
first edit.

## Policy hypothesis

Keep the demonstrated propulsive carrier unchanged, but center both joints'
traveling bend on a common curvature setpoint computed from the instantaneous
normalized body-frame bearing.  Use a smooth odd saturation so steering
authority is bounded and continuously vanishes on alignment.  The local FSI
sanity contract states that positive common curvature produces negative yaw;
therefore a positive bearing maps to positive curvature, opposing the seed's
initial wrong-way yaw.  Centering the posterior lag relation on the same bias
should retain the phase-delayed wave instead of replacing propulsion with a
static bend.  No force, wake-phase, time, route, or world-coordinate signal is
introduced.

Expected test: compared with the sampled seed, the candidate should avoid the
upper-boundary exit and sustain decreasing target distance while keeping a
coherent alternating wake.  Reject the mechanism if it turns with the wrong
sign, merely shifts the exit to the lower boundary, suppresses translation,
or produces persistent angle/acceleration saturation without materially
better distance progress or termination.

bookshelf_consulted: true
source_domain: robotic-fish turning and classical two-joint swimming
source_mechanism: bounded mean-curvature bias superposed on a phase-lagged propulsive rhythm
transferable_invariant: steer by shifting the mean bend from observed target geometry while retaining a directed posterior-lagged wave
nontransferable_details: published gains, species-specific amplitudes, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: map bounded body-frame bearing to a common joint-center bias, and express both the oscillator and posterior lag relative to that bias
falsification: reject if target progress or termination does not improve, the turn sign is wrong, thrust collapses, or joint saturation becomes persistently worse
