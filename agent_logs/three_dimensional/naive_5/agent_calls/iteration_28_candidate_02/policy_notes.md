# Candidate wake-policy notes

## Evidence diagnosis before edit

All four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=(0,0,0)`, no prewarm) and terminate in capture, so this sample has
no failed termination class. The strongest scalar example is the assigned
prefill `solver_8e7135ef9173` (`0.748338L`, `26.2460T`, score `-0.616147`). The
most informative divergent comparator is the turn-priority carrier-relief
sample `solver_730e610b0618` (`0.748792L`, `26.3615T`, score `-0.616770`).

Both combined sheets show self-propulsion rather than advection: the top-down
row develops a regular alternating wake behind a fish that translates steadily
toward the target, and the oblique row retains paired three-dimensional
Lambda2 structures through the approach. The lateral oscillation is productive
and remains coherent; neither view shows wake breakup or numerical instability.
The fish makes the established late hook toward the target immediately before
capture. The two sheets are visually nearly identical, while the carrier-relief
trace arrives `0.1155T` later and finishes with a larger heading (`1.2535` vs
`1.1628 rad`). This does not support suppressing carrier energy to buy turn
authority.

Trajectory cross-checks agree with the visual diagnosis. Every sample has zero
angle, speed, and acceleration-limit contacts; all share peak joint magnitudes
near `(0.7655,0.7724) rad`, speed magnitudes near `(4.5128,4.5075) rad/T`,
command magnitudes near `(29.7259,29.6860) rad/T^2`, and peak planar force near
`0.01883`. The prefill's translationally consistent line-of-sight selector
improves score and distance by only milliscale amounts over the history-only
posterior sample (`solver_7f1d02b1e9e9`, `0.748829L`, `26.2955T`), with the
same visible route and load envelope. Thus selector-side phase rejection is
safe at the fixed pose but is not yet a semantic clearance improvement.

## Policy hypothesis

Preserve the evaluated traveling bend, redirect, posterior capture allocation,
and all viability guards. When the existing speed/distance/agreement gate lets
the translational target-vector observer influence steering side, apply that
same gate to the requested response magnitude: blend from the beat-contaminated
finite-window line-of-sight magnitude to the instantaneous body-frame
translation/target cross-product magnitude. This is an observer change, not a
gain retune. It should prevent tail-beat-scale target-line estimates from
repeatedly demanding saturated residual yaw while retaining the proven
history-based response during startup, far travel, and observer disagreement.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG direction tracking and wake-control time-scale separation
source_mechanism: separate slow persistent route geometry from fast oscillatory body and flow response before modulating a propulsive rhythm
transferable_invariant: persistent target-vector kinematics should set route demand while beat-scale rotation remains a measured response, so oscillation is not mistaken for route error
nontransferable_details: published oscillator gains, duty ratios, species kinematics, exact vortex phase, dimensional frequencies, and source-task routes
policy_translation: use normalized body-frame velocity cross target divided by target distance squared as the phase-resistant line-of-sight rate; under the already evaluated translation gate, use its magnitude as well as its side while leaving the two-joint carrier and command envelope unchanged
falsification: reject if capture is lost, the coherent top-down or oblique wake degrades, limit or load exposure rises, persistent under-response appears, or the trajectory remains milliscale-equivalent with no meaningful command-allocation change

No inherited `logs/optimize` artifact is present in this rendered workspace;
the assigned parent guidance and sampled solver/guidance artifacts supply the
available inherited evidence.
