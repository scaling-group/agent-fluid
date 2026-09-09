# Candidate diagnosis and hypothesis

## Prior evidence

- All four sampled evaluations report direct uniform initialization in still
  water (`U_infinity=(0,0,0)`) with no cylinders or prewarm snapshot.  Both the
  top-down mid-plane row and the oblique Lambda2 row were inspected for every
  sample before this proposal.
- The bounded compact bearing/curvature sample `solver_b6bb94d9cdaf` has the
  best sampled score (`-7.6367`).  Its alternating wake is coherent in both
  views and it self-propels leftward, reducing distance from `12.3277L` to
  `5.3570L`, but it overshoots the required downward course and exits at the
  upper boundary (`center_y=15.2024L`, final distance `5.8935L`).  At `16T`,
  reconstructed normalized body-frame course is about `+0.52 rad` while target
  bearing is about `-0.66 rad`; bearing-only steering has not arrested the
  inertial course error.
- The branch-heavy sign-flipped transfer `solver_e450df1efa49` makes the closest
  sampled pass (`4.1281L`) while retaining a strong visible wake, but passes
  left above the target and diverges to `9.1538L`.  Its requested accelerations
  exceed the `31.4 rad/T^2` physical envelope on most rows according to the
  inherited analysis, so its closest pass does not justify copying its gains or
  branch structure.
- The response-release sample `solver_59bc4ebdddec` also retains a coherent
  wake and makes monotone distance progress to `7.5311L`, yet exits the same
  upper boundary.  Releasing curvature from a very short bearing-rate window
  therefore does not resolve the course topology.
- The assigned prefill parent `solver_d146183ecace` is the informative failure.
  Its top-down frames show little translation through `4T`, followed by a tight
  clockwise/upward arc; the oblique row shows only a short developing wake
  before exit at `8.646T`.  It improves closest distance by only `0.1020L`, then
  exits at `center_y=15.2002L` with final distance `12.7468L`.  The policy calls
  `turn_rate_recent`, but this evaluator aliases that field to instantaneous
  `heading_rate`; sampled values reach beat-scale magnitudes near `-2.38 rad/T`
  and repeatedly reverse sign.  Thus its yaw-rate-error loop is not a
  cycle-mean response estimate and churns posterior curvature near the command
  bound while the unchanged anterior oscillator supplies little early course
  authority.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and classical fish mean-curvature turning
source_mechanism: preserve the rhythmic propulsive oscillator while slow target geometry modulates a bounded distributed bend; do not cancel every fast lateral/yaw oscillation
transferable_invariant: separate persistent route error from beat-scale motion and steer by a bounded body-relative directional mismatch without replacing the traveling wave
nontransferable_details: published CPG gains, species-specific envelopes, dimensional cadence, prescribed vortex phase, and task-specific routes
policy_translation: retain the sampled joint-state oscillator and posterior lag; speed-gate a normalized target/course cross-product and map it directly to bounded posterior mean tangent plus a small opposite anterior acceleration, with no instantaneous yaw-rate feedback
falsification: reject if target/course mismatch does not contract after forward speed develops, closest distance does not beat the assigned parent, the upper/lower exit topology is unchanged, or wake coherence and joint/command-limit residence worsen

## Candidate hypothesis

The controller will use only normalized body-frame target and velocity vectors
to form `sin(target_course_error)`.  At release it smoothly falls back to target
lateral geometry because course is undefined; once forward speed develops, the
cross-product is invariant to rigid heading and directly corrects the direction
of travel.  Removing the instantaneous yaw-rate servo should prevent beat-scale
sign reversals.  Restoring the compact sample's small anterior steering share
should preserve the traveling-bend propulsion that the posterior-only parent
lost.  No distance-based terminal schedule is introduced because no sampled
rollout entered the `0.75L` capture regime.
