# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
prewarm, finite moving-window transport, and `capture`. I inspected the
combined keyframe sheets for the best-scored unprojected redirect, the
projected redirect, and its terminal lateral-velocity-lead composition,
including both the top-down vorticity and oblique body/Lambda2 rows. I also
compared them with the inherited terminal line-of-sight course-residual
failure and cross-checked the views against `wake_metrics.csv`,
`wake_diagnostics.json`, controller sources, assigned-parent guidance, and
inherited optimization notes.

The successful family is visibly self-propelled, not advected: its top-down
rows build a strong alternating street from the caudal region while the body
advances along a broad target-directed curve, and the oblique rows retain
compact three-dimensional caudal structures through first crossing. The four
samples capture at `0.7464--0.7493L` in `19.129--19.228T`, with mean scored
distance `2.1185--2.1277L`. The policy-owned acceleration projection preserves
this route and wake while limiting both returned commands to
`31.416 rad/T^2`; it is therefore the best-supported carrier contract even
though it does not relieve joint-rate contact.

Neither sampled terminal velocity correction supports further instantaneous
course feedback. The raw body-lateral-velocity lead is directionally
inconsistent across matched comparisons: without projection it reaches about
`0.099T` earlier than the base sample but has worse mean distance, while with
projection it reaches about `0.006T` later and again has worse mean distance
than the projected base. These differences lie inside the inherited repeat
band. More decisively, the line-of-sight transverse-velocity residual retains
a coherent energetic wake and initially follows the capture path, but misses
the radius at `0.9490L`, departs along a nearly straight wake, and exits at
`32.065T` with final distance `8.7907L`. Wake coherence is therefore not
evidence that an instantaneous velocity residual preserves target control.

The current redirect releases mean curvature whenever measured yaw has the
correct sign. Correct-sign yaw is only an indirect response measure: body
translation or slip can leave the target bearing from improving. The existing
observation already provides a recent-window body-frame bearing rate, so the
release can be qualified by actual geometric progress without adding memory,
time, a route, or a new propulsive gain.

An eight-row-window reconstruction from the logged head pose and heading
supports that separation. In the projected capture, correct-sign yaw and
improving target bearing disagree on only `6` of `1,624` yaw-correcting rows;
in the inherited course-residual failure they disagree on `1,092` of `2,826`.
The qualifier should therefore be almost transparent on the evidenced capture
path while refusing many misleading yaw releases after the failed approach.

## Single-candidate policy hypothesis

Preserve the projected oscillator, posterior lag, normalized lateral target
request, differential mean curvature, target-owned route sign, and final
acceleration projection. Replace yaw-only response release with a
progress-qualified release: compute bounded correcting magnitudes from recent
yaw rate and recent target-bearing rate, and release curvature only by their
minimum. Thus a beat-scale or slip-induced correct-sign yaw cannot reduce the
route request unless the body-frame line-of-sight angle is also moving toward
zero. The mechanism can only withhold the existing bounded release; it cannot
invert target-owned steering or directly disturb the traveling carrier.

Expect the early redirect to remain engaged through ineffective yaw and then
return to the sampled release once yaw produces actual bearing progress. This
should retain coherent propulsion and capture while reducing broad-path
distance integral if the baseline releases prematurely. Falsify the mechanism
if capture is lost, arrival or mean distance leaves the successful repeat
band, the route develops the inherited late exit, bearing oscillation or joint
rate contact worsens, or the top-down/oblique wake loses the sampled coherent
traveling structure. The new CFD outcome is unavailable to this worker and is
not claimed as evidence.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking around low-dimensional CPG locomotion
source_mechanism: release a bounded mean-turn command only when measured directional error confirms that the observed yaw response is useful
transferable_invariant: persistent normalized body-frame target geometry owns turn sign, while closed-loop directional-error trend may qualify how much curvature is released from a state-feedback traveling rhythm
nontransferable_details: published gains, dimensional beat rates, motor models, clocked CPG phase, species-specific kinematics, exact vortex phases, world-frame paths, and task-specific routes
policy_translation: preserve the captured differential-curvature carrier and acceleration projection; gate its existing one-sided yaw release by the bounded recent body-frame bearing-rate correction using the minimum of the two response measures
falsification: reject if capture or coherent wake is lost, the late-exit topology returns, arrival or mean distance leaves repeat variability, bearing or rate oscillation worsens, steering sign reverses, or returned acceleration exceeds the owned envelope
