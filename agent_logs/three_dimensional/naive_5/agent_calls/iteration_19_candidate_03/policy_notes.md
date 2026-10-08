# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance and its inherited worker log identify the
  reflection-equivariant angle stopping-margin guard as the latest mechanism:
  preserve the capture-proven traveling bend and line-of-sight response, and
  alter only an outward-moving joint whose angle plus stopping excursion
  approaches the hard envelope.
- All four sampled evaluations satisfy the direct-uniform quiescent contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and terminate in capture.
  They comprise two byte-identical executions of the unguarded line-of-sight
  policy (`0.749769L` at `27.6045T`) and two byte-identical executions of the
  angle-guarded policy (`0.749992L` at `27.7695T`), so duplicate sheets support
  fixed-condition determinism but do not supply trajectory diversity.
- In both combined sheets, the top-down mid-plane row shows self-propelled
  translation with an organized alternating wake followed by a late
  correct-sign turn into the capture circle. The oblique body/Lambda2 row
  remains coherent through the same route; the storage window follows the
  body and does not visibly advect it. No sampled failure sheet is available,
  so the informative defect comparison is the unguarded success: it contacts
  the posterior `45 deg` boundary three times and reaches peak planar
  force/yaw moment near `0.03397/0.01548`.
- The angle guard removes those contacts and lowers peak planar force/yaw
  moment to about `0.02212/0.01041`, while reducing acceleration-clamp samples
  from `1878/10038` to `1700/10098`. Its two identical captures materially
  confirm the inherited safety lesson. However, `1124/10098` joint samples
  still reside at the `260 deg/T` speed cap. The sampled improvement therefore
  leaves a measured velocity-envelope defect; moving the angle threshold or
  retuning the navigation gain would not address that distinct state.
- Earlier inherited negative results already close terminal pulse, recoil,
  damping, deeper-curvature, and instantaneous projected-intercept branches.
  The current coherent capture route gives no evidence for reopening them.

## Policy hypothesis

Promote the sampled two-joint angle stopping-margin guard, preserving its
carrier, posterior allocation, target/course selector, redirect, terminal miss
veto, and positive line-of-sight response-deficit branch. Add one separate
velocity-viability mechanism after the angle guard: for either joint, when its
observed angular speed enters a soft band below the hard speed envelope and
the combined command would accelerate farther in the same direction, smoothly
replace only that outward component with bounded opposite acceleration. Leave
inward commands and all sub-band gait phases exactly unchanged, and apply the
same construction to both joints to retain lateral reflection equivariance.

The falsifiable expectation is repeat capture with the same coherent visual
route, no angle contact, and fewer speed-cap samples without restoring the
unguarded force/moment exposure. Reject the mechanism if it loses capture,
changes ordinary sub-band commands, increases acceleration-clamp or load
exposure, creates near-limit chatter, or merely trades speed saturation for
angle contact. The new CFD result is produced only after this worker exits and
is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated rhythmic robotic-fish control and physical-envelope feedback for traveling-wave propulsion
source_mechanism: preserve a productive state-feedback rhythm while a bounded residual intervenes only where measured actuator motion violates a physical viability condition
transferable_invariant: constraint feedback should be reflection-equivariant, inactive throughout viable traveling-bend motion, and oppose only the command component that worsens measured loss of headroom
nontransferable_details: published gains, dimensional frequencies, species-specific joint speeds, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain the body-frame target-line controller and two-joint angle stopping guard; add the same smooth near-speed-limit, command-direction gate to each observed joint acceleration so only speed-increasing commands are replaced by bounded braking
falsification: reject if fixed-condition capture or the coherent route is lost, sub-band or speed-reducing phases change, speed-cap residence does not fall, or angle contact, acceleration clipping, force, or yaw moment increases

## Non-CFD implementation audit

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were run
  directly and separately: the guidance semantic-delta/schema check, finite
  two-joint Julia policy contract, and solver editable-boundary check all pass.
- Every one of the 41 direct `params.FIELD` references is owned by
  `target_policy_params()`, and exactly one non-empty candidate policy exists
  under `solver/`. A reflected synthetic near-cap state negates both commands
  to floating-point tolerance, while a sub-band state exactly matches the
  sampled angle-guard parent. At `259 deg/T`, the governor reduces a
  speed-increasing joint-1 command from `12.2794` to `-0.8405 rad/T^2` and
  leaves joint 2 unchanged.
- Applying only the new governor algebra to the recorded angle-guard trace
  would alter 1,264 joint commands (961 anterior and 303 posterior); every
  change opposes the measured speed direction, and none of those altered
  samples is at the acceleration clamp before or after the algebra. This
  establishes material activation, pass-through behavior, boundedness, and
  symmetry only. It is an open-loop trace audit, not a prediction of the
  unevaluated CFD trajectory or capture result.
