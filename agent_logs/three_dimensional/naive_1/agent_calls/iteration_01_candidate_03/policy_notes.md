# Candidate wake-policy notes

## Inherited evidence diagnosis

The only sampled rollout is the common naive state-feedback carrier
`solver_36a38f7240b3`; no inherited optimizer notes are present. It is an
informative failure, not evidence of a successful controller. The episode uses
the required direct uniform still-water initialization (`U_infinity=0`) and
terminates `left_domain` at `8.547T`, with distance changing from `12.3277L`
to a best `12.0782L` and then `12.3800L`.

Both visual views show self-propulsion rather than background advection. The
top-down row develops an alternating wake and useful initial leftward motion,
but the body then yaws into a tight upward arc; the oblique row confirms a
coherent three-dimensional caudal wake rather than a missing-propulsion or
prewarm artifact. The trace cross-checks the visible failure: heading departs
from `0.506rad` to as far as about `-1.20rad`, planar speed becomes strongly
upward, and the fish exits at center `(20.0749,15.2004)L`. Joint accelerations
remain oscillatory while target asymmetry is identically zero. Thus the
carrier should be preserved for this first candidate, while its absent target
steering is the capability to add.

## Policy hypothesis

Use the normalized body-frame bearing as a slow route error and its short
window rate as braking, then map their bounded combination to a common
mean-curvature target for both joints. Run the inherited joint-state
oscillator around that moving mean and retain its posterior phase-lag target.
The testbed's measured convention is that positive common bend produces
negative yaw; the initial target bearing is positive, so this mapping should
correct the initial small clockwise error and later oppose the large
wrong-route turn without a fixed world direction. Limit the mean bend well
below the joint envelope so the propulsive traveling bend remains visible.

Falsification: reject this mechanism if the rollout keeps the same early
top-boundary exit, turns consistently away from the sign of body-frame
bearing, collapses the alternating wake into sustained static curvature, or
substitutes persistent acceleration saturation for target progress. A longer
finite trajectory with falling distance and bounded alternating joints is the
minimum semantic improvement; capture is the stronger test.

bookshelf_consulted: true
source_domain: classical fish and robotic-fish turning by biasing an oscillatory gait
source_mechanism: target-driven bounded mean-curvature bias with response-rate braking
transferable_invariant: steer by adding limited signed curvature to an otherwise propulsive traveling bend and release it as the desired yaw response develops
nontransferable_details: published gains, species-specific kinematics, prescribed phases, dimensional frequencies, and task-specific routes
policy_translation: normalized body-frame bearing plus bounded bearing-window-rate braking sets a shared joint mean; joint angle and velocity retain the state-feedback carrier and posterior lag
falsification: wrong-sign turn, repeated top exit, destroyed alternating wake, sustained static bend, or saturation without materially better distance progress
