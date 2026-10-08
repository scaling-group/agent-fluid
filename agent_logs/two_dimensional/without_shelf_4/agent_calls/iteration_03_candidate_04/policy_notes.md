# Multi-wake candidate diagnosis

## Evidence boundary and visual diagnosis

- This diagnosis uses the task contract, the assigned parent guidance, the
  sampled solver policies and evaluations, and their inherited optimizer
  notes. It uses no omitted research shelf, neighboring configuration,
  repository history, prescribed inflow signal, fixed route, or coordinates.
- The shared prewarm sheet is a common initial condition: the held fish starts
  above and downstream of the target while all four cylinder streets develop
  across the target corridor. The released sheets therefore expose policy
  differences rather than different starting wakes.
- The best finite sample is `solver_f5cca4991f3d` (`score=-10.4194`, horizon).
  Its sheet shows repeated but bounded reorientation, eventual entry into the
  developed wake corridor, and a final upstream-facing approach. Metrics agree:
  head displacement is `(-5.846,-4.282)L`, final distance equals the minimum at
  `5.812L`, and progress is `0.532`. The vertical displacement nearly matches
  the initial target-row offset, so the remaining miss is principally upstream
  range, not continued one-sided lateral ejection. Its `19 deg`, `0.67` energy-
  shell gait stays below the hard envelope (`19.0/24.3 deg` joint maxima,
  `178/134 deg/time` rates, and `1669/1260 deg/time^2` accelerations), with
  finite RMS force/moment `17.93/352.44`. This is self-propelled target approach,
  although the broad heading reversals are still wasteful.
- The naive seed is the informative overdrive failure. Its released sheet curls
  into a steep descent and exits the lower boundary at `50.13`; diagnostics
  show `(-3.545,-13.300)L` head displacement, rebound from `8.615L` minimum to
  `12.123L` final distance, exact rate and acceleration cap contact, and larger
  RMS relative crossflow/moment (`0.1747/541.70`). It proves that more nominal
  drive without a feasible gait and bounded target feedback produces lateral
  loss, not useful range.
- The reduced target-aware samples bound the other side. The `18 deg`, `0.65`
  negative-posterior-bias policy (`solver_09e7db9bb0ee`) remains finite for
  `143.45` but is advected `+2.186L` downstream and exits with negative progress;
  the `11 deg`, `0.75` positive-posterior-bias policy exits after `24.37` with
  `+2.408L` downstream displacement. Their cap-feasible commands do not supply
  the useful upstream mechanism. The assigned-parent and inherited logs also
  report `14--18 deg`, `0.80` candidates leaving downstream after about `16`
  units. Thus gait feasibility alone is insufficient, while the best sample
  demonstrates a narrow useful regime above those weak gaits and below the
  saturated seed.

## Policy hypothesis

Preserve the best finite architecture: a steering-independent, clock-free
phase-space energy oscillator and a negative body-frame bearing bias confined
to the posterior traveling-wave target. Move only modestly along its demonstrated
propulsion direction, from `19 deg` at period `0.67` to `21 deg` at `0.69`.
The new nominal anterior boundary scales are about `191 deg/time` and
`1741 deg/time^2`, still below the `260/1800` envelope while increasing the
phase-space velocity scale by roughly seven percent. Retain the proven `10 deg`
steering bound and `0.25`-unit clipped bearing-rate lookahead, but widen the
bearing scale from `0.30` to `0.38 rad`: far-off-axis turns remain bounded and
strong, while small bearing errors produce less curvature so the fish should
spend more of the late rollout translating upstream instead of reversing
heading.

The next CFD result should retain horizon survival, negative x displacement,
bounded vertical error, and no hard cap contact while improving on `5.812L`
final distance. The propulsion extrapolation is falsified if x displacement
becomes positive or caps are reached; the near-axis steering softening is
falsified if lateral target offset or final vertical error grows instead of
the broad turns shrinking. No success, thrust gain, or wake robustness is
claimed before the later evaluator produces CFD evidence.
