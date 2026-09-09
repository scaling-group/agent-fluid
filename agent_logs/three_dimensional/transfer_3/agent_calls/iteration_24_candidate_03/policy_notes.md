# Hydrodynamic response-surplus candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite dynamics, and capture. In every combined sheet, the top-down row
  shows body-led advance and a coherent alternating posterior vortex street
  from release to capture. The oblique row independently shows compact paired
  three-dimensional Lambda2 structures following the swimmer. There is no
  passive advection, wake collapse, collision, boundary excursion, or
  terminal loop. The current sample contains no failed termination; the
  complementary-handoff rollout is therefore the informative underperforming
  comparator, while the actuator-consistent rollout is the strongest finite
  comparator. Their visually similar wakes make the trajectory and load
  diagnostics decisive.
- The persistent actuator-consistent gate is still the fastest route. It
  captures at `18.67250T`, has mean distance `2.02129L`, and uses action RMS
  `24.95/28.85 rad/T^2`, anterior/posterior 99%-limit occupancy
  `42.68%/76.41%`, and force/moment RMS `0.01350/0.00703`. The complementary
  amplitude handoff lowers occupancy to `41.74%/74.48%` and loads to
  `0.01336/0.00696`, but arrives at `18.74950T` with worse mean distance
  `2.02989L`; it does not improve the route.
- The sign-only helpful-moment release reaches the lowest sampled loads and
  occupancy (`40.95%/74.41%`, `0.01306/0.00679`) but captures at
  `18.78799T`. The assigned parent's error-conditioned release captures at
  `18.77150T`, mean distance `2.02535L`, occupancy `41.25%/75.53%`, and
  force/moment RMS `0.01335/0.00695`. It is a valid intermediate trade, but
  it dominates neither the `18.67250T` fast endpoint nor the sign-only load
  endpoint. Multiplying helpful-moment release by
  `1 - abs(tanh(yaw_rate_error/scale))` therefore measures error closure, not
  whether the physical response is sufficient to replace phase authority.
- Local body-flow RMS remains `0.01798--0.01816U` across the cohort. Together
  with both visual rows, this supports preserving the self-generated carrier,
  normalized bearing/LOS-rate route law, distributed C-bend, response-
  reversing half-cycle, persistent same-side actuator gate, and explicit
  feasibility projection. The evidence does not support more propulsion,
  range scheduling, task coordinates, or another scalar-only gain change.

## Policy hypothesis recorded before editing

Start from the assigned parent and change one response-selection mechanism.
Normalize helpful hydrodynamic response with the existing moment scale, and
normalize residual correction with the existing bounded response direction.
Release posterior phase only by the positive surplus
`max(helping_moment_release - abs(response_direction), 0)`. Thus a small yaw
error alone cannot release steering: measured moment assistance must exceed
the remaining normalized request. Adverse or insufficient moment retains the
fast actuator-consistent phase path. The comparator is bounded, continuous,
reflection-invariant, memoryless, and expressed only through normalized body-
frame physical response and two-joint state feedback; it adds no gain, clock,
route, or exact vortex phase.

Support requires capture no later than the assigned parent's `18.77150T`
while keeping posterior occupancy at or below `75.53%` and force/moment RMS at
or below `0.01335/0.00695`; stronger support would approach the
`18.67250T` fast route without returning to `76.41%` posterior occupancy.
Falsify the mechanism if capture is lost, arrival exceeds `18.931T`, the
alternating wake weakens, posterior occupancy exceeds `76.41%`, or
force/moment RMS exceeds the inherited `0.01574/0.00810` high-pass failure
boundary. Any benefit remains unproven beyond direct-uniform still water near
`0.018U` local-flow RMS.

The structured bookshelf reconsultation trigger is not met. The latest three
completed iterations introduced complementary actuator handoff,
hydrodynamic-response selection, and error-conditioned response satisfaction,
all while retaining capture; the assigned-parent log likewise records the
preceding actuator-consistency mechanism and semantic timing improvement. No
bookshelf reference informs this edit, so no source-transfer block is
asserted.

The new CFD result is intentionally not claimed here; it becomes evidence only
after this worker exits.
