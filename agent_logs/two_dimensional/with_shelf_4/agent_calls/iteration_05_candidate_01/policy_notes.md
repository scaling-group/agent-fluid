# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and far to the right of
  the target while the four cylinder streets develop and merge. This is the
  common initial condition, so it supports neither a fixed route nor a
  prescribed vortex phase.
- The informative inherited failure bundles a slower gait, stronger moment
  residual, and route-headroom gating. Its released sheet closes into an
  upper-right loop and exits the top boundary after `126.43` units, moving
  only `-1.12L` upstream and regressing from `8.61L` minimum distance to
  `12.05L` final distance. Moderate RMS moment (`317.27`) and feasible joint
  extrema did not diagnose the lost route; later candidates should extend the
  direct-residual success one mechanism at a time.
- The current prefill's direct moment-residual controller reaches the target
  after `149.572` units with `4.38415L` mean distance, `681.91` mean command
  energy, `0.13619` RMS relative crossflow, `16.22` RMS lateral force, and
  `314.99` RMS yaw moment. Its released sheet shows a broad targetward arc,
  sustained alternating bends, and upstream passage through the interacting
  wakes rather than the failed loop.
- The strongest sampled finite policy changes only the route calculation by
  adding smoothly bounded `bearing_window_rate` feedback. It also reaches the
  target in essentially the same time (`149.605`), while mean distance falls
  to `4.35835L`, mean command energy to `647.93`, RMS relative crossflow to
  `0.13206`, RMS force to `15.49`, and RMS moment to `308.48`. Its score
  improves from `-2.43441` to `-2.40838`, and the alternating posterior-lagged
  wave and `-10.93L` upstream translation survive. Because the two files are
  otherwise identical, this is causal evidence for direction-rate damping,
  not a scalar gait comparison.
- The rate term does not shorten arrival: the `0.033`-unit difference is
  negligible and slightly slower. Its supported role is damping route
  zigzags and load/effort without sacrificing capture, not increasing speed.

## Candidate hypothesis

Materialize the sampled rate-damped controller exactly: preserve the current
state-feedback oscillator, zero-mean bearing-driven half-cycle asymmetry,
posterior lag, direct normalized yaw-moment residual, and all gait parameters;
add only the sampled bounded `bearing_window_rate` term inside the persistent
body-frame route request. This should reproduce target reach while retaining
the sampled improvements in distance integral, command effort, crossflow, and
loads. The current candidate's CFD evaluation still occurs after this worker
exits, so reproduction is a test rather than a claimed same-worker result.

Falsify the transfer if capture or upstream translation is lost, arrival is
materially delayed, effort/load reduction does not reproduce, actuator caps
are contacted more strongly, the alternating traveling bend disappears, or a
loop or boundary exit returns. Do not interpret an unchanged arrival time as
failure if mean distance and physical-load metrics retain their sampled gains.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and wake-adaptive swimming
source_mechanism: bounded target-direction rate damping layered over a slower route request and a smaller fast yaw-load residual
transferable_invariant: persistent normalized body-frame target geometry should own route steering, while the observed rate of target-direction convergence may release or restore part of that steering without replacing the propulsive rhythm
nontransferable_details: published gains, dimensional beat settings, robot linkage and species kinematics, exact vortex phase, cylinder layout, recurrent-network state, and source-task routes
policy_translation: preserve the evidenced joint-state half-cycle oscillator and direct `moment_z_L2` residual, then materialize the sampled smoothly bounded `bearing_window_rate` term before the existing turn and amplitude bounds
falsification: reject if rate damping loses or slows capture materially, weakens upstream translation, raises effort or loads, increases cap contact, destroys posterior lag, or recreates a sampled loop or domain exit
