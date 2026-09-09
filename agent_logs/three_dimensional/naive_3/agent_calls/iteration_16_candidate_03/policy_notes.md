# Wake-policy candidate notes

## Prior evidence diagnosis

All four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=0`, no prewarm). In both top-down mid-plane and oblique Lambda2
keyframes, every policy self-propels along the same broad diagonal approach,
leaves a long coherent alternating wake, rotates sharply after passing the
target laterally, and remains powered while exiting the lower virtual boundary.
There is no visual evidence of advection, wake collapse, or a weak carrier.

The quantitative topology is correspondingly narrow: all four terminate
`left_domain` at `30.87--31.58T`, reach minimum distance `2.385--2.536L` near
`17.86--17.99T`, and have mean distance `8.436--8.448L`. The measured-yaw
posterior brake is the best sampled intervention at `2.385L`; the
joint-phase-selected counterbend reaches `2.512L`, full-direction posterior
gating reaches `2.494L`, and the response-released equilibrium S-bend reaches
`2.536L`. The best rollout is still moving at `0.705U` at closest approach,
with direction error about `1.38 rad`, raw yaw `2.185 rad/T`, and anterior joint
rate `-4.464 rad/T`; its anterior/posterior acceleration clamps occupy about
`0.747/0.356` of samples. This supports retaining the coherent carrier and the
raw-yaw half-cycle selector, not adding another posterior bias or scalar gain
edit.

The assigned parent and inherited completed scores also rule out the last two
posterior reallocations: they keep the powered lower exit at about `2.444L` and
`2.585L`; later sampled step-15 results likewise retain `left_domain` with
minimum distances `2.406L` and `2.541L`. The distinct signal defect is in the
anterior course loop. Inside `3L`, heading rate is anticorrelated with anterior
joint rate at `|r|=0.992--0.997` in all four sampled traces, with fitted slopes
from `-0.399` to `-0.459`. Thus raw yaw is mostly beat-synchronous there. At
the best minimum, the cross-sample central coupling `0.44` makes
`heading_rate + 0.44*phi_dot1 = 0.221 rad/T`, separating a much smaller slow
course response from the `2.185 rad/T` instantaneous yaw.

## Candidate hypothesis

Use the best sampled measured-yaw-brake policy as the carrier. Change only the
anterior steering feedback: damp a gait-residualized course yaw
`heading_rate + 0.44*phi_dot1` instead of raw heading rate. Retain raw measured
yaw for the posterior wrong-way half-cycle brake, where the evidence supports
it as a selector. The coefficient is owned by `target_policy_params`, is
dimensionless because both rates use radians per `T`, and is specific to this
unchanged carrier.

Expected result: removing the fast joint-locked yaw from mean-curvature
feedback should prevent useful curvature from being released and reversed on
each beat, while the unchanged posterior brake and traveling wave preserve
far-field progress and wake coherence. Falsify this candidate if cruise
topology or wake coherence changes materially, actuator/load residence rises,
minimum distance is not better than `2.385L`, or the powered lower-boundary
exit persists without a meaningfully different useful trajectory. Do not
transfer the fitted coupling to another carrier without re-estimating it.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-response separation
source_mechanism: separate slow target-directed course feedback from fast rhythmic body response while modulating an observed-state propulsion carrier
transferable_invariant: a gait-synchronous yaw component should not be treated as persistent course response, although the raw response can still select a beat-local intervention
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: preserve the two-joint state-feedback carrier; subtract the evidenced anterior-joint-rate component from yaw in the bounded body-frame mean-curvature loop, while retaining raw yaw for the posterior half-cycle selector
falsification: reject if far-field progress or wake coherence degrades, joint or load saturation increases, the minimum fails to beat 2.385L, or the same powered lower exit remains without a materially different trajectory
