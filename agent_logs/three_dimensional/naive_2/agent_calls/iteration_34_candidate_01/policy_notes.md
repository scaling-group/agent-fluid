# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

The four assigned solver examples are one deterministic nominal experiment:
their candidate-policy and combined-keyframe hashes are identical, as are the
assigned parent's inherited candidate and rollout. All report direct uniform
still-water initialization with `U_infinity=0`, no cylinders, capture at
`16.604496T`, a `0.743958L` final crossing, `1.998146L` scored distance
integral, and score `-0.113729`. Thus there is a strong finite control but no
distinct sampled failure trajectory. The missing failure comparison is an
evidence limitation; it is not a reason to manufacture a failure mechanism
from scalar score.

The combined sheet's top-down row shows self-propelled translation toward the
target and an alternating, tail-connected mid-plane wake from release through
capture, without background advection or a visible collapse into reciprocal
standing motion. The oblique row confirms finite three-dimensional
tail-connected Lambda2 structures through the approach. Diagnostics agree:
the final head is `(9.691019, 9.775620)L`, the planar force/moment peaks remain
about `0.037165/0.018356`, joint angles remain below the `45 deg` hard stops,
and the narrow one-sided guard handles outward requests at the `260 deg/T`
speed envelope without removing the carrier.

The assigned parent's notes and durable history delimit apparently plausible
changes. Completed terminal yaw release, half-cycle relief, projected capture
corridors, target-rate geometry, moment residuals, and carrier-correlated
local-flow subtraction kept finite or capturing wakes but worsened route cost
or crossing depth. Moreover, capture is a first-crossing termination, so this
successful trace contains no post-crossing response from which an approach
hold can be identified. Its shallow-but-valid crossing is not evidence for a
new terminal damping channel.

## Candidate hypothesis

Retain exactly one candidate: the prefilled response-demodulated full-wave
carrier, posterior phase-selective route response, raw anterior target
geometry, and narrow one-sided speed guard, byte-for-byte. This is an
evidence-preserving architecture decision, not scalar-only gain tuning. The
falsifiable nominal expectation is reproduction of the target-crossing arc,
connected two-view wake, joint feasibility, and bounded load envelope. A new
controller mechanism should be admitted only after a completed nonduplicate
near miss, held-out pose/flow response, or dwell-style observation exposes a
repeatable route or terminal-response deficit.

bookshelf_consulted: true
source_domain: classical undulatory propulsion, robotic-fish turning, and wake-adaptive swimming
source_mechanism: posterior-lag traveling propulsion with bounded target-driven asymmetry or disturbance rejection only for an observed response deficit
transferable_invariant: preserve useful traveling-wave propulsion and separate slow body-frame route demand from rhythmic body response before adding a bounded correction
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: adopt no new primitive; retain the normalized body-frame two-joint response-demodulated carrier and one-sided speed guard because identical first-crossing captures expose no distinct deficit for a hold, burst, or wake-residual channel
falsification: reject preservation if nominal capture fails to reproduce, or if a nonduplicate near miss or held-out rollout identifies a bounded state-feedback mechanism that improves termination or route cost without degrading crossing depth, wake connectivity, joint feasibility, effort, force, or moment
