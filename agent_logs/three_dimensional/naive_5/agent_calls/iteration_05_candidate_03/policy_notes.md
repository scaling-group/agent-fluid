# Wake-policy candidate diagnosis

## Evidence diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=[0,0,0]`, no cylinders, and no prewarm), so their
  translation, wake, and exits are controller-generated rather than advection.
- The current best approach, `solver_aaab22dcaa09`, visibly preserves a
  self-propelled alternating vorticity street and discrete three-dimensional
  caudal Lambda2 structures through `38.67T`. It improves the minimum distance
  to `4.676L`, but at the target x-station its head is still at `y=14.181L`
  rather than `9.5L`; the normalized target-versus-course cross product is
  `+0.962`. After `2T`, this course error is positive on `92.3%` of samples
  (mean `+0.604`), matching the top-down marker moving below and then behind
  the nearly horizontal wake corridor before the left-domain exit.
- The phase-rejected descendants calibrate the half-stroke sign. The
  opposite-sign selector in `solver_65e67137c3f9` reaches `5.264L` and crosses
  the target x-station at `y=14.779L`; the corrected response sign in
  `solver_aaab22dcaa09` lowers that crossing by about `0.60L` and improves the
  minimum by `0.588L`, while both retain coherent wakes and avoid the sampled
  `44 deg` anterior-angle occupancy. This supports the corrected mapping but
  shows bearing-only response is too weak to redirect the translational path.
- The prefilled course-biased raw-yaw policy, `solver_12fc3441a636`, is a
  negative control for the signal-to-actuator mapping rather than for course
  feedback itself. It exits the upper boundary at `20.79T`, reaches only
  `6.268L`, and ends with course error `+0.999`; its selector closes through a
  raw yaw measurement whose correlation with anterior joint velocity remains
  `-0.931`. Likewise, the original half-cycle policy
  `solver_0334e73ca6df` has a coherent long wake but
  `corr(heading_rate, phi_dot1)=-0.935`, crosses at `y=14.655L`, and spends
  `60.5%` of post-start samples near the joint-speed cap. Thus raw within-beat
  yaw must not arbitrate slow course correction.
- The best corrected descendant still spends `57.8%` of post-`2T` samples
  with at least one joint above `250 deg/T`, despite eliminating sampled
  `44 deg` angle occupancy. Added route authority therefore needs both angle
  and speed headroom rather than persistent bang-bang reinforcement.

## Policy hypothesis

Preserve the evidenced traveling-bend carrier, lagged posterior follower, and
explicit symmetric anterior phase pump. Retain the evidence-calibrated
phase-rejected yaw residual and corrected response-to-half-stroke sign, but
form the desired slow turn from a bounded body-frame bearing plus a
speed-gated normalized cross product between body-frame velocity and target
vectors. The latter asks whether the actual swimming course, not merely body
orientation, passes to one side of the target. Fade the added pump and
half-cycle steering continuously at both anterior angle and speed soft limits.

Expected result: once translation is measurable, the persistently positive
course error should request positive slow yaw and therefore select the
negative turn-useful half-stroke, bending the velocity vector downward while
leaving the posterior alternating wake intact. The target marker should stay
near the wake corridor, target-x crossing height and minimum distance should
improve beyond `14.181L` and `4.676L`, and speed-limit occupancy should fall.
Falsify the mechanism if course error remains strongly one-signed through the
target x-station, the upper-exit topology returns, the coherent alternating
wake collapses, minimum distance does not improve, or angle/speed saturation
remains material.

bookshelf_consulted: true
source_domain: robotic-fish sensor-feedback direction tracking with asymmetric flapping and low-dimensional rhythmic carriers
source_mechanism: preserve a propulsive traveling rhythm while bounded direction feedback allocates extra authority to the turn-useful half-cycle
transferable_invariant: separate fast gait-synchronous yaw from persistent target-versus-course error and steer through the response-calibrated half-stroke without erasing the traveling wave
nontransferable_details: published gains, linkage geometry, clock-driven CPG phase, species-specific envelopes, exact vortex timing, dimensional frequencies, and task-specific routes
policy_translation: use anterior joint velocity as observable phase, cancel its sampled contribution from normalized yaw rate, combine bounded body-frame bearing with speed-gated normalized target-versus-velocity cross product, apply the corrected response sign, and gate added anterior authority by angle and speed headroom
falsification: reject if the course error stays positive through target-x crossing, the path exits upward or passes above the target without a better minimum, the alternating wake loses coherence, or joint angle and speed saturation remain material
