# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting vortex streets. It is initial-condition evidence,
  not a controller difference.
- The constant-reserve allocator (`solver_72a47313c277`) is the weakest sampled
  success but establishes the baseline topology: a sharp clockwise redirect,
  coherent self-propelled leftward traversal through the merged wake, and target
  entry after `49.1424`. It reaches `0.749267L` with mean distance `2.15598L`,
  command-energy mean `1272.25`, and RMS force/moment `39.05/617.13`. Both joint
  speeds and the candidate's `30.0` acceleration envelope are touched.
- The prefilled course-slip correction (`solver_45b5e77accc8`) preserves that
  visible route and reaches the target `1.111` time units earlier. Its RMS
  force/moment fall to `37.92/605.38`, although mean command energy rises to
  `1299.71`; this supports retaining slip as a route-error correction, not
  claiming it as an effort reduction.
- The bearing-scheduled reserve sibling (`solver_107fd6f7f029`) has the best
  sampled score and reaches after `46.0350`, with mean distance `2.06953L` and
  command-energy mean `1237.06`. Its keyframes show an earlier turn into the
  long upstream traverse. The tradeoff is higher RMS force/moment
  (`51.40/761.46`) and slightly larger joint excursions; acceleration and speed
  limits remain contacted. Thus scheduling improves arrival and effort in this
  wake, but raw-bearing scheduling alone does not establish load reduction.
- The inherited slower/smaller curvature-centered controller remains the
  informative failure boundary: it never entered the useful target region and
  became unstable after `121.517`, with RMS relative crossflow/force/moment
  `1.138/16749.8/290421`. The validated `0.55`-period traveling carrier,
  same-sign residual, and bounded acceleration allocator should remain intact.

## Candidate hypothesis

Combine the two independently useful feedback effects without changing the
validated carrier or scalar gait: compute the same bounded course-slip-corrected
body-frame steering error as the prefill, then use that corrected route error to
schedule the allocator's steering reserve. Large persistent route error receives
extra directional half-cycle authority; lateral motion already carrying the fish
toward the target reduces both the residual and its reserved allocation. Using
the corrected error, rather than raw bearing, is intended to keep the scheduler
from reinforcing the high-load lateral motion seen in the fastest sibling.

Expected test: preserve target reach and coherent leftward propulsion, approach
or improve the `46.0350` scheduled-reserve arrival, and keep RMS force/moment
closer to the course-slip result than `51.40/761.46`. Falsify the combination if
capture is lost, arrival regresses beyond the `49.1424` constant-reserve
baseline, the lower-exit topology returns, mean effort exceeds the course-slip
result without an arrival benefit, or loads approach instability. The current
candidate's CFD evaluation occurs only after this worker exits and is not
claimed here.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and residual path-following control
source_mechanism: sensor-conditioned route-error modulation with bounded half-cycle steering authority around a rhythmic carrier
transferable_invariant: separate persistent body-frame direction error from lateral motion already serving the route, while preserving finite steering authority and the joint-state traveling bend
nontransferable_details: published gains, dimensional beat rates, robot hardware and geometry, clocked phase, species kinematics, exact vortex phase, and source-task routes
policy_translation: subtract regularized normalized body-frame course slip from bearing, map that corrected error to the proven two-joint residual, and smoothly raise the bounded steering reservation only when the corrected error remains large
falsification: reject if semantic capture or propulsion is lost, if arrival is worse than constant reserve, or if scheduled authority raises effort or force/moment without a compensating route benefit
