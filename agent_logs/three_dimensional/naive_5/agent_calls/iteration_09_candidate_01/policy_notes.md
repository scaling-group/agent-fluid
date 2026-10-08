# Candidate diagnosis and hypothesis

Evidence reviewed before editing: the assigned C-start parent, all four sampled
solver scores/observations/metrics/diagnostics/policies, the strongest finite
and most informative failure keyframe sheets in both top-down vorticity and
oblique Lambda2 views, the inherited optimizer guidance, and inherited step-8
scores.  Every sampled rollout reports direct uniform still-water
initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.

The top-down and oblique rows show self-propulsion rather than advection.  The
distributed-posterior sample keeps an alternating three-dimensional wake but
remains in the high corridor and exits the upper margin at `26.043T`, with
`5.386L` minimum distance and angle/load contact.  The assigned same-sign
two-joint redirect preserves a coherent wake to `39.253T`, descends through the
target neighborhood, avoids instability, and reaches `1.165L` at about
`27.055T`; it then overshoots and exits left.  At closest approach its speed is
about `0.68L/T`, closing speed has fallen to zero, body-frame bearing is about
`-72 deg`, and the velocity/target cross product predicts a `1.16L` miss.  The
parent's yaw response suppresses most redirect authority while range falls
from about `5.5L` to `2.9L`, despite a projected miss of roughly `2.5--4.0L`,
then restores a near-static redirect too late to enter the `0.75L` capture.
This agrees with the inherited step-8 negative result: globally vetoing release
until the intercept is good latches the bend at range and worsens the route,
whereas response-based release variants reached `0.830L` and `0.870L` but still
crossed the terminal neighborhood too fast and nearly perpendicular.

Policy hypothesis: preserve the parent's carrier, calibrated turn side, and
yaw-response release outside the target neighborhood.  Inside a continuous
body-length terminal zone only, qualify that release by positive closing speed
and projected course miss.  This should start the already evidenced bounded
redirect early enough to remove the remaining cross-track error without
recreating the failed far-field static-bend latch.  The experiment tests a
release architecture, not another propulsion or steering-gain increase.

bookshelf_consulted: true
source_domain: biological C-start redirection and robotic-fish closed-loop path following, combined with terminal capture control
source_mechanism: large observed heading error invokes bounded curvature, then measured response releases into propulsion; terminal geometry separately schedules approach correction
transferable_invariant: separate broad route redirection from terminal intercept correction, and gate both entry and release with observed geometry and response
nontransferable_details: species-specific C-start shapes, published gains and frequencies, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: retain joint-state phase and the two-joint bounded redirect; blend projected miss and closing-speed qualification into release only as normalized body-frame target distance enters the terminal zone
falsification: reject if the far-field trajectory or coherent wake changes, a static bend appears before the terminal zone, minimum distance does not beat the inherited `0.830L` near miss, or angle/load/limit residence worsens materially
