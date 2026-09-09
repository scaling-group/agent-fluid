# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, and active moving-window shifts. Translation and wake formation
  are therefore released-swimmer behavior rather than ambient advection.
- The two exact sampled `dogfish3d_intercept_guarded_speed_reserve_v1`
  baselines capture at `0.7466--0.7494L` after `18.3205--18.6010T`, including
  the population-best sampled score of `-0.15140`. Inherited guidance records
  at least three exact captures for this controller.
- The two sampled `dogfish3d_speed_reserve_posterior_wave_shape_v1` copies also
  capture, at `0.7480--0.7492L` after `18.1995--18.4690T`, but neither score nor
  inherited actuator/load evidence establishes a benefit over the baseline.
  Their combined sheets show the same useful behavior as the baseline: a
  self-propelled fish, an active alternating mid-plane vortex street, and
  compact bilateral Lambda2 structures through arrival.
- The assigned-parent log supplies the decisive negative repeat. The exact
  posterior-pulse policy kept an organized wake and continued self-propelling,
  yet passed below at `1.2589L` and exited the lower boundary at `32.945T` with
  final distance `10.7282L`. This makes its record `2/3` and identifies terminal
  steering topology, rather than carrier collapse, advection, or instability,
  as the failure mode.
- Earlier inherited results already reject scalar route-gain increases,
  cadence relief, carrier suppression, total-command speed governors,
  carrier-phase steering allocation, projected-miss replacement, and terminal
  yaw damping for this coherent, broadly acquired trajectory family.

## One candidate hypothesis

Remove only the phase-dependent posterior wave-shape residual and restore the
exact evaluated `dogfish3d_intercept_guarded_speed_reserve_v1` bytes. This
preserves the joint-state traveling bend, body-frame achieved-course error,
projected-corridor release veto, additive steering, and conditional outward-
carrier reserve. It is an evidence rollback of one falsified mechanism, not a
scalar gain or route retune.

Expected test: recover the repeat-backed capture class while retaining the
coherent top-down and oblique wakes and the established actuator/load envelope.
The new CFD result is not claimed here because evaluation occurs after this
worker exits.

Falsification: reject the rollback if an exact baseline replay misses, weakens
the active traveling wake, changes far-field closure, or moves clipping,
joint-speed residence, force, or yaw moment outside the sampled baseline
envelope. Do not answer a miss by re-adding or scalar-tuning the posterior
pulse.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a posteriorly lagged propulsive bend while bounded body-frame geometry feedback supplies subordinate steering
transferable_invariant: steering must remain subordinate to an active directional body wave unless repeated evidence shows a better interception topology
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, oscillator clocks, exact vortex phases, world-frame routes, and task coordinates
policy_translation: remove the falsified phase-dependent tail residual and retain the normalized achieved-course/intercept controller plus its two-joint traveling bend and sparse actuator-state reserve
falsification: reject if exact replay loses capture or wake coherence, changes far-field closure, or exceeds the repeat-supported saturation and load envelope
