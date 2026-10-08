# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite direct-uniform still-water captures,
  with no cylinders, prewarm, imposed advection, or reported instability. The
  complete sheet for the strongest sampled policy, `solver_56888ac0e1b7`,
  shows self-propelled S-shaped approach in the top-down row and discrete
  alternating three-dimensional Lambda2 structures from wake formation
  through capture in the oblique row. Its speed-deficit carrier recruitment
  improves the assigned terminal-allocation baseline from `24.310009T` and
  `2.223959L` mean distance to `23.985519T` and `2.202000L` while reducing
  peak normalized force/moment from about `0.031649/0.016385` to
  `0.029769/0.015087`. Progress by `2T` also improves from distance
  `12.267558L` to `12.218429L`. Mean action and anterior/posterior rate-cap
  occupancy rise modestly, from about `56.67` and `11.29/5.93%` to `57.59`
  and `11.81/6.40%`, so the mechanism is useful but should not be strengthened
  by scalar tuning.
- `solver_43e27134a723` supplies the complete two-view baseline comparison. It
  has the same coherent carrier and route class but captures `0.325T` later.
  The translation-alignment negative control `solver_a9222453ae0c` retains the
  top-down route yet delays capture to `24.343010T` and slightly worsens mean
  distance to `2.224020L`; its oblique sheet is blank and is treated as a
  render failure, not as independent three-dimensional wake evidence. This
  reinforces the inherited warning against replacing the evidenced
  closing-speed/stroke terminal response with another alignment gate.
- The assigned-parent mechanism changes only the route-loop observation from
  inertial lateral speed to local-water-relative sideslip. In its sampled
  evaluation, `solver_2ed7853fc449`, capture improves independently to
  `24.018509T`, mean distance to `2.206025L`, peak normalized force/moment to
  `0.030487/0.015991`, and mean action to `56.55`; rate-cap occupancy remains
  near the baseline. Its top-down sheet retains the same productive S-route.
  The blank oblique row prevents a new 3D-wake claim, but the complete
  baseline and speed-recovery sheets bound the preserved wake class.

## One candidate hypothesis

Keep the prefilled speed-deficit carrier recruitment and every established
terminal-allocation element unchanged. Apply the assigned-parent observation
translation only in the slow anterior curvature request: replace inertial
body-lateral speed with sign-equivalent body-minus-local-water sideslip,
`-state.relative_flow_velocity_body_U[2]`. The two independently positive
loops act on separate roles: normalized forward-speed deficit recruits the
joint-state oscillator after locomotor slowdown, while persistent target
geometry is corrected using water-relative lateral slip. The combination is
bounded and reflection equivariant, uses no clock, coordinates, route memory,
or vortex phase, and does not inject local flow directly into posterior phase
or acceleration.

Falsify the combination if it loses capture, arrives later than the strongest
sampled `23.985519T`, exceeds `2.202000L` mean distance, loses the improved
`12.218429L` distance-at-`2T` startup boundary, or worsens the sampled
`57.59` mean-action, `11.81/6.40%` rate-cap, `0.029769` peak-force, `0.015087`
peak-moment, route, or coherent two-view wake envelopes. A fixed-pose result
cannot establish robustness to actual multi-wake flow; later held-out wake or
pose evidence must test that boundary.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction steering
source_mechanism: recruit a traveling rhythmic carrier from measured locomotor slowdown while separating persistent target steering from water-relative crossflow
transferable_invariant: preserve the joint-state traveling wave, use normalized forward-speed deficit only for bounded carrier recovery, and use local-water-relative sideslip only in the slow target-geometry route loop
nontransferable_details: published gains, dimensional speed thresholds, robot sensor calibration, species-specific kinematics, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: retain the evidenced speed-deficit oscillator-energy gate and terminal schedule, but replace inertial lateral velocity in the bounded curvature request with sign-equivalent body-minus-local-water lateral sideslip
falsification: reject if capture is lost or later than 23.985519T, mean distance exceeds 2.202000L, startup progress regresses, or action, saturation, force, moment, route, or coherent wake envelopes worsen
