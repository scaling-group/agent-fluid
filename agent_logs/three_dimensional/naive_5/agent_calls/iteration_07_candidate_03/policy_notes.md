# Wake policy diagnosis and hypothesis

All four sampled rollouts report direct uniform still-water initialization
with `U_infinity=(0,0,0)` and no prewarm.  The combined top-down and oblique
3D sheets show self-propulsion rather than advection: each long carrier sheds
an alternating coherent wake, while the moving window follows actual body
translation.  The raw-yaw closure exits upward at `20.790T` and `6.268L`; the
distributed posterior asymmetry also exits upward at `26.043T` and `5.386L`.
The sign-corrected anterior carrier remains high and passes the target station
near `y=14.044L`, with a `4.516L` minimum.

The inherited observation-gated redirect is the first sampled large-error
mechanism with a materially different useful trajectory.  Its coherent wake
curves downward, it crosses the target x station near `y=11.256L`, and it
reaches `1.165L` at `27.055T` without angle contact.  Any-joint speed- and
acceleration-cap residence fall to about `21.6%` and `35.5%`, from `40.5%`
and `59.3%` for the sign-corrected carrier, and peak planar force and yaw
moment remain comparable (`0.021` and `0.010` in the logged normalizations).
Thus the visual turn is productive and not a scalar-only or wake-strength
artifact.

The remaining failure is a maneuver-release failure.  Near closest approach,
the fish still moves at about `0.68L/T` with almost perpendicular target-course
error, while the two joints have settled into a same-side bend
`(-0.258,-0.173) rad`; their velocities are only `(-0.070,-0.180) rad/T` and
their commands only `(-0.03,-0.08) rad/T^2`.  The heading response then
reverses, distance grows, the rhythm resumes too late, and the fish exits the
left boundary at `39.253T`.  The top-down and oblique rows agree that this is
coasting after a near-static bend, not wake breakup or numerical instability.

Policy hypothesis: preserve the sampled carrier, posterior lag, response-
calibrated steering side, and geometry/yaw-gated redirect.  Add a normalized
two-joint bend-attainment release: when both joints have reached a substantial
fraction of their instantaneous same-side redirect targets, smoothly release
back into the traveling bend even if instantaneous yaw response has faded.
Combine bend and yaw release as a continuous union.  This uses only body-frame
target error, heading response, and observed joint state; it should prevent the
static C-bend latch and supply another propulsive/steering half-cycle near the
`1.165L` miss.  Falsify it if the same low-joint-speed coast remains, if early
release raises the target-station crossing or closest distance, or if limit
residence/load spikes return toward the saturated carrier.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish rhythmic control
source_mechanism: C-start redirect released by observed response or completion of the commanded body bend into a propulsive posterior beat
transferable_invariant: a large-error curvature maneuver must release from sensed body and response state before static curvature destroys the traveling wave
nontransferable_details: species-specific C-start stages, muscle timing, published gains, joint angles, exact wake phase, and task route
policy_translation: compute smooth normalized attainment of both instantaneous two-joint redirect targets and union it with phase-rejected yaw release, using only joint state and normalized body-frame feedback
falsification: reject if the near-target static bend persists, minimum distance does not beat 1.165L, target-station crossing rises above 11.256L, or saturation and loads materially increase
