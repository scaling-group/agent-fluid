# Course-selected yaw-moment residual candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders, no prewarm,
  and finite `left_domain` termination. I inspected both rows of the combined
  sheets for the strongest finite sample (`solver_0620d96874f3`, `2.326L`
  minimum) and the informative differential-S-bend failure
  (`solver_5140ef46529a`, `2.469L`), and checked the other sampled sheets,
  scores, traces, and diagnostics. In every top-down row, the fish develops a
  coherent alternating vorticity street from rest; every oblique row retains
  compact three-dimensional Lambda2 structures through the broad clockwise
  pass and lower exit. The motion is self-propulsion, not advection, and wake
  collapse, collision, or numerical instability does not precede failure.
- The sampled yaw-selected posterior brake reaches `2.385L`, course-selected
  anterior duty reaches `2.433L`, a static differential S-bend reaches
  `2.469L`, and posterior phase-lag modulation reaches `2.326L`; all remain
  powered to the same lower-boundary exit after about `31--32T`, with final
  distance near `9.19--9.21L`. The two inherited attempts to activate phase
  modulation from lateral/closure geometry also kept `left_domain` and
  worsened the minimum to `2.390L` and `2.684L`. This closes another scalar
  gate, duty, static-bend, or phase-amplitude retune as the present test.
- At the best sampled minimum (`17.908T`), speed is still `0.687U`, the target
  ray is strongly lateral in the body frame, course error is `1.088 rad`, and
  instantaneous heading rate is `2.090 rad/T`; anterior/posterior acceleration
  clamp residence is already about `0.749/0.355`. Across its states inside
  `4L`, normalized yaw moment spans about `-0.0121--0.0109` and correlates
  `0.927` with the same-step heading-rate derivative. Moment is therefore an
  evidenced, earlier hydrodynamic response signal; more command limit is not.

## Policy hypothesis

Preserve the sampled `2.326L` bearing-curvature carrier, alignment envelope,
yaw-selected posterior brake, proximity-localized joint-state phase-lag
modulation, and command reserve. Add one bounded fast residual at the posterior
target: persistent body-frame target-ray/course error supplies the desired
course sign, while normalized measured yaw moment identifies an instantaneous
hydrodynamic acceleration that grows that error. Only their harmful signed
product activates a small opposite posterior displacement, under the existing
distance, speed, and course-error envelope. Useful or opposite-sign moment is
left alone, and release/cruise are unchanged to numerical relevance.

The moment/action correlation is sign calibration, not causal proof. Support
requires the coherent cruise wake plus capture, a return leg, a new termination
class, or a material improvement below `2.326L` without higher clamp/load
residence. Reject the residual if it produces the same powered lower exit with
only a scalar shift, fights useful moment, raises saturation or loads, curls
tightly, or damages wake coherence or mean-distance progress.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow route error from a bounded fast hydrodynamic disturbance residual while preserving the propulsive traveling wave
transferable_invariant: persistent target geometry selects desired turn sign, but only measured fast moment that increases that error receives a small state-dependent rejection action
nontransferable_details: published gains, dimensional moment scales, robot tail layouts, clock phases, exact vortex phases, species kinematics, and prescribed routes
policy_translation: normalized body-frame target-ray/course error signs normalized yaw moment; the harmful product gates an opposite posterior target displacement within the existing joint-state phase and approach envelope
falsification: reject on lost cruise progress or wake coherence, increased clamp/load residence, a tight curl, worse mean distance, or the same lower exit without a material closest-approach or return-leg improvement

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. Local replay and
contract checks can establish activation scale, boundedness, locality,
reflection equivariance, and schema consistency, but cannot establish a new
hydrodynamic trajectory or score.

## Controller-only activation audit

Replaying only the new residual algebra on the completed `2.326L` trace gives
`0.743 deg` mean and `2.448 deg` maximum absolute posterior displacement inside
`3L`. It is active on about `17.7%` of all recorded states, but its maximum
absolute displacement during the first `2T` is below `0.000001 deg`. At the
recorded minimum the moment has the useful opposite sign, so the residual is
exactly off rather than damping both gait halves. This audit confirms locality
and sign selection only; it does not replay body or fluid dynamics.

The check-runner's material-guidance, lightweight Julia contract, and editable
boundary checks pass. Mirrored synthetic target, joint, velocity, yaw, and
moment states produce exactly mirrored accelerations (residual below `1e-12`);
a zero-speed probe remains finite, and returned actions stay within the
declared `+/-28 rad/T^2` reserve.
