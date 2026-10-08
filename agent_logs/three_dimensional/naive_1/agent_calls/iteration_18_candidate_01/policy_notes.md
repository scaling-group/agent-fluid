# Wake-policy candidate notes

## Visual and numerical diagnosis before the policy edit

All four sampled rollouts satisfy the released experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders
or prewarm snapshot, finite `capture` termination, and no reported numerical
instability. The complete top-down sheets show continuous curved translation
toward the target behind an alternating red/blue caudal street, so the fish is
self-propelled rather than advected. The complete oblique rows for
`solver_43e27134a723` and `solver_392ed1eddf30` retain discrete three-dimensional
Lambda2 structures at the developed gait, approach, and capture frames. The
blank oblique rows for `solver_a9222453ae0c` and `solver_c85ef8d2aea3` are render
artifacts; their numerical and top-down evidence cannot be counted as separate
3D-wake confirmation.

The response-plus-anterior-stroke schedule in `solver_43e27134a723` and
`solver_c85ef8d2aea3` is the strongest finite sampled policy and reproduces
byte for byte. It captures at `24.310009T` in 4,420 steps, with score-metric
mean distance `2.223959L` and crossing distance `0.749162L`. The broad
closing-deficit relief captures at `24.326511T` with mean distance `2.224097L`;
the prefilled translation-alignment replacement is later at `24.343010T` and
has mean distance `2.224020L`. All share the same measured peak normalized
planar force/yaw moment, about `0.031649/0.016385`, and nearly identical joint
rate-cap occupancy. The complete sheets also show the carrier remains active
through capture. Thus the useful distinction is bounded steering allocation
by observed anterior stroke phase, not extra load, carrier suppression, or a
new terminal response signal.

The inherited optimizer logs sharpen the stopping boundary. A carrier/rudder-
reinforcement intersection added after the successful anterior-stroke schedule
regressed to `24.326511T` and mean distance `2.224136L` without a new
termination or trajectory class. A posterior-velocity overlap and an
anterior/posterior phase union were then proposed from replayed gates, but no
sampled CFD result establishes either as an improvement. Together with the
weaker translation- and bearing-response replacements, this is evidence
against spending this candidate on another inferred phase intersection.

## Policy hypothesis

Replace only the prefilled translation-alignment terminal relief with the
twice-reproduced response-plus-anterior-stroke schedule. Preserve the full
body-frame target geometry, slip-aware anterior center, joint-state traveling
carrier, posterior reactive-rudder sign and recruitment, and the tested 20%
relief ceiling. The one-step closing-deficit signal is retained only as a
fixed-pose empirical trigger; multiplying its bounded relief by the existing
reflection-equivariant product of target-side sign and anterior joint velocity
allocates the mean steering release without changing carrier amplitude or
adding clock phase, route memory, or world coordinates.

This is a conservative selection of the strongest completed mechanism, not a
claim of held-out robustness. Falsify reuse if capture is lost or later than
`24.310009T`, mean distance exceeds `2.223959L`, behavior changes before the
terminal deficit gate activates, or the coherent wake, saturation, near-field
effort, `0.031649` force peak, or `0.016385` moment peak materially worsens.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and asymmetric flapping
source_mechanism: sensory modulation of a bounded steering offset within a continuing rhythmic carrier
transferable_invariant: preserve the propulsive traveling bend and allocate only the mean steering residual by normalized observed joint phase
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, exact vortex phase, prescribed timing, and task-specific routes
policy_translation: combine normalized closing deficit with the reflection-equivariant target-side anterior joint-rate gate while leaving carrier phase, amplitude, rudder sign, and the tested relief ceiling unchanged
falsification: reject if capture is lost or later than 24.310009T, mean distance exceeds 2.223959L, preterminal behavior changes, or wake, saturation, effort, force, or moment envelopes worsen
