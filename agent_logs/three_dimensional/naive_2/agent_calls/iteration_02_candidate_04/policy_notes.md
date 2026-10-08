# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis

All four sampled rollouts report direct uniform still-water initialization and
terminate by leaving the virtual domain; none captures the target. The
top-down and oblique sheets show self-propulsion with a coherent, genuinely 3D
alternating wake rather than passive advection. The useful carrier should
therefore be retained.

The naive carrier reduces distance from 12.328L to 12.078L before curling into
the upper boundary at 8.547T. Its body-frame bearing passes near zero around
4T, then reaches about -1.296 rad, while roughly one third of its raw joint
accelerations exceed the 1800 deg/T^2 envelope. Directly centering joint 1 on
an 8--9 degree mean-curvature bias is worse: the two sampled variants reach
only 12.271L and 12.299L, their joint-speed maxima collapse to roughly
0.83--1.26 rad/T, and they exit at essentially the initial x-position. Those
visual arcs and metrics indicate that static anterior curvature suppresses the
traveling wave without arresting the wrong-way turn.

The strongest finite example instead biases only the posterior target and
smoothly bounds acceleration. It reaches 11.512L with smaller peak force and
moment than the naive carrier, confirming that anterior oscillation can remain
propulsive while the tail steers. However, its instantaneous bearing crosses
zero repeatedly from about 3.4T to 5.8T, then stays negative as the trajectory
drifts upward; both joint velocities touch the 260 deg/T limit and the fish
exits at 9.823T. Body heading alone is therefore a poor route proxy during a
strong tail beat. The body-frame angle between target displacement and actual
velocity supplies a rotation-invariant course error and is speed-gated so its
near-rest direction is ignored.

## Policy hypothesis

Keep the naive joint-state oscillator and posterior phase lag, including the
successful smooth acceleration bound. Replace static tail offset with a
bounded half-cycle envelope asymmetry: a course-aware turn request strengthens
one sign of the posterior traveling wave and weakens the other without moving
the anterior oscillator center. Bearing provides low-speed target geometry;
speed-gated course error corrects accumulated translational slip; measured yaw
rate supplies a smaller counter-rotation term. The testable expectation is
that the fish retains the strong example's leftward progress but reverses its
mean turn before the upper-boundary exit. Reject the mechanism if minimum
distance is not below 11.512L, if the same upper-exit topology remains, if
propulsion falls to the direct-curvature level, or if acceleration/velocity
saturation or load spikes become persistent.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: sensor-driven half-cycle amplitude asymmetry around a rhythmic carrier
transferable_invariant: steer by changing the relative strength of the two beat halves while preserving posterior lag and the propulsive oscillator
nontransferable_details: published gains, clock phase, duty timings, robot kinematics, species envelopes, and prescribed routes
policy_translation: form a bounded turn request from normalized body-frame bearing, speed-gated target-versus-velocity course error, and yaw response; add turn request times the absolute posterior wave target to that target before damped tracking
falsification: reject if target bearing and course do not converge before 8T, leftward progress collapses, upper-boundary exit recurs, or joint limits and hydrodynamic loads dominate
