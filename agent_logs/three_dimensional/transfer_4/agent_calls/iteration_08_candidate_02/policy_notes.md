# Candidate diagnosis and hypothesis

All four sampled evaluations satisfy the frozen Phase-2 contract: direct
uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm, no
cylinders, and capture termination. The two `-0.51274776` samples are exact
reruns of the signed-curvature rate-governed controller, so they establish
determinism rather than separate mechanisms. The line-of-sight drift residual
slightly improved that baseline to `-0.49332402` and `23.1715T`, but the
posterior-priority phase-plane envelope is the decisive sampled improvement:
it captures at `17.8585T`, improves the score to `-0.09355786` and mean
score-distance from `2.4095L` to `1.9800L`, shortens center path from
`13.3177L` to `12.8148L`, and reduces maximum straight-line cross-track from
`2.014L` to `0.535L`. Its far/middle inertial line-of-sight drift has only
`0.0011 rad/T` mean, so adding another route-drift correction is not supported
for this parent.

I inspected the combined top-down mid-plane and oblique Lambda2 sheets for the
posterior-priority parent, the rate-governed baseline, and the inherited shared
cadence regression. All begin in quiescent water and show self-propelled motion
with a coherent alternating wake and persistent three-dimensional posterior
vortex train through capture; there is no passive advection, prewarm artifact,
collision, wake breakup, or out-of-plane instability. The posterior-priority
sheet visibly takes a shorter, straighter route and arrives earlier, while the
baseline and shared-gate sheets bend later. The useful new mechanism is thus
posterior propulsion, not a change in wake existence or steering polarity.

That improvement did not satisfy its original load-relief falsification. Relative
to the rate-governed baseline, anterior residence above 96% of joint rate falls
only from `15.68%` to `14.72%`, posterior rate residence rises from `3.58%` to
`5.76%`, and acceleration-ceiling residence changes from `69.61/50.68%` to
`69.70/65.17%`. RMS yaw, planar force coefficient, and moment coefficient rise
from `1.5537 rad/T`, `0.0123`, and `0.0064` to `2.0285 rad/T`, `0.0156`, and
`0.0081`. The contrast concentrates in the already successful approach: inside
`2.1L` the posterior-priority rollout has mean course alignment `0.870`, mean
speed `0.876U`, RMS yaw `2.110 rad/T`, and `72.48%` posterior
acceleration-ceiling residence, versus `0.945`, `0.678U`, `1.535 rad/T`, and
`48.96%` for the baseline. At capture its course alignment is only `0.374`,
speed is `0.900U`, yaw rate is `-3.078 rad/T`, and the posterior action is at
the acceleration ceiling. Capture is fast but tangential and load-heavy.

The candidate preserves the measured odd target-to-curvature polarity, the
phase-plane anterior envelope, full posterior emphasis throughout far and
middle transit, cadence, steering, and direction-selective rate governor. It
adds one compact approach-hold mechanism: continuously blend only the *extra*
posterior wave emphasis toward its neutral traveling-wave gain as normalized
distance closes, but retain it when measured course alignment and speed place
the fish in the capture corridor. The existing body-frame distance/alignment
gate supplies the blend, so there is no clock, route, target identity, or
world-frame command. Expected evidence is an unchanged far/middle path and
wake, retained capture near the parent's arrival scale, better terminal course
alignment, and lower terminal posterior acceleration/yaw/load. Falsify the
mechanism if it materially delays or loses capture, disturbs the coherent
posterior wake before approach, fails to reduce terminal load and tangential
arrival, or merely transfers saturation to the anterior joint.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and closed-loop robotic-fish terminal direction tracking
source_mechanism: posterior-emphasized traveling-wave propulsion with a continuous near-target approach hold
transferable_invariant: retain posterior lag and emphasis for transit, then condition only excess propulsive excursion on normalized target distance and measured course closure near capture
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, and task routes
policy_translation: use the existing body-frame distance and course-alignment gate to blend posterior wave gain between the evidenced transit emphasis and a neutral lagged wave while leaving odd curvature steering and the anterior state-feedback carrier intact
falsification: reject if capture, arrival scale, distance integral, reflection symmetry, or two-view wake coherence worsens materially, or if terminal posterior saturation, yaw, and poor course alignment do not improve
