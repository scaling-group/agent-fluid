# Candidate-specific wake diagnosis and policy hypothesis

## Evidence read before the edit

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot.  Their combined
keyframe sheets show that motion is self-generated.  In both top-down and
oblique views, each policy forms an alternating three-dimensional caudal wake,
then hooks upward rather than holding a target-directed course.

The anterior useful-half-cycle controller is the strongest finite example
(`solver_8596fba5898a`, score `-14.165`).  It preserves the visible wake and
improves minimum/final distance to `11.782/11.797L`, compared with
`12.078/12.380L` for the target-blind seed, but still exits the upper boundary
at `8.98T`.  The posterior-only half-cycle scale in the prefill reaches only
`12.006L` and exits at `8.61T`; the shared anterior/posterior residual is worse
at `12.140L`.  Thus the prior rollouts support retaining phase-selective
anterior steering, not relocating it to the posterior joint or adding a common
residual.

The best trace also exposes the remaining failure.  Body-frame bearing changes
from about `+9 deg` to `-5 deg` by `4T`, then grows to about `-79 deg` by `8T`,
while instantaneous heading rate alternates between roughly `-2.2` and
`+2.1 rad/T`.  Using that beat-scale yaw signal directly in the route request
therefore reverses or unloads steering within successive strokes even as the
slow target error grows.  Moreover, all four sampled policies reach the
`260 deg/T` joint-rate cap.  The useful-half-cycle residual leaves the opposite
stroke unopposed, so it does not reserve enough directional authority to
replace the common upper-exit topology.

## One candidate hypothesis

Keep the best example's zero-centered anterior oscillator and inherited
posterior lag.  Replace its one-sided gate with slip-damped half-cycle
rectification on joint 1: body-frame bearing minus body-frame lateral velocity
sets a bounded turn request, and the magnitude of normalized anterior joint
velocity gates a signed residual.  On the requested stroke the residual adds
energy; on the opposite stroke it brakes motion.  Because it vanishes at each
stroke reversal and never shifts the oscillator's equilibrium, it should
preserve the alternating traveling bend while creating more persistent mean
turn authority than the useful-half-only gate.  The slow lateral slip term
unloads motion already carrying the fish toward the target side without using
the sampled controller's beat-scale yaw chatter.

Falsify this candidate if the wake or posterior lag collapses, rate saturation
becomes more persistent, closest approach fails to beat `11.782L`, or the fish
again exits the upper boundary with large negative bearing.  A lower distance
without a different termination or useful trajectory remains only partial
support.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering and biological asymmetric flapping
source_mechanism: sensor-driven half-cycle amplitude and duty asymmetry around a continuing propulsive rhythm
transferable_invariant: persistent body-frame target error should strengthen the requested stroke and weaken the opposing stroke while target-side motion releases the asymmetry
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, exact vortex phases, prescribed duty ratios, and task-specific routes
policy_translation: map body-frame bearing and normalized lateral body velocity to a bounded request, then rectify observed anterior joint velocity into a signed acceleration residual while retaining the zero-centered carrier and posterior lag
falsification: reject if alternating propulsion collapses, actuator saturation worsens, minimum distance does not beat 11.782L, or large wrong-side bearing and the upper-boundary exit persist
