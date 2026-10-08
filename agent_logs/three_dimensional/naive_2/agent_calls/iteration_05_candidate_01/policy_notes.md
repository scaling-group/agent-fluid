# Candidate wake-policy notes

## Visual and metric diagnosis before editing

All four sampled rollouts report direct uniform initialization with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot.  Their combined
keyframe sheets show self-propelled motion in both views: the top-down row
develops an alternating mid-plane vortex street, while the oblique row shows
tail-connected three-dimensional Lambda2 loops.  None is passive advection or
a wake-collapse failure.  Every sample nevertheless turns upward and exits the
upper virtual boundary, so the semantic problem remains steering authority and
turn arrest rather than wake generation.

The strongest finite sample is the crossflow-assisted posterior-mean policy
with a speed-gated centerline course brake.  Relative to the assigned-parent
response-gated anterior redirect, it survives from `10.324T` to `11.594T`,
improves minimum/final distance from `11.081/11.155L` to `9.880/9.880L`, and
advances the center from `x=18.775L` to `17.386L`.  The top-down wake remains
alternating through exit and the oblique row retains separated, tail-connected
vortex loops, so the course brake is a useful semantic improvement even though
it does not capture.

The sampled histories identify the next bottleneck.  In the stronger policy,
body-frame bearing is already about `-0.37 rad` near `6T` and the reconstructed
posterior mean request is about `-11 deg`; from `8T` onward it is effectively
at the `-12 deg` curvature bound, yet the center rises from `14.11L` to
`15.20L`.  Tail acceleration is above 95% of the soft envelope on about 31% of
samples while anterior acceleration is there on about 9%, and both joint-speed
maxima reach the released limit.  More posterior gain is therefore poorly
supported.  The assigned-parent large-error anterior redirect is also a
negative control: recentering the oscillator state and building the tail wave
from that shifted state reduced head amplitude/speed, lowered saturation, but
reached only `11.081L` before the same upper exit.  Later workers should not
equate lower saturation from carrier relief with better route control.

## Single candidate hypothesis

Use the strongest sampled course-braked posterior-mean policy as the baseline.
Keep its zero-centered Van der Pol drive, complete lagged posterior wave,
relative-crossflow residual, yaw damping, course brake, and smooth acceleration
bound.  Add one new actuator mechanism only for established route error: a
continuous anterior half-cycle asymmetry proportional to the absolute observed
head-joint displacement.  A steep even bearing gate makes it negligible near
initial alignment; the odd turn command selects which half-cycle becomes
stronger once posterior steering is saturated.  Because the asymmetry vanishes
at every anterior zero crossing and the Van der Pol energy term remains centered
on zero, it does not reproduce the failed static anterior equilibrium shift or
remove posterior lag.

The first semantic test is reversal of the accumulated upper turn before the
`11.594T` boundary exit while retaining the sampled leftward progress and
alternating 3D wake.  Falsify the translation if minimum distance fails to beat
`9.880L`, the exit is not delayed or changed, anterior joint-speed residence or
acceleration saturation becomes persistent, hydrodynamic loads rise materially,
or the head carrier loses its zero crossings.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop direction tracking
source_mechanism: target-driven half-cycle amplitude asymmetry superposed on a traveling propulsive bend
transferable_invariant: when a bounded posterior mean turn is already saturated, add signed turning authority by strengthening one observed carrier half-cycle while preserving zero crossings and posterior lag
nontransferable_details: published gains, duty ratios, clocked CPG phase, robot or species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: map the existing normalized body-frame route command through an even large-bearing gate to an odd anterior equilibrium perturbation proportional to absolute joint displacement, leaving the zero-centered oscillator energy term and posterior traveling wave unchanged
falsification: reject if the upper exit is not delayed beyond 11.594T, closest approach does not improve below 9.880L, carrier zero crossings disappear, or velocity saturation and force or moment loads materially increase
