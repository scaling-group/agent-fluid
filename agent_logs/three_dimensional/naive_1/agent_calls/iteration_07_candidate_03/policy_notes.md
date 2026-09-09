# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the edit

All four sampled evaluations satisfy the frozen evidence contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders
or prewarm, finite dynamics, and valid moving-window transport. I inspected
both rows of every combined keyframe sheet and compared the strongest sampled
capture with the inherited outward-rate-guard failure. The captures retain an
alternating top-down vorticity street and compact three-dimensional caudal
Lambda2 structures while curving into the target. The rate-guard failure has
an equally coherent self-propelled wake, but holds the high-side route, reaches
only `5.3386L`, and exits at `21.203T` and `5.8866L`. Wake coherence therefore
does not rescue a carrier edit that loses mean route authority, and the failed
outward-rate taper should not be retried.

The sampled baseline captures at `19.228T` and `19.321T`. A terminal
target-side lateral-velocity lead captures at `19.129T`; a policy-side hard
projection of the completed acceleration captures at `19.135T`. All four
scores (`-0.2390` to `-0.2299`) and arrival times lie in a narrow band, and the
behaviorally equivalent baseline and hard-projection policies finish on
opposite sides of the target. The single velocity-lead trace is therefore
evidence that the terminal feedback is compatible with capture, not proof that
it caused its terminal side or improved score.

The hard projection does establish a separate interface result. Unprojected
baseline and lead policies return commands above the `1800 deg/T^2` envelope
on about `61.6--72.3%` of rows, with peaks near `62/101 rad/T^2`; the projected
sample returns no over-envelope commands while retaining the captured wake and
route. This is expected because the episode already applies the identical
projection before joint integration. In contrast, rate-dependent attenuation
is not equivalent and has failed twice in inherited logs.

## Single-candidate policy hypothesis

Preserve the successful joint-state oscillator, posterior lag, normalized
body-frame lateral request, differential mean curvature, and one-sided yaw
release. Add the sampled terminal lateral-motion lead: it is zero outside
`2.5L`, ramps continuously to full authority inside `1.5L`, releases a small
share of curvature when body-frame lateral velocity is toward the target side,
and restores it when velocity is adverse. Target geometry continues to own
turn sign, so beat-scale slip cannot reverse the route request. Then hard-clamp
only the two completed acceleration outputs at the policy-owned physical
envelope; this changes the public command but not the episode-applied action.

This compact combination tests one behavior-changing terminal feedback while
making its output contract physically explicit. Falsify the lead if capture is
lost, arrival or mean distance moves materially outside the current repeat
band, lateral error grows, or a high/low boundary exit returns. Falsify the
projection if any returned command exceeds its owned bound or if it changes
the applied joint trajectory relative to the episode's existing clamp. Lost
wake coherence, increased loads, or increased joint-limit contact also reject
the package. The new candidate has not been evaluated here.

bookshelf_consulted: true
source_domain: robotic-fish sensor-feedback direction tracking and actuator-limited state-feedback CPG control
source_mechanism: target-relative lateral-motion modulation of rhythmic mean curvature with phase-preserving command projection
transferable_invariant: preserve the propulsive rhythm and target-owned turn sign while bounded measured motion modulates steering magnitude; enforce actuator bounds only after the completed phase and curvature command
nontransferable_details: published gains, robot or species kinematics, dimensional beat settings, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: gate normalized body-frame target-side lateral velocity by normalized distance, use it only to adjust differential-curvature magnitude, retain the two-joint state-feedback carrier, and project final accelerations onto the policy-owned episode envelope
falsification: lost capture, boundary exit, materially worse distance progress, larger terminal lateral error, changed applied phase or curvature, over-envelope output, collapsed wake coherence, or worse load and saturation histories
