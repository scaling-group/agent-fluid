# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled solver evaluations and the assigned parent's inherited
evaluation use direct uniform still-water initialization with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the combined
top-down vorticity and oblique body/Lambda2 sheets for the strongest sampled
capture (`solver_a2a24e9e57f4`), the prefilled parent
(`solver_7c3c97939b32`), and the inherited posterior-only half-cycle failure
(`solver_18a6636f0024`), then cross-checked the images against metrics,
diagnostics, trajectories, policy sources, assigned-parent guidance, and
inherited optimization notes.

The parent and strongest sample are visibly self-propelled rather than
advected. Both build a coherent alternating top-down street, translate along
a broad target-directed curve, and retain compact three-dimensional caudal
structures through capture. The strongest sample is the only current result
with a positive trajectory signal outside a scalar-only edit: coordinated
half-cycle scaling of both mean-curvature shares improves score from
`-0.226715` to `-0.211642` and mean distance from `2.11536L` to `2.09994L`,
while capture time is essentially unchanged (`19.019T` to `19.008T`). Peak
planar force and moment do not increase (`0.02730` and `0.01640` versus
`0.02851` and `0.01687`), and the wake remains coherent.

This mechanism is not actuator relief. Anterior/posterior acceleration contact
remains `61.1%/73.1%` versus `61.5%/72.1%` for the parent, and joint-rate
contact changes from `11.08%/14.29%` to `11.20%/14.99%`. The final projection
therefore remains interface ownership, not an efficiency claim.

The inherited failure makes allocation, not the phrase "half-cycle
steering," the important boundary. Modulating only posterior bias from
posterior displacement, while removing the terminal lateral-velocity lead,
kept an energetic alternating wake but missed capture at `1.219L`, straightened
onto a departure wake, and exited left at `31.570T` and `8.882L`. Thus wake
coherence and bounded phase modulation alone do not preserve route authority.
The successful sample instead retains the captured lead and scales the
opposite-sign anterior/posterior bias pair together from normalized anterior
displacement, preserving their ratio and target-owned sign.

## Single-candidate policy hypothesis

Promote the strongest sampled executable exactly: preserve the prefilled
joint-state oscillator, posterior lag, normalized target-side request,
terminal body-lateral-velocity lead, one-sided yaw release, opposite-sign mean
curvature, and final acceleration projection. Add the sampled bounded
anterior-phase factor in `[0.8,1.2]` to both mean-bias shares. This concentrates
curvature in the target-useful half-cycle without changing the steering sign,
anterior/posterior allocation ratio, oscillator period, or actuator envelope.

The prior CFD result supports improved distance integration with capture, but
one evaluation does not establish repeatability or efficiency. Falsify this
promotion if its new evaluation loses capture, leaves the coherent wake/route
class, falls outside the sampled successful arrival and mean-distance band,
materially raises loads or rate contact, reverses target-owned steering, or
returns an acceleration outside the owned envelope. Do not respond to such a
failure by increasing the half-cycle fraction or retrying posterior-only
modulation; first isolate whether the phase allocation or retained terminal
lead caused the divergence. The new evaluation is unavailable to this worker
and is not claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning with state-dependent asymmetric flapping, informed by classical mean-curvature steering
source_mechanism: concentrate bounded steering authority in the target-useful beat half-cycle while retaining a low-dimensional traveling rhythm
transferable_invariant: normalized body-frame target geometry owns turn sign, while observed joint phase may redistribute but not invert the coordinated anterior/posterior curvature request across a beat
nontransferable_details: published gains, duty ratios, dimensional frequencies, motor models, species-specific kinematics, full-body waveforms, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the captured two-joint carrier and terminal lead; infer target-aligned anterior displacement from joint state and multiply both opposite-sign mean-bias shares by the same bounded positive phase factor
falsification: reject if capture or coherent wake is lost, route progress fails to replicate beyond variability, load or saturation worsens materially, the curvature allocation ratio changes, steering sign reverses, or returned acceleration exceeds the owned envelope
