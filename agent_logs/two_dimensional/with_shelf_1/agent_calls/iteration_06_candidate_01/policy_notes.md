# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of the
  four staggered cylinders while their interacting streets develop around the
  second-row target. It is common initial-condition evidence, not a policy
  difference.
- All sampled released sheets are finite successes with the same useful
  topology: a sharp initial clockwise redirect, then an actively propelled
  leftward/downward traverse through the merged wake. The regular posterior
  body wake and roughly `-10.9L` head displacement in x rule out passive
  advection as the primary transport. No failed sheet is sampled; the inherited
  slower/smaller curvature-carrier instability remains the failure boundary.
- Bearing-scheduled reservation is the strongest current result. It reaches in
  `46.035`, has mean distance `2.0695L`, and mean command energy `1237.1`, but
  pays RMS force/moment `51.40/761.46`. Course-slip correction with constant
  reservation reaches in `48.032` and lowers loads to `37.92/605.38`, but uses
  mean command energy `1299.7`.
- The assigned-parent log proposed feeding the slip-corrected error into both
  steering and reservation. Its sampled evaluation (duplicated as
  `solver_25436e69e921`) still reaches, but regresses against raw-bearing
  scheduling: arrival `46.761`, mean distance `2.1087L`, mean effort `1259.8`,
  and RMS force/moment `59.04/923.45`. Its sheet remains coherent but finishes
  with less downward head displacement (`-4.098L` versus `-4.327L`), consistent
  with targetward course feedback releasing directional allocation too early.
  Therefore the two independently useful feedback effects are not compositional
  when one corrected signal drives both roles.

## Candidate hypothesis

Preserve the successful `0.55`-period joint-state carrier, posterior lag,
same-sign bearing residual, joint split, `30.0` envelope, and raw-bearing
reservation schedule. Add the already sampled regularized body-frame course
slip only to the steering residual. This separates roles: persistent target
geometry controls how much finite authority is protected, while measured
lateral course response removes redundant curvature inside that protected
channel. It is one structural signal-routing change, not scalar gait tuning.

Expected test: preserve capture and the scheduler's early redirect while
moving force/moment or route compactness toward the course-slip result without
the fully coupled combination's effort/load regression. Falsify if capture is
lost, arrival exceeds the `49.142` constant-reserve baseline, mean effort is
above `1299.7` without a load benefit, loads exceed `59.04/923.45`, or the same
reduced-downward-progress route remains. This candidate is not evaluated until
after the worker exits.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and wake-interaction control
source_mechanism: sensor-conditioned route correction around a bounded rhythmic propulsive carrier
transferable_invariant: persistent body-frame target geometry and measured lateral course response have different control roles, so disturbance correction should not automatically weaken the finite authority reserved for route recovery
nontransferable_details: published gains, robot geometry and actuators, clocked phases, species kinematics, dimensional beat rates, exact vortex phases, and source-task routes
policy_translation: use regularized normalized body-frame lateral velocity only in the bearing residual, while current body-frame bearing independently schedules the reserved share of the unchanged two-joint carrier/residual envelope
falsification: reject if semantic capture or coherent upstream propulsion is lost, or if role separation fails to improve arrival, effort, route, or force/moment relative to the already evaluated fully coupled combination
