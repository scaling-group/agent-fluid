# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The assigned parent's burden-conditioned steering allocator was evaluated
  from direct uniform still water with `U_infinity=(0,0,0)` and no cylinders.
  It captured at `0.7474L` in `18.3040T` with 235 moving-window shifts. This is
  a new semantic success relative to the immediately preceding broader
  load-conditioned allocator, which kept swimming but passed below at
  `1.1961L` and exited with final distance `10.8967L`.
- I inspected both rows of the combined keyframe sheets for the best-scoring
  sampled speed-reserve capture (`solver_6b0e320e2f55`), the assigned-parent
  capture, and the inherited `1.1961L` failure. In all three, the top-down view
  shows an organized alternating street and the oblique view shows bilateral
  Lambda2 structures with an active posterior bend. The failure continues to
  propel after closest pass and diverges below the target; there is no visible
  carrier collapse or numerical instability. The discriminating mechanism is
  terminal steering allocation, not propulsion generation.
- Trace cross-check agrees. The assigned parent reached peak speed
  `0.9214L/T`, peak planar force `0.03126`, and peak yaw moment `0.01627`, all
  within the sampled repeat-backed speed-reserve envelope. Its head/tail action
  clipping (`68.69%/70.61%`) and speed-limit residence (`10.61%/11.60%`) did
  not improve that envelope. The evidence therefore supports the refined
  allocator as a capture-compatible mechanism, but not as an actuator-limit
  cure and not yet as robust: it has only one completed evaluation.
- All four sampled solvers captured, but two are the exact speed-reserve
  baseline and the prefilled posterior wave-shape policy belongs to a recorded
  `2/3` lineage. Earlier isolated captures from projected miss, yaw damping,
  phase shaping, mean curvature, course observers, and unconditional spatial
  transfer later failed or added no useful envelope benefit. An exact replay
  of the new parent's bytes is more informative than stacking another
  terminal residual or scalar-tuning its burden thresholds.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and sensor-modulated robotic-fish turning
source_mechanism: preserve posterior traveling-wave thrust while applying bounded steering asymmetry through the actuator with observed usable authority
transferable_invariant: separate the posterior propulsive role from the anterior steering role conditionally, preserving the traveling bend and total steering request
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact phases, body splines, and task-specific routes
policy_translation: exactly repeat the parent's normalized joint-speed/previous-action gate, which transfers only an unsafe-terminal steering residual when posterior outward burden exceeds anterior burden, posterior steering is outward, and the anterior has margin
falsification: reject robustness after an exact-policy miss, lower-branch exit, weakened wake, changed far-field closure, or speed, force, moment, clipping, or speed-limit residence outside the sampled speed-reserve envelope
```

## Single candidate hypothesis

Install the assigned parent's exact
`dogfish3d_burden_conditioned_steering_transfer_v1` policy as the sole
candidate, without tuning or adding a second mechanism. It retains the
repeat-backed achieved-course/intercept scaffold, state-feedback traveling
bend, cadence, sparse outward-carrier reserve, steering magnitude, and total
steering share. Its only distinction is a normalized, direction-sensitive
transfer of terminal steering from the burdened posterior joint to an anterior
joint with margin.

Expected test: repeat capture near the parent's `18.3040T` while preserving
both coherent wake views and the sampled speed/load/actuator envelope. A
second exact success would distinguish the refined sparse gate from the prior
broad allocator and from the many one- or two-capture terminal mechanisms;
an exact miss would instead classify the result as another fragile threshold
crossing and direct later workers back to the unmodified speed-reserve
baseline rather than to threshold tuning.
