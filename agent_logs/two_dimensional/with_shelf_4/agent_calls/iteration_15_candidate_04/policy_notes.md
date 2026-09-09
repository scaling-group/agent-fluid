# Multi-wake candidate diagnosis

## Evidence read before the edit

- The certified prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets. It is common initial-condition
  evidence, not a reusable wake phase or a route specification.
- All four sampled solvers are deterministic repetitions of the same semantic
  policy. Their sheets show a self-propelled broad redirect, sustained
  alternating posterior-lagged bends, several midcourse lateral reversals, and
  capture after `137.357` released units. The repeated metrics are `4.18356L`
  mean distance, `-10.9139L` upstream head displacement, `90228.38` total
  command energy, and `0.12955/14.75/303.02` RMS relative crossflow, lateral
  force, and yaw moment. Mean upstream body speed (`-0.0791`) exceeds the
  magnitude of mean local-flow x (`-0.0542`), confirming active propulsion.
- Joint-1 acceleration already peaks at `30.846 rad/time^2` against the
  `31.416` cap, so more oscillator authority or scalar-only gain tuning is not
  supported. The targetward route, direct moment residual, zero-mean anterior
  half-cycle asymmetry, and posterior wave should remain intact.
- The most informative inherited controller regression preserves capture but
  makes same-sign posterior half-cycle modulation share the route request. Its
  sheet shows a long upper-right loop, a deep lower detour, and late wake entry;
  arrival slows to `279.439`, mean distance grows to `6.982L`, total energy
  doubles to `182836`, and RMS crossflow/force/moment rise to
  `0.13554/15.54/316.29`. The assigned parent also records the actual seed
  failure boundary: target-blind oscillation exits the bottom after `50.13`
  units with `-13.30L` lateral displacement and saturated joint rates and
  accelerations. Together these reject posterior actuator sharing and extra
  propulsion as repairs for the remaining course reversals.
- Inherited one-change residuals also regress from the reproduced parent: an
  oppositely signed relative-crossflow residual delays capture to `154.110`
  while barely changing RMS crossflow (`0.13005` versus `0.12955`), and a
  lateral-target residual delays capture to `159.302`. More importantly, a
  proposed forward-geometry qualification reproduces every parent metric and
  keyframe exactly at `137.357`. Code inspection explains why: it used positive
  `target_body_L[1] / distance_L`, but this lane defines forward target
  distance as `-target_body[1]`. Its clamped gate was therefore dormant along
  the forward-target portion of the route. That rollout did not falsify the
  mechanism; it exposed an observation-sign no-op.

## Policy hypothesis

Make exactly one feedback-topology change from the replicated parent. Preserve
instantaneous bearing as route owner and keep its proven positive-closing-speed
qualification. Conjunctively qualify only the existing
`bearing_window_rate` damping with the correctly signed normalized forward
projection `-target_body_L[1] / distance_L`. Damping is therefore admitted
only when measured targetward translation and forward alignment agree. If a
wake turn moves the target toward the lateral or aft body region, persistent
bearing regains the full correction instead of accepting angular convergence
alone. This adds no route residual, posterior edit, hidden stage, or gain
amplification, and it cannot recreate the slower globally active damping.

The expected formal test is preservation of alternating upstream propulsion
and capture with fewer midcourse reversals, earlier arrival or lower mean
distance, and no increase in effort, load, or actuator-cap contact. Falsify it
if the initial redirect is weakened, capture or upstream translation is lost,
the alternating bend disappears, or arrival, distance, command effort,
crossflow, force, moment, or saturation fails to improve jointly against the
replicated `137.357` baseline. The new CFD evaluation runs after this worker
exits, so these are expectations rather than same-worker results.

bookshelf_consulted: true
source_domain: nonsteady fish redirect control and sensor-modulated robotic-fish direction tracking
source_mechanism: sustain bounded curvature for large directional error, then release response damping only after observed target geometry and targetward translation agree
transferable_invariant: normalized body-frame geometry and measured progress can jointly gate a continuous redirect-to-course transition while persistent bearing remains the route owner
nontransferable_details: published gains, dimensional gait settings, species-specific C-start kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the two-joint half-cycle traveling bend and direct moment residual; multiply the existing closing-progress gate by correctly signed `-target_body_L[1] / distance_L` for bearing-rate damping only
falsification: reject if the conjunctive gate loses or slows capture, deepens course reversals, removes upstream alternating propulsion, or fails to improve trajectory, effort, load, and saturation together
