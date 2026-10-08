# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled solver evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, capture
  termination, and no reported numerical instability. Their trajectory CSVs
  are byte-identical despite comment-only policy differences. Each captures at
  `24.326511T` and `0.749329L`, has mean scored distance `2.224097L`, and
  scores `-0.325310`. This is deterministic fixed-pose replication of the
  assigned parent's terminal-rudder-relief result, not evidence of held-out
  robustness.
- The complete `solver_392ed1eddf30` visual pair shows active propulsion: the
  top-down row develops an alternating red/blue caudal street while distance
  closes continuously, and its oblique row retains discrete three-dimensional
  Lambda2 structures through capture. `solver_cb5a6b73ffd9` and the prefill
  `solver_d802465f301b` have blank oblique rows and approximately 2 KB oblique
  videos. Those are visualization failures and cannot independently support a
  3D-wake claim; their exact trajectory agreement may still support the
  deterministic control comparison.
- The replicated trace retains the inherited load envelope: peak normalized
  planar force/yaw moment are `0.031649/0.016385`, and mean action norm below
  `1.5L` is about `42.934`. The target remains poorly aligned at capture:
  reconstructed full head-relative error is `1.307 rad`, while instantaneous
  heading rate is `-1.456 rad/T`. Below `1.5L`, the seven-sample
  `bearing_window_rate` scale reconstructed from the trajectory has mean
  absolute value `0.967 rad/T` and RMS `1.209 rad/T`; target-signed bearing is
  decreasing during only `44.5%` of samples and increasing during `55.5%`.
- The inherited matched response test remains the informative negative result.
  Adding up to 20% rudder during low one-step closing speed delayed capture to
  `24.4145T`, tightened the threshold crossing to `0.749996L`, and raised
  terminal effort, whereas removing up to 20% advanced capture by two control
  steps without changing peak loads. That establishes steering allocation as
  the useful channel but leaves the one-step closure trigger causally
  ambiguous. The older same-sign posterior C-bend is the route-control
  counterexample: it retained propulsion but produced wrong-sign mean yaw,
  missed at `3.692L`, and exited low. Therefore the posterior load sign and
  carrier must remain intact.

## One candidate hypothesis

Replace the one-step closing-deficit trigger with a response-aligned terminal
rudder allocation. Below `1.5L`, use the existing seven-sample body-frame
`bearing_window_rate` to detect when the target-side bearing is already
decreasing. Smoothly remove at most 20% of only the posterior mean rudder in
that condition; retain full rudder when bearing is static or worsening and
retain the joint-state carrier at all times. A `0.75 rad/T` full-response scale
is inside the observed terminal rate envelope, and the distance gate reaches
full authority by `0.9L`, so the established far and middle route is unchanged.
This tests a new derivative-response mechanism rather than another carrier or
rudder gain.

Falsify the candidate if it loses capture, arrives later than `24.3265T`,
raises mean distance above `2.224097L`, or materially worsens terminal full
target error, joint-rate occupancy, action effort, the `0.031649/0.016385`
force/moment envelope, or the coherent complete oblique wake. Also reject the
mechanism if the controller changes before `1.5L` or if alternating response
gating visibly damages the traveling wake. A fixed-pose improvement would not
establish robustness to another target pose or hydrodynamic condition.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal approach scheduling
source_mechanism: preserve the rhythmic carrier while sensor feedback unloads only a steering offset after the requested directional response appears
transferable_invariant: separate propulsion from steering and condition terminal steering allocation on target-error response rather than on effort or geometry alone
nontransferable_details: published CPG gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, prescribed maneuver timing, exact vortex phases, and task-specific routes
policy_translation: normalized distance gates a bounded reduction of the existing posterior rudder only when target-signed body-frame bearing is decreasing over the provided observation window; joint state continues the inherited carrier
falsification: reject if capture is lost or later than 24.3265T, mean distance exceeds 2.224097L, terminal alignment does not improve, or wake, saturation, effort, force, or moment envelopes worsen
