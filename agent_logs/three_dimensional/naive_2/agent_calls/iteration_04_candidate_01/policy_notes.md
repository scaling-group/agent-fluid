# Candidate wake-policy notes

## Visual and metric diagnosis before editing

All four sampled rollouts report direct uniform initialization in still water.
Their top-down sheets show self-propelled motion and alternating vorticity, and
their oblique sheets show tail-connected three-dimensional Lambda2 structures;
none is passive advection or a prewarm artifact.  All nevertheless arc upward
and terminate at the upper virtual boundary rather than approaching the target
to the lower left.

The strongest finite sample is the relative-crossflow posterior-mean policy.
It reaches and finishes at `10.513L`, survives to `10.79T`, and advances the
center to `x=18.144L`.  The assigned parent's course-aware posterior-mean
policy reaches and finishes at only `11.303L` at `9.91T`; the bearing-only
failure reaches `11.512L` and exits at `9.82T`.  At `8T` the parent already has
body-frame bearing `-0.892 rad`, course error `-0.600 rad`, and yaw rate
`-2.122 rad/T`, yet it continues upward from `y=14.425L` to `15.201L` before
corrective positive yaw appears at the exit.  The stronger crossflow sample
likewise has bearing/yaw `-0.760/-2.166` at `8T` and still has wrong-signed yaw
at termination.  Thus the route request has saturated in the corrective
direction, but posterior mean curvature acts too slowly to reverse the turn.

This is not evidence for more scalar drive.  The crossflow sample already
spends about `29.1%` of tail-action samples above 95% of the soft acceleration
limit, versus `27.3%` for the parent, with similar force/moment scales.  Nor is
a larger posterior hold sufficient: the sampled response-gated redirect raises
posterior curvature while relieving the wave, but reaches only `11.330L` and
then recedes to `11.546L`.  Inherited logs also show that permanent `8--9 deg`
anterior centering suppresses the carrier, cutting joint-speed maxima to about
`0.83--1.26 rad/T` and producing much worse distance.  The remaining useful
test is therefore a transient change in steering actuator, not another course,
crossflow, or posterior-curvature gain edit.

## Policy hypothesis

Use the strongest sampled relative-crossflow posterior mean controller as the
propulsive and route-feedback baseline.  Add a small anterior mean-curvature
redirect only when absolute body-frame bearing is large and the measured yaw
does not yet have the requested sign.  A steep continuous error gate keeps the
anterior oscillator effectively uncentered through release and the early
target-line crossing; a response gate releases the head bend as corrective yaw
develops.  Center the oscillator state only during that redirect and form the
posterior traveling wave from the centered state, retaining posterior lag and
zero-mean propulsion outside the redirect.

The first semantic test is earlier positive yaw after the persistent negative
bearing develops, while retaining the alternating wake and the crossflow
sample's leftward progress.  Falsify this translation if the same upper exit
occurs no later than `10.79T`, minimum distance does not beat `10.513L`, the
anterior joint-speed collapse of static centering returns, or joint/acceleration
saturation and force/moment peaks grow materially.

bookshelf_consulted: true
source_domain: biological C-start redirection and robotic-fish closed-loop direction tracking
source_mechanism: large observed route error triggers bounded whole-body curvature and measured turn response releases it back into the propulsive gait
transferable_invariant: reserve anterior bending authority for a transient state-triggered redirect when posterior steering has not produced corrective yaw, then continuously release it once the response appears
nontransferable_details: species-specific C-start shapes, published gains, dimensional timing, exact vortex phases, clocked CPG phases, and task-specific routes
policy_translation: map normalized body-frame bearing and recent yaw response to an odd bounded anterior equilibrium offset while preserving relative-crossflow posterior mean steering and the joint-state traveling wave
falsification: reject if the redirect quenches the alternating carrier, fails to reverse wrong-signed yaw before the prior exit, does not improve the 10.513L closest approach, or materially increases saturation or hydrodynamic loads
