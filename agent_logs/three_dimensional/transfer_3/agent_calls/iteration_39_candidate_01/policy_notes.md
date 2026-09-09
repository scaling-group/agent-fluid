# Posterior speed-headroom candidate

## Visual and metric diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no prewarm
  and no cylinders. Each terminates by capture at `18.6560--18.7330T`. I read
  every combined sheet from release through termination. In both the top-down
  mid-plane row and the oblique Lambda2 row, the fish creates its own compact,
  alternating caudal wake by `4T`, follows the same shallow corrected route,
  and reaches the target without wake breakup, collision, boundary contact, or
  instability. Body speed at `4T` is `0.534--0.536U` and local-flow RMS is
  `0.01804--0.01816U`, so progress is self-propelled rather than advection.
- The two exact actuator-consistent samples bracket normal same-policy route
  variation: capture at `18.6725T` and `18.7330T`, score `-0.13219` and
  `-0.13142`, mean distance `2.02018L` and `2.01959L`, posterior action RMS
  `28.77` and `28.72 rad/T^2`, posterior acceleration-limit occupancy
  `75.46%` and `75.19%`, and force/moment RMS
  `0.01331--0.01335 / 0.00693--0.00695`. The helpful-moment prefill captures
  at `18.6560T`, but its `0.0165T` edge is below the exact-policy timing spread
  and its `28.77 rad/T^2`, `75.74%`, and `0.01328/0.00691` effort/load values
  do not separate. The inherited notes and exact-policy repeat likewise show
  that instantaneous physical-yaw allocation is not a robust improvement.
- One-sided joint-rate anti-windup is the useful assigned-parent mechanism.
  The sampled rollout captures at `18.7000T` on the same visible route while
  lowering posterior returned-action RMS to `28.24 rad/T^2` and acceleration-
  limit occupancy to `73.91%`; its `0.01333/0.00694` force/moment RMS remains
  in the productive envelope. Two inherited completed anti-windup candidates
  also terminate by capture (scores `-0.14324` and `-0.13666`), establishing
  route robustness but not a repeated score or speed advantage.
- The residual is specifically a posterior speed-envelope issue, not joint-
  angle windup. Across current samples, `|q2|` peaks at only
  `0.620--0.646 rad`, below the `pi/4` hard angle, while `|qdot2|` occupies the
  `260 deg/T` rate limit for `7.05--7.39%` of rows. In the two exact samples,
  outward posterior acceleration persists above `95%` of the speed limit for
  `8.60--8.87%` of rows. Hard-boundary anti-windup removes infeasible outward
  work only after headroom is gone; a continuous headroom projection can test
  whether approaching the boundary smoothly further reduces clipping without
  altering the route controller or carrier.

## Policy hypothesis recorded before the policy edit

Produce exactly one candidate by restoring the plain actuator-consistent
route (removing the unsupported helpful-moment residual) and adding only a
posterior, one-sided speed-headroom projection. Preserve normalized body-frame
bearing-plus-LOS-rate guidance, the traveling two-joint carrier, distributed
C-bend, response-reversing half-cycle steering, persistent same-side phase
recruitment, coefficient rotation, anterior command, and componentwise
acceleration clamp. When `|qdot2|` rises above a parameter-owned fraction of
the physical rate limit, smoothly taper only acceleration with the same sign
as `qdot2`; opposite-sign braking remains untouched. Continue to use the raw
same-side posterior demand as the phase-persistence witness while the taper is
active, and release that witness immediately when demand reverses. The gate is
reflection-equivariant because speed magnitude is invariant and acceleration
and joint velocity reverse together.

A later evaluation supports the mechanism only if it preserves capture within
the inherited `18.6725--19.0520T` route band, mean distance no greater than
`2.02129L`, coherent self-propelled wakes in both views, and force/moment RMS
no greater than `0.01350/0.00703`. It should reduce posterior returned-action
RMS below `28.72 rad/T^2`, acceleration-limit occupancy below `75.19%`, or
rate-limit residence below `7.05%` without weakening reverse braking. Falsify
it on route delay/loss, wake weakening, load growth, or no effort/residence
separation; then retain hard-boundary anti-windup or restore the plain feasible
projection rather than tuning the taper threshold. The candidate's CFD result
occurs only after this worker exits and is not claimed here.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-envelope gait design
source_mechanism: preserve a coordinated rhythmic carrier while joint-state feedback continuously allocates command inside actuator headroom
transferable_invariant: keep the posterior-lagged traveling bend primary; near a measured joint-speed boundary reduce only same-direction acceleration while retaining full reverse braking and route feedback
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, full-body waveforms, exact vortex phases, hardware-specific limits, and task-specific routes
policy_translation: retain normalized body-frame LOS feedback and the two-joint phase actuator, then apply a bounded posterior taper driven by normalized observed joint speed and the signed acceleration-velocity product
falsification: reject if capture leaves the replicated route band, either wake weakens, braking or phase reversal is impaired, load exceeds the inherited envelope, or posterior effort and rate-limit residence do not separate from the plain route
