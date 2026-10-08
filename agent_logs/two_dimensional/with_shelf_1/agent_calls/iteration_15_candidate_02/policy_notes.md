# Wake Policy Candidate Notes

## Evidence read before editing

- The assigned parent policy is byte-identical to sampled example
  `solver_1c846ab92c50`. Its released sheet shows the already-useful topology:
  an immediate targetward redirect, a long self-propelled upstream traverse
  through the developed multi-cylinder wake, and first-entry capture. It
  reaches in `34.859`, with mean distance `1.62681L`, total/mean command energy
  `47176.8/1353.36`, RMS relative crossflow `0.24086`, and RMS force/moment
  `74.24/1105.81`.
- The shared prewarm sheet confirms that every sampled candidate starts beside
  the same fully developed interacting vortex streets; it is initial-condition
  evidence, not evidence for a controller difference.
- `solver_62f806d86ad7`, `solver_7bf9f4934d4b`, and
  `solver_afd5d60a9317` independently reproduce the same stronger result:
  target reach in `34.7105`, mean distance `1.62283L`, total/mean command
  energy `46985.9/1353.65`, RMS relative crossflow `0.24023`, and RMS
  force/moment `68.96/1036.40`. Their released sheets retain the same useful
  trajectory topology as the parent.
- The only material code difference is burst-release coordination. The parent
  computes a separate speed-pressure release for each joint, so the extra
  half-cycle redirect can be modulated differently across the traveling bend.
  The three stronger policies use the maximum normalized speed pressure of
  either joint as one shared release signal for both joints. Thus the shared
  version reduces total energy about `0.4%`, RMS force about `7.1%`, and RMS
  moment about `6.3%`, while slightly improving arrival and mean distance;
  only mean command energy worsens slightly (`1353.36 -> 1353.65`).
- No sampled current example is a failure, so there is no current failure
  keyframe sheet to compare. The inherited guidance supplies the applicable
  failure boundary: the target-blind seed exited downward, opposite-sign
  curvature exited with negative progress, and wholesale carrier changes
  became unstable. Therefore this candidate preserves the validated carrier,
  bearing sign, reserve, course response, and base/burst asymmetry.
- The assigned optimizer example's inherited logs were read after resolving a
  duplicated parent marker in the rendered workspace README. They sharpen the
  boundary around this edit: a prior speed-only gate regressed arrival and
  load; gating assisting-moment credit by only the anterior targetward phase
  raised load to `82.35/1231.74`; and the immediately inherited step-14 note
  already proposed coherent two-joint burst release from two exact sampled
  copies. The current four-solver sample adds a third exact coherent-release
  result, strengthening replication of the coupled-release lesson without
  establishing an isolated speed-as-wake-sensor claim.

## Visual diagnosis and policy hypothesis

The compact sheets do not resolve a route-topology difference between the
parent and stronger siblings: both turn promptly, continue propelling against
the mean flow, enter the interacting wake region, and capture without visible
collision or late target loss. The metric change instead points to avoidable
internal gait disagreement: local speed gating lets the anterior and posterior
redirect envelopes diverge even though they are parts of one traveling bend.

Candidate hypothesis: use one whole-carrier limit-pressure signal, computed
from the larger normalized absolute velocity of the two joints, to release
only the surplus response-gated redirect burst on both joints together. Keep
the base asymmetry and all persistent route/propulsion terms untouched. This
should reproduce target reach and the `34.7105` useful trajectory while
recovering the sampled force, moment, distance, and total-energy advantages.

bookshelf_consulted: true
source_domain: classical undulatory swimming and coupled-oscillator robotic-fish control
source_mechanism: a coordinated anterior-to-posterior traveling bend with coupled rhythmic modulation
transferable_invariant: modulate the two joints coherently when they implement one propulsive wave, so a local actuator cue does not introduce an unintended relative envelope mismatch
nontransferable_details: published gains, body-wave shapes, dimensional frequencies, species envelopes, exact wake phase, and task-specific routes
policy_translation: normalize both joint velocities by the state-derived oscillator speed scale, use their maximum as one bounded speed-pressure release, and apply it only to both joints' extra bearing-response burst within the existing body-frame two-joint feedback
falsification: reject the translation if evaluation loses target reach, changes the useful redirect-and-traverse topology, or fails to recover a meaningful force/moment or total-effort advantage over the per-joint parent; do not infer robustness from the unchanged shared wake phase
