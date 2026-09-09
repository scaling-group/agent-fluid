# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and an active moving window.
  The three exact speed-reserve baseline evaluations captured at
  `0.7466--0.7494L` in `18.2050--18.6010T`. Their combined top-down and
  oblique sheets show self-propulsion through capture, a coherent alternating
  mid-plane wake, and compact three-dimensional Lambda2 structures rather
  than passive advection or terminal carrier collapse.
- The fourth sampled policy adds a small, clock-free posterior wave-shape
  steering term only inside the existing intercept region. It also captured,
  at `0.7492L` in `18.4690T`; its two visual rows retain the baseline's active
  traveling wake through the crossing. Its action-clamp fractions
  (`68.46%/70.94%`), joint-speed-limit residence (`10.81%/11.58%`), peak
  force coefficients (`0.0148/0.0286`), and peak moment coefficient (`0.0161`)
  are within the ranges of the three baseline captures. This is compatibility
  evidence from one run, not yet a repeat-backed benefit.
- I compared those captures with the assigned parent's exact
  geometry-gated-yaw-brake repeat. Its top-down and oblique rows retain an
  organized wake and stable self-propulsion, but the fish passes below the
  target at `1.5097L`, continues the wrong trajectory, and exits the lower
  boundary at `32.2355T` with final distance `10.4372L`. Because this is the
  repeat requested by inherited guidance after an earlier `0.7486L` crossing,
  it falsifies the yaw-brake mechanism for this topology; the failure is not
  weak propulsion, excessive force, numerical instability, or prewarm.

## One candidate hypothesis

Repeat the exact sampled `dogfish3d_speed_reserve_posterior_wave_shape_v1`
policy bytes. Preserve the repeat-backed achieved-course route error,
intercept-release veto, traveling-bend carrier, sparse outward-carrier reserve,
and every evaluated parameter. The only difference from the baseline remains
the small posterior target bias driven by normalized anterior joint-state
phase, signed body-frame turn request, and the existing intercept gate. This
tests a mechanism-level steering realization without another scalar cadence,
route-gain, damping, or allocation change.

Expected test: retain far-field closure and both coherent wake views, then
capture with actuator residence and force/moment peaks inside the sampled
baseline envelope. A second exact capture would support continued testing of
posterior wave-shape steering; it would not by itself establish a performance
gain because the first run's score and arrival are within baseline variation.

Falsification: reject the wave-shape addition and restore the exact
speed-reserve baseline if the repeat misses, weakens the traveling wake,
changes far-field closure, increases action/speed saturation or loads outside
the baseline range, or produces no repeatable path/arrival benefit after
multiple captures. Do not respond to failure by tuning its scalar gain or
intercept distance in isolation.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and two-joint wave-shape turning
source_mechanism: preserve the propulsive oscillator while applying a bounded posterior phase-dependent steering bias
transferable_invariant: steering can be realized as a subordinate posterior wave-shape perturbation that preserves an active traveling bend
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact body envelopes, vortex phases, and task-specific coordinates or routes
policy_translation: use normalized anterior joint-state phase, body-frame turn request, and the existing normalized intercept gate to add a small bounded posterior target bias without changing the far-field carrier
falsification: reject if an exact repeat loses capture, weakens either wake view, changes far-field closure, raises actuator or load metrics outside the baseline envelope, or fails to develop a repeatable terminal benefit
