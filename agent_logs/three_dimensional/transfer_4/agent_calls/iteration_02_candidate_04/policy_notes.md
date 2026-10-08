# Wake-policy candidate notes

## Evidence read before editing

All four sampled evaluations satisfy the Phase-2 initialization contract:
direct uniform still water with `U_infinity=(0,0,0)`, no prewarm, and no
cylinders. I inspected both the top-down vorticity and oblique body/Lambda2
rows in every combined keyframe sheet, then cross-checked them against
`wake_metrics.csv`, `wake_diagnostics.json`, and the trajectory histories.
The assigned-parent guidance and its inherited optimizer note were also read.

- The prefilled signed-curvature policy is the only semantic success. It
  captures at `23.353T` and `0.74968L`, with mean distance `2.41468L`. Both
  visual rows show self-propulsion and a coherent alternating three-dimensional
  wake through the final target-directed bend. Its raw acceleration request is
  outside the `1800 deg/T^2` envelope in about `70.0%/51.8%` of joint samples,
  but joint-rate saturation is only about `8.7%/1.5%`, the run remains stable,
  and the wake does not collapse. This supports preserving the carrier and the
  empirically corrected odd posterior-curvature polarity.
- The inherited parent's steering-reserve hypothesis did not survive its
  completed evaluation. Smoothly bounding both commands removed raw
  acceleration exceedance, yet that candidate turned toward the upper boundary
  and exited at `17.578T`, no closer than `6.276L`. Thus desaturation alone is
  not an adequate substitute for correct actuator polarity, and redesigning
  the successful carrier now would discard the strongest available evidence.
- The separate velocity-course redirect reached `4.022L` but then continued
  above the target and exited at `29.673T` with final distance `8.666L`. The
  large geometry redirect looped below the target, reaching `5.775L` before
  exiting with final distance `13.056L`; it also had the largest sampled peak
  moment coefficient (`0.108`). Their keyframes retain coherent wakes, so
  these are course-control failures rather than propulsion failures. Both
  added separately signed mean-posture branches on top of the inherited
  inverse-polarity map, making their course signal and actuation sign difficult
  to reconcile.

The successful trajectory still contains a correctable S-shaped course. At
`4T` its body points close to the line of sight, but its velocity is too steeply
across that line; from roughly `8--18T`, the velocity is on the opposite side
and too shallow. A normalized target/velocity cross product exposes this
course error without using world coordinates. An offline replay on the
completed capture trace (diagnostic only, not new CFD evidence) shows that a
speed-qualified correction `-0.9 * gate * course_cross` is essentially absent
while propulsion develops (`0--2T` mean gate `0.006`), then contributes mean
turn-request corrections of `+0.34`, `+0.42`, `+0.32`, and `+0.25` over the
`4--8T`, `8--12T`, `12--16T`, and `16--20T` intervals. Its magnitude is bounded
below `0.9`, compared with the existing request limit of `6.0`, and it reverses
continuously as the terminal course crosses the target line.

## Candidate hypothesis

Preserve the captured policy's state-feedback traveling wave, odd signed tail
curvature, approach schedule, and actuator paths. Add one small mechanism:
compute the rotation-invariant sine of the angle between the body-frame target
vector and translational velocity, suppress it below the measured
self-propulsive speed range, and add its opposite sign to the existing
geometric turn request. Sending the residual through the already validated
odd target-to-curvature map avoids a second polarity convention. The expected
testable effect is a straighter middle approach and an earlier capture while
retaining the coherent wake.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and mean-curvature turning
source_mechanism: sensed course error modulates the bounded mean bend of an otherwise retained propulsive oscillator
transferable_invariant: preserve the traveling propulsive wave while a normalized persistent target-course error supplies a small continuously releasable curvature correction
nontransferable_details: published gains, hardware dimensions, clock phase, species-specific bends, dimensional frequencies, exact vortex phases, and prescribed routes
policy_translation: form a body-frame normalized target/velocity cross product, apply an observation-calibrated speed gate, and add the bounded opposite-sign residual to the existing target request before its odd posterior-curvature map
falsification: reject if capture is lost, arrival or mean distance worsens materially, the path exits either virtual boundary, course error does not contract through the 4--20T middle approach, or wake coherence, joint bounds, and load stability degrade
