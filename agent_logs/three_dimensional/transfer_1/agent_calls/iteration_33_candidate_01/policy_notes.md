# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four assigned solver samples satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no prewarm and no cylinders) and terminate
  by capture at `0.7480--0.7495L`. They comprise two exact speed-reserve
  policies, one posterior wave-shape policy, and one fixed anterior-transfer
  policy, so they are not four confirmations of one mechanism. The current
  prefill is the posterior policy; inherited exact-repeat evidence is only
  `2/3`, with an active-wake lower miss at `1.2589L`, so that pulse is removed
  rather than scalar-tuned.
- I inspected both rows of the combined keyframe sheet for the strongest
  assigned baseline capture (`solver_6b0e320e2f55`). The fish self-propels from
  quiescent water, lays down a persistent alternating red/blue top-down street,
  and retains bilateral posterior Lambda2 structures and body undulation
  through the `0.7494L` capture at `18.6010T`. Its peak speed is `0.9215L/T`,
  peak planar force coefficient is `0.03120`, peak yaw-moment coefficient is
  `0.01627`, head/tail acceleration clamps occupy `68.48%/70.64%` of rows,
  and exact speed-limit residence is `10.41%/11.30%`.
- The assigned parent's completed missed-pass reacquisition is the informative
  semantic failure. Its top-down and oblique rows retain the same organized
  alternating wake after closest pass; there is no carrier collapse, passive
  advection, or numerical instability before the lower exit. Metrics agree:
  it reaches only `1.6538L` at `18.7825T`, then self-propels until
  `left_domain` at `31.7350T` and `10.2816L`; peak speed, force, and moment
  remain `0.9218L/T`, `0.03086`, and `0.01590`. Thus an aft-target/opening-
  range recovery that engages only after a missed pass is too late for this
  topology and should not be strengthened or gain-tuned.
- A sampled sibling provides one genuinely new completed result. Its narrow
  outer unsupported-bearing qualifier captures at `0.74975L` and `18.3205T`.
  I inspected both visual rows: the alternating top-down street and bilateral
  3D structures remain coherent through arrival. Trace checks keep peak speed,
  force, and moment at `0.9293L/T`, `0.03048`, and `0.01630`; clamp fractions
  are `68.60%/70.61%` and speed-limit residence `10.57%/11.56%`, inside the
  sampled speed-reserve envelope. This is one mechanism demonstration, not a
  robustness claim.

## One candidate hypothesis

Use the evaluated sibling policy unchanged as an exact-repeat candidate.
Restore the intercept-guarded speed-reserve carrier and fixed steering
allocation, remove the falsified posterior pulse, and qualify raw
achieved-course error only with target bearing that is not already supported
by an informative same-signed course error. The qualifier is reflection
equivariant, zero outside the existing `4L` terminal region, and fades to zero
through the inner intercept gate; it cannot directly change carrier cadence,
posterior lag, steering allocation, or capture-corridor release geometry.

Expected test: preserve far-field closure, both organized wake views, and the
baseline actuator/load envelope while repeating capture. A second exact-policy
capture would make the discriminator repeat-supported, not robust. Falsify it
on any exact-repeat miss, lower exit, wake weakening, or actuator/load
excursion; if falsified, restore the speed-reserve baseline and avoid widening
the bearing gate or reviving post-pass reacquisition.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking over a rhythmic CPG carrier
source_mechanism: target-vector-to-bounded-curvature feedback layered on rather than substituted for the propulsive oscillator
transferable_invariant: preserve the traveling propulsive bend while a persistent target-side cue remains available only when achieved-course feedback is momentarily uninformative
nontransferable_details: published gains, clock-driven CPG phase, robot morphology, dimensional cadence, species kinematics, exact vortex phase, and task-specific routes
policy_translation: add a bounded reflection-equivariant unsupported-bearing residual from normalized body-frame target and velocity geometry only in the outer terminal annulus, while preserving the two-joint state-feedback carrier and inner intercept guard
falsification: reject if an exact repeat misses, retains the lower branch, weakens either coherent wake view, changes far-field closure, or moves speed, clipping, force, or moment outside the sampled speed-reserve envelope
