# Candidate wake-policy notes

## Evidence diagnosis before edit

All four sampled rollouts report direct uniform still-water initialization,
`U_infinity=[0,0,0]`, no cylinders, and capture. The strongest finite example
is the repeated split-observer baseline (`solver_3cb46b9057a1`, reproduced by
`solver_8ae803ceeb4c` and `solver_f5ac4c378d79`): it captures at `23.8370T`
with score `-0.535013`, mean distance `2.433468L`, and final distance
`0.746096L`. The weaker v33 comparator (`solver_2546ece173ab`) captures at
`23.8425T` with score `-0.535091`, mean distance `2.433543L`, and final
distance `0.746165L`. No sampled rollout is a semantic failure, so v33 is the
most informative finite regression rather than evidence for a new failure
topology.

Both rows of the combined sheets were inspected. In the top-down row, the fish
moves from rest toward the target under its own actuation and leaves a coherent,
alternating lateral wake through the redirect and final approach. In the
oblique Lambda2 row, the body sheds a persistent alternating three-dimensional
vortex chain without visible wake collapse, passive background advection,
collision, or domain exit. The v33 and split-observer sheets are nearly
indistinguishable at the rendered cadence, consistent with the narrow metric
change; all three split-observer sheets are byte-identical.

Telemetry resolves the remaining defect. Relative to v33, the split observer
slightly improves inside-`3L` mean absolute yaw (`1.67999` to `1.67938 rad/T`),
mean absolute target-cross-track speed (`0.23924` to `0.23868U`), and peak
moment (`0.013730` to `0.013581`), but peak yaw rises from `3.18484` to
`3.19386 rad/T`. Peak joint speed and smoothly projected command remain
essentially unchanged (`4.53786 rad/T` and about `31.385 rad/T^2`). Thus the
carrier and observer scope should be preserved; the narrow mixed terminal
result supports testing when the existing anterior residual acts, not adding
authority or changing the posterior traveling wave.

The assigned-parent guidance and sampled policies show that differently named
implementations of the same split algebra reproduce exactly, while broadening
the distributed rate cue into the continuous course brake regressed arrival and
distance. The inherited step-26 logs add two score-only captures that regress
to `-0.535561`/`0.746654L` and `-0.535880`/`0.746981L`; without their policy and
multimodal diagnostics they are negative population-selection evidence, not a
basis for attributing a mechanism.

## Policy hypothesis

Retain the split observer, v24 course brake, C-bend carrier, posterior target,
and all correction magnitudes. Replace only the position-only tail-side gate
for the phase-selected anterior residual with a bounded displacement-rate phase
coordinate:

`(phi1 + phi2) + 0.25 * (phi_dot1 + phi_dot2) / omega`.

Dividing rate by the current state-feedback oscillator frequency puts both
terms in joint-displacement units. Offline replay of the repeated baseline
shows that this small lead changes the position-only half-cycle sign on about
`6.0%` of inside-`3L` samples; it therefore anticipates the beat transition
without a clock and without changing posterior propulsion. The candidate is
supported only if CFD retains capture, coherent wake, baseline-scale arrival
and distance, and actuator feasibility while reducing peak yaw or moment
without worsening their mean values. Reject it if it delays capture, worsens
mean/final distance, changes the wake topology, raises peak yaw/moment, or
increases joint/command limit exposure.

bookshelf_consulted: true
source_domain: robotic-fish feedback-modulated CPG turning and asymmetric flapping
source_mechanism: infer beat side from joint displacement and rate, then gate a bounded half-cycle steering residual
transferable_invariant: state-derived phase can time asymmetric steering without a clock while leaving the propulsive traveling wave intact
nontransferable_details: published gains, clock-driven oscillator phases, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: use normalized full-tail tangent plus full-tail tangent rate divided by current oscillator frequency only to time the existing anterior terminal residual
falsification: reject if capture/progress, coherent wake, yaw or moment histories, or actuator feasibility regress against the repeated split-observer baseline
