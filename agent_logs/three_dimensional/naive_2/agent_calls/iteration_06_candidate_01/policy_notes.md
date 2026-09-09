# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- All four sampled evaluations report direct uniform still water
  (`U_infinity=(0,0,0)`), no cylinders, and no prewarm. In every combined
  sheet, the top-down row shows a body-connected alternating vortex street and
  the oblique row shows three-dimensional Lambda2 structures shed from the
  moving tail. The trajectories are self-propelled rather than advected, and
  none is numerically unstable.
- The inherited phase-compensated half-cycle controller
  `solver_77835bec7423` preserves a compact wake and reaches `3.174L` at
  `18.095T`, but passes the target corridor at about `0.982L/T` and exits the
  left boundary at `27.429T`. The distance-only carrier-relief branch
  `solver_8f636e61280c` is a concrete negative result: it raises near-rate
  occupancy to `16.3%/13.9%`, worsens closest approach to `3.600L`, and keeps
  an almost straight left-exit topology. Proximity without a directional
  response condition is therefore not sufficient.
- The unconditional approach/target-plane hold in `solver_1fbf1e40b119`
  reaches `2.703L`, but exits at `24.518T` with the largest sampled lateral
  force and yaw-moment magnitudes (`0.426` and `0.300` in logged normalized
  units). Its top-down and oblique rows retain an alternating wake, yet the
  late arc still climbs out of the target corridor. Broad or persistent hold
  is not adopted.
- The prefilled full-vector, angle-gated approach redirect
  `solver_4b6f0dc046cd` is the strongest geometric sample. Its top-down row
  visibly bends into a late return arc, the oblique row retains the
  body-connected tail wake, and closest approach improves to `2.319L` at
  `18.032T`. This survives to `27.227T`, but still exits with center/head near
  the upper boundary and joint rates near their hard limit for
  `11.9%/12.3%` of samples. It establishes that full body-frame target geometry
  plus angle-conditioned drive relief is useful, but not yet a capture policy.
- The prefilled trace exposes a specific gate defect during the closing pass.
  At `14.98T` and `15.98T`, distance is `3.97L` and `3.27L`, body-lateral speed
  is `0.90U` and `0.86U`, and normalized target-line course crossflow is about
  `-0.86` and `-0.72`. Beat-scale body yaw nevertheless brings the full-circle
  pursuit angle to `0.00` and `0.07` rad, so angle-only misalignment restores
  the symmetric carrier to about `0.99` and `0.91`. The fish is geometrically
  aligned for an instant while its inertial course is still carrying it across
  the narrow capture corridor.
- Inherited guidance rules out persistent mean-curvature offsets, tail-only
  steering, and a general joint-rate brake: those mechanisms weakened useful
  translation or produced a wrong-way loop. The current candidate therefore
  preserves shared-joint half-cycle actuation, phase-compensated yaw response,
  and the far-field carrier, and changes only the response condition for the
  already evidenced approach reallocation.

## Single candidate hypothesis

Preserve the prefilled full-circle pursuit controller. Add a normalized
target-line course-misalignment gate computed from the body-frame cross product
of `target_body_L` and `velocity_body_U`, divided by target distance and speed.
Its magnitude is invariant to body rotation and lateral reflection, so it does
not inherit the beat-scale sign changes of body yaw. Smoothly combine it with
the existing angular-misalignment gate only inside the approach region. This
keeps symmetric carrier relief active through the evidenced `14--17T` lateral
crossing, while releasing automatically when either distance is large or the
actual velocity course aligns; half-cycle steering remains unscaled.

The mechanism is falsified if early targetward translation or the coherent
alternating wake degrades, closest approach does not improve below `2.319L`,
the same upper/left exit occurs without a visibly tighter or returning arc, or
rate-limit occupancy and normalized force/moment peaks materially exceed the
prefilled branch. Capture or a better termination class is stronger evidence
than a scalar-score change. This worker performs dry validation only; later CFD
must decide these physical tests.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal target approach control
source_mechanism: retain a rhythmic propulsive scaffold while measured course misalignment keeps a bounded approach reallocation active until motion, not merely instantaneous posture, aligns with the target
transferable_invariant: normalized body-frame target and velocity vectors provide a rotation-invariant, reflection-compatible course-cross product that can gate reversible drive-to-steering reallocation near a target
nontransferable_details: published gains, dimensional speeds, robot linkage geometry, species kinematics, maneuver timing, exact vortex phases, and task-specific routes
policy_translation: smoothly union absolute normalized target-line course crossflow with pursuit-angle misalignment inside the existing distance gate; attenuate only the symmetric carrier and preserve phase-compensated shared half-cycle steering
falsification: reject if pre-approach propulsion or wake coherence degrades, minimum distance fails to beat 2.319L, termination topology does not improve, or actuator occupancy and load peaks grow materially

## Dry validation only

The mandated guidance, lightweight Julia policy-contract, parameter-schema,
and editable-boundary checks pass; no CFD was run. A `43,740`-state grid over
joint angles/rates, targets ahead and behind, target sides, low and finite
body-frame speeds, and yaw response produced finite actions strictly inside
the smooth `30 rad/T^2` envelope (`29.999999999999833` maximum) and exact
left/right reflection (`0.0` maximum error). These checks establish only schema,
boundedness, and symmetry; they do not establish the physical hypothesis.
