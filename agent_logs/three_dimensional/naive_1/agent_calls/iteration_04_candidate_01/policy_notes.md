# Candidate diagnosis and hypothesis

All sampled rollouts report direct uniform still-water initialization with
`U_infinity=0`; none is a prewarm artifact.  In the top-down row, the naive
drive-only rollout forms an alternating posterior wake but curls upward and
leaves the domain at `8.55T`, after only a transient `12.328L -> 12.078L`
approach.  The assigned parent's large-error posterior redirect retains a
visible alternating wake in both the top-down vorticity and oblique Lambda2
views, yet follows the same upper-exit topology at `9.12T` with
`11.838/12.054L` minimum/final distance.  Its redirect therefore does not turn
the visible thrust into route control.

The strongest sampled finite rollout is the anterior, slip-unloaded
half-cycle rectifier.  Its top-down row shows substantially longer leftward
translation, and its oblique row shows a coherent three-dimensional posterior
vortex chain through termination.  Numerically it sustains monotone late
approach to `10.062L` through `11.20T`, versus the assigned parent's reversal,
while limiting heading to about `-41..37 deg` rather than the seed's roughly
`103 deg` sweep.  It still exits the upper boundary at `y=15.202L`; both joints
still touch the `260 deg/T` rate cap.  This is evidence to preserve its
body-frame bearing-minus-lateral-velocity request and anterior-only steering,
but not evidence that its steering authority is sufficient.

Policy hypothesis: preserve that finite rollout's zero-centered traveling-bend
carrier, posterior lag, and small-error phase-speed rectification.  When the
absolute body-frame bearing becomes large, hand steering continuously from the
rectifier to a bounded mean-curvature center for joint 1.  Express the tail
target relative to that moving center so the new mean bend remains anterior
and posterior motion remains a propulsive lag rather than repeating the failed
posterior redirect.  The same normalized lateral velocity unloads both modes
when translation is already target-side.  This should keep the coherent wake
while generating enough persistent opposite curvature to change the upper-exit
topology.  The later CFD evaluation should reject the hypothesis if the wake
loses alternation, joint angle/rate saturation materially worsens, minimum
distance loses the `10.062L` reference, or the fish again reaches the upper
boundary without a sustained target-side lateral correction.

```text
bookshelf_consulted: true
source_domain: closed-loop CPG and robotic-fish asymmetric turning
source_mechanism: target-feedback modulation of rhythmic propulsion by bounded average bend
transferable_invariant: persistent body-frame route error should set bounded mean curvature while the oscillatory traveling wave remains intact and measured target-side response unloads the turn
nontransferable_details: published gains, robot linkage geometry, species kinematics, clock-driven phase, exact vortex phase, and task-specific routes
policy_translation: bearing minus normalized body-frame lateral velocity drives a bounded anterior oscillator center; the posterior joint tracks only the zero-centered lagged carrier, and small-error phase-speed rectification hands off smoothly as bearing grows
falsification: reject if alternating propulsion collapses, saturation or loads worsen, the 10.062L sampled minimum is lost, or the same upper-boundary exit persists without sustained target-side velocity
```
