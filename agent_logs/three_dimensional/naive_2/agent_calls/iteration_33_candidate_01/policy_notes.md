# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

All four sampled solver directories contain the same policy, trajectory, and
combined-keyframe hashes. They are therefore one deterministic nominal control
experiment, not a strong-versus-failure comparison. Each reports direct
uniform still-water initialization, no cylinders, capture at `16.604496T`, a
`0.743958L` crossing, `1.998146L` scored distance integral, and score
`-0.113729`. The assigned parent's inherited score records also repeat this
same capture tuple, so the apparent population plateau contains no distinct
trajectory or new semantic failure.

The top-down frames show self-propelled target approach with an alternating,
tail-connected mid-plane wake from release through crossing; there is no
visible advective background or loss of the propulsive wave. The oblique
Lambda2 frames confirm finite three-dimensional tail-connected structures
rather than a purely planar rendering artifact. At capture the head is at
`(9.691019, 9.775620)L`, so the crossing is shallow but genuine. Trajectory and
diagnostic data agree with the images: peak planar force/moment are about
`0.037165/0.018356`, joint magnitudes stay below the `45 deg` stops, and both
joint speeds reach the released `260 deg/T` limit while the one-sided final-band
guard keeps requested acceleration finite. No sampled rollout supplies an
informative failure immediately before instability, boundary exit, or wake
breakup.

Inherited completed negative controls delimit the next edit. Terminal yaw and
half-cycle release, projected interception, line-of-sight or bearing-rate
terms, moment residuals, and carrier-correlated local-flow subtraction retained
finite or capturing wakes but worsened route cost or crossing depth without a
load or feasibility benefit. A required mechanism review is not itself
evidence that another residual should be added.

## Candidate hypothesis

Finalize exactly one evidence-preserving candidate: retain the prefilled
response-demodulated full-wave carrier, posterior phase-selective steering,
raw target geometry for the anterior center, and narrow one-sided joint-speed
guard byte-for-byte. This is a deliberate negative architecture result, not a
scalar gain trial. Its falsifiable nominal expectation is reproduction of the
connected two-view wake and capture envelope above. Architecture should reopen
only after a completed nonduplicate or held-out pose, target, or flow rollout
isolates a repeatable directional-response deficit; any later addition must
preserve capture, route cost, crossing depth, wake connectivity, joint
feasibility, effort, force, and moment.

bookshelf_consulted: true
source_domain: classical undulatory propulsion, robotic-fish turning, and wake-adaptive swimming
source_mechanism: preserve a posterior-lag traveling carrier and add a bounded asymmetry or disturbance residual only for an observed response deficit
transferable_invariant: separate the propulsive rhythm and slow body-frame route request from any fast correction, and preserve useful oscillatory motion unless evidence identifies it as harmful
nontransferable_details: published gains, species-specific kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized body-frame response-demodulated two-joint controller and narrow speed guard because the current evidence exposes no distinct error for another channel to correct
falsification: reject preservation if nominal capture ceases to reproduce, or if a nonduplicate held-out rollout identifies a bounded feedback mechanism that improves semantics or route cost without degrading wake connection, joint feasibility, effort, force, or moment
