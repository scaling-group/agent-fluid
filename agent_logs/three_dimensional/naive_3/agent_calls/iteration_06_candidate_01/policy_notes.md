# Candidate diagnosis and hypothesis

## Evidence read before editing

All sampled and inherited evaluations report direct uniform still-water
initialization (`U_infinity=0`), no cylinders, finite dynamics, and a
`left_domain` termination. The combined top-down-vorticity and oblique-Lambda2
sheets for the strongest sampled carrier (`2.443L`) and the inherited
closing-gated C-bend failure (`2.468L`) show self-propulsion with a coherent
alternating three-dimensional wake. Neither rollout is an advection, weak-wake,
or numerical-instability failure. Both approach from the upper right, pass on
the same lower side of the target, rotate into a powered downward track, and
leave the lower boundary.

The inherited C-bend changed the late body shape visible near `24T`, but it did
not change the semantic trajectory or termination. Relative to the strongest
sample, its score fell from `-10.220` to `-10.750`, mean distance rose from
`8.443L` to `8.877L`, final distance rose from `9.193L` to `9.657L`, and peak
planar force/moment magnitude rose from about `0.0287/0.0148` to
`0.0510/0.0260`. Its slightly smaller `2.468L` minimum is therefore not a
positive mechanism result. The prior return-half-cycle brake also retained the
same topology (`2.501L`, lower exit), so neither stronger late curvature nor
beat-side braking is retained.

The strongest carrier exposes an earlier feedback omission. On its inbound
crossings of `8L` and `6L`, body-axis target-direction error was only
`0.083--0.098 rad`, while the measured velocity direction lay about
`0.62 rad` on the opposite side of the forward axis; velocity-to-target course
error was `0.712--0.716 rad` and closing speed was only `0.691--0.693 L/T`
despite `0.913--0.918 U` speed. The target-bearing controller therefore sees
near alignment while the actual course already carries substantial lateral
slip. This precedes both the `2.443L` lateral miss and the late redirect gate.

## Policy hypothesis

Return to the strongest sampled alignment-gated, `7 deg` bounded-curvature
carrier and add one mechanism: speed-qualified body-frame sideslip compensation
inside the target-direction-to-curvature map. Compute the measured velocity
angle relative to the body forward axis, fade it continuously to zero at low
speed, and subtract a bounded fraction from the full target-direction error.
This asks for corrective curvature while the body points near the target but
its course drifts away, and releases that correction when velocity moves to the
target side. It does not add burst curvature, distance staging, a clock, a
route, or scalar carrier-gain tuning; the posterior traveling wave and its
alignment authority remain intact.

Falsification: reject sideslip compensation if it damages the coherent
far-field wake or early distance decrease, causes a tight curl or larger
force/moment peaks, increases acceleration-limit residence, or retains the
same powered lower exit and roughly `2.4--2.9L` closest-approach band. A scalar
improvement without a meaningfully different useful trajectory is not enough.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and fish-like terminal yaw/slip control
source_mechanism: measured motion feedback modulates a bounded mean-curvature command around an intact posterior-lag propulsive rhythm
transferable_invariant: steer the observed course, not body bearing alone, by correcting persistent body-frame sideslip while preserving the traveling wave
nontransferable_details: published gains, robot or species kinematics, dimensional beat timing, open-loop phase, exact vortex timing, and task-specific routes
policy_translation: blend bounded full target-direction error with a speed-qualified body-frame velocity angle, then drive the existing two-joint mean-curvature carrier
falsification: early-progress loss, wake collapse, a short-radius curl, larger load or clamp residence, or the same powered lower-boundary miss

## Implemented candidate and pre-CFD sanity

The implemented policy removes the failed return-half-cycle brake and
instantaneous-yaw release term, retains the sampled oscillator, posterior lag,
alignment gating, and `7 deg` curvature cap, and adds only the speed-qualified
sideslip term described above. Replaying the strongest completed trajectory's
observations through the new steering map (not a hydrodynamic rollout) adds
about `+0.199/+0.195 rad` of correct-sign steering at the inbound `8L/6L`
crossings, then releases to `-0.024/-0.058 rad` as measured velocity moves to
the corrective side at `4L/3L`. This is the intended early-course correction,
not a claim of improved CFD behavior.

All `324` repository tests pass. Synthetic mirrored target, velocity, joint,
and joint-rate states produce sign-mirrored finite commands; zero-speed startup
remains finite and removes velocity-direction authority; and opposite-side
slip produces the expected corrective command ordering within the configured
limit. Formal CFD remains deferred to the evaluator.
