# Wake-policy candidate notes

## Evidence read before the edit

All four sampled rollouts and the assigned parent's inherited rollout report
direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
prewarm, and capture. The strongest sampled soft-envelope controller captures
at `16.943T`, scores `-0.20539`, and has mean distance `2.090L`. The prefilled
continuous angle-barrier controller is an informative slower contrast: it
captures at `18.276T`, scores `-0.24813`, and has mean distance `2.135L`.

Both rows of their combined keyframe sheets were inspected from release to
termination. In each top-down row, body motion advances through still water
while a regular alternating red/blue street lengthens behind the tail; the
soft-envelope sample reaches the target sooner without turning the street into
a standing or one-sided wake. In each oblique row, compact alternating
three-dimensional Lambda2 structures trail the body through approach and
remain present at capture. Peak local flow is only `0.0325U` in the stronger
sample versus peak body speed `1.393U`, confirming self-propulsion rather than
moving-window advection. The soft envelope also reduces raw acceleration
peaks from `59.87/88.41` to `29.84/29.85 rad/T^2`, peak force/yaw moment from
`0.03716/0.01907` to `0.03609/0.01766`, and posterior angle magnitude from
`0.7505` to `0.5907 rad`.

The residual defect is repeated exact `260 deg/T` speed occupancy
(`3.73/3.54%`). Two completed speed overlays establish a tradeoff rather than
a wake failure. The assigned parent's smooth one-sided guard eliminates exact
occupancy and preserves the alternating sheets but delays capture to
`17.330T`, increases mean distance to `2.102L`, and lowers peak swim speed to
`1.366U`. The sampled linear braking barrier also eliminates occupancy, but is
more intrusive (`17.435T`, `2.111L`, `1.328U`). In the unguarded soft-envelope
trace the two joints never occupy the speed limit simultaneously: at all 115
anterior-limit samples the posterior is below 90% of its limit (mean 27%), and
at all 109 posterior-limit samples the anterior is below 90% (mean 11%). Thus
the evidence supports testing phase-aware allocation, not stronger symmetric
braking or another fixed threshold alone.

## Single-candidate hypothesis

Start from the strongest sampled soft-envelope capture and retain its
body-frame velocity-course observation, zero-centered anterior oscillator,
posterior lag, target-steering reserve, and posterior angle stopping-risk
projection. Add the assigned parent's continuous high-speed guard to both
joints, then introduce one bounded, one-way carrier-work reallocation: when
that guard removes speed-increasing anterior acceleration, transfer a fraction
of the removed magnitude into the existing posterior carrier direction only
when the posterior command agrees with that direction. Limit the transfer by
the posterior soft-envelope headroom, then apply the posterior speed guard and
angle projection. No posterior loss is sent into the anterior oscillator, so
the evidenced zero-centered anterior structure and target steering sign are
not replaced.

As a non-CFD replay of the new projection on the strongest logged trace, the
anterior guard would activate in `7.92%` of samples and the phase/headroom
conditions would admit posterior allocation in `6.62%`. Active transfers have
mean magnitude `0.835` and maximum `5.454 rad/T^2`, only eight samples exceed
`5 rad/T^2`, and every transfer remains below the existing soft ceiling. This
checks that the mechanism is selective and material; it does not predict its
closed-loop trajectory.

Expected result: retain zero speed-limit occupancy and the coherent
alternating wake while recovering some of the parent's `0.387T` arrival loss
without exceeding the soft acceleration ceiling. Falsify the mechanism if it
loses capture, exceeds the parent's speed maxima, disrupts alternating
shedding, materially exceeds the soft baseline's `0.0361/0.0177` load peaks,
increases posterior angle occupancy, or fails to improve on the parent's
`17.330T` arrival and `2.102L` mean distance.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and elongated-body reactive propulsion
source_mechanism: retain a low-dimensional feedback-modulated rhythm while posterior wave kinematics carry most reactive thrust
transferable_invariant: preserve carrier phase and redirect only bounded unavailable anterior work toward an already phase-consistent posterior stroke with measured actuator headroom
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, full-body waves, exact vortex phases, and prescribed routes
policy_translation: use normalized joint speed and the physical acceleration envelope to guard both outputs, then allocate only guarded anterior acceleration into the signed posterior carrier command within its remaining soft headroom
falsification: reject if hard-speed occupancy returns, capture or coherent alternating shedding is lost, arrival and mean distance do not improve over the one-sided guard, or force, moment, and posterior-angle peaks exceed the soft-envelope reference
