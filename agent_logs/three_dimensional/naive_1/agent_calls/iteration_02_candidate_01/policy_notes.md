# Candidate-specific wake diagnosis and hypothesis

## Evidence read before the edit

All four sampled evaluations satisfy the frozen initialization contract:
direct uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
prewarm snapshot.  None captured the target; all terminated at the upper
virtual boundary (`left_domain`).  The target-blind seed
`solver_36a38f7240b3` remains the strongest finite example: distance fell from
`12.3277L` to `12.0782L` before reversing to `12.3800L` at `8.547T`.  The
three target-feedback candidates reached only `12.2283L`, `12.2864L`, and
`12.3039L`, then exited with final distances of `13.2576L`, `13.4008L`, and
`13.4874L`.

Both visual rows distinguish propulsion from route control.  The seed's
top-down row develops a strong alternating caudal wake while translating left,
then curls upward; its oblique Lambda2 row confirms coherent three-dimensional
structures shed along that curved path, so motion is self-propelled rather
than imposed-flow advection.  The direct acceleration-residual candidate
`solver_1c9001e61100` retains an oscillatory wake but bends it into the same
upper-exit arc.  The two candidates that recenter the oscillator on a mean
curvature (`solver_137608088dcd` and `solver_79b9eb651f44`) have weak early
wakes and settle by termination near static bends (`-8/-8 deg` and
`-8/-4.8 deg` respectively); their late curved structures accompany inertial
translation rather than sustained alternating thrust.

The metrics and traces corroborate the images.  The seed translates about
`0.925L` left and briefly gains `0.2496L`, but reaches both the `260 deg/T`
joint-rate cap and `2.79 rad/T` absolute heading rate before exiting.  In
contrast, the two recentered oscillators translate almost no net distance
toward the target and end with joint rates near zero.  The acceleration
residual preserves more beating but reduces the closest progress to `0.0994L`
and still exits at `8.706T`.  Thus the assigned-parent lesson that a target
coupling is needed survives, but the sampled children and inherited notes
falsify continuous common acceleration and moving oscillator equilibria as
effective translations here: both preserve the same topology, and the latter
also suppress the useful carrier.

## One candidate hypothesis

Preserve the seed oscillator and posterior lag exactly, and introduce one new
steering primitive: body-frame target-and-yaw feedback gates a bounded
same-sign residual onto only the target-aligned half-cycle.  The beat side is
reconstructed continuously from `(phi1, phi_dot1/omega)`, so no clock or
hidden stage is introduced.  Positive bearing retains the established
positive-bend/negative-yaw convention; same-direction heading rate unloads
the request before large yaw accumulates.  Applying the residual primarily
while the oscillator is traveling toward the requested bend should create
tail-beat asymmetry without replacing the zero-mean traveling-wave carrier
with a static curvature equilibrium.

The expected semantic change is a visibly alternating wake that survives
past the seed's early curl while bearing changes sign and the fish continues
left/down toward the target.  Falsify the mechanism if the first corrective
turn has the wrong sign, either joint settles to a static bend, rate or
acceleration saturation becomes more persistent, the alternating 3D wake
collapses, closest distance fails to beat `12.0782L`, or the same upper-exit
trajectory remains.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and asymmetric flapping
source_mechanism: sensor-driven half-cycle amplitude or duty asymmetry superimposed on a continuing propulsive rhythm
transferable_invariant: strengthen only the beat portion aligned with a persistent target-relative turn request while preserving the alternating carrier and unloading as the measured yaw response develops
nontransferable_details: published gains, clock-driven phase, dimensional cadence, species-specific envelopes, exact vortex phase, and source-task routes
policy_translation: use normalized body-frame bearing plus normalized heading rate to gate a bounded same-sign acceleration residual by phase reconstructed from the two-joint state, while retaining the seed oscillator and posterior lag
falsification: reject if turn sign is wrong, the carrier becomes a static bend, the coherent wake or leftward propulsion collapses, actuator saturation worsens, closest approach does not beat the seed, or the upper-boundary exit topology persists
