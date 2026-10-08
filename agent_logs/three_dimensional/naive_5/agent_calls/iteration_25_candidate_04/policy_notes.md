# Candidate diagnosis and policy hypothesis

The four sampled rollouts are valid direct-uniform still-water evaluations and
all capture at about `26.30T`.  The coordinated traveling-bend carrier remains
self-propelled: the top-down sheets show a coherent alternating reverse wake
from release through capture, and the oblique sheets show a persistent compact
three-dimensional wake without a terminal breakup or an externally advected
fish.  The evaluated baseline, anterior capture-corridor residual, and
posterior tail-bias variant have visually indistinguishable route topology and
identical sampled peak planar force/yaw moment (`0.018834/0.009789`), with no
angle, speed, or acceleration contacts.  The anterior residual changes final
distance from `0.749242L` to `0.749090L`; the assigned posterior variant reaches
`0.748829L`.  Those sub-milliscale changes are evidence that neither additional
terminal anterior authority nor the small posterior mean bias materially
changes the shallow crossing.

At the assigned rollout's capture sample, speed is about `0.648L/T`, while only
about `0.338` of that velocity is directed along the target line and the
frozen-course projected miss is about `0.705L`.  Thus the remaining problem is
not wake formation or actuator headroom; the fish retains too much transverse
translation while the target-line/yaw response remains deficient.  The policy
hypothesis is a bounded radial-progress-conditioned gait reallocation.  Inside
the existing approach/miss corridor only, poor normalized closing efficiency
and a positive line-of-sight yaw-response deficit smoothly blend the complete
carrier-plus-residual command toward the already evaluated same-sign redirect.
Efficiently closing states, disagreement between course and target-line turn
sides, and far-field propulsion pass through unchanged.  This removes the
ineffective posterior tail-bias branch rather than stacking another terminal
pulse onto it.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation
source_mechanism: sensory feedback reallocates a rhythmic gait between propulsion and turning when the observed directional response is inadequate
transferable_invariant: preserve the productive rhythm while response is useful, but use normalized measured progress to trigger a bounded continuous reallocation toward curvature
nontransferable_details: published oscillator gains, robot geometry, dimensional beat timing, species-specific C-start kinematics, exact wake phase, and task-specific routes
policy_translation: combine body-frame target and velocity into a dimensionless closing-efficiency signal, then gate a smooth blend from the existing traveling-bend command to the existing two-joint redirect using the established approach, miss, closing, side-agreement, and yaw-deficit evidence
falsification: reject if the far trajectory changes, the coherent two-view wake or capture is lost, command contacts return, arrival slows materially, loads rise, or the capture crossing is not visibly deeper than the sampled sub-milliscale variants
