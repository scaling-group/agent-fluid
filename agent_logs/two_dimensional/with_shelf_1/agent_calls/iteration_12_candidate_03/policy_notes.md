# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. The target lies inside the merged
  second-row wake. This is the common initial condition, not a
  candidate-specific advantage.
- All four sampled released sheets reach the target with the same sharp initial
  redirect and coherent upstream traverse. Head displacement is about
  `(-10.91,-4.2)L`, while mean local flow is about `(-0.20,-0.17)U`; the
  persistent posterior trail and net upstream motion therefore indicate active
  propulsion rather than useful passive advection. No released failure sheet
  is available in the sampled workspace. The inherited predictive-bearing
  failure remains the semantic contrast: it exited right after `18.304` with
  negative progress, so raw-bearing mean authority and the joint-state carrier
  must remain intact.
- The prefilled ungated response-burst policy captures at `34.8205`, with mean
  distance `1.6270L`, total/mean command energy `47151/1354.1`, relative
  crossflow `0.2414`, and RMS force/moment `77.09/1142.74`.
- A phase-agnostic assisting-moment gate preserves the same visible route and
  captures at `34.9415`. That small `0.121` arrival cost buys a material load
  reduction to `71.86/1064.16`, while effort remains effectively unchanged at
  `47298/1353.6`.
- The assigned parent's phase-correlated version also preserves the visible
  route and slightly improves mean distance to `1.6268L`, but its
  `34.8535` arrival is still slower than the ungated policy and its RMS
  force/moment rise to `82.35/1231.74`. Restricting moment credit to the
  anterior targetward half-cycle therefore fails as load relief: it increases
  both loads without producing a meaningfully different useful trajectory.
  The current evidence supports the sign boundary of moment credit, but not a
  phase-side boundary.

## Candidate policy hypothesis

Preserve the prefilled carrier, course-slip residual, raw-bearing reserve,
base half-cycle asymmetry, and bearing-response burst. Add one bounded
response-credit mechanism: a body-normalized yaw moment may relieve only the
optional redirect burst when its sign assists the persistent raw-bearing
request, but cap that credit so some burst authority survives at every moment.
Apply the credit symmetrically across joint-state half-cycles; this removes the
evaluated phase-side discontinuity while retaining more redirect authority than
the fully relieved signed-moment sibling. Mean steering, base asymmetry,
posterior lag, and propulsion remain active for every moment sign.

Expected test: preserve target capture and the coherent redirect/upstream
traverse; keep arrival no worse than the full signed-moment gate's `34.9415`
while reducing RMS force and moment below the ungated policy's
`77.09/1142.74`. Reject the mechanism if capture or upstream propulsion is
lost, if arrival exceeds the full-credit sibling, if load does not improve on
the ungated baseline, or if command effort rises without a route or load
benefit. The candidate's CFD evaluation occurs only after this worker exits,
so no same-worker improvement is claimed.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and adaptive swimming in organized wakes
source_mechanism: preserve a rhythmic propulsive carrier and persistent route request while measured hydrodynamic response relieves only surplus asymmetric turning authority
transferable_invariant: normalized body-frame yaw earns bounded control credit only when its sign assists persistent target error; the propulsive carrier and a minimum route authority remain active
nontransferable_details: published gains, dimensional moments, robot actuator ratings, species kinematics, clocked CPG phases, exact vortex phases, and source-task routes
policy_translation: use `moment_z_L2` and a smooth raw-bearing sign to partially attenuate only the response-scheduled extra half-cycle asymmetry; do not gate the credit by beat side, and retain mean steering, base asymmetry, reserve, and both joint-state carriers
falsification: reject if target capture or coherent leftward propulsion is lost, arrival exceeds the evaluated full-credit sibling, or force/moment fail to improve on the ungated response-burst baseline without a compensating route benefit
