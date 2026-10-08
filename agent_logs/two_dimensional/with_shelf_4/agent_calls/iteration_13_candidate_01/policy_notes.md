# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the certified common release
  condition, not evidence for a fixed route or a transferable wake phase.
- All four sampled solvers are replications of one semantic policy and one
  released trajectory: the keyframe sheets and physical metrics are identical
  (the two policy hashes differ only in comments). The fish self-propels from
  the upper right, sustains an alternating posterior-lagged bend, crosses the
  mixed wake, and reaches the target after `137.357` released units. Evidence
  is `4.18356L` mean distance, `-10.9139L` upstream head displacement,
  `90228.38` total command energy, and `0.12955/14.75/303.02` RMS relative
  crossflow/force/moment. Mean upstream body speed `-0.0791` exceeds the
  magnitude of mean local-flow x `-0.0542`, confirming active propulsion.
- The successful sheet nevertheless shows a broad initial redirect followed
  by several lateral course reversals before the final right-side entry. The
  `4.3045L` peak absolute lateral target offset agrees with that visual
  topology. Joint-1 acceleration already reaches `30.846 rad/time^2` against
  the `31.416` cap, so more anterior gait or steering authority is not an
  evidence-backed response.
- No sampled result supplies a distinct failure. Inherited logs provide the
  contrast: globally active bearing-rate damping captures at `149.605` rather
  than `137.357`, and short-history bearing smoothing, unconditioned
  crossflow/lateral-target residuals, large-bearing tail-lag relief, and
  response-gated moment rejection all retain capture only with worse arrival,
  distance, effort, or load. Near-target route relief loses capture and exits
  the top boundary. Posterior coordination is also negative across the tested
  topologies: same-sign full-tail modulation delays capture to `279.439` with
  `182836` energy, opposite full-tail modulation to `150.210`, and isolated
  tail-lag half-cycle modulation to `196.317`. These results support keeping
  the reproduced route, load residual, anterior half-cycle mechanism, and
  posterior wave intact.

## Policy hypothesis

Make exactly one feedback-topology change to the reproduced scaffold. Keep
instantaneous body-frame bearing as route owner and retain the positive
closing-speed qualification that improved the globally damped predecessor.
Add normalized forward target geometry as a second, restricted qualification
for the same bearing-rate damping: while the target remains aft, closing
progress is still the only way damping earns authority, preserving the firm
initial redirect; after the target enters the forward body half-plane, its
normalized forward projection can retain damping during brief non-closing
wake events. Use the maximum of closing progress and forward projection so the
new gate never amplifies the existing damping above its owned gain.

This tests a C-start-style release boundary without a time stage, route
coordinate, new observation residual, posterior edit, or scalar gait change.
The expected result is the same alternating upstream propulsion and target
capture with fewer midcourse reversals, earlier arrival or lower mean distance,
and no increase in effort, load, or actuator-cap contact. Falsify it if the
initial redirect is blunted toward the `149.605` global-damping trajectory,
capture or upstream translation is lost, the alternating bend disappears, or
arrival, distance, effort, crossflow, force, moment, or saturation fails to
improve jointly over the reproduced `137.357` baseline. CFD evaluation occurs
only after this worker exits, so these are expectations, not current evidence.

bookshelf_consulted: true
source_domain: nonsteady fish redirect control and sensor-modulated robotic-fish direction tracking
source_mechanism: sustain strong bounded curvature for a large rearward target error, then release response damping only after observed target geometry enters the forward control region
transferable_invariant: normalized body-frame geometry can gate a continuous transition from redirect to course damping while persistent target bearing remains the route owner
nontransferable_details: published gains, dimensional beat settings, species-specific C-start kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the evidenced two-joint half-cycle traveling bend, direct moment residual, and closing-progress gate; let only the normalized positive forward component of `target_body_L / distance_L` additionally qualify the existing `bearing_window_rate` damping
falsification: reject if rearward redirect weakens, capture or upstream translation is lost, the course retains or enlarges its reversals, or arrival, mean distance, effort, loads, and cap contact do not improve together over the replicated baseline
