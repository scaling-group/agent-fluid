# Multi-wake target-policy candidate notes

## Visual diagnosis before the edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. It is byte-common initial-state
  evidence, not support for a fixed phase, cylinder coordinate, or route.
- All four current released sheets are finite target captures; no sampled
  failure keyframe is available. Each shows an immediate body-generated
  traveling wake, active diagonal down-left swimming rather than downstream
  advection, and one broad correction through the merged wake region into the
  capture circle. The strongest policy's `-10.962L` upstream head displacement
  and `target_reached` termination agree with that visual diagnosis.
- The assigned parent reaches at `45.2595` with score `0.165009`, mean distance
  `1.71529L`, command-energy mean `1030.54`, and force/moment RMS
  `438.82/4341.50`. Three distinct sampled solvers add a body-frame time-to-go
  cap to the heading-response prediction and reproduce exactly the improved
  `45.2210`, `0.165860`, `1.71458L`, and `1030.39`; loads are effectively
  unchanged at `439.16/4344.77`. Their released sheets preserve the parent's
  route topology. This is fixed-snapshot evidence for a terminal tracking
  improvement, not for wake robustness or load reduction.
- Both variants still reach about `4.538` rad/time joint-rate magnitude and
  approach the candidate soft acceleration limit. The inherited quantitative
  failure boundary—a broader propulsion allocator passed below capture and
  collided at `58.93` after a `1.872L` closest approach with `537/4995` RMS
  loads—argues against changing the base wave or posterior allocation. No
  unavailable failure image is inferred.

## Policy hypothesis

Adopt exactly the sampled terminal prediction scheduler on the assigned
parent. Preserve the zero-centered oscillator, posterior lag, yaw-gated
half-cycle steering, positive normalized-closure residual, rate-and-yaw gate
on positive course amplification, and full negative course correction. Limit
the heading-rate extrapolation horizon by remaining normalized body-frame
distance divided by observed body-speed magnitude. Far from capture the policy
is unchanged; near capture it does not project the current turn beyond the
available approach time.

The three matched rollouts support preserving capture with a small arrival,
mean-distance, and effort improvement under the shared wake snapshot. Falsify
this candidate if a later changed-wake evaluation loses capture or diagonal
topology, regresses beyond the `45.2595`/`1.71529L` parent without compensating
load relief, or returns to the inherited below-target collision family.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG path following and terminal capture control
source_mechanism: preserve a low-dimensional propulsive rhythm while scheduling residual turn prediction by observed remaining approach time
transferable_invariant: do not extrapolate measured yaw response farther than the normalized time remaining to close current body-frame range
nontransferable_details: published gains, dimensional frequencies, species-specific gait envelopes, exact vortex phases, cylinder coordinates, capture geometry, and task-specific routes
policy_translation: cap the existing heading-response horizon by `distance_L / max(hypot(velocity_body_U...), body_speed_floor)` before bounded bearing feedback while leaving both joint-state-feedback accelerations and propulsion allocation unchanged
falsification: reject if capture or diagonal topology is lost, arrival or mean distance regresses beyond the parent without material load relief, or terminal steering produces the inherited below-target pass
