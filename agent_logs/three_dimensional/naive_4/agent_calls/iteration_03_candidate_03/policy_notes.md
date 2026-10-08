# Course-error steering candidate notes

## Evidence diagnosis recorded before the edit

- All four sampled evaluations are finite, direct-uniform still-water
  rollouts with `U_infinity=(0,0,0)`, no prewarm, and no cylinders. All four
  terminate at the upper virtual boundary (`center_y=15.200L`) before `10T`,
  so none establishes target capture or a better termination class.
- Both rows of the combined sheets show self-propulsion rather than
  advection. The top-down mid-plane views develop alternating red/blue
  vorticity and the oblique views show coherent three-dimensional Lambda2
  structures shed behind the tail. At release the field is quiescent; by
  `4T` the wakes are established, and the `7T` to termination frames show the
  bodies and wakes curling upward, away from the lower-left target. Thus the
  reusable anterior carrier and posterior traveling-wave lag should remain.
- The posterior bearing-plus-trend mean-curvature policy is still the strongest
  sampled finite trajectory: it moves the center `1.919L` leftward and
  improves minimum/final distance to `11.413/11.421L`, versus the assigned
  half-cycle parent's `11.778/11.860L`. The parent retains the visible wake
  and returns bounded accelerations, but exits earlier at `8.800T` and fails
  its inherited hypothesis of improving the `11.413L` closest approach or the
  upper-exit topology. Posterior half-cycle asymmetry is therefore a concrete
  negative result here, not evidence for another gain change.
- Closing a desired-turn-rate residual also fails to fix the topology. That
  candidate reaches only `11.858L`, exits upward at `9.532T`, and requests
  posterior acceleration beyond `1800 deg/T^2` in `69.8%` of samples, worse
  than the bearing-plus-trend policy's `54.9%`. The adapter constructs
  `turn_rate_recent` from only seven integration-history entries (about
  `0.033T`), so it remains dominated by within-beat yaw rather than providing
  the slow response assumed in the inherited note.
- Trajectory reconstruction exposes an observation mismatch shared by the
  sampled controllers. At `4T`, target bearing is still only `+0.06` to
  `+0.16 rad`, but body-frame lateral velocity is already `+0.21` to
  `+0.26 U`; one period later bearing is negative and the upward course is
  established. In the strongest sample specifically, a bounded body-course
  angle from velocity is about `+0.99 rad` at `4T` while bearing is
  `+0.13 rad`. Steering only body orientation therefore reverses too late to
  redirect the fish's inertial course.

## Policy hypothesis

Return to the strongest sampled actuator translation: preserve the anterior
Van der Pol carrier and apply a bounded mean tangent only to the posterior
lagged target. Replace the short-window bearing extrapolation and the failed
half-cycle gate with one course-error mechanism. Compute a bounded body-frame
course angle from normalized forward and lateral velocity, subtract a modest
fraction from target bearing, and map that target-versus-course error to the
posterior mean tangent. A speed floor makes this reduce continuously to pure
bearing steering at release. The translation remains reflection-equivariant,
uses no route or clock, and keeps the posterior target and both returned
accelerations inside their fixed envelopes.

The expected semantic change is earlier reversal when lateral momentum begins
to carry the fish upward: retain the alternating three-dimensional wake while
beating the `11.413L` closest approach and delaying or eliminating the upper
exit. Reject this mechanism if it suppresses leftward propulsion, causes
persistent angle/rate limiting, or repeats the same upper-exit topology
without improving distance and course alignment. The new candidate has no
same-worker CFD result.

bookshelf_consulted: true
source_domain: line-of-sight guidance for robotic fish layered on a traveling-bend propulsive rhythm
source_mechanism: target-vector steering corrected by normalized body-frame slip while posterior mean curvature modulates an existing carrier
transferable_invariant: when body heading and inertial course diverge, bounded target-versus-course error should redirect lateral momentum while leaving the propulsive rhythm intact
nontransferable_details: published gains, species-specific kinematics, clock-driven phases, dimensional speeds, exact vortex phases, and task-specific routes
policy_translation: subtract a bounded normalized body-velocity course angle from body-frame target bearing and map the result to a bounded posterior-only mean tangent around the two-joint state-feedback carrier
falsification: reject if the alternating wake or leftward progress collapses, closest approach does not beat `11.413L`, the upper exit persists without later survival, or joint-angle, joint-rate, or acceleration limiting becomes persistent
