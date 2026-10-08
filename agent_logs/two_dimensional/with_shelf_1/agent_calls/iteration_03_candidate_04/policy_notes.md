# Multi-wake candidate diagnosis and hypothesis

## Evidence diagnosis

The shared prewarm sheet shows the common held fish above and downstream of
four interacting cylinder streets; it is initial-condition evidence, not a
candidate difference. In the released sheets, the prefilled direct-residual
policy (`solver_19dd0f242733`) makes a long downward arc, undergoes a visibly
large correction below the direct approach, and reaches `0.7496L` after
`62.304` released time units. Its command-energy mean is `1436.3`; both joint
speed and episode acceleration limits are touched. The otherwise identical
steering-reserve mixer (`solver_72a47313c277`) aligns leftward earlier, retains
a coherent posterior traveling wake, and approaches the target from the right
without the same deep excursion. That sampled sibling reaches `0.7493L` after
`49.142`, lowers mean distance from `2.4600L` to `2.1560L`, and lowers
command-energy mean to `1272.3`. Its policy bounds both accelerations at
`30.0`, below the `31.416` episode cap, although joint speed still reaches its
limit and RMS force/moment rise from `27.25/525.8` to `39.05/617.1`.

The slow, small, curvature-centered failure (`solver_0c51696bec78`) supplies
the stability boundary: it produces little targetward displacement, is swept
through growing crossflow, and ends in a compact vortex/load blow-up after
`121.517`, with RMS force/moment `16749.8/290421`. It does not support broad
carrier slowdown. The two successful policies have similar RMS relative
crossflow (`0.222` and `0.230`), and the compact evidence has no sign-resolved
disturbance history, so it does not justify adding flow or force cancellation.

## Candidate hypothesis

Adopt the sampled steering-reserve mixer while leaving the validated
`0.55`-period carrier, same-sign bearing residual, and joint steering ratio
unchanged. Reserving a small bounded share of the target-directed residual
before fitting the remaining carrier-plus-residual into a `30.0` acceleration
envelope creates directional half-cycle authority that symmetric downstream
clipping otherwise erases. The prior sibling result predicts a faster, lower
distance-integral and lower-command-effort target reach than the prefill; this
workspace's rollout is not evaluated until after exit. Reject the mechanism on
a later wake phase if it loses target reach, leftward propulsion, or produces
load growth without the arrival/distance benefit.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and residual CPG/path-following control
source_mechanism: bounded half-cycle amplitude asymmetry around a propulsive rhythm
transferable_invariant: preserve the traveling-wave carrier while a persistent observed turn request keeps directional authority in the useful half-cycle
nontransferable_details: published gains, clocked CPG phase, robot geometry and hardware, species kinematics, exact vortex phase, and task route
policy_translation: map normalized body-frame bearing through a bounded same-sign residual, share it across both joints, reserve a small fraction, and fit the carrier plus remainder inside each acceleration envelope
falsification: reject if target reach or leftward propulsion is lost, or if increased force and moment are not repaid by improved arrival, distance integral, or effort on later wake phases
