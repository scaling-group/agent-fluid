# Sign-coherent curvature-conserving allocation candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver rollouts and the inherited parent rollout report
  direct uniform initialization with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. The top-down mid-plane and oblique Lambda2 sheets show body-led
  translation and alternating three-dimensional wakes, so the trajectories
  are self-propelled rather than imposed-flow advection or moving-window
  transport.
- The best sampled finite policy is the parameter-owned acceleration-feasible
  response-triggered C-bend. It captures at `19.2830T` with score `-0.18218`,
  head `(9.745,9.435)L`, action RMS `25.62/28.69 rad/T^2`, force-magnitude RMS
  `0.01340`, moment RMS `0.00699`, and local-flow RMS `(0.01761,0.00426)U`.
  Both visual rows retain a coherent alternating wake through a nearly direct
  right-side arrival. The weaker collision-course gate also captures, but at
  `19.7835T`, score `-0.20824`, and a visibly higher terminal approach.
- The inherited response-gated posterior-relief rollout is the informative
  failure. Removing `75%` of posterior mean curvature when the anterior gate
  was recruited preserves a coherent wake and remains finite, but the target
  passes below the trajectory: closest approach is `3.191L` at `19.283T`, the
  head crosses target x at `y=12.692L`, and the fish exits left at `30.096T`
  with final range `9.117L`. Its raw action-envelope occupancy is still
  `62.1%/73.2%`, so the edit neither establishes feasible effort nor preserves
  route closure. This falsifies the assumption that gate coincidence alone
  identifies duplicated posterior steering.
- The failed policy reduced posterior mean bend without compensating anterior
  mean bend and also reduced it when the anterior route request and posterior
  yaw correction could oppose one another. The evidence therefore supports
  preserving total slow curvature and retaining opposite-sign posterior
  correction; it does not support repeating posterior-relief gain tuning.

## Policy hypothesis recorded before editing

Start from the best sampled acceleration-feasible response-triggered C-bend,
including its normalized body-frame bearing and rotation-invariant LOS rate,
phase-conditioned yaw residual, continuously active anterior redirect,
posterior anti-phase/velocity-lag carrier, and componentwise physical
acceleration projection.

Add one allocation semantic. Normalize the existing anterior and posterior
mean curvatures by their owned limits and allocate posterior mean curvature
forward only when their smooth signed product is positive. Add exactly the
allocated curvature to the anterior oscillator center and subtract it from
the posterior mean target, conserving their total slow bend. When the two
requests oppose, allocation is zero, so the posterior yaw correction remains
fully active. No carrier, lag, damping, route feedback, or terminal steering
is released.

The expected result is retention of the completed capture topology with less
same-sign slow steering assigned to the propulsive posterior joint. Reject the
mechanism if capture is lost or delayed, the target-x crossing leaves the
`0.75L` corridor, posterior saturation/load does not improve, the alternating
wake weakens, or the anterior joint approaches its `45 degree` position bound.
The new candidate's CFD result is not available to this worker and is not
claimed as evidence here.

bookshelf_consulted: true
source_domain: Lighthill reactive-thrust allocation and sensor-modulated robotic-fish CPG steering
source_mechanism: preserve posterior phase-lagged propulsion while assigning only genuinely coherent slow direction bias toward the anterior actuator
transferable_invariant: actuator allocation must preserve the evidenced traveling wave and net route curvature, and must not erase an opposing closed-loop correction merely because another steering gate is active
nontransferable_details: analytical force coefficients, published gains, species envelopes, robot linkage geometry, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use the signed product of existing normalized body-frame anterior and posterior mean-curvature requests to shift only their same-sign portion forward while conserving total slow curvature in the two-joint state-feedback contract
falsification: reject if capture or route closure is lost, posterior occupancy or loads do not fall, anterior position saturation appears, or the coherent alternating wake degrades
