# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The common prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets, with the target inside the merged
  second-row wake. It is identical initial-condition evidence rather than a
  controller difference.
- All four current samples reach the target with the same useful visible
  topology: a sharp clockwise redirect followed by a coherent, actively
  propelled leftward traverse through the merged wakes. Their posterior wakes
  and roughly `(-10.9,-4.1 to -4.3)L` head displacement show propulsion rather
  than passive advection; none visibly collides or exits the domain.
- The raw-bearing reserve scheduler is the best sampled arrival/effort case:
  it reaches in `46.035` with `2.0695L` mean distance and total/mean command
  energy `56948/1237.1`. Its cost is RMS force/moment `51.40/761.46`, above the
  prefilled course-slip controller's `37.92/605.38`.
- Course-slip correction alone reaches in `48.032` and provides the lowest
  sampled force/moment, although its mean command energy rises to `1299.7`.
  The sampled coupled child applies course-slip-corrected error to both the
  steering residual and reserve scheduler. It still reaches in `46.761`, but
  is worse than raw-bearing scheduling in arrival, mean distance, mean effort,
  relative crossflow, and RMS force/moment (`59.04/923.45`). Thus the evidence
  rejects sharing the slip-corrected error across both feedback roles; it does
  not reject course-slip correction confined to the residual.
- No failed keyframe sheet is present in the current sample. The inherited
  failure boundary is the wholesale slower/smaller curvature-equilibrium
  replacement, which stayed at least `9.238L` away and became unstable after
  `121.517` with RMS relative crossflow/force/moment
  `1.138/16749.8/290421`. The validated `0.55`-period carrier, posterior lag,
  same-sign bearing translation, and `30.0` allocator envelope remain intact.

## Candidate policy hypothesis

Use a decoupled two-path steering allocator. Raw body-frame bearing schedules
the finite steering reservation so target geometry retains the empirically
validated redirect authority near saturation. A separately regularized
body-frame course-slip correction affects only the bounded steering residual,
where targetward lateral motion can reduce redundant correction without also
withdrawing reserved authority. Preserve every carrier, joint split, envelope,
and previously evaluated scalar setting.

Expected test: retain target reach and the early leftward redirect while
recovering the raw-bearing scheduler's arrival advantage and moving force or
moment toward the course-slip result. Falsify the separation if capture is
lost, arrival exceeds the `48.032` course-slip result, mean effort exceeds
`1299.7` without a load benefit, either RMS load exceeds `51.40/761.46`, or the
lower-exit/unstable topology returns. The candidate receives CFD evaluation
only after this worker exits; no improvement is claimed in advance.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and wake-interaction control
source_mechanism: persistent route geometry allocates bounded turning authority while measured lateral response modulates a separate residual around the rhythmic carrier
transferable_invariant: do not let fast lateral response erase finite authority requested by persistent body-frame target error; preserve the traveling bend and separate the two feedback roles
nontransferable_details: published gains, robot hardware, species kinematics, dimensional beat rates, clocked phase, exact vortex phase, and source-task routes
policy_translation: schedule the proven two-joint saturation reserve from raw normalized body-frame bearing, but apply regularized normalized body-frame course slip only to the steering residual
falsification: reject if capture or coherent upstream propulsion is lost, if arrival regresses beyond course-slip alone, or if effort and force/moment fail to improve on their relevant sampled boundaries
