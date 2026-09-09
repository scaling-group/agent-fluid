# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All sampled rollouts report direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Motion in both visual
  rows and every wake structure is therefore self-generated rather than
  imposed advection.
- The assigned parent `solver_2bf5e06dbda4` falsifies two-joint recoil
  compensation as a route controller in its present form. Its top-down row
  shows only a short, curved wake and the oblique row shows compact structures
  following an early turn toward the upper boundary. It reaches just
  `11.764L`, translates only to `(19.579,15.203)L`, and exits at `9.213T`.
  Thus the retrospective reduction in beat-scale yaw variance did not preserve
  propulsion or produce the hypothesized braking response.
- `solver_adc862529891` is the strongest sampled target-aware result. Its
  single-anterior-phase residual preserves a coherent alternating vorticity
  street and Lambda2 structures through `16.77T`, advancing from `12.328L` to
  `5.658L`. However, it reaches the target's x station while far above it:
  center `(9.451,15.202)L`, final distance `5.843L`, and an upper-boundary
  exit. Its target error changes side while posterior curvature continues to
  alternate near its limits, so the result supports the carrier but not the
  phase-conditioned yaw-rate loop as controlled steering.
- The clean-B carrier `solver_19f251537923` provides the complementary failure.
  Both visual rows show a long, coherent wake and range falls to `6.138L` at
  about `16.5T`, but a persistent downward arc then reverses progress and ends
  at the lower boundary with `10.460L`. Strong propulsion without gait-
  subordinate steering can therefore miss on either side.
- The inherited half-cycle result `solver_03abcb979019` used a slower `20 deg`,
  `0.70T` envelope-limited carrier and `14%` asymmetry. It produced a visibly
  weak short wake, reached only `12.195L`, and exited upward at `8.635T`.
  That result rejects combining strong asymmetry with carrier weakening; it
  does not isolate a small phase-selective steering perturbation on the
  evidenced `28 deg`, `0.55T` carrier.
- Local flow remains only about `0.02--0.04U`, no sample enters the `0.75L`
  capture regime, and no termination is numerical. Wake-disturbance rejection
  and terminal distance scheduling are not supported by this evidence. The
  next test should change the steering actuator while preserving propulsion.

## Policy hypothesis

Remove the failed compensated-yaw loop and any persistent posterior equilibrium
offset. Preserve the `28 deg`, `0.55T` state-feedback traveling bend exactly,
then let normalized body-frame line of sight impose only a small half-cycle
amplitude imbalance on the posterior wave. Joint state supplies phase: the
target-side posterior half-cycle is strengthened and the opposite half-cycle
is weakened by at most `5%`; the imbalance reverses with target side and
vanishes continuously at alignment. This tests gait-synchronized steering
without reading raw yaw rate, a sub-beat trend, time, or a memorized route.

Expected result: retain the long alternating wake and leftward translation of
`solver_adc862529891`, but reduce the accumulated upward cross-track excursion
instead of entering a tight static-bend turn. Falsify the mechanism if the wake
becomes short or visibly weaker, either action becomes persistently saturated,
the fish again exits the upper boundary without improving on `5.658L`, or the
opposite lower-exit arc appears. The new CFD result is unavailable to this
worker and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG direction tracking
source_mechanism: sensor-gated half-cycle amplitude asymmetry superposed on a posterior-lagged propulsive rhythm
transferable_invariant: persistent body-frame direction error may slightly imbalance the two observed gait half-cycles, but the imbalance must reverse with target side and vanish at alignment while the traveling wave remains the carrier
nontransferable_details: published gains, dimensional beat frequencies, linkage geometry, clock-driven CPG phase, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: normalize `target_body_L` by `distance_L`, infer posterior wave side only from `phi1` and `phi_dot1`, and apply a bounded signed scale imbalance before the second-joint state-feedback tracker
falsification: reject if carrier wake coherence or translation collapses, target-side sign is wrong, returned commands persist at the actuator bound, or an upper/lower boundary exit repeats without a better closest approach
