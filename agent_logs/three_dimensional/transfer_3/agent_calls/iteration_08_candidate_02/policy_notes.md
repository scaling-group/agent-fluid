# Line-of-sight-rate release candidate

## Evidence diagnosis recorded before the policy edit

- Every sampled and inherited diagnostic reports direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Translation is therefore self-propulsion, not advection or a storage-window
  artifact.
- In both rows of the combined sheets, the stronger sampled policies retain a
  coherent alternating top-down vortex street and compact oblique Lambda2
  structures. The best-score sample (`solver_adc862529891`) nevertheless rises
  to `y=15.20L` and exits at `16.77T` after reaching `5.658L`. The raw-slip and
  joint-rate-projected-slip samples improve closest approach to `4.158L` and
  `4.128L`, but both pass the target x-station about `4.1L` high and continue
  into a left exit near `29.6T` with final range about `9.05L`. Their organized
  wakes, finite dynamics, and small local flow show a route-response failure,
  not lost propulsion or wake advection.
- The inherited full signed-course release (`solver_f080e10f704b`) is a
  negative result: despite recoil projection it exits upward at `11.30T`,
  reaches only `8.507L`, and ends at the same range. Thus an instantaneous
  course-angle reversal is still too carrier-contaminated for the posterior
  mean-curvature loop.
- The assigned parent's response-damped half-cycle candidate
  (`solver_5c3c1ecb1b6b`) is the clearest actuator failure. The top-down row
  curls into a tight upward arc, the oblique row shows the body turning without
  building the long downstream wake seen in the stronger samples, and the
  fish exits at `8.70T` near its start. Its minimum distance is `12.072L` and
  final distance `12.492L`. Response feedback therefore did not make
  half-cycle strength asymmetry safe; later policies should not tune that
  architecture again without a different response signal and actuator.
- A kinematic cross-check supplies a different response signal. Using the
  rotation-invariant target-line rate
  `(r_y*v_x - r_x*v_y)/|r|^2`, the phase-separated-slip sample is near
  `+0.023 rad/T` by `4T` and grows through `+0.097 rad/T` at `12T`, while its
  body bearing changes sign later and it remains on the high-pass trajectory.
  The same positive growth appears in the other high exits. This rate uses the
  normalized body-frame target vector and rigid-body velocity directly; it
  does not divide two small velocity components or use the evidenced
  `0.0385T` sub-beat heading window.

## Policy hypothesis recorded before editing

Preserve the evaluated `28 degree`, `0.55T` joint-state traveling bend and its
bounded posterior mean-curvature actuator. Form the usual normalized
body-frame line-of-sight bearing, but add a separately bounded inertial
line-of-sight-rate response to the desired yaw rate. Bearing supplies the
initial redirect; when the actual route makes the target line rotate away,
the signed rate term opposes and can reverse that redirect before delayed body
alignment. Gate only the response term by resolved rigid-body speed, then use
the existing joint-rate projection to keep within-beat yaw recoil out of the
curvature residual.

Expected evidence is the sampled coherent wake and strong minus-x travel, but
with yaw release near the first positive target-line-rate transition, a target
x-station crossing materially below `y=13.6L`, and closest approach below
`4.128L` or a better termination class. Falsify the mechanism if it repeats
the `11.30T` upper exit, the roughly `4L` high left pass, or weakens the
alternating wake; that would show that rigid-body velocity still lacks the
needed beat-scale route estimate or that posterior mean curvature is the
limiting actuator.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking
source_mechanism: sensory route-response feedback releases a bounded mean-bend command while the propulsive oscillator remains active
transferable_invariant: preserve the traveling-wave carrier and separate target displacement from observed route response so steering reverses when motion carries the line of sight away, without a timed maneuver
nontransferable_details: published gains, robot linkage geometry, clock-driven phases, dimensional rates, species kinematics, exact vortex phases, and task-specific paths
policy_translation: compute rotation-invariant line-of-sight rate from normalized body-frame target and rigid-body velocity, speed-gate and bound it separately from bearing, and feed their yaw-rate demand through the two-joint posterior-curvature contract
falsification: reject if the short upper exit or more-than-4L high left pass recurs, closest approach does not beat 4.128L, or carrier wake coherence and propulsion degrade
