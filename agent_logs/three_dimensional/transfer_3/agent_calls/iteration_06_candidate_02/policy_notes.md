# Distributed course-bend candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The combined top-down
  vorticity and oblique Lambda2 rows therefore show self-propulsion rather
  than imposed advection.
- The best finite sample, `solver_adc862529891`, retains a coherent alternating
  wake and reduces distance from `12.328L` to `5.658L`, but it bends above the
  target and exits the upper boundary at `16.77T` (`final=5.843L`). The
  informative `solver_b22e8cf1f277` failure keeps the wake coherent for
  `29.52T` and gets closer (`4.158L`), then travels past the target line and
  exits the left boundary at `9.037L`. Thus neither failure is wake collapse
  or numerical instability; both lack sustained cross-track correction.
- `solver_7108cd3d3374` confirms the distinction: course-response release
  improves closest approach to `4.358L`, but the fish remains near `y=14L`
  while the target is at `y=9.5L`, then exits left at `9.767L`. Its trajectory
  and `solver_b22e8cf1f277` reverse their course error well before closest
  approach, yet their posterior-only yaw residual does not turn the mean
  swimming direction onto the target.
- The assigned parent `solver_97bc3c03d55b` is a shorter upper exit
  (`min=final=9.175L` at `11.13T`). The inherited optimizer logs also record
  three target-aware upper exits: bounded bearing-response lead reached only
  `12.030L`, a phase-compensated yaw loop reached `11.764L`, and the sampled
  course-response child retained the left-exit topology. Repeating another
  yaw-rate gain or posterior-bias scalar change is therefore unsupported.
- The sampled strong carrier is physically productive but command-limited:
  raw anterior commands exceed `1800 deg/T^2` in about `41--58%` of samples,
  and raw posterior commands in about `31--74%`. A posterior-only steering
  residual is consequently often masked by the same actuator that is already
  tracking the propulsive wave. The 3D turn-sanity contract instead calibrates
  a shared mean joint bias as a direct negative-yaw actuator.
- Across all four sampled trajectories, a joint-rate projection
  `v_lateral_slow = v_lateral + 0.11*phi_dot1 - 0.04*phi_dot2` reduces the
  lateral body-velocity standard deviation from `0.29--0.40U` to
  `0.08--0.12U`; the fitted coefficient signs are consistent in every sample.
  This supports a phase-conditioned motion course rather than feeding the
  carrier's instantaneous lateral recoil back as route error.

## Policy hypothesis recorded before editing

Test one actuator/feedback mechanism rather than another yaw-loop gain: a
sensor-modulated, distributed mean centerline bend. Preserve the evidenced
`28 deg`, `0.55T` state-feedback traveling-bend carrier, but compute a bounded
course error from normalized body-frame target and velocity directions. Gate
velocity direction near rest and remove only the joint-rate-correlated lateral
component evidenced above. Move the anterior oscillator equilibrium and the
posterior traveling-wave equilibrium together by the resulting mean bend, so
steering is not confined to the heavily clipped posterior tracker. The FSI sign
calibration is explicit: positive body-y course error requests positive mean
bend, which produces negative yaw.

Expected result: preserve the coherent alternating wake, turn the mean motion
down toward the target instead of merely releasing the initial yaw, and beat
the `4.158L` sampled closest approach without an upper or straight-through
left exit. Falsify the mechanism if the initial yaw polarity is wrong, both
joints lose their phase-lagged carrier, mean bend remains pinned at its limit,
raw clipping or wake coherence materially worsens, or the trajectory again
stays near `y=14L` and exits left. The new candidate's CFD result is not
available to this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and calibrated two-joint turning
source_mechanism: preserve a rhythmic propulsive carrier while a bounded observed course error shifts the mean body curvature
transferable_invariant: steering authority should be a slow bounded residual around the propulsive rhythm, and its actuator distribution should create a mean bend without replacing the traveling wave
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, dimensional beat rates, species envelopes, exact vortex phases, and task-specific routes
policy_translation: form target and phase-conditioned velocity directions only from normalized body-frame observations and joint rates, suppress velocity direction near rest, and shift both equilibria of the two-joint state-feedback traveling bend by one bounded course-error command
falsification: reject if turn polarity is wrong, the carrier or wake loses coherence, the mean bend saturates persistently, or closest approach and left-exit topology do not improve
