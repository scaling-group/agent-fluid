# Self-consistently centered joint-phase recoil candidate

## Visual diagnosis recorded before the policy edit

- The four sampled rollouts and the assigned parent's inherited rollout all
  report direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In the sampled best
  capture and the inherited regression, the top-down mid-plane rows show the
  fish forming an alternating reverse-vortex street from initially quiescent
  fluid. The oblique Lambda2 rows show compact three-dimensional structures
  convecting behind the moving body. Translation is therefore self-propelled,
  not imposed-flow advection or moving-window transport.
- All four sampled response-triggered distributed-C-bend policies capture.
  The strongest finite example is the acceleration-feasible form at
  `19.2335T`, score `-0.17657`, with mean distance `2.065L`, local-flow RMS
  `0.0180U`, force-magnitude RMS `0.01322`, and moment RMS `0.00690`. Its wake
  remains coherent through a right-side approach. The assigned-parent prefill
  captures at `19.5855T`, score `-0.20397`, with the same visual wake topology;
  the two explicit-clipping repeats arrive at `19.23--19.28T` and the two
  unclipped-return repeats at `19.59--19.89T`, but the episode applies the same
  componentwise limiter before integration. The separation therefore cannot
  establish changed applied dynamics, lower effort, or lower loads from
  policy-side clipping alone.
- The assigned parent's inherited joint-position-quadrature rollout is the
  informative regression. It retains the coherent self-propelled wake and
  capture, but arrival moves to `22.6215T`, score falls to `-0.45455`, mean
  distance rises to `2.350L`, and distance at `8T` is `10.323L` rather than
  `9.227L` in the strongest sampled baseline. Force/moment RMS falls only
  slightly to `0.01259/0.00653`. Thus the new route, not wake collapse or
  instability, explains the loss.
- Replaying the inherited formula against its completed trace exposes the
  semantic error. Only the anterior position quadrature was centered on its
  slow route bend. From `4T` onward the uncentered posterior term contributes
  roughly `-0.276` to `-0.390 rad/T` to the alleged recoil signal, while the
  controller holds posterior mean curvature near `+0.150` to `+0.172 rad` and
  bounded desired yaw near `+0.351` to `+0.478 rad/T`. The posterior route
  offset is being interpreted as beat recoil, creating a self-reinforcing
  steering residual and the visibly straighter, slower early route.

## Policy hypothesis recorded before editing

Return to the sampled response-triggered distributed C-bend and preserve its
normalized body-frame bearing/LOS-rate demand, anterior recruitment, complete
posterior mean steering, velocity-phase recoil terms, traveling carrier, and
physical acceleration projection. Add one corrected observation mechanism:
center both position quadratures on their commanded slow bends. Because the
posterior bend is itself computed from the recoil-corrected yaw error, solve
that single bounded scalar relation by a fixed-count bisection. This is a
memoryless state-feedback equilibrium, not a clock, stage counter, route, or
mutable filter.

On the strongest sampled trace, counterfactual replay of the centered relation
reduces mean absolute posterior-curvature demand from `0.145` to `0.091 rad`,
reconstructed raw posterior acceleration RMS from `70.40` to `49.20 rad/T^2`,
and raw posterior-limit exceedance from `73.6%` to `63.8%`. These are offline
algebra checks on a fixed trajectory, not a changed-rollout result. Falsify the
candidate if it loses capture or coherent wake formation, arrives outside the
sampled `19.23--19.89T` band, repeats the inherited slow straight approach, or
completed diagnostics fail to reduce posterior conflict without increasing
force/moment load or anterior saturation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and phase-lagged traveling-wave swimming
source_mechanism: separate slow directional modulation from periodic joint-phase recoil before closing the route-response loop
transferable_invariant: joint-position recoil terms must be centered on the controller's slow commanded bend so that rhythmic feedback does not cancel or reinforce the route command it is meant to regulate
nontransferable_details: published oscillator gains, robot linkage geometry, species kinematics, dimensional frequencies, exact wake phases, and task-specific routes
policy_translation: retain normalized body-frame LOS steering and the two-joint traveling carrier, then solve a bounded posterior mean-curvature equilibrium using position quadratures centered on both commanded slow bends
falsification: reject if capture or wake coherence is lost, the slow early route recurs, arrival worsens beyond the sampled band, or completed posterior saturation and load diagnostics do not improve

## Validation status

- The mandated independent check-runner reports PASS for the material-guidance
  check and PASS for the solver boundary check. The deterministic schema audit
  finds no direct `params.FIELD` reference missing from
  `target_policy_params()`.
- The check-runner's Julia contract probe is unavailable because this worker
  environment has no `julia` executable. A translated-formula audit over
  10,000 randomized finite states returned bounded commands, exact lateral
  reflection equivariance, and maximum implicit-equilibrium residual
  `7.214e-6 rad`; this does not replace the unavailable Julia probe.
- No CFD rollout was run, and no outcome for this candidate is claimed here.
