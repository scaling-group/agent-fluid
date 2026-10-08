# Candidate diagnosis and hypothesis

## Evidence diagnosis before the policy edit

- The assigned parent guidance preserves the traveling-wave carrier,
  joint-phase-demodulated yaw feedback, phase-selective posterior relief, and
  a narrow outward-speed guard. It specifically rejects scalar carrier
  reduction, static anterior centering, posterior mean bursts, and raw
  short-window yaw as a directional-response signal.
- All four sampled rollouts use direct uniform still-water initialization
  (`U_infinity=0`) with no cylinders or prewarm and terminate in capture. The
  three `3323ffe...` samples are exact repeats at `16.609995T`, score
  `-0.115560`, and `1.999656L` distance integral. The assigned solver parent
  `452903d...`, which additionally removes fitted anterior-phase sway from
  posterior course and crossflow, captures at `16.604496T`, improves score to
  `-0.113729`, and lowers the distance integral to `1.998146L`. Its peak
  planar force/moment is slightly higher (`0.037165/0.018356` versus
  `0.035828/0.017759`), so this is a narrow route improvement rather than
  evidence for stronger actuation.
- In both top-down sheets the fish advances under its own alternating,
  tail-connected vorticity street and follows the same target-crossing arc;
  there is no passive advection or wake breakup. In both oblique Lambda2
  sheets, compact alternating structures remain attached to the posterior
  body through capture, with no visible instability. The sampled set contains
  no semantic failure; the exact triplicate is the informative non-improving
  comparator, not independent robustness evidence.
- Reconstructing the parent's phase-demodulated inertial line-of-sight rate as
  `-(target x directional_velocity)/distance^2` gives mean absolute rates of
  `0.0274/T` beyond `6.5L`, `0.0690/T` from `3--6.5L`, and `0.2036/T` inside
  `3L` (near-target 90th percentile `0.4127/T`). Its sign reverses five times
  inside `3L` while the fish remains strongly propulsive. The terminal issue
  is therefore a rapidly rotating target line during a successful beat, not
  missing thrust or a case for scalar wave relief.

## Policy hypothesis

Preserve the evaluated parent exactly outside the existing approach gate. On
approach, form an inertial line-of-sight rotation from the already
phase-demodulated body-frame target and velocity vectors, smoothly bound it,
and add it as feedforward to the desired physical yaw rate. This is a single
response-level mechanism: requested yaw follows the moving target line while
the existing yaw residual and posterior half-cycle channel remain responsible
for actuator translation. It adds neither a clock nor a world-frame route and
does not change carrier amplitude, curvature limits, or the speed guard.

Expected test: retain the parent's capture arc and connected 3D wake while
reducing late bearing reversals, distance integral, or arrival time without
raising joint contact, acceleration residence, force, or moment. Falsify the
mechanism if capture is lost, the far route changes before `6.5L`, the wake
disconnects, late LOS rotation is not reduced, or any trajectory/load/effort
metric regresses materially.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking
source_mechanism: sensor feedback modulates directional response around rhythmic locomotion
transferable_invariant: preserve the traveling carrier while a bounded observed route-response rate continuously advances or releases steering
nontransferable_details: published CPG gains, species kinematics, exact vortex phase, dimensional turn rate, and task-specific routes
policy_translation: within the existing approach gate, feed a bounded phase-demodulated body-frame line-of-sight rotation into desired yaw rate, leaving carrier and actuator envelopes unchanged
falsification: reject if the completed rollout loses capture or the parent approach, changes the far route or connected wake, retains late target-line reversals, or worsens joint contact, saturation, force, moment, effort, or score
