# Candidate wake-policy notes

## Evidence diagnosis before editing

All reviewed rollouts satisfy the direct-uniform still-water contract.  The
naive seed is self-propelled: its top-down row develops an alternating wake and
its oblique row confirms a coherent three-dimensional tail wake.  It nevertheless
hooks upward, improves only from `12.328L` to `12.078L`, and exits at `8.547T`
with distance `12.380L`.  Its raw anterior and posterior acceleration requests
exceed `1800 deg/T^2` on about 32% and 34% of samples, respectively, so more
unguided drive is not the missing capability.

The assigned parent's equal `9 deg` head/tail equilibrium bias is a concrete
negative result.  Its joint means become approximately `(0.105, 0.107) rad`,
acceleration RMS falls to only `(1.5, 2.2) rad/T^2`, and the alternating carrier
visibly gives way to a broad U-shaped turn.  It never gets closer than
`12.321L` and ends at `15.360L`.  The two other sampled controllers that recenter
the anterior oscillator likewise reduce its oscillation and leave through the
upper boundary at final distances near `13.45L`.  Thus persistent mean
curvature on the anterior oscillator is not supported here, and the previously
assumed static-curvature turn sign is not reliable once the carrier has been
quenched.

The strongest finite comparison is the posterior-only candidate.  Keeping the
anterior oscillator centered at zero while adding a bounded tail tangent and a
smooth acceleration envelope preserves an energetic alternating wake, moves
the center left from `21.000L` to `19.253L`, and improves minimum distance to
`11.512L`.  Its oblique frames show an organized vortex train rather than wake
collapse.  However it still exits upward at `9.823T` with `y=15.203L` and
distance `11.518L`.  Near the target-line crossing, body-frame lateral velocity
is already about `+0.23U` in the seed; in the posterior-only run it reaches
about `+0.32U` at `7T` while bearing is negative.  Bearing-only mean bias reacts
too late to the accumulated lateral slip even though yaw is beginning to
reverse at termination.

## Policy hypothesis

Keep the naive anterior Van der Pol oscillator and posterior phase-lag waveform
as the propulsive carrier.  Replace persistent tail equilibrium offset with a
bounded half-cycle amplitude asymmetry: a positive turn request strengthens
the positive side of the observed posterior target and weakens the negative
side, and reflection reverses both choices.  This produces a signed average
turning effect while requiring the tail waveform to cross zero every beat.

Form the turn request from body-frame bearing, relative crossflow, and measured
turn rate.  Relative crossflow supplies early sideslip compensation: in still
water it changes sign against lateral body motion, so a fish sliding away from
the target asks for earlier corrective asymmetry.  Turn-rate feedback reduces
authority once the requested yaw develops.  Smoothly bound both accelerations
at the released actuator envelope, retaining the useful behavior of the best
sample without treating the envelope as a drive target.

The first semantic test is an alternating carrier that survives past `9.823T`
without the same upper-boundary exit while improving on `11.512L`.  Falsify the
translation if its initial yaw sign is wrong, half-cycle modulation causes a
large joint mean or erases posterior lag, normalized lateral slip does not
decline around the bearing crossing, acceleration/joint saturation increases,
or the same exit topology recurs without a meaningfully different useful
trajectory.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop direction tracking
source_mechanism: target-driven half-cycle amplitude asymmetry layered on a posteriorly lagged propulsive wave
transferable_invariant: preserve the alternating traveling bend while strengthening only the beat side that supplies the requested signed turn, with bounded feedback releasing as target alignment and yaw response improve
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, clocked CPG phases, exact vortex phases, and task-specific routes
policy_translation: map normalized body-frame bearing plus relative crossflow and turn-rate feedback to an odd bounded request that asymmetrically scales the two signs of the observed posterior phase-lag target
falsification: reject if reflection reversibility fails, the tail stops crossing zero, target progress does not beat the posterior-only sample, lateral slip persists, actuator loads grow, or the upper-boundary exit remains unchanged
