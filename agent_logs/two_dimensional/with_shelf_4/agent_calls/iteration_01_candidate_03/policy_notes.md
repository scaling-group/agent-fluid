# Wake-policy candidate notes

## Inherited evidence

- The assigned parent guidance is the fresh-lineage contract: preserve useful
  seed propulsion, add normalized body-frame feedback for the missing
  capability, and do not encode time, global direction, wake phase, cylinder
  coordinates, or a route. No earlier `logs/optimize/` artifact is present in
  this workspace, so the sampled seed rollout is the only inherited
  candidate-specific result.
- The sampled seed is finite but fails by `left_domain` after only `50.1269`
  released time units. It moves its head `(-3.5452,-13.3003)L`, reaches a best
  distance of `8.6150L`, then finishes `12.1226L` away; target progress is only
  `0.0243`. Mean local lateral flow is `-0.2414`, RMS relative crossflow is
  `0.1747`, and RMS force/moment are `21.9428/541.704`, so the fish experiences
  substantial wake loading while the target-blind oscillator supplies high
  command effort (`1496.25` mean command energy).
- The shared-prewarm sheet shows the fish held above/right of four developed,
  interacting vortex streets. In released keyframes the fish initially points
  broadly along the target diagonal and sheds a coherent propulsive wake, but
  then turns into an almost vertical downward trajectory. The orange path never
  enters the target neighborhood and the last frames show continued downward
  self-propulsion into the boundary, not a collision or numerical breakup.

## Diagnosis and hypothesis

The seed has usable propulsion but no observation-to-steering path. Its
downward exit and worsening distance after the closest approach therefore
support adding pursuit feedback before attempting wake-phase rejection or
scalar gait tuning. Preserve the joint-state oscillator and posterior lag,
but run the oscillatory state around a bounded mean-curvature equilibrium
computed from `state.bearing`. Apply a smaller share of the same mean bend at
the posterior joint so the traveling component remains posterior-lagged.

Expected evidence: compared with the sampled seed, released keyframes should
show curvature returning the nose toward the green target after lateral
deflection, a trajectory with materially larger upstream displacement relative
to downward displacement, later/no domain exit, and lower final or minimum
distance. Falsify the mechanism if positive bearing produces the opposite turn,
if a persistent static bend suppresses the coherent propulsive wake, if joint
saturation/bang-bang effort grows, or if the same near-vertical exit topology
remains.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and mean-curvature turning
source_mechanism: sensor-driven bounded bias of a propulsive rhythm to turn while retaining the traveling wave
transferable_invariant: persistent body-frame target-side error should shift mean curvature while the oscillatory propulsion component remains phase-lagged
nontransferable_details: published gains, clock-driven phases, robot geometry, species kinematics, exact vortex phase, and source-task routes
policy_translation: map normalized body-frame bearing through a smooth bounded mean-bend command; center joint 1 on that bend and give joint 2 a smaller same-sign mean share around the inherited lagged oscillation
falsification: reject if turn sign is wrong, target approach does not improve over the seed's 8.6150L closest distance and early domain exit, or curvature destroys propulsion or increases persistent saturation
