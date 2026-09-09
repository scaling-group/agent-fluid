# Phase 2 multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled solver rollouts satisfy the frozen contract: direct-uniform
  quiescent initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite moving-window transport, and capture termination. Three execute the
  prefilled common-envelope redistribution policy byte-for-byte. They capture
  at `18.6505--18.8815T` with score-defined mean distance
  `2.08855--2.09222L`; this is exact-policy repeat spread, not a gain signal.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the fastest redistribution capture, the best distance-integral repeat,
  and the distinct rearward-route policy. From release through first crossing,
  each fish translates under its own actuation through initially quiescent
  water, develops a coherent alternating target-bending street, and retains
  compact bilateral/caudal 3D structures. No sheet shows passive advection,
  collision, wake collapse, domain exit, or instability. The current sampled
  batch contains no failure-class rollout; inherited failure evidence supplies
  that contrast rather than mislabelling the slower capture as a failure.
- The rearward-route sample captures at `18.9640T`, mean distance `2.09072L`,
  and its normalized target-forward fraction remains `0.67165--1.0` on every
  trajectory row. Its recovery branch is therefore inactive. Its acceleration
  contact (`61.17%/73.00%`), rate contact (`10.90%/14.73%`), peak planar force
  (`0.01518/0.02817`), and peak moment (`0.01640`) overlap the three clean
  redistribution samples. It establishes non-interference, not recovery.
- The assigned parent records two executable-equivalent redistribution misses:
  closest approaches `0.81206L` and `1.25093L`, followed by downward/left
  exits despite energetic wakes and finite loads. It identifies removal of the
  extra beat-phase envelope allocation as the clean semantic discriminator.
- Two completed assigned-parent optimizer logs now evaluate that clean
  geometry-scheduled ablation. Both preserve the two visual wake classes and
  capture: one at `18.6395T`, mean distance `2.09383L`; the other at
  `18.7220T`, mean distance `2.09898L`. Their acceleration contact is
  `60.78--60.81%`/`73.09--73.12%`, rate contact is
  `11.05--11.09%`/`14.84--15.05%`, and peak planar force/moment remain inside
  the parent bands. Combined with the parent's three earlier clean captures,
  this gives five capture-class results, but no actuator relief. The second
  result also falsifies the parent's overly narrow `2.09340--2.09542L`
  repeatability band; the supported clean-carrier band is now
  `2.09340--2.09898L`.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological mean-curvature turning and closed-loop robotic-fish asymmetric-flapping control
source_mechanism: apply a bounded target-signed bend on an observed beat half while preserving a coordinated posterior-lagged traveling wave
transferable_invariant: retain the body-frame target-owned curvature sign, positive displacement-phase steering factor, and posterior-lagged carrier; remove a second phase allocation when completed route semantics contradict it
nontransferable_details: published gains, dimensional cadence, species-specific envelopes and kinematics, robot duty ratios, clock phase, exact vortex phase, and task-specific routes
policy_translation: keep normalized body-lateral steering, one-sided non-inverting response release, displacement-only half-cycle curvature, geometry-owned common amplitude relief, posterior lag, and final acceleration projection; omit phase-dependent relief redistribution
falsification: reject if capture or either coherent wake row is lost, if the downward near-miss/left-exit topology recurs, or if mean distance leaves the revised `2.09340--2.09898L` clean-carrier band without a distinct semantic or load benefit

The consultation was triggered because three consecutive completed inherited
workers used the same clean ablation without a new mechanism or semantic class.
No additional shelf primitive is adopted: terminal scheduling, velocity/flow
residuals, posterior-specific allocation, rate barriers, and stacked recovery
already have contradictory completed evidence, while the sampled still-water
rollouts show no unresolved advection or wake-disturbance event that would
justify reopening them. The shelf informs which traveling-wave and steering
invariants are preserved; rollout evidence remains the reason for the edit.

## Exactly one candidate hypothesis

Materialize the geometry-scheduled half-cycle carrier by removing only the
phase-dependent redistribution of common amplitude relief. Preserve the
target-signed mean-curvature shares, positive displacement-phase steering,
one-sided response release, common geometry-owned relief, posterior lag, and
exact public acceleration projection. This is one structural ablation from the
prefill, not scalar-only gain tuning and not a claim that the current worker's
unevaluated CFD has improved performance.

Expected result: remain in the five-result clean capture class with both wake
views coherent. The candidate is preferred as a semantic-robustness test even
though redistribution has the better best-case distance integral. Formal CFD
runs only after handoff; accept a future result only against capture, route
topology, the revised mean-distance band, both wake views, demand, and loads.
