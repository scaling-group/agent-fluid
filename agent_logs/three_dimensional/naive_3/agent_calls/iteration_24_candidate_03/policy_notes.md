# Wake-policy candidate notes

## Evidence read before the edit

All four sampled evaluations report direct uniform still-water initialization
with `U_infinity=[0,0,0]`, no prewarm, and capture. The inherited parent log
also contains two identical captures, one left-domain failure with a `5.621L`
closest approach, and the later soft-envelope capture. Because the inherited
failure has only a scalar score log here, it is evidence that capture can be
lost but not enough evidence to attribute that loss to a particular mechanism.

The combined keyframe sheets were read in both views. Across release,
established swimming, and capture, the top-down row shows a coherent
alternating vorticity street rather than a reciprocal standing wiggle. The
oblique row shows compact, alternating three-dimensional Lambda2 structures
following the body. The fish advances through still water while peak local
flow remains only `0.0315--0.0325U`, so the trajectory is self-propelled, not
passive advection. No sampled sheet shows collision, domain exit, or wake
collapse before termination.

The informative contrast is the best finite soft-envelope sample against the
three slower barrier variants. The soft-envelope policy captures at `16.943T`
with mean distance `2.090L`, versus about `18.27T` and `2.135L`. Its peak speed
is `1.393U` rather than `1.329U`; raw acceleration exceedance falls from about
`51.3/46.4%` to zero; peak force/yaw moment fall to `0.03609/0.01766`; and the
posterior angle stays within `0.5907 rad` instead of reaching `0.7505 rad` or
the `0.7854 rad` hard stop. The retained alternating wake agrees with those
metrics. The remaining mechanical defect is exact joint-speed-limit occupancy
of about `3.73/3.54%`, so command-magnitude protection alone does not establish
speed viability.

## Single-candidate hypothesis

Start from the evidenced soft-envelope capture, preserving its target-course
observation, zero-centered anterior oscillator, posterior lag, steering
allocation, and angle stopping-risk projection. Add one continuous normalized
joint-speed guard to both outputs. It activates only above a high fraction of
the known speed envelope and only when acceleration and velocity have the same
sign; inward braking and all lower-speed commands remain unchanged. The guard
therefore addresses residual hard-stop occupancy without installing another
route mode, static bend, external phase, or scalar-only carrier retune.

Expected result: preserve capture, the alternating 3D wake, sub-limit raw
accelerations, and the faster broad route while reducing exact speed-limit
occupancy below the `3.73/3.54%` reference. Falsify the candidate if it loses
capture, materially worsens the `16.943T` arrival or `2.090L` mean distance,
reduces peak speed without reducing hard-stop occupancy, raises the
`0.0361/0.0177` force/moment reference, or disrupts alternating shedding.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and classical reactive swimming
source_mechanism: preserve a low-dimensional rhythmic carrier while sensor feedback modulates a bounded actuation envelope
transferable_invariant: protect actuator viability with joint-state feedback while retaining the phase-coherent traveling bend that supplies thrust
nontransferable_details: published CPG gains, dimensional beat frequency and amplitude, species-specific envelopes, full-body waves, and prescribed routes
policy_translation: normalize measured joint speed by its physical limit and smoothly remove only outward acceleration near that limit, after the evidenced sub-limit acceleration envelope
falsification: reject if capture or coherent alternating shedding is lost, arrival or mean distance materially worsens, load peaks rise, or exact speed-limit occupancy does not fall
