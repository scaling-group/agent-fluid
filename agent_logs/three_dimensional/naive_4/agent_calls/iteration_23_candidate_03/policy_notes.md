# Candidate diagnosis and hypothesis

## Inherited evidence

The sampled direct-uniform still-water rollouts all capture at `16.0544T` with
239 moving-window shifts. The three step-22 candidates have different source
hashes only because of comments: their executable policies, trajectories, and
combined keyframe sheets are identical at `0.745943L`, distance integral
`1.929921L`, and score `-0.047001`. The informative brake-only comparison also
captures at the same step but crosses at `0.746051L`, distance integral
`1.930012L`, and score `-0.047113`.

Both combined sheets satisfy the experiment contract (`U_infinity=0`, direct
uniform initialization, no prewarm). From release through capture, the
top-down row shows self-propelled translation with a growing, coherent
alternating vorticity street and a smooth target-directed arc. The oblique row
shows paired three-dimensional Lambda2 structures convecting behind the body;
there is no visible wake collapse, passive advection, collision, exit, or
instability. The brake-only and combined policies remain visually
indistinguishable at sheet resolution, agreeing with the identical arrival,
shift count, hard-limit residence, joint extrema, and load peaks summarized in
the inherited guidance. Their measurable difference is confined to the final
fraction of the crossing.

Trace reconstruction in the assigned parent localizes the remaining response:
over the last `0.0715T`, predicted miss and closing speed improve while bearing
reopens from `0.021` to `0.178 rad` and target-signed yaw rises from `0.53` to
`2.02 rad/T`. The current whole-beat `2 deg` mean-curvature brake and alignment
handoff combine positively, but three repeated combined rollouts establish
that another scalar threshold or another stacked mean brake would remain in
the same terminal topology rather than test a new control mechanism.

## Policy hypothesis

Preserve the evidenced carrier, route-improving yaw-opposition redirect,
alignment handoff, anterior corridor release, and exact-boundary projection.
Phase-allocate only the terminal yaw brake. Reuse the full measured terminal
predicate (proximity, closing, safe intercept, target-signed yaw, and reopening
bearing) and infer the reinforcing half-cycle from the sign of the observed
posterior wave relative to the target-directed turn. While the wave opposes the
turn, retain the sampled `2 deg` mean brake unchanged. As the reinforcing lobe
appears, continuously hand that response from whole-wave mean curvature to
attenuation of that lobe; never amplify or scale the opposite wave lobe. At the
sampled crossing, the bounded `0.65` maximum reuses the already evidenced
one-sided cruise-relief envelope rather than a published gain. Acting on an
approximately `0.10 rad` reinforcing posterior wave after the smooth response
and phase gates, it gives a same-order replacement for—not an addition to—the
inherited mean brake and remains below full lobe suppression. The allocation
is identically inactive before the established terminal gate.

Expected effect: preserve capture time, milestones, wake coherence, and the
known cruise trajectory while reducing the final target-signed yaw response
with less disruption to the alternating carrier. Reject the mechanism if it
changes pre-terminal motion, delays or loses capture, increases limiting or
loads materially, or fails to improve final distance/distance integral beyond
the repeated combined baseline.

Static sampled-state audit (not a CFD result): compared with the assigned
parent on its recorded trajectory, the candidate leaves every anterior command
and every posterior command through `16.0324T` exactly unchanged. It changes
only the four posterior commands from `16.0379T` through capture, all with a
positive target-reinforcing reconstructed wave, and the largest action change
is `2.043 rad/T^2` versus the `31.416 rad/T^2` hard envelope. The Julia contract
probe is finite and the mirrored terminal-state probe is reflection-equivariant.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning by asymmetric flapping
source_mechanism: sensor-conditioned half-cycle amplitude or duty asymmetry changes turning while retaining an oscillatory carrier
transferable_invariant: allocate a steering correction to the tail-beat phase that contributes the unwanted turn instead of shifting the whole rhythmic equilibrium
nontransferable_details: published robot gains, clock-driven CPG phase, hardware kinematics, species envelopes, exact wake phase, and task-specific routes
policy_translation: use normalized anterior joint state to construct the posterior wave; under the existing body-frame closing-intercept and measured-yaw/reopening predicate, retain the sampled mean brake on the opposing lobe and hand it continuously to attenuation only when the wave reinforces the target-directed turn
falsification: reject if the established route or coherent two-view wake changes before the terminal gate, capture is delayed or lost, the opposite wave lobe is attenuated or amplified, or crossing and actuator/load metrics do not beat the repeated parent baseline
