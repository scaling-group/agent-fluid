# Candidate diagnosis and hypothesis

## Assigned evidence

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and moving-window storage.
- The three independently materialized v34 policies reproduce the same capture:
  `18.4030 T`, score `-0.140449`, distance integral `2.027810 L`, and final
  distance `0.747223 L`.  Their combined top-down/oblique sheets show
  self-propulsion from rest, a coherent alternating mid-plane wake, compact
  three-dimensional Lambda2 structures shed from the posterior body, and a
  smooth target-directed arc rather than passive advection.
- The v35 response-release variant preserves the visible route and wake but is
  a small regression: capture at `18.4140 T`, score `-0.141536`, and distance
  integral `2.028719 L`.  It matches v34 through `14 T`, then trails by
  `0.0008/0.0033/0.0042 L` at `16/17/18 T`.  Peak speed, normalized force, and
  normalized moment are effectively unchanged (`0.948 L/T`, `0.03068`, and
  `0.01587`), so nested response release did not buy load relief.
- The strongest v34 trace still has a startup interval: distance changes by
  only `0.0703 L` by `2 T`, while speed grows from zero to `0.136 L/T`; the
  coherent wake is visibly established later.  However, inherited guidance
  already shows that cadence/lag launch edits are not reliably beneficial, so
  this candidate does not retune propulsion.
- Over `4-17 T`, the current whole-wave pose projection reduces reconstructed
  within-beat target-bearing standard deviation from about `0.178` to
  `0.046 rad`.  The remaining residual correlates with the filtered body-frame
  head crossflow (`0.796`) and lateral force (`-0.805`).  This supports one
  small fluid-side common-mode test; it does not establish that direct force or
  rate feedback is safe.

## Policy hypothesis

Preserve the complete v34 carrier, redirect, bearing-divergence recovery,
route-rate correction, half-cycle steering, and saturation-aware spillover.
Add a bounded carrier-coherent crossflow angle only to the proportional
whole-wave pose projection.  Filtered local body-frame crossflow magnitude
weights the observed, de-meaned anterior joint phase; the sign remains tied to
joint phase so persistent crossflow is not rectified into a one-sided route
command.  The correction is excluded from raw large-error redirect geometry,
bearing trend, turn rate, carrier dynamics, and direct actuator commands.  This
should reduce fast fluid/body recoil that the joint-only pose model leaves in
the route bearing without cancelling the productive alternating wake or
repeating the previously catastrophic route-rate projection.

The frozen v34 trace is used only as a bounded counterfactual, not as claimed
closed-loop evidence.  A `2 deg` correction bound with the observed
`0.003 L/T` crossflow scale reduces reconstructed within-beat bearing standard
deviation from `0.0464` to about `0.0366 rad`; the term remains odd under a
body-frame reflection.  Its limited authority is intentional because the
closed-loop CFD outcome is deferred to the next worker.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish control
source_mechanism: separate slow target geometry from fast alternating crossflow and apply only bounded feedback to the latter
transferable_invariant: carrier-coherent body-frame crossflow can identify a fast locomotor common mode without becoming the route command
nontransferable_details: published gains, species kinematics, exact vortex phase, cylinder-wake synchronization, and memorized routes
policy_translation: use normalized local body-frame crossflow magnitude to weight an odd observed-joint-phase correction only in proportional gait-pose rejection
falsification: reject if capture or middle/late closure regresses, the coherent wake weakens, acceleration-limit residence or speed/load peaks materially rise, or imposed crossflow is mistaken for self-wake under another pose
