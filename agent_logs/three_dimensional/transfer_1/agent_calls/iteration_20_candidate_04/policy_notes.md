# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the assigned-parent rollout use direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. The observed translation and wakes are therefore released-swimmer
  behavior rather than ambient advection.
- Three exact sampled copies of the prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1` policy capture at
  `0.7466--0.7494L` after `18.2050--18.6010T`. The fourth sample adds one
  intercept-gated posterior wave-shape pulse and captures at `0.7492L` after
  `18.4690T`. Its score (`-0.15855`) lies inside the baseline range, so this
  first success establishes compatibility, not improvement or robustness.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  highest-scoring sampled baseline capture, the posterior wave-shape capture,
  and the assigned parent's informative terminal-yaw-brake failure. Both
  sampled captures self-propel through termination with coherent alternating
  mid-plane vortices and compact three-dimensional wake structures. The yaw
  brake also retains an active alternating wake but passes below the target,
  reaches only `1.5097L`, and exits the lower boundary at `10.4372L`; its
  failure is terminal path geometry rather than advection, carrier collapse,
  or numerical instability.
- The assigned parent proposed the geometry-gated yaw brake as a repeatability
  test of earlier inherited evidence. Its completed lower exit falsifies
  treating that damping residual as repeat-supported and argues against
  widening its gates or tuning its scalar. The current sampled posterior
  wave-shape pulse changes only the tail command inside the existing intercept
  region and leaves the three-repeat carrier, achieved-course error, response
  release, and actuator reserve intact.

## One candidate hypothesis

Repeat the exact sampled `dogfish3d_speed_reserve_posterior_wave_shape_v1`
policy bytes without changing its gain or gates. The anterior joint velocity
provides a normalized clock-free phase cue; only inside the existing intercept
gate, a small target-signed posterior target bias adds curvature while the
proven traveling bend and additive steering remain active. Exact replay is the
cleanest test of whether its single capture survives the terminal variability
already observed in this direct-uniform solver.

Expected test: preserve command identity with the three-capture baseline
outside `2.75L`, retain the coherent top-down and oblique wakes, and capture
without leaving the sampled actuator and load envelope. A second exact capture
would support repeatability of the mechanism but would still require arrival,
path, load, or actuator evidence before claiming superiority over the baseline.

Falsification: reject the posterior pulse and restore the exact speed-reserve
baseline if the repeat misses, changes far-field closure, weakens the
alternating wake, increases clipping or speed-limit residence, or raises force
or yaw-moment peaks. Do not answer a failed repeat by tuning only the pulse
gain or stacking the failed yaw brake.

bookshelf_consulted: true
source_domain: fish and robotic-fish turning by posterior phase-lag or wave-shape modulation
source_mechanism: embed a bounded target-directed curvature pulse in the posterior traveling wave
transferable_invariant: a small state-synchronous posterior wave-shape change can realize steering while preserving an active propulsive carrier
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, oscillator clocks, exact vortex phases, prescribed paths, and task coordinates
policy_translation: use normalized anterior joint speed as a clock-free phase cue and the existing body-frame turn and intercept gates to add a bounded posterior target bias that is exactly zero in the far field
falsification: reject if exact replay loses capture, alters far-field commands, weakens the wake, or increases saturation and force or yaw-moment loads beyond the repeat-supported baseline
