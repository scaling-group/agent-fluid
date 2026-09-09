# Wake-policy candidate diagnosis and hypothesis

## Evidence read before the policy edit

All four sampled evaluations satisfy the Phase-2 evidence contract: direct
uniform initialization in quiescent water (`U_infinity=[0,0,0]`), no prewarm,
no cylinders, finite dynamics, and populated top-down and oblique views.  The
combined sheets were inspected before this edit.  Their alternating mid-plane
vorticity streets and three-dimensional caudal Lambda2 structures accompany
finite force and moment histories while sampled local-flow magnitude remains
below `0.030U`; the translation is self-propelled rather than ambient
advection.

The assigned differential-curvature turn-rate servo preserves the strongest
long wake among the failures, travels `18.81L`, and survives to `33.209T`, but
its raw recent-yaw term spans roughly `[-2.64,2.49] rad/T` around a desired
rate capped at `0.50 rad/T`.  It therefore reverses the redirect each beat
while target bearing remains predominantly negative.  The top-down route
passes the target near world `y=14--15L`, reaches only `4.9765L`, and exits
high at `(2.23,15.20)L`; its joint rates touch the envelope on about
`16.8%/19.1%` of rows and its raw accelerations exceed the envelope on
`70.5%/77.6%`.

The strongest sampled policy changes that topology without changing the
traveling-bend carrier.  Its normalized body-frame lateral target fraction
owns redirect sign, while recent yaw can only release up to a bounded fraction
of correctly signed curvature and can never invert it.  The top-down frames
show monotone target approach rather than the parent's high pass, and the
oblique row retains compact three-dimensional caudal shedding through capture.
It captures at `19.228T` and `0.7482L`, decreases distance on `97.3%` of logged
steps, and remains finite with maximum local-flow magnitude `0.0254U`.  This is
the first semantic success and directly validates the inherited hypothesis
that persistent target geometry must stay authoritative over beat-scale yaw.
It is not an efficiency result: joint rates still touch their limits on about
`10.8%/14.3%` of rows and raw accelerations exceed the envelope on
`61.9%/72.0%`.

The full signed-course comparator is an important boundary.  It reaches
`1.0927L` near `19.058T` with a similarly coherent wake, but after the target
moves behind the head its `atan` course request grows toward `pi`, the fish
continues below the target, and it exits at `y=0.796L`.  Because that comparator
also lacks one-sided response release, the evidence supports the successful
combined mechanism but does not isolate lateral-fraction saturation from the
release gate.

## Policy hypothesis

Materialize the sampled successful mechanism as this workspace's single
candidate: preserve the joint-state oscillator, posterior lag, and evidenced
opposite-sign anterior/posterior allocation; map normalized body-frame lateral
target fraction to bounded differential mean curvature; and permit measured
recent yaw to reduce only a fixed fraction of a correctly signed request.  No
world route, clock, external phase, or mutable state is introduced.

The expected outcome is the sampled semantic class: coherent propulsion with
sustained target progress and capture instead of the assigned parent's
high-side straight pass.  Falsify the transfer if reevaluation turns with the
wrong sign, loses the alternating three-dimensional wake, fails to capture,
or worsens rate/acceleration saturation.  The candidate's new CFD evaluation
occurs after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and closed-loop robotic-fish CPG direction tracking
source_mechanism: target-signed bounded curvature with response-gated release into a persistent propulsive rhythm
transferable_invariant: slow persistent route geometry must own redirect sign while fast measured yaw may soften but not reverse that request
nontransferable_details: published gains, dimensional turn rates, clocked CPG phase, species-specific bend envelopes, exact vortex phase, and prescribed routes
policy_translation: normalize target lateral displacement by distance, map it to opposite-sign anterior/posterior mean offsets, and use bounded recent body turn response only as a one-sided release around the two-joint state-feedback oscillator
falsification: reject if capture does not survive, turn sign is wrong, the coherent wake collapses, or actuator saturation and load histories worsen
