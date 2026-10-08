# Candidate diagnosis and hypothesis

## Rollout evidence

- All four sampled rollouts use direct uniform still-water initialization and
  capture in `16.0544T` after `239` moving-window shifts. Their combined sheets
  show the same self-propelled, coherent alternating mid-plane wake and compact
  oblique Lambda2 structures from release through capture; there is no visible
  wake collapse, passive advection, domain exit, or unstable body response.
- The assigned parent applies net bearing-rate mean damping only from `0.90L`
  to capture. It reaches `0.745854L` with a `1.929846L` scored distance
  integral and `21.86%` posterior acceleration-limit residence.
- Separating yaw and translational slip plus slip-conditioned half-cycle
  relief reaches `0.745867L`; attenuating the raw bearing-rate-reinforcing
  posterior lobe reaches `0.745940L`. Both keep the same arrival step and wake,
  so phase-local terminal relief is not a surviving improvement.
- The strongest sampled result first subtracts the anterior-joint carrier yaw
  prediction from normalized line-of-sight rate, applies the residual as
  bounded mean curvature in the middle closing corridor, and fades into the
  parent's net-rate terminal damper. It reaches `0.745846L`, lowers distance
  integral to `1.929840L`, posterior mean command from `24.5858` to
  `24.5845 rad/T^2`, and posterior exact-limit residence to `21.79%`. Peak
  lateral force rises slightly from `0.03223` to `0.03239`; earlier distance
  history and arrival remain effectively unchanged. This is a small terminal
  geometry result, not evidence of a new route.

## Policy hypothesis

Use the sampled carrier-demodulated line-of-sight response as the single
candidate mechanism. Preserve all carrier, redirect, handoff, posterior wave,
and exact-boundary projection behavior. In the reliable closing corridor,
subtract the normalized anterior-phase yaw prediction from instantaneous
bearing rate; oppose only residual reopening before `0.90L`, then fade
continuously into the assigned parent's measured net bearing-rate damper. The
two weights are complementary and share the existing `3 deg` curvature bound,
so the mechanism neither stacks authority nor changes the established cruise
route.

bookshelf_consulted: true
source_domain: closed-loop CPG and robotic-fish path-following control
source_mechanism: separate a repeatable rhythmic locomotor carrier from a bounded sensory residual command
transferable_invariant: persistent navigation response should be acted on only after removing the predictable joint-state carrier component
nontransferable_details: published oscillator gains, dimensional frequencies, species-specific envelopes, full-body kinematics, and task routes
policy_translation: predict normalized carrier yaw from body-joint position and velocity, subtract it from normalized body-frame bearing rate, and gate bounded posterior mean curvature by closing and intercept reliability
falsification: reject if capture, wake coherence, earlier milestones, distance integral, posterior limiting, or the force envelope regress, or if action remains confined to the final beat and does not outperform the parent terminal damper

