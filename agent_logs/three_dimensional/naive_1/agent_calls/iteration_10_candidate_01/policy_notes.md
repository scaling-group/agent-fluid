# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts and the completed assigned-parent rollout satisfy
  the direct-uniform still-water contract: `U_infinity=[0,0,0]`, no cylinders,
  no prewarm snapshot, and no numerical instability. In both the best sampled
  `3.691L` sheet and the assigned-parent sheet, the top-down row shows an
  alternating red/blue caudal street from release through the lower exit, and
  the oblique row shows discrete three-dimensional Lambda2 structures rather
  than a passive coast. The fish are self-propelled; the persistent defect is
  planar target alignment.
- `solver_24724bc7bb0b` remains the strongest sampled closest approach. It
  reaches `3.691L` at `20.46T` with full head-relative error `1.364 rad`, then
  passes below the target and exits low at `33.27T` and `9.294L`. Its mean
  anterior/posterior angles over `22--26T` are about `+0.247/-0.093 rad` and
  mean yaw rate is `-0.018 rad/T`; the opposite-mean S carrier retains a useful
  wake but supplies too little target-side yaw.
- The sampled one-sided anterior-envelope test (`solver_237089f89ff4`) is a
  narrow semantic improvement, not a solution. It keeps the early visual wake
  active and reduces full error at closest approach from `1.364` to
  `1.291 rad`, but minimum distance worsens slightly to `3.712L` and the same
  lower exit remains. This supports recruiting a steering load before abeam
  without suppressing the carrier, but falsifies anterior-envelope reshaping
  alone as capture authority.
- The assigned parent's same-sign posterior C-bend is the decisive sign
  calibration. It leaves the trajectory and wake nearly identical through
  `20T` and reaches `3.692L`, then changes the `22--26T` posterior mean from
  about `-0.093` to `+0.093 rad` while the anterior mean stays near
  `+0.247 rad`. The requested C shape is therefore realized. Nevertheless,
  mean yaw changes from `-0.018` to `+0.019 rad/T`, full error grows from
  `1.783` to `2.251 rad`, and the visibly tighter curl exits low earlier at
  `32.23T`. Posterior rate-cap occupancy is zero in that interval and the peak
  force/moment envelope does not increase, so saturation or wake collapse
  does not explain the failure: the posterior mean load has the wrong yaw
  sign for this maneuver.

## One candidate hypothesis

Start from the full-angle whole-body half-cycle carrier that preserves the
sampled `3.691L` approach, remove the falsified same-sign C-bend, and test one
distinct posterior reactive-load primitive. As normalized distance falls
inside `8L`, reaching full proximity authority by `5.5L`, and full target
error exceeds the sampled alignment band, smoothly add a posterior mean
deflection opposite to the requested anterior bend. This is a
counter-curvature, rudder-like tail load rather than another shared curvature
center: the assigned-parent finite difference indicates that moving the
posterior mean positive moved mean yaw positive, whereas positive target error
requires negative yaw. The anterior oscillator, phase-selective redirect, and
lagged posterior carrier remain active, and the residual vanishes continuously
when the target lateral component or error vanishes.

The mechanism is falsified if it does not make mean yaw target-signed before
abeam, full error and closest approach do not improve beyond the sampled
`1.291 rad` and `3.691L` boundaries, the same lower exit persists without a
meaningful delay, or the visual carrier, posterior rate-cap occupancy, and
force/moment envelope degrade materially.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive loading and closed-loop robotic-fish mean-offset steering
source_mechanism: a traveling posterior beat supplies propulsion while a bounded mean tail deflection redirects its lateral impulse and is released by observed target alignment
transferable_invariant: preserve the rhythmic traveling carrier and choose posterior steering-load sign from measured yaw response rather than from geometric bend appearance alone
nontransferable_details: elongated-body coefficients, published robot gains, linkage geometry, species-specific envelopes, dimensional frequencies, prescribed maneuver duration, exact vortex phase, and task-specific routes
policy_translation: normalized distance and full head-relative target angle gate a smooth posterior mean offset opposite the target-signed anterior bend while joint state continues to generate the inherited phase-lagged carrier
falsification: reject if pre-abeam yaw is not target-signed, the 3.691L distance or 1.291 rad error boundary is not improved, the lower exit remains without meaningful delay, or wake coherence, saturation, or load envelopes worsen materially
