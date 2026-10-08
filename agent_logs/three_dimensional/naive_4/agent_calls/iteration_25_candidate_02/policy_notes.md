# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

All four sampled rollouts are valid direct-uniform still-water episodes:
`U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture rather than domain
exit or instability.  The top-down sheets show a self-propelled fish growing a
coherent alternating wake from release, translating toward the target, and
retaining the wake through the final turn.  The oblique Lambda2 rows likewise
show organized three-dimensional tail-shed structures rather than advection of
an inactive body or wake breakdown.  The best and lowest-scoring sheets are
visually indistinguishable at their sampled frames, so the scalar difference is
terminal control evidence rather than a claim of different bulk wake topology.

The four policies all cross `8/6/4/2/1.25L` at the same logged steps, capture at
`16.0543747T`, use `239` moving-window shifts, and have the same sampled joint,
load, and saturation envelopes: approximately `26.3/36.4 deg` maximum joint
excursion, `49.2/21.9%` exact acceleration-limit residence, `0.02485/0.03223`
peak body-force coefficients, and `0.01903` peak yaw-moment coefficient.  Their
terminal mechanisms nevertheless separate cleanly:

- net line-of-sight-rate mean damping (`solver_8474fe870fa5`) is best at
  `1.929846L` distance integral, `0.745854L` final distance, and `-0.046908`;
- separate yaw-plus-slip mean damping (`solver_ddf99a38d49e`) reaches
  `1.929859L`, `0.745869L`, and `-0.046924`;
- adding slip-conditioned posterior half-cycle relief (`solver_e808cf9d855f`)
  changes only three commands after `16.0434T` and is trajectory-equivalent at
  `1.929858L`, `0.745867L`, and `-0.046923`;
- bearing-rate posterior-lobe relief (`solver_a03406b458eb`) changes only 17
  commands after `15.9664T` and regresses to `1.929919L`, `0.745940L`, and
  `-0.046998`.

Thus the sampled evidence supports the net target-relative mean response and
rejects another terminal wave-lobe gate as a useful route change.  It also
exposes the next testable separation: outside `2L`, a linear fit of normalized
bearing rate to normalized anterior angle and velocity explains `98.7%` of its
variance (`99.3%` over the reliable `2-10L` interval), with approximately the
same `(0.03,-0.44)` carrier coefficients already used for yaw.  Raw line-of-
sight rate is therefore mostly carrier motion; a bounded carrier-notched
residual can act earlier on persistent reopening without damping each beat.

## Policy hypothesis

Start from the sampled net line-of-sight-rate mean-damping policy.  Preserve its
anterior oscillator, posterior lag, response-gated redirect, wave relief,
approach settling, anti-windup, and validated terminal damping.  Add one
posterior-only mean-curvature correction during reliable target-closing motion:
subtract the joint-phase-predicted component from normalized bearing rate, and
oppose only the residual whose sign is reopening the body-frame target bearing.
Fade this route residual out as the validated terminal line-of-sight damper
fades in, so the two roles do not stack.  This should change feasible posterior
action before the last 17 commands while leaving the propulsive carrier intact.

Falsification is loss or delay of capture, later `8/6/4/2L` milestones, a larger
distance integral, reappearance of an exit/unstable topology, loss of the
coherent two-view wake, or materially increased posterior limiting/load peaks.
It is also falsified as a new route mechanism if it changes only the final beat
or reproduces the current `16.0544T` trajectory within rollout precision.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and fish wake-response control
source_mechanism: preserve a rhythmic carrier while feeding back a separated target-response residual through a bounded steering channel
transferable_invariant: distinguish repeatable carrier-phase motion from persistent navigation error, then correct only target-error reopening without cancelling the propulsive beat
nontransferable_details: published CPG gains, clock phase, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized anterior joint angle and velocity to predict normalized body-frame bearing rate; apply bounded posterior mean curvature only when the residual reopens bearing during speed-reliable target closing, with the sampled terminal line-of-sight response retaining its own nonoverlapping role
falsification: reject if capture or coherent propulsion is lost, milestones or distance integral regress, limiting or loads grow materially, or action changes remain confined to the sampled terminal commands
