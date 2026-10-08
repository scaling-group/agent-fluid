# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common held-fish prewarm sheet shows the same four developed,
  interacting vortex streets for every candidate.  The fish begins above and
  to the right of the target, outside the organized second-row corridor, so
  this shared initial condition does not justify a fixed route or vortex phase.
- The inherited static-mean-curvature failure remains on the far-right side in
  a compact loop for the full `300`-unit horizon.  Its head displacement is
  only `(-1.19,-3.78)L`, its closest/final distances are `10.28/10.48L`, and it
  never enters the useful wake corridor despite a low `270.96` RMS yaw moment.
  Low load without target-directed translation is therefore not progress.
- The two duplicate anterior-only, zero-mean half-cycle policies both reach the
  target in `179.22` units, with `5.04L` mean distance, `18.42` RMS lateral
  force, and `338.91` RMS yaw moment.  Their identical finite outcomes support
  preserving target-bearing half-cycle asymmetry and the posterior-lagged
  traveling bend instead of reopening static curvature or scalar gait tuning.
- The slower policy that also modulates the posterior half-cycle reaches the
  target only after `268.49` units and has `8.04L` mean distance.  Its lower
  `273.01` RMS moment and `30.34` mean power proxy show that lower effort alone
  does not compensate for the long, visibly meandering approach.
- Adding a small normalized yaw-moment residual to the anterior-only policy is
  a positive controlled comparison: arrival improves from `179.22` to `149.57`
  and mean distance from `5.04L` to `4.38L`, while RMS lateral force falls from
  `18.42` to `16.22` and RMS yaw moment from `338.91` to `314.99`.  The released
  sheet confirms a shorter target-reaching path through the wake rather than a
  scalar-only benefit.  Relative crossflow rises slightly (`0.1333` to
  `0.1362`) and peak anterior acceleration rises from `30.40` to `30.92`
  rad/time^2, already about `98%` of the `1800 deg/time^2` limit, so increasing
  load gain or gait authority is not the supported next move.
- The best sheet still shows successive cross-track direction changes during
  the middle and final approach.  Because target success is established and
  the moment residual already reduces load, the remaining narrow hypothesis is
  that the route command holds a turn too long as body-frame bearing converges.

## Candidate hypothesis

Keep the best sampled oscillator, posterior lag, target-bearing half-cycle
asymmetry, and softly saturated yaw-moment residual unchanged.  Add bounded
derivative damping from the existing windowed body-frame bearing rate only to
the slow route request.  Normalize the rate as the predicted bearing change
over one control period divided by the same bearing scale used for route error;
this avoids a dimensional gain or a case-specific time scale.  A converging
bearing rate then releases steering before overshoot, while a diverging rate
adds a small corrective request.  The moment residual remains a separate fast
wake-load channel, and the final combined turn request stays clipped to the
same envelope as the successful parent.

The later rollout should retain target capture and upstream translation while
reducing visible route zigzags, arrival time, or distance integral without
raising load or saturation.  Reject the addition if it slows or loses capture,
recreates looping or domain exit, damps a necessary target turn, raises the
existing near-limit acceleration/load metrics, or produces no trajectory
change beyond the deterministic parent.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking combined with wake-adaptive swimming
source_mechanism: sensor-mediated damping of a rhythmic route command while a separate bounded load residual handles faster wake torque
transferable_invariant: persistent body-frame bearing should set mean route authority, while the observed rate of bearing convergence should release that authority before overshoot without cancelling the propulsive wave
nontransferable_details: published gains, dimensional filter windows, robot linkage geometry, species-specific gait envelopes, clock-driven CPG phase, exact vortex phase, cylinder coordinates, and source-task routes
policy_translation: retain the evidenced zero-mean anterior half-cycle controller and moment residual, and add a softly bounded one-beat normalized `bearing_window_rate` term only inside the body-frame route request
falsification: reject if semantic success, upstream thrust, or arrival degrades; if route reversals, distance integral, and load metrics do not improve; or if joint acceleration clipping increases

## Pre-evaluation contract audit

A joint-only semi-implicit parity grid (not CFD and not new rollout evidence)
tested fixed bearings `-0.5/0/+0.5` rad, windowed bearing rates
`-0.8/0/+0.8` rad/time, and normalized moments `-0.08/0/+0.08`.  Peak
anterior/posterior angles were `23.15/19.68 deg`, speeds were
`192.09/163.76 deg/time`, and raw accelerations were
`1771.27/1455.20 deg/time^2`, within the formal `45/260/1800` envelope.  The
combined turn remains clipped to the successful parent's range, so the added
route damping does not expand the commanded half-cycle envelope.  A static
schema audit also confirms that every direct `params.FIELD` reference is
returned by `target_policy_params()`.

The required guidance and solver-boundary checks pass.  The configured Julia
contract command was attempted but this environment has no `julia` executable,
so it failed before loading the candidate; the parity calculation is only a
bounded-equation audit and does not establish hydrodynamic success.
