# Evidence-selected response-gated distributed C-bend candidate

## Visual diagnosis recorded before the policy edit

- All four sampled evaluations report direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The combined keyframe
  sheets were inspected in both the top-down vorticity and oblique Lambda2
  rows. Translation and the alternating wakes are self-generated, not imposed
  advection or moving-window motion.
- The response-gated and collision-course-gated distributed C-bends are the
  only sampled captures. Both retain a coherent alternating top-down street
  and compact three-dimensional Lambda2 structures throughout the approach,
  terminating at `19.585T` and `19.784T` with distances `0.7487L` and
  `0.7480L`. Their small local-flow RMS (`0.01825U` and `0.01842U`) confirms
  that capture comes from self-propulsion plus route feedback.
- The assigned-parent guidance identifies posterior-only LOS-rate steering as
  a useful but incomplete broad approach. The sampled phase-conditioned
  posterior-only controller likewise makes a coherent wake but turns upward,
  reaches only `5.658L`, and exits at `16.77T`. Distributed mean curvature is
  therefore a semantic actuator-allocation improvement, not scalar-only
  carrier tuning.
- The prefilled safe-intercept release is now a completed negative result. It
  preserves a coherent wake but suppresses desired yaw and posterior residual
  curvature when an instantaneous constant-velocity miss estimate appears
  safe. It then passes above the target, reaches only `1.7117L` at `19.844T`,
  and exits left at `28.897T`. Its raw acceleration-envelope occupancy
  (`60.6%/76.4%`) and force/moment RMS (`0.01580/0.00812`) also exceed the
  response-gated capture's `39.5%/71.6%` and `0.01261/0.00661`. Continued
  acceleration and yaw invalidate the coasted constant-velocity prediction;
  this is a control-release failure, not wake collapse.
- Between the two captures, the response-gated controller is the stronger
  completed choice: it arrives about `0.20T` earlier with lower acceleration
  occupancy, force RMS, and yaw-moment RMS. There is no sampled evidence for
  changing its carrier gains or adding a second terminal mechanism.

## Policy hypothesis recorded before editing

Replace the failed safe-intercept release with the completed response-gated
distributed C-bend exactly. Preserve the `28 degree`, `0.55T` joint-state
traveling wave, normalized body-frame bearing, rotation-invariant LOS rate,
phase-conditioned posterior curvature, and the bounded anterior oscillator-
center shift recruited by large bearing or bounded route-response demand. In
particular, do not suppress route demand from an instantaneous predicted miss:
let the observed bearing-plus-LOS response release or reverse the shared bend
continuously while propulsion remains active.

Expected evidence is reproducible capture near `19.6T`, a coherent long wake,
and force, moment, and raw acceleration occupancy comparable to the sampled
response-gated rollout. Falsify this selection if capture does not reproduce,
the route returns to a more-than-`1L` high pass or early curl, wake coherence
degrades, or loads and envelope occupancy materially exceed the completed
baseline. Under a later held-out wake disturbance, also falsify it if the
memoryless LOS response confuses fast wake-induced yaw with persistent route
error; that would motivate a separately evidenced disturbance residual rather
than another collision-course release.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish sensor-modulated CPG direction tracking
source_mechanism: observed route demand recruits bounded distributed mean curvature on a persistent propulsive rhythm and releases or reverses it with measured response
transferable_invariant: preserve the traveling wave while normalized target geometry and rigid-body response continuously recruit bounded steering across available joints
nontransferable_details: published gains, species-specific C-start timing and shapes, robot linkage geometry, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame bearing plus rotation-invariant LOS rate to gate and sign the anterior oscillator-center shift while phase-conditioned yaw error drives bounded posterior mean curvature in the two-joint state-feedback contract
falsification: reject if capture fails to reproduce, the high pass or an early curl returns, the coherent carrier degrades, or acceleration and load occupancy materially worsen
