# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, capture
  termination, and no reported instability. They are exact trajectory-level
  replications of the assigned terminal-rudder-relief parent: each captures at
  `24.326511T` and `0.749329L`, has mean distance `2.224097L`, scores
  `-0.325310`, and uses 4,423 steps. This is strong fixed-pose repeatability,
  not evidence of robustness to another pose or hydrodynamic condition.
- The complete `solver_392ed1eddf30` sheet shows active self-propulsion from
  rest through capture. Its top-down row develops a regular alternating
  red/blue caudal street along a continuously closing curved path, and its
  oblique row retains discrete three-dimensional Lambda2 structures at
  `8T`, `16T`, `24T`, and capture. The assigned-parent
  `solver_d802465f301b` top-down row agrees, but its oblique row is blank; that
  is a rendering failure and cannot independently support a 3D-wake claim.
- The repeated trajectory retains the parent's narrow terminal weakness. The
  crossing margin is only `0.000671L`, while reconstructed full head-relative
  target error is about `1.307 rad`. From `23.50T` to capture the distance
  falls from `0.968L` to `0.749L`; short-window folded-bearing rate alternates
  with the beat but is target-correcting near `23.50T` (about `-1.23 rad/T`)
  and again over the final samples (about `-0.15 rad/T`), while closing speed
  is only about `0.16L/T` at crossing. The successful carrier remains active,
  so this supports an allocation test on posterior mean steering rather than
  drive suppression or another global rudder-gain edit.
- The inherited response comparison supplies the sign boundary: adding up to
  20% rudder during a closing deficit delayed capture to `24.414513T` and
  raised terminal effort, whereas removing up to 20% advanced capture to the
  replicated `24.326511T` result without increasing force, moment, or rate-cap
  occupancy. The older same-sign C-bend and direct recent-yaw unloading remain
  negative controls: do not reverse the evidenced rudder sign, reshape the
  carrier mean, or suppress rhythmic motion.

## One candidate hypothesis

Add one response-conditioned allocation layer to the replicated parent. Keep
the joint-state traveling carrier, slip-aware anterior center, full-angle
half-cycle redistribution, distance/error-gated opposite-sign posterior
rudder, and the evidenced closing-deficit relief unchanged. Inside a new
smooth `1.5--0.9L` approach gate, use the sign and magnitude of normalized
short-window folded-bearing rate to detect when target angle is already moving
toward zero. Smoothly release at most another 10% of only the posterior rudder
in that condition; leave the carrier and anterior actuation untouched. This is
a line-of-sight response allocator, not scalar tuning of the drive or the
successful rudder schedule.

Falsify the mechanism if capture is lost or later than `24.326511T`, mean
distance exceeds `2.224097L`, the crossing margin does not widen beyond
`0.000671L`, final full target error exceeds about `1.307 rad`, or the coherent
wake, terminal effort, rate-cap occupancy, and `0.03165/0.01638` peak
force/moment envelope materially worsen. Because `bearing_window_rate` spans
only the observation history and still contains beat-scale motion, reject the
mechanism rather than retune it if it phase-chops the posterior carrier or
changes the trajectory before `1.5L`.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal pursuit or capture scheduling
source_mechanism: preserve a rhythmic propulsive carrier while measured line-of-sight response continuously unloads steering that is no longer needed for target-directed rotation
transferable_invariant: separate propulsion from steering allocation and reduce only the steering mean when normalized body-frame target angle is already correcting near capture
nontransferable_details: published CPG gains, robot linkage geometry, species-specific kinematics, dimensional frequencies, prescribed maneuver timing, exact vortex phases, and task-specific routes
policy_translation: joint state retains the two-joint traveling carrier; normalized distance gates the approach regime; target-side sign times short-window body-frame bearing rate gates a bounded additional reduction of the existing posterior rudder
falsification: reject if capture is later or lost, crossing depth and alignment do not improve, the route changes before 1.5L, or wake, saturation, effort, force, or moment envelopes worsen
