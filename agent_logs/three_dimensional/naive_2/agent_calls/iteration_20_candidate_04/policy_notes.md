# Candidate wake-policy notes

## Evidence and visual diagnosis

- All four sampled rollouts report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, so the observed motion is self-propulsion,
  not imposed advection or a prewarm artifact.
- The prefill is byte-identical to `solver_ec81137f627b`. Its top-down row
  shows a strong, coherent alternating vortex street rather than a collapsed
  gait, while the oblique row shows an organized compact three-dimensional
  wake. The control failure is the route: the body bends through a broad pass,
  center y rises from `14.0L` to `15.202L`, closest distance is only `4.650L`,
  and it exits left at `20.03T` with distance `5.706L`. Propulsion should be
  preserved; full-circle pursuit plus near-target carrier braking should not.
- The highest-scoring sampled capture, `solver_d32fb3a02de7`, follows a nearly
  direct upper-right-to-target path while retaining the same compact
  alternating top-down wake and paired three-dimensional Lambda2 structures.
  It reaches `0.749982L` at `15.983T`, with center y reduced to `9.148L`.
  `solver_16135cb555bf` is byte-identical and independently captures at
  `15.994T`; the response-released-pulse variant `solver_8e5a36c75b2e`
  captures at `16.016T`. Diagnostics report no instability, no joint dwell
  above 40 degrees, and peak normalized planar force/moment below about
  `0.035/0.018` for this family.
- The assigned parent logs contain three consecutive `left_domain` outcomes
  with minima `3.863L`, `1.016L`, and `1.073L`; sampled lineage logs then show
  captures only after the constant-course predicted-miss architecture. The
  inherited guidance also records a no-pulse sibling capture at `16.011T`, so
  the posterior pulse is not needed to explain semantic improvement.

## Policy hypothesis

Preserve the evidenced Van der Pol traveling-bend carrier and shared-joint
half-cycle steering. Replace phase-separated pursuit and carrier braking with
body-frame constant-course interception: use target/velocity projection to
predict time to closest approach and signed cross-track miss, recruit a small
bounded mean curvature only for an imminent miss, and release terminal
authority when carrier-separated yaw is already corrective. Remove the
posterior pulse so this candidate tests the replicated interception/response
handoff without an uncredited actuator mechanism.

Expected outcome: change the prefill's broad high left-domain pass into the
sampled compact capture trajectory without sacrificing wake coherence or
translation. Falsify this candidate if it loses capture, returns to a domain
exit or materially worse closest pass, degrades the alternating wake, creates
joint dwell above 40 degrees, increases rate-limit occupancy materially, or
exceeds the sampled force/moment scale.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and biological burst redirect
source_mechanism: target-conditioned bounded mean curvature that releases into the propulsive rhythm when a corrective yaw response appears
transferable_invariant: separate the propulsion carrier from geometry-driven redirect authority and hand that authority back continuously once measured response is corrective
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, clock phase, exact vortex phase, and task-specific routes
policy_translation: form normalized body-frame course error, time to closest approach, and signed predicted miss from target and velocity; gate a small common bend and use joint-rate-separated heading response to release it within the two-joint acceleration contract
falsification: reject if capture and closest approach do not improve together over the prefill, or if the redirect loses translation, wake coherence, joint reserve, or load quality
