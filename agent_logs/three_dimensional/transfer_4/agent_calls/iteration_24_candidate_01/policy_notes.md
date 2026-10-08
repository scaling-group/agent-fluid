# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=0`, capture termination, and complete top-down mid-plane plus
  oblique Lambda2 evidence. There is no prewarm artifact.
- The top-down and oblique rows for the finite leader
  `solver_f5d69a1ef633` show self-propelled motion with a coherent alternating
  traveling wake from release through capture. The informative null comparator
  `solver_a75510758521` is visually indistinguishable and is numerically
  episode-equivalent to the `v12` baseline despite its terminal reserve-work
  partition. Thus neither the wake topology nor scalar-only retuning motivates
  another transit edit.
- Relative to the repeated `v12` baseline, the leader's alignment-qualified
  posterior envelope preserved capture and nearly identical mean distance
  (`1.950801L` versus `1.950823L`) while reducing final speed
  (`0.8511U` versus `0.8902U`), final yaw magnitude
  (`0.4200` versus `1.0891 rad/T`), and raising final course alignment
  (`0.1818` versus `0.0678`). It also slightly reduced RMS yaw, force, moment,
  posterior rate residence, and posterior acceleration-ceiling residence.
  This is a small but internally consistent terminal-state improvement, so the
  leader's carrier, odd curvature map, and posterior terminal envelope are the
  behavior to preserve.
- The assigned parent guidance records that adding signed course error directly
  to terminal curvature kept the same transit and wake but regressed score and
  mean distance to `-0.064645/1.950875L`, reduced final alignment to `0.1640`,
  and increased final yaw magnitude to `0.5884 rad/T`. This is the informative
  mechanism failure: a cross product chooses a turn side but does not say
  whether the body already has enough angular response. The inherited
  score-only captures from later workers (`-0.064862`, `-0.064888`,
  `-0.064995`, and `-0.065308`) contain no matching policy or trajectory
  evidence here, so they constrain claims but cannot identify a mechanism.

## Policy hypothesis

Use the sampled `v16` alignment-qualified posterior envelope as the base.
Inside the existing normalized approach gate only, compute signed course error
from the cross product of body-frame velocity and the body-frame target unit
vector. Map that error to a bounded, deliberately modest desired yaw rate, and
blend it into the existing target-yaw-rate loop before subtracting measured
recent turn rate. This turns the failed direct-curvature command into yaw-rate
tracking: when measured yaw is already faster than the course request, the
same signed course error produces braking rather than additional bend. The
authority is exactly zero at and beyond `2.10L`, so transit cadence, route
feedback, mean steering, and the two-joint traveling-wave target are unchanged.

Expected result: retain the coherent two-view wake, capture, and sampled-best
far/middle distance history while improving terminal course alignment or yaw
without increasing the leader's saturation/load class. Reject the mechanism
if pre-approach closure changes, capture or mean distance regresses materially,
terminal alignment/yaw does not improve together, either view loses the
traveling wake, or reflected geometry fails to reflect the course response.

bookshelf_consulted: true
source_domain: cross-domain robotic-fish steering and terminal capture
source_mechanism: schedule near-target yaw and slip damping without removing the propulsive traveling wave
transferable_invariant: turn signed course error into a bounded desired angular response and close it around measured yaw, with continuous near-target authority
nontransferable_details: published gains, species-specific gait envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: blend a normalized body-frame velocity-to-target course request into the existing desired-yaw-rate feedback only inside the observed approach region; preserve the two-joint carrier and posterior lag
falsification: reject if transit changes, capture or distance integral worsens, yaw and alignment do not improve jointly, saturation or loads rise, wake coherence is lost, or reflection equivariance fails
