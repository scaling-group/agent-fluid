# Candidate visual diagnosis and hypothesis

The sampled evidence is direct-uniform still water in every case
(`U_infinity=[0,0,0]`, no prewarm). Three sampled entries are byte-identical
copies of v33, so they count as one physical rollout. The assigned v30 parent
and sampled v33 both self-propel from the upper-right pose, establish a compact
alternating caudal wake by `4T`, retain coherent top-down vortices and oblique
Lambda2 structures through the approach, turn toward the target, and capture.
There is no domain-exit or unstable failure among the sampled sheets; v30 is
therefore the most informative weaker comparison rather than a semantic
failure.

The visual difference between v30 and v33 is too small to support a wake-shape
claim, but the trajectories resolve the intervention. Moving the excess-yaw
residual from a load-gated posterior counter-tangent to a side-selected
anterior curvature changed capture from `23.8315T` to `23.8425T`, improved
scoring mean/final distance from `2.433642/0.746599L` to
`2.433543/0.746165L`, reduced inside-`3L` peak yaw from `3.2645` to
`3.1848 rad/T`, and reduced peak absolute moment from `0.014385` to
`0.013730`, while peak joint angle/velocity and command remained essentially
unchanged (`0.6156 rad`, `4.5379 rad/T`, about `31.39 rad/T^2`). This supports
the anterior joint as the safer residual coordinate, but the nearly unchanged
inside-`3L` mean yaw (`1.6816` to `1.6800 rad/T`) rejects claiming that static
tail-side selection is a complete regulation mechanism.

Inherited optimizer evidence adds the necessary negative boundary: a fixed
`25%` transfer of continuous course curvature anteriorly reduced inside-`3L`
mean/peak yaw to `1.644/3.121 rad/T`, but regressed score and mean/final
distance to `-0.535920` and `2.434212/0.747022L`. The candidate will therefore
preserve v33's continuous course bend, posterior traveling-wave amplitude, and
posterior lag. It will make one mechanism change: infer the yaw-supporting beat
phase from a bounded combination of observed tail tangent and tail-tangent
velocity, and apply the existing anterior excess-yaw residual on that
phase-advanced half-cycle. The velocity component should start the correction
as the tail sweeps toward the supporting side and release it as the sweep
reverses, without a clock or a fixed route.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and asymmetric flapping
source_mechanism: sensor-modulated half-cycle duty and phase asymmetry superposed on a propulsive rhythm
transferable_invariant: preserve the traveling carrier and localize a bounded steering residual with joint-state phase inferred from both bend and bend velocity
nontransferable_details: published gains, dimensional frequencies, robot morphology, exact duty ratios, and prescribed oscillator phase
policy_translation: combine normalized posterior tangent and tangent velocity into a bounded phase coordinate; use carrier-rejected excess yaw only for sign and magnitude; apply the residual to the anterior oscillator center while leaving posterior amplitude and lag unchanged
falsification: reject if capture is lost, score or mean/final distance regresses beyond v33, the alternating wake weakens, inside-3L yaw or moment exceeds v33, or joint velocity and acceleration-limit exposure increase
