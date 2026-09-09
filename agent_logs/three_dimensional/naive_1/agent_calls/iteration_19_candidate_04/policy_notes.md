# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled solver rollouts satisfy the frozen direct-uniform still-water
contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm), remain finite, and
capture. I inspected both the top-down vorticity and oblique body/Lambda2 rows
for the strongest sampled finite result, the assigned parent, and the most
informative inherited failure, then cross-checked the visual claims against
scores, metrics, diagnostics, trajectories, executable policy diffs, inherited
notes, and the assigned parent guidance.

The sampled capture class is physically consistent. From release through first
crossing, its top-down sheets develop a coherent body-attached alternating
street along a broad target-directed turn; the oblique sheets retain compact
alternating caudal Lambda2 structures. The geometry-scheduled pair is
executable-equivalent and captures at `18.6505--18.6835T` with mean distance
`2.09340--2.09405L`. The response-coupled parent stays inside that band at
`18.6615T` and `2.09362L`. Their projected acceleration contact is about
`60.85--60.98%` anterior and `73.03--73.19%` posterior, while rate contact is
about `11.02--11.12%` and `14.92--15.13%`; none establishes demand relief.

The half-cycle envelope-redistribution sample captures at `18.8265T` and has
the best sampled score (`-0.20041`) and mean distance (`2.08855L`) while
retaining both coherent wake views. That one-run lead is not reusable evidence:
an inherited candidate whose executable text is identical after stripping
comments and whitespace reaches `0.81206L` but misses, turns away, and exits at
`34.2320T` with final distance `10.67789L`. Its top-down street and oblique
caudal structures remain energetic, and its peak planar force/moment are not
worse, so the failure is route recovery rather than wake collapse or numerical
blow-up. At closest approach the target is still forward (`0.456` normalized
body-longitudinal fraction) and far to the side (`0.890` lateral fraction), so
the existing turn is already saturated. After the miss the target becomes
rearward while the lateral fraction falls from `0.361` at `24T` to `0.128` at
`28T`; the lateral-only turn request therefore weakens even as recovery needs a
continued turn, and by `32T` the target is almost directly astern.

This divergence also sharpens the evidence boundary: do not promote
half-cycle envelope redistribution from its scalar lead, and do not weaken the
proven capture carrier to prevent a miss that occurs only in one
executable-equivalent repeat. Preserve displacement-only half-cycle steering,
the one-sided correcting-yaw release, the posterior lag, and the final
acceleration projection.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and classical mean-curvature turning
source_mechanism: sensed target direction modulates bounded turn curvature while a coupled traveling rhythm remains intact
transferable_invariant: keep the propulsive oscillator organized and use the full normalized body-frame target direction to maintain turning authority during off-axis recovery
nontransferable_details: published gains, robot geometry, clock phase, species kinematics, exact vortex phase, dimensional cadence, and task-specific routes
policy_translation: preserve the assigned carrier and multiply only its existing target-signed route argument by a bounded factor when normalized body-longitudinal geometry says the target is behind; lateral target sign still owns turn direction
falsification: reject if sampled capture timing or either coherent wake view changes before a miss, the controller reverses or chatters near the directly-astern ambiguity, a near miss still decays into the same left-domain exit, or action/rate contact and planar loads materially worsen

## Single-candidate policy hypothesis

Add exactly one behind-target recovery mechanism to the assigned
response-coupled capture carrier. Compute normalized forward fraction from the
already available body-frame target vector. When the target is forward, the
new factor is exactly one, so all steering, gait relief, oscillator dynamics,
posterior lag, response release, and action projection are unchanged. When the
target is behind and remains laterally off-axis, multiply the existing
lateral route argument by at most two before the same `tanh` bound. This adds
no fixed route, stage, clock, velocity phase, terminal residual, posterior-only
allocation, or new turn sign.

The formal CFD evaluation occurs after this worker exits. Accept the mechanism
only if ordinary captures retain their established route/wake/demand band or a
near miss turns back toward the target instead of reproducing the inherited
left-domain topology. Treat directly-astern sign chatter, pre-capture route
change, lost capture, or unchanged post-miss decay as falsification.
