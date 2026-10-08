# Phase-preserving nominal acceleration envelope

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. Every sample captures. Three byte-identical executions of the
  prefilled rate-guard policy capture at `0.749366L` and `27.5770T`; the
  non-rate-guard angle-stopping parent captures at `0.749992L` and `27.7695T`.
  The duplicates establish fixed-condition determinism, not trajectory or
  initial-condition robustness.
- In the top-down vorticity rows, both unique policies self-propel from rest,
  leave an organized alternating wake, translate continuously toward the
  target, and make the same late correct-sign hook into the capture circle.
  In the oblique body/Lambda2 rows, compact three-dimensional structures remain
  attached to and trail the oscillating body through the route. The wake and
  world-space track move relative to the storage box through `255--264` window
  shifts, so neither apparent translation nor capture is window advection.
- No sampled `left_domain`, instability, or collision sheet is available in
  this workspace. The most informative sampled defect comparison is therefore
  the angle-only capture. Its exact `260 deg/T` residence is `1124/10098`
  joint samples, whereas the rate guard removes all exact contacts, retains
  zero `45 deg` contacts, and captures `0.1925T` earlier. Peak planar force/yaw
  moment remain essentially unchanged (`0.02212/0.01041` versus
  `0.02218/0.01034`). Inherited logs supply the failure contrast: a stronger
  fixed rate brake left 34 speed contacts, increased acceleration-clamp
  exposure to 1725 samples, raised peak load coefficients to
  `0.02418/0.01124`, and scored worse despite capture. Thus strengthening or
  scalar-retuning the successful rate brake is unsupported.
- The successful rate-guard trace still contains 1,688 near-clamp occurrences
  under a direct `|a| > 29.999 rad/T^2` CSV threshold (the inherited exact-cap
  aggregate reports 1,686 of 10,028 joint samples). At least 878 occur while
  the joint is already moving inward, when the angle-stopping guard is
  inactive, and the two-joint command norm exceeds `36 rad/T^2` on 1,041 of
  5,014 steps. Independent final clipping can therefore distort the
  anterior/posterior acceleration ratio of the otherwise coherent traveling
  bend. This is a distinct nominal-command allocation defect, not evidence to
  change target-line response, redirect, propulsion gain, or the proven safety
  guards.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, posterior follower, body-frame
target/course selector, same-sign redirect, terminal miss veto, positive
line-of-sight response-deficit branch, angle stopping guard, and successful
rate guard. Before the safety guards, apply one reflection-equivariant common
scale to the nominal two-joint acceleration vector using a high-order soft
maximum envelope. The scale approaches one below the individual acceleration
boundary, smoothly compresses only boundary-scale requests, and preserves the
joint-command ratio instead of clipping each component independently. Angle
and rate guards remain downstream and may still demand stronger inward action
where observed state makes it necessary.

The falsifiable expectation is repeat capture with the same coherent visual
route and zero angle/rate contacts, but fewer nominal acceleration-clamp
samples and no increase in force or yaw moment. Reject this mechanism if it
slows or dephases the carrier enough to lose capture, changes the late
target-directed hook, causes a safety guard to spend more time at full brake,
or merely trades nominal clipping for worse propulsion, loads, angle, or rate
exposure. The candidate's CFD evaluation occurs after this worker exits and is
not evidence in these notes.

bookshelf_consulted: true
source_domain: classical reactive fish propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: a directed traveling bend depends on preserved anterior-to-posterior timing and should be modulated continuously from measured state within a finite actuator envelope
transferable_invariant: near an actuation boundary, preserve the direction and relative allocation of an already productive multi-joint rhythm while smoothly reducing only its infeasible magnitude
nontransferable_details: published CPG gains, dimensional acceleration budgets, species-specific envelopes, exact Strouhal values, vortex phases, and task-specific routes
policy_translation: retain the normalized body-frame target feedback and two-joint state oscillator, apply one common soft scale to the nominal acceleration pair, then leave the evidenced inward-only angle and speed viability guards in final authority
falsification: reject if capture or coherent propulsion is lost, anterior/posterior phase allocation changes visibly, clamp residence fails to fall, or joint contacts and hydrodynamic loads worsen

## Non-CFD implementation audit

- The lightweight Julia contract returns two finite bounded accelerations, and
  the new direct parameter reference is owned by `target_policy_params()`.
- A deterministic grid of 1,600 target, joint-angle, and joint-rate states is
  finite and bounded; reflecting lateral target/velocity signals, yaw signals,
  angles, and rates negates both commands exactly to floating-point precision.
- A frozen-state audit reconstructed body-frame target geometry and recent
  bearing/turn rates for all 5,014 rows of the completed rate-guard trace. The
  envelope changes 2,717 row commands by more than `0.1 rad/T^2` and 1,683 by
  more than `1 rad/T^2`; the mean maximum-joint difference is `0.879 rad/T^2`
  and the largest is `4.457 rad/T^2`. On those frozen states, exact nominal
  clamp occurrences fall from 1,643 to zero. This establishes material,
  bounded, symmetry-preserving activation only: it is not a counterfactual
  CFD trajectory and does not predict capture or closed-loop clamp counts.
- The mandated check-runner agent was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three prescribed commands were
  run directly and separately: the guidance semantic-delta/parameter-schema
  check passes, the finite two-joint Julia contract passes, and the solver
  editable-boundary check passes. No CFD was run.
