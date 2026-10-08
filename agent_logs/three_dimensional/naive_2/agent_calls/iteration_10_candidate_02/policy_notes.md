# Signed-response posterior half-cycle candidate

## Evidence diagnosis

All four sampled evaluations used direct uniform still-water initialization
with `U_infinity=[0,0,0]`; none is a prewarm or passive-advection case. In both
rows of the combined keyframe sheets, each policy self-propels with an
alternating top-down vortex street and tail-connected oblique Lambda2
structures. The wake therefore supports preserving the traveling-wave carrier.
The failure is trajectory control: the useful `solver_37a652a3989e` rollout
turns sharply only in its final panels and exits through the upper boundary.
Its trajectory reaches `4.162L` at `17.506T` while still moving at `0.824U`,
with target-versus-velocity course error about `-1.155 rad` and body-frame
lateral velocity about `+0.234U`, then recedes to `6.363L`. The
distance-relieved `solver_4482d3d05d9c` keeps an even straighter coherent wake
but gives up approach distance (`5.126L` minimum), confirming that wake
coherence alone is not capture control.

The inherited half-cycle result reached `3.259L` and reduced acceleration-limit
residence from `75.0%` to `65.8%`, so posterior half-cycle attenuation remains
a plausible phase-compatible steering actuator. However, the sampled early
course-responsive descendant `solver_963e74a3f179` worsened closest approach to
`5.000L` even though it retained the coherent wake, reduced sampled
near-limit residence to about `62.1%`, and ended closer at `5.918L`. Its
activation is driven by absolute course-error magnitude: it can attenuate a
half-cycle when bearing and course error request opposite corrections. The
sampled trajectory contains such disagreement near `3T`, `4T`, `6T`, `7T`,
`9T`, and `10T`, before the useful parent's closest approach.

## Policy hypothesis

Preserve the full-amplitude anterior oscillator, bounded mean posterior
steering, and the existing normalized bearing/crossflow/yaw/course feedback.
Replace whole-posterior-wave closure relief with posterior half-cycle
attenuation whose activation is the positive product of bounded target bearing
and speed-qualified course error. This makes the mechanism silent when the two
directional observations disagree and releases it continuously as either
alignment returns. It should preserve the useful far route while advancing the
late correct-sign turn without adding static body curvature or removing both
tail half-cycles.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and biological burst redirect
source_mechanism: observed direction error gates asymmetric flapping, with response-triggered release back to the propulsive rhythm
transferable_invariant: apply bounded phase-selective steering only when independent body-frame direction and course-response cues agree, then release it as alignment returns
nontransferable_details: published gains, duty ratios, oscillator frequencies, species kinematics, exact vortex phases, and task-specific routes
policy_translation: multiply bounded body-frame bearing and speed-gated target-versus-velocity course commands, use only their positive agreement to attenuate the posterior wave half-cycle opposing the agreed turn, and leave the anterior state-feedback carrier intact
falsification: reject if closest approach remains worse than the inherited 3.259L half-cycle result, if the far route or coherent 3D wake degrades, or if lateral slip, post-minimum recession, upper-boundary exit, saturation, or loads do not improve

## Evaluation boundary

No CFD result is claimed for this candidate. The next evaluation should compare
minimum distance and route topology first, then final recession, course error,
lateral slip, acceleration-limit residence, force/moment peaks, and both wake
views. Improvement in final distance alone cannot rescue a materially worse
closest approach.
