# Wake-policy candidate notes

## Evidence diagnosis

The only sampled completed rollout is the common naive seed
`solver_ab755c2206e8`; no separate strong or successful finite example is
available in this fresh lineage.  It is direct-uniform still water
(`U_infinity=0`) with no cylinders, so its early finite segment and terminal
failure are the available comparison.  No inherited optimizer log existed in
this workspace before this candidate note; the assigned parent guidance and
the sampled solver artifacts are therefore the complete inherited evidence.

Both visual rows show self-propulsion rather than ambient advection.  From
release through about `6T`, the top-down row develops an alternating attached
body/tail wake and the oblique Lambda2 row confirms a coherent three-dimensional
vortex trail.  The same views then show a large upward-curving sweep: the fish
rotates across the local window and exits the top of the inertial field rather
than keeping its small initial target correction.  This is a steering/yaw
stability failure, not a missing-wake or weak-propulsion failure.

The trace agrees with the images.  Distance falls only from `12.328L` to
`12.078L` at `6.358T`, then rises to `12.380L` at `left_domain` termination at
`8.547T`.  The center reaches `y=15.200L`; absolute heading rate exceeds
`1 rad/T` for about 41% of samples.  Joint speed reaches the `260 deg/T` limit
and the raw policy request exceeds `1800 deg/T^2` on about 52% of samples,
although joint-speed limit contact is only about 4.4%.  The useful invariant
to preserve is the state-feedback traveling bend and coherent propulsion; the
missing mechanism is bounded target-referenced mean curvature with braking as
the target bearing starts sweeping through centerline.

## Policy hypothesis

Keep the seed's autonomous joint-state oscillator and posterior lag.  Center
the head and tail rhythms on small bounded mean-bend targets computed from the
normalized body-frame bearing.  Add a short bearing-trend prediction in the
same coordinate so a correct turn loses authority before overshoot and a
diverging turn gains it.  This is one target-vector-to-mean-curvature mechanism,
not a clocked route or a scalar-only gait retune.  Do not add distance staging
or wake cancellation before broad target-directed swimming is demonstrated.

Expected evidence after evaluation: retain an alternating 3D wake, prevent the
large upward sweep and sub-`10T` top-boundary exit, and reduce distance
materially below `12.078L`.  Falsify the mechanism if the first turn has the
wrong sign, if the same early `left_domain` topology remains, or if mean bend
destroys the coherent propulsive wave or increases limit contact/load spikes.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and classical fish turning
source_mechanism: sensor-modulated bounded tail-beat offset or mean curvature superposed on a propulsive rhythm
transferable_invariant: separate the oscillatory propulsion carrier from a bounded target-error-driven mean bend, and reduce that bend when observed bearing trend shows centerline convergence
nontransferable_details: published gains, clock-driven phase, species-specific joint envelopes, exact kinematics, and task-specific routes
policy_translation: map normalized body-frame bearing plus its bounded recent rate to joint-center biases while retaining the joint-state oscillator and posterior phase lag
falsification: reject if turn sign is wrong, early top-boundary exit persists, or the alternating wake and useful forward progress collapse
