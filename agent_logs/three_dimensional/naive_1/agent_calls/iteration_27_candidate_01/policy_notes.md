# Broadside middle-distance curvature reserve

## Evidence diagnosis before the edit

All four sampled evaluations use direct uniform quiescent initialization and
terminate in capture.  The combined sheets show genuine self-propulsion: the
top-down row develops a persistent alternating wake while the body bends onto
the target-directed route, and the oblique row retains compact caudal
Lambda2 structures through approach.  The trajectory and diagnostics agree:
peak planar force coefficient is `0.0307--0.0322`, peak local-flow magnitude
is about `0.026 U`, and the three executable-identical parent samples capture
at `18.6505--18.8815 T` with mean distance `2.08855--2.09222 L`.  Their
acceleration/rate contact remains about `61/73%` and `11/15%`, so coherent
wakes and capture do not justify adding propulsion effort.

The sampled route topology also gives a useful non-interference boundary.  One
parent capture never reaches `|lateral_fraction|=0.60`; the other two first do
so only at `1.2746--1.2861 L`.  The rearward-route variant first becomes
broadside at `1.3224 L` and captures without ever putting the target behind
the fish, so its new multiplier is dormant rather than recovery evidence.  In
contrast, the assigned parent guidance records an executable-equivalent
near-miss that first reaches `|lateral_fraction|=0.60` at `2.0134 L` while the
target is still forward, after the ordinary route argument is already nearly
saturated; it misses at `0.85155 L` and exits left.  A behind-target boost is
therefore too late, while another term inside the saturated route argument has
no clear authority.

## Policy hypothesis

Preserve the parent's oscillator, posterior lag, half-cycle redistribution,
target-owned turn sign, correcting-yaw response release, and final
acceleration projection.  Add one small differential mean-curvature reserve
outside `route_request`, gated continuously by three normalized body-frame
conditions: appreciable lateral broadside error, positive forward target
fraction, and distance above the successful terminal broadside band.  The
reserve fades to exactly zero by `1.35 L`, so it is dormant on every sampled
capture trajectory and cannot interfere with the established terminal route.
It should act only on the earlier broadside topology represented by the
inherited near miss.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish closed-loop CPG turning
source_mechanism: releaseable C-start-like mean-curvature bias layered on a propulsive rhythm
transferable_invariant: a large observed route error can receive bounded extra curvature, then release when geometry or correcting response no longer calls for it
nontransferable_details: species-specific C-start shape and duration, published CPG gains, dimensional frequencies, exact vortex phases, and prescribed routes
policy_translation: use normalized forward/lateral target fractions, normalized distance, and observed yaw response to gate a small opposite-sign anterior/posterior curvature reserve while retaining the two-joint state-feedback wave
falsification: reject if any ordinary capture is lost, the same near-miss/left-exit topology remains, wake coherence degrades, or actuator contact and planar load rise without a better termination class or route

The new candidate has no same-worker CFD evidence.  Its evaluation must test
capture first, then route topology, both visual rows, demand contact, and load
against the sampled bands above.
