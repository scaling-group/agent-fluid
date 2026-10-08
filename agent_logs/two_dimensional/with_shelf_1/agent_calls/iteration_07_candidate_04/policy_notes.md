# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets. The target lies inside the mixed
  second-row wake; this sheet is common initial-condition evidence, not a
  controller comparison.
- All four sampled released sheets terminate at the target. They show active
  propulsion: the fish makes a sharp clockwise redirect, sheds a coherent
  posterior wake, and then traverses left through the cylinder streets rather
  than following the local flow passively. No sampled sheet shows collision,
  domain exit, or an unproductive lateral loop.
- Three independently sampled evaluations of the inherited decoupled
  controller are numerically identical. Relative to the raw-bearing reserve
  scheduler, separating course slip from reserve allocation improves arrival
  `46.035 -> 45.727`, mean distance `2.0695L -> 2.0543L`, and RMS lateral force
  `51.40 -> 49.36`; the final keyframe approach is also slightly more direct.
  The tradeoff is worse mean command energy `1237.1 -> 1264.7`, RMS relative
  crossflow `0.2290 -> 0.2349`, and RMS moment `761.46 -> 799.31`. Thus the
  decoupling is an evidenced route/arrival mechanism, not yet a load or effort
  improvement.
- Course-slip correction alone remains the sampled load boundary at RMS
  force/moment `37.92/605.38`, although it arrived later at `48.032`. Applying
  the slip-corrected error to both steering and reserve was strictly worse than
  the separated roles, so raw bearing must continue to own reserve authority.
- No failed keyframe sheet is present in the sampled evidence. The inherited
  scalar failure boundary is the wholesale slower/smaller carrier replacement,
  which became unstable at `121.517` with RMS crossflow/force/moment
  `1.138/16749.8/290421`. The validated `0.55`-period carrier, posterior lag,
  steering sign, and `30.0` allocator envelope therefore remain unchanged.

## Candidate policy hypothesis

Preserve the evaluated two-path controller and add one bounded wake-disturbance
residual to its steering request. Raw body-frame bearing continues to schedule
finite reserved authority; body-frame course slip continues to remove redundant
target correction; current normalized body-frame relative crossflow supplies a
small anticipatory term before that crossflow becomes lateral course error. A
`tanh` bound and an evidence-scaled `0.25` velocity scale prevent the fast wake
signal from replacing the propulsive carrier or cancelling every helpful
lateral motion.

Expected test: retain capture and the decisive redirect while reducing the
decoupled controller's `0.2349` RMS relative crossflow, `799.31` RMS moment, or
`1264.7` mean effort without losing its `45.727` arrival advantage. Falsify the
mechanism if capture is lost, arrival exceeds the raw-bearing scheduler's
`46.035`, the coherent upstream traverse disappears, or both moment and effort
fail to improve. The candidate receives CFD evaluation only after this worker
exits; no outcome is claimed here.

bookshelf_consulted: true
source_domain: wake-interaction and adaptive-swimming control around a rhythmic fish gait
source_mechanism: separate persistent route correction from a small bounded response to fast alternating crossflow while preserving the propulsive rhythm
transferable_invariant: persistent body-frame target geometry should retain steering authority while normalized local disturbance feedback acts only as a limited residual
nontransferable_details: published gains, species and robot kinematics, dimensional beat rates, exact vortex phases, single-cylinder synchronization, and source-task routes
policy_translation: keep raw bearing in the reserve scheduler and add a tanh-bounded body-frame relative-crossflow term only to the existing slip-corrected steering error
falsification: reject if capture or coherent propulsion is lost, arrival exceeds 46.035, or the added residual reduces neither moment nor effort relative to the decoupled parent
