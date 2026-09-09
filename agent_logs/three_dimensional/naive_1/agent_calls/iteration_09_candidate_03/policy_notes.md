# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders
or prewarm, finite moving-window dynamics, and `capture`. I inspected the
combined sheets for the best-scored prefilled carrier and the assigned
parent's newly evaluated bearing-progress qualifier, including the top-down
vorticity and oblique body/Lambda2 rows, and cross-checked them against
`wake_metrics.csv`, `wake_diagnostics.json`, their trajectories, controller
sources, assigned-parent guidance, and inherited optimization notes.

Both policies are visibly self-propelled rather than advected. They form the
same coherent alternating top-down street, follow the same broad
target-directed curve, and retain compact three-dimensional caudal structures
through first crossing. The progress-qualified parent therefore preserves the
useful carrier but does not produce a semantic trajectory improvement. It
captures at `19.1675T`, with score `-0.237379` and mean scored distance
`2.12587L`; the prefilled terminal-slip carrier captures at `19.0190T`, with
score `-0.226715` and mean scored distance `2.11536L`. The parent's joint-rate
contact is also slightly higher (`10.85%/14.55%` versus `10.76%/14.05%`) while
peak planar force and moment overlap. These differences are small, but they
reject the parent's expectation of a shorter broad route and give no reason to
stack another response-release qualifier.

The other sampled controls reinforce that boundary. The unprojected base and
projected base capture at `19.2280T` and `19.1345T`, with mean scored distances
`2.11852L` and `2.12198L`; all four wake sheets remain in one route/wake class.
Thus terminal raw lateral velocity remains only a capture-preserving
composition, not a tuned causal improvement, while final acceleration
projection remains the validated public-action boundary. The inherited
outward rate barriers are still excluded because they removed rate contact but
lost capture near `5L`.

The trajectory offers a bounded state-feedback direction for a distinct
actuator primitive. Reconstructing normalized target side and the anterior
joint phase for the best sample, target-requested-bend-aligned displacement
occurs on `2,904` rows and has correcting yaw on `57.1%`; the opposed half-cycle
occurs on `554` rows and has correcting yaw on only `14.8%`. The correlation
between phase alignment and correcting yaw is `0.392`. This is not causal proof
or a transferable gain, but it is enough to test phase-selective steering
instead of another scalar or instantaneous course residual.

## Single-candidate policy hypothesis

Preserve the prefilled oscillator, posterior lag, normalized target geometry,
terminal lateral-velocity lead, one-sided yaw release, opposite-sign mean
curvature, and final acceleration projection. Add one bounded half-cycle
steering asymmetry derived only from anterior joint displacement relative to
its current biased center and the sign of the existing turn request. Scale both
anterior and posterior bias shares by the same factor in `[0.8,1.2]`: strengthen
the target-aligned bend half-cycle and weaken the opposed half-cycle without
changing steering sign, mean bias allocation, oscillator clock, posterior lag,
or acceleration envelope.

Expect phase-selective curvature to turn more usefully per beat and shorten the
broad approach without the phase destruction seen under pointwise rate
barriers. Falsify it if capture is lost; arrival, mean distance, rate contact,
force, or moment leaves the successful repeat band; the high/left exit returns;
the top-down street or oblique caudal structures lose coherence; or the phase
scaling reverses target-owned sign or returns an out-of-envelope command. The
new CFD outcome is unavailable to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning with state-dependent asymmetric flapping, informed by classical mean-curvature steering
source_mechanism: concentrate bounded steering authority in the target-useful beat half-cycle while retaining a low-dimensional traveling rhythm
transferable_invariant: persistent normalized body-frame target geometry owns turn sign, while observed joint phase may redistribute but not invert bounded curvature authority across a beat
nontransferable_details: published gains, duty ratios, dimensional frequencies, motor models, species-specific kinematics, full-body waveforms, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: retain the captured two-joint carrier and steering request; infer target-aligned anterior displacement from joint state and multiply both opposite-sign bias shares by one bounded phase factor
falsification: reject if capture or coherent wake is lost, route progress fails to improve beyond repeat variability, load or saturation worsens, carrier phase is distorted, steering sign reverses, or returned acceleration exceeds the owned envelope
