# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled solver diagnostics and the assigned parent's inherited
rollout report direct-uniform initialization in still water, zero imposed
velocity, no cylinders or prewarm snapshot, and finite `left_domain`
termination. In both rows of their combined keyframe sheets, the fish is
self-propelled: an alternating mid-plane vortex street and tail-connected
three-dimensional Lambda2 structures form by about `4T` and persist through
exit. The visible failure is planar route control rather than advection or
wake collapse. Every trajectory passes above the target and crosses the upper
virtual boundary while its propulsive wake remains organized.

The sampled `4 deg` centerline course redistribution (`6d90d1984e81`) is the
strongest finite approach. It reaches `3.161L` at `18.227T`, with head near
`(9.511,12.619)L`, body-frame target-to-velocity angle about `-1.488 rad`,
forward speed `0.741U`, and relative crossflow `-0.414U`; it then recedes to
`8.569L` and exits at `27.572T`. The `3 deg` version (`c0a67102cc0a`) reaches
only `4.419L` but gives the best sampled scalar score and survives to
`23.260T`. Distance-scheduled amplitude relief (`4482d3d05d9c`) reaches only
`5.126L`, while the prefilled course-error damping child (`a763085dcb98`)
reaches only `6.397L` and exits at `16.830T`. Their top-down wakes remain
coherent, so their regressions do not support more carrier-energy scheduling.

The assigned parent's predicted-miss gate (`cac759c37551`) is a completed
negative test of earlier authority through the same anterior lever. It
preserves the full alternating wake and survives to `29.101T`, but its minimum
is `3.448L` at a still-higher head position near `(9.558,12.903)L`; it recedes
to `9.596L` and repeats the upper exit. The inherited closing-aware amplitude
hold (`bc0a63178377`) likewise reaches only `3.926L`, recedes to `7.891L`, and
exits through the same boundary. Thus opening, damping, or scaling the same
carrier from distance, closing, course error, or projected miss has not
produced a new trajectory class. The next test should change how the measured
route demand enters the posterior beat, not add another scalar gate around the
anterior redistribution.

## Single candidate hypothesis

Use the sampled `4 deg` controller as the carrier: retain its joint-state Van
der Pol oscillator, full posterior lag, body-frame bearing and relative-
crossflow feedback, centerline target-to-velocity course brake, recent-yaw
term, transient anterior course redistribution, and smooth acceleration
envelope. Replace its continuously applied posterior mean-curvature steering
with one phase-coupled half-cycle mechanism. Construct the posterior traveling
wave from observed anterior angle and velocity, use its absolute normalized
excursion as an even activity envelope, and multiply that envelope by the odd
bounded route command. The resulting tail bias is zero at a wave crossing,
approaches the existing `12 deg` steering bound near an excursion peak,
strengthens the route-side half-cycle, and relieves the opposite half-cycle.
It adds no clock, route coordinate, persistent body bend, or larger steering
curvature envelope.

This should vector the already productive posterior beat toward the target
instead of asking a saturated traveling-wave tracker to hold a continuous
offset. Falsify it if minimum distance does not beat `3.161L`, the head still
passes roughly `3L` above the target and repeats the receding upper exit, the
early leftward transit or alternating 3D wake weakens, or joint-limit
residence and peak force/moment materially exceed the sampled full-wave
carrier's approximately `73.8%`, `0.0337`, and `0.0175` reference levels. The
new CFD evaluation occurs after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: preserve a rhythmic propulsive carrier while shifting posterior excursion between the two beat half-cycles according to closed-loop direction error
transferable_invariant: when a coherent traveling wave propels but continuous curvature feedback does not rotate the route, apply bounded target-side asymmetry only while the observed wave has excursion and release it at wave crossings
nontransferable_details: published gains, oscillator clocks, robot morphology, species-specific envelopes, dimensional beat timing, exact vortex phases, and task-specific routes
policy_translation: multiply an even bounded envelope of the state-reconstructed posterior wave by the odd body-frame bearing/crossflow/course/yaw turn command, use the product as a posterior target bias within the existing curvature bound, and retain the evidenced anterior oscillator and lag
falsification: reject if closest approach does not beat 3.161L, the same high receding upper exit remains, propulsion or the alternating 3D wake degrades, or actuator and load excursions materially grow
