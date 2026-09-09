# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled evaluations satisfy the frozen contract: direct uniform
still-water initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
finite moving-window transport, and `capture`. I inspected every combined
keyframe sheet, including both its top-down vorticity row and oblique 3D
Lambda2 row, and cross-checked the strongest score against the most informative
inherited failure. The four captures visibly self-propel along the same broad
target-directed curve, retain an alternating top-down street, and carry compact
three-dimensional caudal structures into the capture circle. The inherited
`0.80` rate-guard failure instead retains a coherent energetic wake but bends
onto a late downward exit, terminating `left_domain` at `21.203T` after only
`5.3386L` closest approach. Coherent shedding and zero rate contact therefore
do not establish route preservation.

The samples provide two useful controlled differences. The unprojected base
redirect captures at `19.228T` and `19.321T`; the terminal lateral-velocity-lead
variant captures at `19.129T`; and the final-command projection captures at
`19.135T`. Mean distance remains within `2.1185--2.1279L`, score within
`-0.2390---0.2299`, and force/moment maxima overlap. These differences are too
small and under-replicated to rank the terminal lead above the repeat band, but
they do show that it preserves the successful route and wake. The projection
has stronger evidence: this sample and the assigned parent's inherited
projection result both capture near `19.12T`, while bounding both public
accelerations at `31.416 rad/T^2`; unprojected variants peak near
`62/101 rad/T^2`. The plant already applies the identical hard projection, so
this improves the public action contract without changing applied dynamics.

The inherited negative boundary is equally specific. State-dependent
outward-acceleration guards starting at `0.80` and `0.85` of the joint-rate
limit remove rate contact but lose capture at `5.3386L` and `5.0277L` closest
approach. This candidate does not retry a rate taper or claim rate relief. It
preserves the prefilled terminal velocity lead, target-owned route sign,
one-sided yaw-response release, differential mean curvature, and joint-state
traveling carrier exactly, and adds only the independently validated final
acceleration projection.

## Policy hypothesis

Add a policy-owned `1800 deg/T^2` acceleration limit and clamp only the two
completed commands. This composes the sampled terminal slip-aware approach
residual with the separately replicated interface projection. The projection
cannot alter the action seen by the plant when its limit matches the episode,
so the candidate should reproduce the prefilled capture topology and coherent
wake while returning no physically unrealizable acceleration.

Falsify the composition if either returned command exceeds the owned limit,
state becomes non-finite, capture or wake coherence is lost, or route, arrival,
mean distance, joint-rate contact, or load history leaves the successful repeat
band. Do not interpret unchanged rate contact as failure of this projection;
future rate relief must demonstrate phase preservation rather than merely
smaller commands.

bookshelf_consulted: true
source_domain: robotic-fish sensor-feedback CPG control and actuator-limited rhythmic locomotion
source_mechanism: preserve a low-dimensional joint-state traveling rhythm while body-frame feedback modulates direction, then project only commands outside the physical actuator envelope
transferable_invariant: route information and carrier phase stay in normalized body-frame geometry and observed joint state; an actuator projection should remove only demand the plant cannot apply
nontransferable_details: published gains, motor dynamics, dimensional beat settings, species-specific kinematics, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the captured lateral-fraction, terminal lateral-velocity, yaw-release, and differential-curvature equations, then clamp each completed two-joint acceleration at the policy-owned episode limit
falsification: any out-of-envelope return, non-finite state, lost capture or coherent wake, or applied trajectory outside the successful repeat band
