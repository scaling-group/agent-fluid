# Multi-wake target-policy candidate diagnosis

## Evidence read before the policy edit

- All four sampled rollouts satisfy the released contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm snapshot, finite `capture` termination, and no reported numerical
  instability. The assigned-parent response-plus-anterior-stroke policy is
  represented by `solver_43e27134a723` and captures at `24.310009T`, with
  score-metric mean distance `2.223959L`. Its complete top-down sheet shows a
  continuous curved approach behind an alternating red/blue caudal street,
  while its complete oblique row shows discrete three-dimensional Lambda2
  structures through capture. This is self-propulsion with an active carrier,
  not imposed advection or a terminal inertial coast.
- The prefilled speed-recovery descendant `solver_56888ac0e1b7` is the
  strongest sampled result. Bounded anterior oscillator-energy recruitment
  below the measured cruise envelope improves distance at `2T` from
  `12.265744L` to `12.218025L`, capture from `24.310009T` to `23.985519T`, and
  mean distance from `2.223959L` to `2.202000L`. Its complete two-view sheet
  retains the same useful S-route and coherent three-dimensional wake class.
  Peak normalized planar force/yaw moment fall from about
  `0.031649/0.016385` to `0.029769/0.015087`; mean action and rate-cap
  occupancy rise modestly, so this is evidence for response-gated carrier
  recruitment rather than unbounded drive.
- The separately sampled fluid-relative sideslip descendant
  `solver_2ed7853fc449` also improves the same assigned parent without changing
  any gain or actuator allocation: capture advances to `24.018509T`, mean
  distance falls to `2.206025L`, mean action falls from about `56.669` to
  `56.549`, and peak force/moment remain bounded near `0.030487/0.015991`.
  Its top-down sheet retains the approach and alternating wake. Its oblique
  row is a blank 34 KB render artifact, so the numerical/top-down improvement
  is not counted as independent three-dimensional-wake confirmation. The
  measured local lateral flow is small but nonzero (about `0.0043U` RMS), and
  replacing inertial sway with body-minus-local-water sway prevents that fluid
  motion from being interpreted as route error.
- The translation-alignment replacement `solver_a9222453ae0c` is the
  informative negative control: it is identical to the assigned parent
  through the far and middle route, then captures later at `24.343010T` with
  mean distance `2.224020L`. Its blank oblique row also limits it to numerical
  and top-down evidence. Together with inherited failures from smoother
  bearing response, wider/narrower phase windows, rudder boost, and carrier
  unloading, it argues against another terminal gate, scalar rudder edit, or
  suppression of the established rhythm.
- Speed recruitment and fluid-relative route slip are distinct but compatible
  measured-response mechanisms: the former is active mainly during low
  forward speed and returns to the inherited oscillator at cruise, whereas the
  latter changes only the bounded anterior curvature request as local water
  motion develops. Their combined CFD response is unknown, so neither sampled
  improvement is claimed for the new candidate in advance.

## One candidate hypothesis

Preserve the prefilled speed-deficit oscillator recruitment, traveling
two-joint carrier, full body-frame target geometry, measured posterior-rudder
sign, and response-plus-anterior-stroke terminal relief. Change only the route
feedback from inertial body-lateral velocity to the sampled water-relative
sideslip, `-state.relative_flow_velocity_body_U[2]`, retaining the evidenced
gain. This small combination should keep the faster carrier startup while
preventing local fluid motion from masquerading as body slip in the slow route
request. It remains bounded and reflection equivariant and uses no clock,
world coordinate, route memory, or source-specific kinematics.

Falsify the combination if capture is lost or later than the speed-recovery
parent's `23.985519T`, score-metric mean distance exceeds `2.202000L`, progress
at `2T` regresses above `12.218025L`, or the preterminal S-route changes
adversely. Also reject it if the alternating top-down and three-dimensional
wake, roughly `0.0298/0.0151` peak normalized force/moment, finite rate-cap
occupancy, or action effort materially worsens. A positive result at the same
pose would remain fixed-condition evidence rather than multi-wake robustness.

bookshelf_consulted: true
source_domain: wake-interaction sensing and sensor-modulated robotic-fish CPG control
source_mechanism: separate persistent target steering from locally measured fluid-relative crossflow while preserving response-gated rhythmic propulsion
transferable_invariant: route feedback should use body motion relative to the surrounding water, while joint-state carrier energy is recruited only from a bounded normalized locomotor deficit
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional speed targets, prescribed timing, cylinder geometry, exact vortex phase, and task-specific routes
policy_translation: retain the evidenced forward-speed-gated anterior oscillator and replace only inertial lateral speed in the bounded route request with sign-equivalent body-minus-local-water sideslip
falsification: reject if capture is later than 23.985519T or lost, mean distance exceeds 2.202000L, early progress regresses, or route, wake, saturation, effort, force, or moment envelopes worsen
