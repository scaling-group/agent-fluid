# Candidate diagnosis and hypothesis

## Assigned-parent evidence

- The only sampled rollout is the exact prefill policy
  `solver_19f251537923` (`score=-12.078693`, `termination=left_domain`). It is
  a direct-uniform still-water run: `U_infinity=(0,0,0)`, no prewarm, no
  cylinders, and 323 inertial moving-window shifts.
- The combined keyframe sheet was inspected in both rows. The top-down row
  shows a regular alternating vorticity street and sustained translation; the
  oblique Lambda2 row shows a finite coherent wake rather than passive
  advection or a 2D-only rendering artifact. The useful finite segment reaches
  `6.13836L` from an initial `12.32772L` at `t=16.5055T`.
- The same sheet then shows the nose rotating downward while the wake continues
  to propel the fish. The trajectory cross-check has center/head
  `(14.0134,0.7987)L/(13.9898,0.3073)L`, speed approximately
  `(-0.079,-0.795)U`, heading `1.38255rad`, and recent heading rate
  `1.57143rad/T` immediately before the lower (`left_domain`) exit at
  `t=26.1470T`. Distance has reopened to `10.45961L`.
- The raw policy action exceeds the configured `1800deg/T^2`
  (`31.4159rad/T^2`) envelope on at least one joint in 4,650 of 4,754 logged
  samples (97.8%); requested maxima are `73.43` and `125.37rad/T^2`. Both joint
  rates reach `4.53786rad/T`, effectively the `260deg/T` limit. The coherent
  wake therefore demonstrates a useful traveling-wave structure, not evidence
  that the imported `0.55T`, `28deg` operating point or its clipped action is
  reusable in 3D.
- Thus the useful comparison available within this sole sample is its finite
  approach segment versus its informative terminal failure. It supports
  retaining the traveling-bend propulsion, but not the imported steering
  architecture. The controller's numerous asymmetric request gates and
  tail-only curvature path fail to arrest growing yaw after closest approach.
- Repository calibration independently fixes the actuator sign:
  `free_swim_turn_sanity3d.jl` records that positive mean joint bias produces
  negative yaw. This makes a direct sign-consistent body-frame reflex possible
  without a world-frame route.

## Candidate policy hypothesis

Preserve the parent's state-feedback oscillator and posterior-lag traveling-wave
structure, but move it inside the observed joint-rate/acceleration envelope.
Replace the multi-branch imported steering law with one bounded mean-curvature
mechanism: normalized target lateral geometry requests the corresponding joint
bias, while bounded recent yaw rate and bearing trend oppose overshoot. Apply
the bias as the equilibrium of both joint oscillators, not merely as a small
tail-tangent offset, so steering authority remains explicit while the
posterior traveling wave remains intact. Clamp the requested action inside the
episode limit as a final guard, with the design intended not to live on it.

Expected result: the fish should retain a coherent propulsive wake and early
distance reduction, but should bend back toward the target rather than keep a
sustained downward velocity through the lower boundary. Falsify the mechanism
if the new rollout still exits at low `y`, turns in the wrong sign, loses the
alternating wake/thrust, or continues persistent joint-limit or
acceleration-limit saturation. A semantic improvement
(horizon/near miss/success) matters more than a small scalar change.

## Dry mechanism check

A joint-only integration using the episode's angle/rate/acceleration clamps
(no fluid solver) rejected the provisional `20deg` oscillator scale because
its realized Van der Pol limit cycle still reached the rate ceiling and action
guard. With the final `12deg` scale, the aligned-target limit cycle reaches
about `24.00/23.62deg`, `177.64/175.78deg/T`, and
`1324.37/1274.41deg/T^2`. Holding a strong target geometry that produces an
`8.89deg` mean bias raises maximum joint angle only to `32.88/32.51deg` and
does not change those rate/acceleration maxima; neither case hits a guard or
episode limit. This check validates state-feedback envelope compatibility, not
hydrodynamic propulsion or capture.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and classical fish mean-curvature turning
source_mechanism: sensor-modulated rhythmic locomotion with bounded average joint bend
transferable_invariant: preserve the traveling propulsive rhythm while slow body-frame target error sets bounded mean curvature and measured yaw response releases or reverses that curvature
nontransferable_details: published gains, duty ratios, species envelopes, clock-driven CPG phase, exact vortex phase, and source-task routes
policy_translation: use normalized target_body_L/distance_L, bearing_window_rate, turn_rate_recent, and observed joint state to bias both two-joint oscillator equilibria with a bounded state-feedback command
falsification: reject if target-relative turn sign is wrong, the low-y exit topology persists, coherent propulsion collapses, or joint and acceleration saturation become persistent
