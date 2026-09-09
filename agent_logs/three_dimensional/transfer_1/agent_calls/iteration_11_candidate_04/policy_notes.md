# Candidate wake-policy notes

## Evidence diagnosis

- The evidence contract is valid for the compared rollouts: both report direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and the L64 moving-window episode.
- In the assigned-parent combined sheet (`solver_213717a6b100`), both the
  top-down mid-plane and oblique Lambda2 rows show self-propulsion with a
  coherent alternating wake through the first approach. The fish then turns
  sharply below the target instead of coasting: it reaches only `1.5454L`, its
  closing speed falls to zero near `18.24T`, and the still-active wake carries
  it to the lower virtual boundary at `30.29T`. The terminal mean-curvature
  replacement therefore preserves locomotor energy but does not supply the
  needed collision-course correction; its acceleration commands occupy the
  envelope on about `70.5%/72.5%` of rows.
- In the strongest sampled finite rollout (`solver_29faa601686c`), the same
  views show a compact, alternating propulsive wake while the path bends
  toward the target without the parent's terminal downward turn. It captures
  at `18.61T` and `0.7493448L`, with `0.9392` normalized progress. Reconstructed
  body-frame geometry is consistent with the policy mechanism: the signed
  inertial line-of-sight miss becomes large during the final cross-track
  approach, so the response-release gate restores existing shared steering.
  The assigned parent already exhibits warning values of about `0.13/T` at
  `3.31L`, `0.31/T` at `1.66L`, and `0.48/T` when closure stops at `1.545L`.
- The two rate-cascade samples (`solver_5c5f9d80447b` and
  `solver_95d1e880b3e5`) miss at `3.0031L` and `3.1135L` and exit left. They do
  not support adding another yaw-rate cascade. The evidence instead supports
  restoring the already successful line-of-sight-guarded release mechanism
  while retaining the achieved-course outer loop and traveling carrier.

## Policy hypothesis

Replace the parent's wholesale terminal transfer into static posterior mean
curvature with the sampled response-release actuator guarded by normalized
inertial line-of-sight rate. Joint-compensated yaw response may smoothly
release shared steering only while target/velocity geometry remains on a
collision course; a growing signed line-of-sight miss re-engages the same
bounded authority. Keep the propulsive carrier intact and do not add route
gain, a second rate cascade, or scalar-only gain tuning.

Falsification: reject this candidate as a robust mechanism if the released CFD
loses capture, no longer produces an alternating terminal wake, materially
increases acceleration saturation or load spikes, changes the useful early
closure, or returns to the assigned parent's lower-exit topology. Because the
only sampled capture clears the threshold by roughly `0.00065L`, later workers
must also test reproduction and held-out pose/target conditions before treating
it as robust.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: preserve a rhythmic propulsive carrier while sensor feedback modulates bounded steering authority during final approach
transferable_invariant: separate the propulsive rhythm from a continuously gated approach correction, and release correction only when an independent collision-course observation agrees
nontransferable_details: published CPG gains, robot geometry, dimensional cadence, species kinematics, exact tail phase, and task-specific routes
policy_translation: retain the joint-state traveling bend and achieved-course request; gate shared two-joint steering release with joint-compensated yaw response and body-frame target/velocity line-of-sight rate
falsification: reject if capture, coherent wake, early closure, or saturation/load behavior degrades, or if the same lower-boundary overshoot survives
