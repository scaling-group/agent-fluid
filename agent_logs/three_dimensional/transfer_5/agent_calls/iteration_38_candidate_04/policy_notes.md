# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

All four sampled evaluations report direct uniform initialization with
`U_infinity=(0,0,0)`, no cylinders or prewarm snapshot, finite dynamics, and
capture. There is therefore no sampled non-capture to compare; the informative
regression is the assigned-parent role-separated observer, and the strongest
finite result is the course-observer stabilization handoff reproduced by two
independently written policies with bit-identical CFD trajectories.

I inspected the combined top-down mid-plane-vorticity and oblique Lambda2 rows
for the strongest course-observer rollout and the assigned-parent regression
from release through capture, and also checked the stabilization-envelope
anchor. All three fish self-propel along the same smooth left-and-down arc. A
compact alternating vorticity street appears behind the body, the oblique view
shows coherent alternating three-dimensional structures convecting downstream,
and neither view shows passive advection, wake collapse, or out-of-plane
instability. The visual sampling cannot distinguish the controller variants,
so the small ordering is a trajectory/load effect rather than a new wake class.

The two replicated shared-course observers capture at `23.441015T`, score
`-0.501691`, and have scoring mean/final distance
`2.399184/0.746948L`. Relative to the faster stabilization-envelope anchor
(`23.375013T`, `-0.502603`, `2.400102/0.746257L`), they reduce inside-`3L`
mean absolute yaw from `1.70656` to `1.68733 rad/T`, mean/peak target-line
cross-track speed from `0.23432/0.62616U` to `0.22592/0.58298U`, and
mean/peak absolute moment from `0.006564/0.015118` to
`0.006393/0.013886`. They also reach `6L` `0.0605T` earlier, but reach
`3/2/1L` later and then carry signed/absolute target-line cross-track speed of
`+0.31846/0.34055U` below `1L`. Thus the course residual is useful through the
middle approach but remains a plausible contributor to the late crossing
delay.

The assigned parent retained that course residual in the main turn request but
restored body-lateral slip only in the terminal desired-yaw reference. It has
the same sampled `6/3/2/1L` crossing times as the shared observer and captures
only `0.0055T` earlier, while regressing score and scoring mean/final distance
to `-0.502841` and `2.400084/0.748139L`. Its peak yaw and moment also worsen
to `3.35551 rad/T` and `0.014017`. This completed negative result rejects
another terminal desired-yaw role swap: it does not resolve the final-band
tradeoff and gives back the shared observer's aggregate benefit.

## Candidate hypothesis

Restore the replicated shared carrier-rejected target-course observer, then add
one progress-qualified near-capture handoff. Outside `1L`, use the sampled
course residual unchanged in both slow route roles. Inside `1L`, continuously
withdraw only that velocity-derived course term as the fish closes toward the
existing `0.75L` terminal scale, qualified by positive target-radial motion and
the existing release speed gate. Bearing, target-vector geometry, yaw/slip
stabilizers, steering authority, base cadence, C-bend carrier, posterior lag,
and smooth command projection remain active. This tests a control-layer handoff,
not a scalar gain retune, and should leave the trajectory unchanged until the
observed regression band.

Falsify the mechanism if formal CFD loses capture or coherent propulsion,
changes the shared observer's pre-`1L` crossing topology, fails to improve its
arrival or distance integral, worsens final-band cross-track motion/yaw/moment,
or increases joint-limit or projected-command exposure.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG path following and terminal approach control
source_mechanism: sensor feedback modulates a slow directional residual while a coupled rhythmic carrier and short-range stabilizer retain separate roles
transferable_invariant: preserve target-directed traveling-wave propulsion, but hand a slow course correction to short-range geometry and damping only after observed target-directed closing is established
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, duty ratios, oscillator phase, exact vortex timing, capture radius, and prescribed route
policy_translation: use normalized body-frame distance, target-radial progress, and swimmer speed to fade only the carrier-rejected target-line course residual inside the observed final band while retaining the two-joint state-feedback carrier and existing stabilizers
falsification: reject if CFD changes the pre-handoff path, loses capture or wake coherence, fails to improve shared-observer arrival/distance, or worsens terminal lateral motion, yaw/load, or actuator feasibility

The new candidate has no same-worker CFD result; its handoff remains a
falsifiable proposal for the next evaluation.
