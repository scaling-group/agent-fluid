# Candidate diagnosis and hypothesis

The sampled v50 controller is the strong finite comparator.  Two independent
copies capture at `17.41299 T`, score `-0.0595203`, and total/observed distance
integrals `1.945327/1.329976 L`.  Its top-down sheet shows self-propelled target
approach behind a coherent alternating street; the oblique sheet shows organized
three-dimensional caudal structures at release, `4 T`, `16 T`, and capture,
with the `12 T` oblique keyframe missing rather than showing a physical failure.
The direct-uniform initialization and zero background flow are confirmed in the
observation and diagnostics.

The prefilled v52 terminal course-slip correction is the informative failure.
It preserves the same visible route and coherent wake, and its oblique sequence
is readable, but it does not improve a checkpoint: at `16 T` it is `0.000016 L`
farther away.  It reaches the same discrete `17.41299 T` capture step while
worsening total integral to `1.946671 L`, leaving observed integral effectively
unchanged at `1.329989 L`, crossing more shallowly at `0.746705 L`, and raising
any-joint acceleration-limit residence from `40.11%` to `40.75%`.  Maximum
speed and normalized force/moment remain `0.9831 L/T`, `0.03225`, and `0.01609`.
Thus normalized course slip is observable, but adding it to the route request
perturbs the already validated head steering, drive arbitration, and posterior
shape together without buying radial closure.

The candidate restores reproduced v50 route behavior and tests one different
mechanism: a bounded, approach-and-closing-gated course residual localized to
posterior wave shape.  It uses the signed normalized cross product of body-frame
target direction and body velocity, is multiplied by observed carrier motion,
and vanishes outside terminal approach, without changing the anterior command,
base mean curvature, cadence, redirect, or carrier-first allocation.  The
hypothesis is that low-dimensional posterior modulation will rotate terminal
thrust/curvature while preserving v50's radial carrier.  Reject it if capture,
the `14-16 T` lead, either distance integral, wake coherence, or the sampled
speed/action/load envelope regresses.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and residual CPG modulation
source_mechanism: sensory course error modulates a low-dimensional rhythmic wave-shape command while the propulsive oscillator remains intact
transferable_invariant: localize bounded direction feedback to the posterior traveling-wave degree of freedom instead of rewriting the established carrier and route command
nontransferable_details: published oscillator gains, robot morphology, duty ratios, dimensional cadence, exact phases, and task-specific paths
policy_translation: compute reflection-odd normalized body-frame target/velocity course slip and inject an approach-and-closing-gated posterior shape target on the observed joint-state carrier
falsification: reject if v50's capture or middle/late closure is lost, total or observed distance integral fails to improve, the two-view wake decoheres, or speed, saturation, force, or moment exceeds the sampled envelope
