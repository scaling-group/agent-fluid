# Posterior rate anti-windup candidate

## Evidence diagnosis

All four sampled rollouts use direct uniform still-water initialization and
capture in `19.360--19.552T`. The combined sheets show self-propelled motion in
both views: a coherent alternating mid-plane street and paired three-dimensional
Lambda2 structures remain attached to the traveling bend through the long
approach. They also show the same useful trajectory family rather than four
distinct solutions: broad target-directed travel followed by a late terminal
hook. The response-gated posterior-curvature parent is the fastest sample
(`19.360T`, score `-0.19989`) and has the lowest sampled mean absolute yaw below
`2L` (`0.285 rad/T`), but the posterior-authority variant is close in time
(`19.431T`) and has slightly lower terminal yaw (`0.263 rad/T`) while a worse
distance history and score. There is no sampled semantic failure that supports
another terminal gate or curvature gain.

The actuator trace is more repeatable than those small trajectory differences.
Every sample reaches the exact `260 deg/T` rate ceiling on both joints. Posterior
rate exceeds 80% of that ceiling for `21.8--22.1%` of samples, and posterior
acceleration still points outward while above that threshold for `9.7--10.3%`.
Meanwhile, the wakes stay coherent and peak planar force/yaw moment stay near
`0.025/0.013`, so suppressing the whole posterior rhythm would discard supported
propulsion to address a localized saturation path.

## Policy hypothesis

Preserve the prefilled response-gated curvature controller exactly through its
raw posterior acceleration. Apply a smooth, normalized rate guard only when
that acceleration has the same sign as posterior joint velocity. The guard is
neutral below 80% of the owned rate envelope, increases continuously to full
unloading at the envelope, and never attenuates acceleration that brakes or
reverses the joint. This is a new actuator-state feedback mechanism, not a
scalar retune. It should reduce posterior near-limit command/rate residence
without changing the far-from-limit traveling wave, route steering, terminal
redirect, or useful return stroke.

bookshelf_consulted: true
source_domain: slender-body reactive propulsion and sensor-modulated robotic-fish rhythmic control
source_mechanism: preserve posterior traveling-wave authority because tail kinematics dominate reactive thrust, while using measured state to modulate the command
transferable_invariant: constrain only the actuator motion that drives farther into a measured limit and preserve the posterior braking/reversal that sustains a traveling bend
nontransferable_details: published gains, species-specific envelopes, dimensional beat frequencies, exact tail phases, and task-specific routes
policy_translation: normalize posterior joint rate by an owned two-joint rate envelope and smoothly unload only same-sign raw posterior acceleration above an owned onset fraction
falsification: reject if capture is lost or timing/distance integral, joint margin, loads, command residence, or either-view wake coherence regresses; restore the clean scaffold if rate residence does not fall materially
