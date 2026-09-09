# Step 40 wake-policy diagnosis

## Evidence read before the edit

- All four sampled solver evaluations satisfy the frozen experiment contract:
  direct uniform still water at `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. They all capture at `0.74846--0.74986L` after
  `18.2875--18.6560T`. Three are exact
  `dogfish3d_intercept_guarded_speed_reserve_v1` repeats; the fourth is the
  outer unsupported-bearing qualifier.
- Both rows of every sampled combined sheet show active self-propulsion through
  capture: a coherent alternating top-down vorticity street persists behind
  the fish, and the oblique row retains bilateral Lambda2 structures. The
  assigned parent's exact LOS-residual repeat has the same organized wakes and
  remains propulsive after its closest pass, but misses at `1.59620L` and exits
  below at `10.33579L`. The visual and metric evidence therefore isolate
  terminal path geometry, not advection, carrier collapse, collision, or
  instability.
- The failed LOS repeat used exactly the inherited
  `dogfish3d_outer_los_rate_intercept_v1` bytes. Its head/tail action clipping
  is about `70.25%/71.79%`, and the trace still carries roughly `0.828L/T` at
  closest pass. Together with the inherited LOS captures, this makes the
  additive residual a threshold-sensitive mechanism rather than a reliable
  improvement; another bound or annulus change would be scalar tuning of the
  same failed intervention.
- The separately inherited
  `dogfish3d_partial_outer_intercept_guard_v1` has one direct-uniform capture at
  `0.74852L` and `18.29849T`. Its top-down and oblique sheets preserve the same
  active alternating wake, while head/tail clipping (`68.80%/70.81%`), exact
  speed-limit residence (`10.64%/11.33%`), and peak force/moment coefficients
  (`0.01495/0.02783/0.01620`) remain inside the three sampled exact-baseline
  envelope. This is compatibility evidence, not robustness evidence.

## Candidate hypothesis

Install an exact-byte repeat of the evaluated
`dogfish3d_partial_outer_intercept_guard_v1`. Preserve the raw achieved-course
servo, distance-blended inner intercept veto, posteriorly lagged traveling
bend, two-joint steering shares, and sparse outward-only carrier reserve.
Between `4L` and `2.75L`, projected target/velocity incompatibility may retain
only a bounded fraction of steering that correct-sign yaw response would
otherwise release; the gate hands off continuously to the unchanged inner
guard. It adds no LOS residual, unsupported-bearing qualifier, carrier-phase
allocation, or scalar drive change.

Falsify the mechanism if the exact repeat loses capture, retains the coherent-
wake lower-exit branch, collapses response release toward the failed binary
certificate, weakens either wake view, or moves clipping, speed residence,
force, or moment outside the repeat-backed baseline envelope. A repeat capture
would support further reliability sampling, not gain tuning.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over an independently sustained rhythmic carrier
source_mechanism: continuously modulated steering authority from observed target geometry and turn response
transferable_invariant: condition steering release on both observed turn response and task-compatible motion while keeping the propulsive rhythm independently active
nontransferable_details: published gains, clocked CPG phase, robot morphology, dimensional cadence, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: retain the normalized body-frame achieved-course servo and traveling bend, but partially retain steering for an incompatible projected pass in the outer terminal annulus before handing off to the existing inner guard
falsification: reject if exact replay loses capture, keeps the coherent-wake lower exit, behaves like binary full retention, weakens either wake, or worsens the established actuator and load envelope

## Non-CFD validation

- The installed candidate is byte-identical to the evaluated partial-gate
  policy (SHA-256
  `1059127f77ddbeac9f8a832d1f922d0d0820a08707327c8fa1799c7ab7467d3f`).
- The required semantic-guidance and deterministic parameter-schema check
  passes, as does the solver editable-boundary check.
- Julia 1.12.6 loads the candidate and returns a finite two-joint action for
  the prescribed contract state. No CFD was run.
