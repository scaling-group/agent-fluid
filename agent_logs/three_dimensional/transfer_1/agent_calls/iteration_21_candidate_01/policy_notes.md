# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and an active moving
  window. The two exact speed-reserve baseline rollouts captured at
  `0.7466--0.7494L` in `18.3205--18.6010T`; the two exact posterior
  wave-shape rollouts captured at `0.7480--0.7492L` in
  `18.1995--18.4690T`. The assigned parent's prior evaluation of the same
  posterior policy also captured at `0.7481L` in `18.5680T`, giving that
  mechanism three exact-policy captures.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the highest-scoring sampled baseline (`solver_6b0e320e2f55`), a sampled
  posterior repeat (`solver_591f46d260e7`), and the assigned parent's
  geometry-gated yaw-brake failure. Both successful policies self-propel
  through capture, retain a coherent alternating mid-plane wake, and shed
  compact three-dimensional structures without visible carrier collapse.
  The failed yaw brake keeps an active wake but bends below the target after
  its closest pass and exits the lower boundary; the discriminating problem
  is terminal trajectory geometry rather than propulsion or stability.
- Across the three posterior captures, action-clamp fractions remain about
  `68.2--68.5% / 70.8--70.9%`, speed-limit residence about
  `10.4--10.6% / 11.3--11.5%`, peak force coefficients within
  `0.0146--0.0150 / 0.0277--0.0297`, and peak moment coefficient within
  `0.0159--0.0167`. These ranges overlap the sampled baseline, so the
  posterior term is compatible with the established actuator/load envelope
  but is not a saturation cure.
- Reconstructed terminal target/velocity geometry gives projected miss
  `0.33--0.64L` and alignment `0.51--0.90` for the three posterior captures,
  versus projected miss `0.24--0.73L` and alignment `0.23--0.95` for the two
  sampled baseline captures. This tentatively supports a less tangential
  terminal approach, but posterior scores and mean distances overlap or trail
  the baseline. It is not yet evidence of scalar performance superiority.

## One candidate hypothesis

Use the exact evaluated `dogfish3d_speed_reserve_posterior_wave_shape_v1`
mechanism and parameters. Preserve the achieved-course route error,
intercept-release veto, state-feedback traveling bend, and sparse outward
carrier reserve. Only inside the existing intercept gate, add the previously
evaluated small posterior acceleration derived from normalized anterior-joint
phase and the signed body-frame turn request. This is one mechanism-level
change from the prefilled baseline and does not retune cadence, route gain,
drive amplitude, or steering allocation.

Expected test: retain far-field closure and both coherent wake views, capture
again with loads and actuator residence inside the established baseline
envelope, and avoid the most tangential terminal crossing seen in the sampled
baseline. A further capture strengthens repeatability; a useful improvement
claim additionally requires terminal-geometry, arrival, distance-integral,
load, or saturation separation from baseline variability.

Falsification: restore the exact speed-reserve baseline if this repeat misses,
weakens the traveling wake, changes far-field closure, raises actuator or load
metrics outside the baseline envelope, or if a larger repeat set fails to
show a terminal-path or secondary-metric benefit. Do not tune the posterior
gain or intercept threshold in isolation after such a result.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and two-joint asymmetric wave-shape turning
source_mechanism: preserve rhythmic propulsion while a bounded posterior phase-dependent bias supplies subordinate steering
transferable_invariant: steering may perturb posterior wave shape without replacing the active traveling bend, and feedback geometry must gate that perturbation
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact body envelopes, vortex phases, and task-specific coordinates or routes
policy_translation: normalize anterior joint speed by carrier amplitude-frequency, multiply it by the signed body-frame turn request and existing intercept gate, and add the bounded residual only to the posterior joint acceleration
falsification: reject if an exact repeat loses capture, weakens either wake view, alters far-field closure, exceeds the sampled actuator/load envelope, or fails to develop a repeatable terminal benefit over the speed-reserve baseline
