# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from direct uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and no
  reported instability. The three strongest samples are semantically
  identical copies of the assigned-parent controller and reproduce capture at
  `23.864521T`, crossing at `0.749310L`, score-metric mean distance
  `2.192138L`, and score `-0.294271`. This improves the inherited
  inertial-lateral-speed comparison at `23.985519T`, `0.749542L`,
  `2.202000L`, and `-0.303937`, establishing that speed-deficit carrier
  recruitment and water-relative slow-route feedback are compatible rather
  than merely independent positives.
- The repeated parent's top-down row shows continuous target-directed
  translation along the established S-shaped route with an attached,
  alternating red/blue caudal street through capture. The matched slower
  comparison shows the same route and, in its complete oblique row, discrete
  three-dimensional Lambda2 structures from release through capture. All
  three repeated-parent oblique rows are black render failures, so they do not
  independently confirm the 3D wake; the complete comparison only bounds the
  inherited carrier's wake class.
- Relative to the inertial-speed comparison, the assigned parent lowers mean
  action norm from about `57.594` to `57.572` and peak normalized force from
  `0.029769` to `0.029479`; peak normalized moment changes from `0.015087` to
  `0.015344`, and anterior/posterior exact rate-cap occupancy remains close at
  about `11.75/6.41%`. Its distance at `2T`, `12.222539L`, is slightly worse
  than the comparison's `12.218025L`, so the improvement is a route-loop
  compatibility result rather than evidence for stronger startup drive.
- The parent's remaining inertial observation is the forward-speed signal in
  oscillator-energy recovery. In its trace, body-inertial forward speed
  averages `0.5553U`, while head-local axial flow averages `-0.0170U` and the
  corresponding through-water speed averages `0.5383U`. Replaying only the
  smooth recovery gate against those observed values changes its mean
  activation from `0.1157` to `0.1195`; it is already nearly saturated during
  `0--2T` (`0.9909` versus `0.9937`) and remains exactly zero inside `1.5L`.
  Thus a water-relative translation is a small, bounded startup/mid-route
  mechanism test and does not alter the evidenced terminal allocation.

## One candidate hypothesis

Preserve the complete assigned-parent controller, including its joint-state
traveling carrier, water-relative lateral route feedback, anterior redirect,
phase-selective posterior carrier, reactive-rudder sign, and terminal
response-plus-stroke relief. Replace only the oscillator-recovery observation
`-state.velocity_body_U[1]` with the sign-equivalent through-water axial speed
`state.relative_flow_velocity_body_U[1]`. In still water this asks the existing
bounded energy gate to remain active slightly longer when entrained local
fluid reduces relative advance; in a future advecting wake it prevents inertial
transport from masquerading as locomotor recovery. It adds no gain, clock,
world coordinate, route memory, or raw load command.

Falsify this translation if capture is lost or later than `23.864521T`, mean
distance exceeds `2.192138L`, distance at `2T` exceeds `12.222539L`, the
preterminal route changes adversely, or mean action, `11.75/6.41%` rate-cap
occupancy, `0.029479` peak force, or `0.015344` peak moment materially worsen.
Because the current best oblique renders are blank and the released case is
quiescent, even a better fixed-pose result would establish neither a new 3D
wake envelope nor robustness to imposed wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction feedback
source_mechanism: preserve a traveling rhythmic carrier while recruiting its energy from measured locomotor slowdown relative to the surrounding water
transferable_invariant: a bounded low-speed carrier-recovery loop should distinguish through-water advance from inertial advection while leaving target geometry responsible for route steering
nontransferable_details: published gains, dimensional speed thresholds, robot sensor calibration, species-specific kinematics, exact vortex phases, cylinder geometry, and task-specific routes
policy_translation: retain the evidenced smooth speed-deficit gate and all steering allocation, but feed it normalized body-frame axial relative flow instead of inertial forward speed
falsification: reject if capture is later than 23.864521T or lost, mean distance exceeds 2.192138L, 2T progress regresses, or route, wake, saturation, effort, force, or moment envelopes worsen
