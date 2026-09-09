# Response-damped half-cycle course candidate

## Evidence read before the policy edit

- All four sampled rollouts use direct uniform initialization in still water
  (`U_infinity=(0,0,0)`), without cylinders or prewarm. Their motion and wakes
  are self-generated; every rollout remains finite and ends by leaving the
  virtual domain.
- Both rows of the combined sheets show that `solver_adc862529891`,
  `solver_b22e8cf1f277`, and the assigned prefill
  `solver_4c50eba7cd00` retain an alternating top-down vortex street and
  compact oblique Lambda2 structures. The best-score sample exits the upper
  boundary at `16.77T` after reaching `5.658L`. The raw-slip and
  phase-separated-slip policies improve closest approach to `4.158L` and
  `4.128L`, but both pass the target's x station about `4.1L` high and exit
  left near `29.5T` at final distances of `9.037L` and `9.051L`.
  Their small local-flow RMS (about `0.019U` axial and `0.007U` lateral) and
  intact wakes make this a steering-topology failure rather than advection,
  numerical instability, or lost propulsion.
- The assigned prefill is a direct negative test of lateral recoil projection
  as a complete fix: replacing raw lateral velocity with
  `v_y + 0.11*phi_dot1 - 0.035*phi_dot2` changes the minimum by only `0.030L`
  and leaves the same left-exit topology and final range. The projection is a
  useful observation transform, but another mean-curvature course loop does
  not create the missing route authority.
- A completed inherited log supplies the actuator counterexample
  `solver_f02c0fe79142`. Direct phase-separated course-to-posterior half-cycle
  asymmetry on the same `28 degree`, `0.55T` carrier produces a tight turn in
  both visual rows, reaches only `11.994L`, and exits upward at `8.66T` near
  `x=19.85L`. Thus half-cycle asymmetry has ample turn authority, but an
  undamped course command carries yaw momentum through alignment and is not a
  safe drop-in replacement for mean curvature.
- Returned actions are adapter-limited in the strong-carrier samples (the
  prefill's raw anterior/posterior accelerations exceed the acceleration
  envelope in `3115/5392` and `3986/5392` rows). This candidate preserves the
  already evaluated carrier rather than claiming an unevaluated scalar fix;
  its isolated change is the feedback path and steering actuator.

## Policy hypothesis recorded before editing

Preserve the evidenced traveling-bend carrier and the cross-rollout joint-rate
projections for lateral course and rigid yaw. Form a full target-course minus
phase-separated measured-course error, convert it to a bounded desired yaw
rate, and compare that demand with phase-separated observed yaw. Use the yaw
response residual—not course error directly—to set posterior half-cycle
asymmetry. The inherited half-cycle rollout calibrates positive asymmetry
request to decreasing heading; when measured yaw becomes more negative than
the demand, the residual reverses the asymmetry and supplies the braking that
the direct half-cycle controller lacked. This tests one compact combination:
response-damped asymmetric steering on the unchanged propulsive rhythm.

Expected evidence is the same long coherent wake and strong minus-x travel,
an initial downward course change, asymmetry reversal before a tight upper
turn, center y materially below the sampled `13.6--14.0L` near-miss band, and
a closest approach below `4.128L`. Reject the mechanism if the short upper
exit of the direct half-cycle controller recurs, if the trajectory still
passes more than `4L` high and exits left, if the alternating wake weakens, or
if the response residual remains dominated by beat recoil.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and asymmetric flapping
source_mechanism: a sensory yaw-response residual modulates bounded half-cycle strength on a persistent propulsive rhythm
transferable_invariant: asymmetric steering needs observed turn-response feedback so the beat imbalance reverses when yaw outruns the route demand, while the traveling-wave carrier remains active
nontransferable_details: published gains, robot linkage geometry, clock-driven phase, dimensional rates, species kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity course, remove evidenced joint-rate recoil from lateral velocity and yaw rate, and map only the bounded yaw-response residual to state-identified posterior half-cycle scaling in the two-joint contract
falsification: reject if the direct-half-cycle upper-turn topology recurs, the more-than-4L high left pass remains, closest approach does not beat 4.128L, or propulsion and wake coherence degrade
