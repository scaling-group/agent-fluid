# Wake policy diagnosis and hypothesis

All four sampled evaluations report direct uniform still-water initialization
with `U_infinity=(0,0,0)`.  In both rows of the combined sheets, the fish moves
through the inertial field while shedding an alternating three-dimensional
wake, so the trajectories are self-propelled rather than moving-window
advection.  The raw-yaw closure is the informative short failure: it keeps a
coherent wake but curls to the upper/left boundary at `20.790T`, no closer than
`6.268L`, with angle contact, roughly `51/58%` speed/command-limit residence,
and peak planar force/yaw moment about `0.057/0.027`.  The sampled intercept-
qualified redirect and posterior wave-asymmetry variants also remain in the
high corridor and get no closer than `4.278L` and `5.386L`.

The joint-state-released redirect is the uniquely useful finite trajectory.
Its top-down row visibly turns down toward the target and its oblique row
retains a compact alternating wake throughout approach.  It crosses the target
x station at about `y=11.050L`, reaches `0.831L` at `27.484T`, has no sampled
joint-angle contact, and keeps peak planar force/yaw moment near
`0.021/0.010`.  This validates observed bend attainment as a release signal
even though the eventual left exit makes its scalar score worse.

At closest approach the head is at `(8.294,9.938)L`, only `0.081L` outside the
capture radius, but it is still moving about `0.661L/T` down-left with the
normalized velocity/target cross error near `0.99`.  The posterior joint has
reached only about `26%` of its instantaneous same-side redirect target, so the
bend-release gate is still closed; both commands are below `0.24 rad/T^2` and
closing speed falls through zero.  The failure is therefore a terminal
collision-cone miss during a low-power redirect, not wake breakup or too-early
global release.  The preceding intercept-only release is the negative control:
requiring an already-safe projected miss before restoring the traveling wave
latched the redirect in the high corridor and stopped at `4.278L`.

Policy hypothesis: start from the validated joint-attainment release, and add
one continuous terminal rebeat gate.  Only when distance is small, closing is
positive, and normalized projected miss remains large, smoothly remove the
static redirect weight so the existing joint-state oscillator and posterior
lag supply a dynamically steered beat.  Outside that conjunction, preserve
the sampled redirect and all carrier gains.  This is a state-dependent energy-
allocation change rather than scalar amplification; it should rotate or sweep
the head through the final `0.081L` gap without disturbing the productive
broad redirect.  Falsify it if minimum distance does not beat `0.831L`, the
same low-command cross-target coast persists, the target-station crossing rises
above `11.050L`, or speed/command residence and peak loads materially exceed
the sampled near-capture trajectory.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish rhythmic control
source_mechanism: release a bounded large-error curvature maneuver into a sensor-gated propulsive rhythm when terminal interception still requires lateral correction
transferable_invariant: near a target, persistent projected miss while closing calls for renewed dynamic steering before static curvature becomes a coast
nontransferable_details: species-specific C-start stages, published CPG gains, joint angles, exact vortex phase, dimensional distance thresholds, and task route
policy_translation: use smooth normalized body-frame distance, closing speed, and velocity-target cross-error gates to release the two-joint redirect into the existing joint-state traveling bend
falsification: reject if capture or a sub-0.831L approach is not obtained, the low-command terminal coast remains, the earlier redirect worsens, or limit residence and loads materially increase
