# Candidate wake-policy diagnosis

## Evidence read before editing

All four sampled evaluations report `uniform_direct` initialization with zero
background velocity, so the visible wakes are generated after release rather
than inherited from a prewarm. In both rows of the combined sheets, the
alignment carrier, the strongest response-gated brake (`2.385L` minimum), and
the assigned parent's differential course S-bend (`2.469L`) remain stable and
self-propelled. The top-down row shows a long, alternating reverse-street-like
trail and a repeatable down-left transit past the target; the oblique Lambda2
row confirms coherent three-dimensional shedding through the closest approach
and on to termination. There is no visual wake collapse, passive advection, or
tight curl before the miss.

The trajectory cross-check makes the failure specific. Every sampled policy
retains one sign of target-ray-to-course error for every sample inside `3L` at
speed above `0.2U`; its mean magnitude is about `1.54 rad`. At their minima,
the strongest brake and assigned parent are still moving at `0.705U` and
`0.690U`, with full target-direction errors of `1.379` and `1.339 rad`.
Anterior acceleration is already clamped for roughly `0.73` of samples inside
`3L`, while posterior acceleration is not. The parent's added course-equilibrium
request therefore changes the closest point only from `2.385L` to `2.469L` and
retains the same powered lower-boundary exit. More posterior equilibrium
redirection, scalar propulsion gain, or additive anterior authority is not the
supported next test.

## Policy hypothesis

Return to the evidenced response-gated-brake scaffold and add one distinct
anterior half-cycle mechanism. Near the target, when normalized target-ray to
translational-course error is large and measured yaw is currently worsening
that signed error, continuously attenuate only the zero-mean anterior
oscillatory acceleration. Keep the anterior mean-curvature acceleration and
the posterior traveling-wave target intact except for the already evidenced
posterior brake. This uses unclipping/withholding rather than demanding more
from the saturated anterior actuator. It should accumulate corrective yaw
without destroying the coherent cruise wake. The hypothesis is falsified by a
minimum no better than `2.385L`, the same lower exit, a short-wake curl, worse
far-field progress, or greater actuator/load residence.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction control
source_mechanism: sensor-gated half-cycle amplitude or duty asymmetry around a propulsive rhythm
transferable_invariant: preserve the traveling carrier and modulate only the rhythm portion that reinforces measured wrong-way turning
nontransferable_details: published gains, clock phase, species-specific kinematics, exact duty ratios, and task-specific routes
policy_translation: use normalized body-frame target/course error, distance, speed, and measured heading rate to attenuate only wrong-way anterior oscillatory acceleration while retaining bounded mean-curvature steering
falsification: reject if closest approach is not better than 2.385L, the lower-exit topology persists, wake coherence or far-field progress degrades, or actuator/load residence rises
```
