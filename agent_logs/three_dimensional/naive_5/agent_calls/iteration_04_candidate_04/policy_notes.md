# Wake-policy candidate diagnosis

## Evidence diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=[0,0,0]`, zero cylinders, no prewarm). Their motion,
  wake, and boundary exits therefore come from the fish/controller rather than
  imposed advection.
- The best finite sample, `solver_0334e73ca6df`, visibly self-propels. Its
  top-down row shows a sustained alternating vorticity street while the fish
  travels left, but the target marker moves below and then behind the nearly
  horizontal path. The oblique row confirms a coherent three-dimensional
  caudal Lambda2 trail through `39T`. Metrics agree: it survives to `39.088T`,
  reaches `5.156L` at a center near `(9.403,14.678)L`, then misses below-target
  correction and exits left at `y=14.961L` with final distance `10.235L`.
- The assigned-parent candidate, `solver_614a9cbf562b`, does not preserve that
  useful topology. Its top-down frames curl sharply upward and its oblique row
  shows only a short bent trail before the fish exits at `8.778T`. It reaches
  only `12.186L`, finishes at `12.547L`, and has lower relative-flow RMS
  (`0.266` versus `0.570` in the strong rollout), consistent with weak useful
  translation rather than a hidden energetic advance. Force/moment RMS are
  also lower (`0.0060/0.0032` versus `0.0092/0.0046`), and neither rollout is
  numerically unstable.
- The inherited course signal was geometrically bounded but translated to the
  wrong half-stroke response. Its selector is positive for `70.2%` of samples
  and remains about `+0.99` after `5T`; meanwhile bearing has crossed negative
  and cycle-mean yaw remains between roughly `-0.15` and `-0.31 rad/T` until
  the upper exit. The independent bearing-persistent sample
  `solver_4c2f69e357da` supplies the same sign calibration: after negative
  bearing makes its half-stroke selector rise from `+0.36` to `+0.99`, yaw
  remains negative at about `-0.21` to `-0.27 rad/T`. Thus a positive selector
  reinforces negative yaw in this carrier; using negative bearing to request
  a positive selector drives away from recovery.
- The strong sample's nominal yaw controller is not reliable slow feedback:
  after `2T`, `corr(heading_rate, phi_dot1)=-0.935` and a linear phase term is
  approximately `heading_rate=-0.452*phi_dot1 + residual`. Its raw-yaw
  selector therefore acts mainly as a symmetric phase-synchronous energy pump.
  This explains both the long coherent wake and the poor target correction,
  plus the observed saturation: at least one joint exceeds `44 deg` on `9.7%`
  and `250 deg/T` on `58.9%` of samples.

## Policy hypothesis

Make the useful roles explicit rather than asking instantaneous yaw to perform
both. Preserve the strong sample's state-feedback traveling bend and replace
its accidental raw-yaw phase pump with a bounded, symmetric joint-velocity
phase pump. Independently estimate slow yaw as
`heading_rate + 0.45*phi_dot1`, cancelling the phase-synchronous component
measured in the strong rollout. Compare that residual with a bounded desired
yaw from body-frame bearing, and invert the error-to-half-stroke allocation to
match the two sampled response signs: positive selector for requested negative
yaw, negative selector for requested positive yaw. Gate both added drives by
an anterior soft-angle headroom while retaining the evidenced lagged posterior
follower.

Expected result: the symmetric pump retains leftward self-propulsion and the
alternating 3D wake, while the response-gated asymmetry arrests the intrinsic
negative-yaw curl as bearing crosses through zero and then bends the course
toward the target. The target marker should remain near the wake corridor,
minimum distance should beat `5.156L`, and angle/speed saturation should fall
below the strong sample. Falsify the hypothesis if it repeats the near-`9T`
upper exit, if the gait-phase-rejected yaw residual still selects the wrong
recovery half-stroke, if propulsion collapses before meaningful progress, if
the path again passes near `x=9L` above `y=14L`, or if hard-limit occupancy
remains material.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking with asymmetric flapping, informed by burst-redirect response gating
source_mechanism: preserve a rhythmic propulsive carrier while sensor feedback allocates bounded extra authority to the turn-useful half-cycle and releases or reverses it when yaw response appears
transferable_invariant: separate fast gait-synchronous motion from persistent target error, preserve the traveling wave, and map bounded steering to the half-stroke whose measured slow response has the requested sign
nontransferable_details: published gains, robot linkage geometry, clock-driven CPG phase, species-specific envelopes, exact vortex phases, dimensional frequencies, and task-specific routes
policy_translation: use anterior joint velocity as observable phase, cancel its measured component from normalized yaw rate, form desired yaw from bounded body-frame bearing, apply the evidence-calibrated opposite sign from yaw error to half-stroke selector, and retain a lagged posterior state-feedback wave
falsification: reject if the symmetric pump loses the coherent translating wake, if negative bearing still produces sustained negative slow yaw, if the near-9T upper exit recurs, if minimum distance cannot beat 5.156L, or if joint angle and speed saturation remain material
