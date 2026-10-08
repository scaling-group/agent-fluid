# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets, with the target inside their merged
  second-row wake. This is the common initial condition and not evidence for a
  candidate difference.
- All four sampled released sheets reach the target on the same compact
  redirect-and-upstream topology, and no sampled released failure sheet is
  available. The coherent posterior trail, about `-10.91L` head displacement
  in x, and mean upstream speed near `-0.31U` versus mean local flow near
  `-0.20U` show active propulsion rather than passive advection. The inherited
  predictive-bearing failure remains the useful contrast: it exited right
  after `18.304` with negative progress, so raw-bearing mean authority and the
  state-feedback carrier must remain intact.
- The prefilled response-scheduled parent is the fastest sampled policy:
  capture at `34.8205`, mean distance `1.6270L`, total/mean command energy
  `47151/1354.1`, and RMS force/moment `77.09/1142.74`. Its visual sheet shows
  a sharp initial redirect, sustained upstream swimming through the wake, and
  direct first entry into the `0.75L` capture circle; there is no terminal
  near-miss for a distance gate to repair.
- Three moment-aware siblings isolate a sign boundary. A signed assisting-yaw
  gate retains the same visible route and gives back only `0.121` arrival time
  while lowering RMS force/moment to `71.86/1064.16` (about `6.8%` each).
  A magnitude-only linear gate gives back `0.176` and lowers load less to
  `71.92/1086.47`; a magnitude-only inverse-square gate is worse on route,
  crossflow, force, and moment (`35.035`, `1.6351L`, `0.2448`,
  `78.35/1216.43`). Thus load magnitude alone is not an evidenced response
  signal, while moment aligned with the requested turn is.
- The assigned optimizer logs also show that joint-speed-gated burst relief
  regressed capture to `37.262` and raised load above the fixed-half-cycle
  baseline. Joint speed may identify carrier phase, but its magnitude is not
  a hydrodynamic-load proxy. Both sampled moment gates and the parent still
  touch the joint-speed and `30.0` acceleration limits.

## Candidate policy hypothesis

Preserve the prefilled carrier, course-slip correction, raw-bearing reserve,
base half-cycle asymmetry, and bearing-response-scheduled burst. Add a single
phase-correlated response-credit mechanism: normalize body-frame yaw moment,
accept only the sign that assists the raw-bearing turn request, and relieve
only the extra burst while the anterior joint is already moving through the
targetward half-cycle. An assisting moment outside that half-cycle receives no
credit, preventing the phase-agnostic gate from reshaping the recovery side of
the beat. Mean steering, base asymmetry, posterior lag, and propulsion remain
active for every moment sign.

Expected test: preserve capture and the coherent redirect/upstream traverse;
improve on the signed-moment sibling's `34.9415` arrival and `1.6290L` mean
distance while retaining a material part of its force/moment reduction from
the parent's `77.09/1142.74`. Reject the mechanism if capture or upstream
propulsion is lost, arrival exceeds the fixed-asymmetry `36.4705` baseline,
load returns fully to the parent, or effort/load rise without a route benefit.
The new CFD evaluation happens only after this worker exits, so no same-worker
improvement is claimed.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and adaptive wake-interaction control
source_mechanism: preserve a rhythmic carrier and persistent route request while measured hydrodynamic response relieves only surplus asymmetric turning in the actuator phase that produces it
transferable_invariant: environmental yaw earns control credit only when its sign assists persistent body-frame target error and its timing coincides with the targetward actuation half-cycle
nontransferable_details: published gains, dimensional moments, robot actuator ratings, species kinematics, clocked phases, exact vortex phases, and source-task routes
policy_translation: use normalized body-frame `moment_z_L2`, raw bearing sign, and anterior joint velocity normalized by the carrier scale to attenuate only the response-scheduled extra half-cycle asymmetry; retain mean steering, base asymmetry, raw-bearing reserve, and both joint-state carriers
falsification: reject if target capture or coherent leftward propulsion is lost, if arrival exceeds the fixed-asymmetry baseline, or if the signed-moment load benefit disappears without improving route or effort
