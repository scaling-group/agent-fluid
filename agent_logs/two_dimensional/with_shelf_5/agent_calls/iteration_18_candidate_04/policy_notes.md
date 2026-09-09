# Multi-wake target-policy candidate

## Pre-edit evidence diagnosis

- The held-fish prewarm sheet shows the common developed four-cylinder vortex
  field and the fish released above and downstream of the target; it is common
  initial-condition evidence, not a policy outcome.
- The sampled rollouts all reach the target.  The strongest semantic-coherence
  carrier reaches in `39.1104` with mean distance `1.9149L`, RMS relative
  crossflow/force/moment `0.2193/57.21/783.64`, and excursions
  `0.543/0.463` rad.  Its keyframes show a sharp release redirect followed by
  self-propelled, target-directed transit through the interacting wake, with
  lateral waviness but no collision or boundary excursion.
- The informative high-load contrast reaches in `40.6450` with mean distance
  `1.9786L`, RMS crossflow/force/moment `0.2248/64.70/875.97`, and excursions
  `0.574/0.510` rad.  Its sheet has the same useful route topology, but a more
  pronounced mid-route lateral bend.  Both rate and acceleration caps are
  reached, so the remaining distinction is fast authority/load handling, not
  missing propulsion or wrong-sign steering.
- The assigned parent adds response-conditioned release to the coherent
  carrier.  Against its otherwise matching `39.1104` sample, it keeps the
  arrival time, changes mean distance only from `1.91494L` to `1.91533L`, and
  reduces RMS force/moment from `57.21/783.64` to `54.19/754.87` and command
  energy from `50060.7` to `50044.8`; both hard caps remain touched.  This is
  positive evidence that semantic release near alignment can remove waste
  without erasing the direct route.
- Inherited outward-rate projections reached later (`40.7715` and `40.8375`)
  with `62.41/843.60` and `65.39/897.89` RMS force/moment.  Another cap or
  rate-threshold edit is therefore not supported.  The inherited seed failure
  remains the failure-class boundary: target-blind actuation was advected out
  of the lower domain, unlike every target-directed sample here.

## Policy hypothesis

Preserve the parent's carrier, circular-history route, sign-coherence
fallback, padded-history redirect, and convergence release.  Add one bounded
fast selector from normalized body-frame yaw moment: inside the existing
small-bearing alignment gate, release only the extra posterior half-cycle
authority when the measured yaw moment has the target-turn sign; retain full
authority for opposing yaw.  Scale the smooth assist fraction by the sampled
normalized RMS moment class (`754.9/64^2` to `876.0/64^2`) and the existing
aligned-request boundary, rather than importing a published gain.  This should
avoid reinforcing helpful wake-induced yaw and reduce moment/force or cap
contact while leaving the large-error redirect and propulsive carrier intact.

bookshelf_consulted: true
source_domain: biological wake interaction and closed-loop robotic-fish steering
source_mechanism: preserve useful wake-induced motion while separating slow route steering from bounded fast feedback
transferable_invariant: do not cancel or reinforce every wake disturbance; condition fast steering authority on whether observed yaw assists or opposes the persistent target turn
nontransferable_details: species kinematics, single-cylinder Karman phase, published CPG gains, dimensional frequencies, and source-task routes
policy_translation: combine normalized body-frame target-turn request with `moment_z_L2`; within the existing alignment gate, smoothly release only posterior half-cycle boost for target-assisting moment
falsification: reject if target capture is delayed or lost, the direct trajectory changes materially, RMS force/moment or cap contact do not improve, or lateral oscillation grows

## Evaluation boundary

The new CFD rollout occurs only after this worker exits.  This candidate makes
no same-worker improvement claim; its test is the stated arrival/route/load
comparison against the sampled coherent and parent carriers.
