# Candidate wake-policy notes

## Evidence diagnosis

Only the common naive-seed rollout is sampled in this first-generation
workspace, so there is no independent successful example to claim. Its early
finite segment is nevertheless informative beside its terminal failure. The
run used the required direct uniform still-water initialization
(`U_infinity=[0,0,0]`) and no cylinders.

Both visual views show genuine self-propulsion rather than passive advection.
The top-down row develops an alternating, body-attached wake by 2--3T and a
coherent curved vortex trail by 8T; the oblique Lambda2 row confirms that this
is a three-dimensional shed wake, not a mid-plane rendering artifact. The
useful carrier initially moves the head left and trims distance from 12.328L
to 12.078L. It does not turn to the target: body-frame bearing grows from
+0.155 rad initially to -0.428 rad at 5T, -1.086 rad at 7T, and -1.296 rad at
termination. The fish curls upward and exits the virtual field at 8.547T with
distance 12.380L. Thus the visible wake and early finite progress support
preserving the phase-lagged carrier, while the left-domain topology supports
adding target feedback rather than merely increasing propulsion.

The metrics also expose limited carrier headroom: joint speed reaches the
260 deg/T hard limit, while raw requested accelerations reach about 60 and
75 rad/T^2. This candidate therefore does not add a burst or higher-frequency
drive. The single new mechanism is bounded mean-curvature steering. The 3D
turn-sanity calibration states that positive joint bias creates negative yaw;
that sign maps the initial positive bearing to the required negative-yaw
correction. A small normalized heading-rate term opposes wrong-way yaw and
relaxes the bias once yaw develops in the requested direction.

## Policy hypothesis

Center the inherited Van der Pol anterior oscillator and its lagged posterior
target on a bounded, body-frame bearing-dependent curvature. Apply the same
mean-bend sign to both joints so steering changes mean curvature without
replacing posterior phase lag. Keep the request continuous with `tanh`, and
limit its joint-angle bias so the oscillatory carrier retains room inside the
45 degree envelope.

Expected result: the initial positive bearing should produce a positive bend
and negative yaw before the uncontrolled 4--6T turn, after which the bias
should reverse as the target crosses the centerline. The first semantic bar is
avoiding the upper-boundary exit while making more than the seed's 0.250L
closest approach; capture is the stronger test. Falsify the mechanism if the
turn has the wrong sign, if bearing remains beyond 0.5 rad for several beats,
if the same `left_domain` trajectory recurs, or if static curvature destroys
the alternating wake and forward progress.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and classical mean-curvature turning
source_mechanism: sensor-driven average joint offset superposed on a propulsive rhythm
transferable_invariant: persistent body-frame target error should create bounded mean curvature while the posterior traveling-wave lag remains active
nontransferable_details: published gains, species-specific amplitudes, clock-driven CPG phase, exact vortex phase, and prescribed routes
policy_translation: map normalized bearing plus normalized yaw-rate damping through tanh to bounded centers for both joint-state oscillators
falsification: reject if yaw initially moves away from the target, the carrier wake or distance progress collapses, or boundary exit persists without a meaningfully different useful trajectory
