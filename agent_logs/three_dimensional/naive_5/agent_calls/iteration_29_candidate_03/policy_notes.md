# Candidate diagnosis and hypothesis

The sampled rollouts all satisfy the direct-uniform still-water contract and
capture with the same coherent traveling-wake topology.  The assigned
translation-consistent parent is the best sampled score (`-0.616147`) and
reaches `0.748338L` at `26.246T`; the unarbitrated line-of-sight baseline
reaches `0.748829L` at `26.296T`, course-priority response allocation reaches
`0.748591L` at `26.241T`, and response-gated carrier relief reaches
`0.748792L` at `26.362T`.  All four have identical `8T` and `16T` distance to
the reported precision, remain within `0.013L` at `24T`, retain zero angle,
speed, and acceleration contacts, and share essentially the same peak planar
force/yaw moment near `0.01883/0.00979` (course priority reaches `0.00990`).
The top-down rows show sustained self-propulsion and an orderly alternating
wake followed by a late target-side hook; the oblique rows show that the
three-dimensional wake stays coherent through capture.  Thus none is a
semantic improvement, and neither more carrier relief nor another scalar
terminal or steering gain is supported.  The inherited scalar-only optimizer
logs likewise contain captures in the same narrow `0.7483--0.7496L` band but
provide no trajectory, visual, or load evidence for retuning.

The actionable conflict is structural.  The parent converts the route request
and target-line response request into half-cycle drives separately and then
adds them.  When their signs oppose, the signed steering parts cancel but the
two absolute-value phase terms do not; this injects an unintended beat-phase
pump precisely in the middle/late corridor where inherited evidence reports
opposed requests.  The candidate will use the parent's existing smooth
translation-distance gate to sum the two signed, gated acceleration requests
before applying the half-cycle selector once in the evidenced middle/late
corridor.  Agreement and far travel are exact pass-through states, while
nearby disagreement cancels coherently before the nonlinear phase map.  The
established carrier, large-error redirect, terminal posterior wave-shape term,
common acceleration projection, and joint viability guards remain unchanged.

Expected test: retain the coherent capture route and zero actuator contacts,
while changing the middle/late trajectory enough to improve capture margin or
arrival without raising the sampled force/moment envelope.  Reject the
mechanism if capture is lost, the wake weakens, arrival slows like the carrier-
relief branch, loads rise, or the result stays in the same milliscale-equivalent
cluster.

A frozen-state audit over all `4772` assigned-parent trajectory rows changes
`420` commands, all at distances no greater than `4.5L` and between
`19.162--24.349T`; the largest command delta is `0.8744 rad/T^2`, while the
maximum candidate request remains the parent's `29.72585 rad/T^2`.  This is not
a rollout claim, but it verifies that the mechanism is active, bounded, and an
exact far-route pass-through before formal downstream evaluation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG and asymmetric flapping control
source_mechanism: target feedback changes one rhythmic half-cycle or duty ratio to turn while preserving the propulsive cycle
transferable_invariant: combine simultaneous signed steering demands before one phase-selective rhythm modulation so cancellation does not create a second, contradictory half-cycle pump
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species kinematics, dimensional frequencies, and prescribed routes
policy_translation: form normalized body-frame route and inertial target-line response accelerations, then use the existing smooth distance gate to sum them before the anterior joint-state half-cycle selector in the evidenced middle/late corridor
falsification: reject if the fixed-condition rollout loses capture or wake coherence, increases force or moment and limit exposure, delays arrival, or fails to leave the existing milliscale trajectory cluster
