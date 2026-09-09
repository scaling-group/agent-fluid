# Response-reversing posterior phase replication candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. The top-down rows show body-led translation with a
  coherent alternating vorticity street, while the oblique rows show compact
  tail-associated three-dimensional Lambda2 structures through capture. The
  motion is self-propelled rather than background-flow or moving-window
  advection; local-flow magnitude RMS is only `0.0178--0.0184U`.
- The assigned response-reversing half-cycle policy now has two exact-hash
  captures at `18.9310T` and `19.0520T`, scores `-0.15357` and `-0.16031`.
  This replicates the semantic improvement over the inherited explicitly
  feasible distributed-C-bend band beginning at `19.2335T`; it is no longer a
  single-sample capture. Its two runs preserve the carrier with action RMS
  `24.85--25.22/28.75--28.86 rad/T^2`, force-magnitude RMS
  `0.01330--0.01357`, and moment RMS `0.00692--0.00707`.
- The sampled posterior phase-rotation variant also captures directly at
  `18.9970T` (score `-0.15967`, mean distance `2.0480L`). Its combined sheet
  retains the same alternating wake topology through capture. It reduces
  action RMS to `24.55/28.59 rad/T^2`, acceleration-limit occupancy to
  `41.3%/74.1%`, force-magnitude RMS to `0.01317`, and moment RMS to
  `0.00685`; those values are below both assigned-policy replications while
  arrival lies inside their `0.121T` spread. This supports a load-shaping
  tradeoff, not a claim of faster arrival.
- The informative weaker sample moves compatible slow posterior curvature
  into the anterior oscillator center. It still captures, but only at
  `19.2390T` (score `-0.17198`, mean distance `2.0610L`). It lowers force and
  moment RMS further to `0.01250/0.00654`, yet its head remains farther from
  target at `16T` and `18T`, and both visual rows show the corresponding
  delayed direct route rather than wake collapse. Together with the inherited
  `49.742T` near-range allocation loop and `1.845L` same-hash high-pass miss,
  this argues against another memoryless slow-curvature allocator, range gate,
  or mean-bend gain increase.

## Policy hypothesis recorded before editing

Start from the assigned, twice-captured response-reversing half-cycle policy
and add exactly the already sampled bounded posterior phase mechanism. Form the
posterior traveling wave by rotating its joint-position and normalized joint-
velocity coefficients at fixed norm. Select the phase-shift sign from the
product of normalized phase-conditioned yaw error and the observed local
joint-phase gradient, so steering reverses when measured yaw outruns route
demand. Preserve normalized body-frame bearing and LOS-rate guidance,
continuous two-joint route closure, the half-cycle scale, and explicit physical
acceleration projection. No clock, mutable history, coordinate, range gate, or
new mean curvature is introduced.

This candidate deliberately replicates a sampled Pareto mechanism rather than
claiming another untested scalar improvement. Falsify its reusable value if
the new evaluation loses capture, arrives later than the `19.2335T` feasible
C-bend reference, exceeds the assigned policy's load interval or `76.1%`
posterior limit occupancy, or visibly weakens the alternating wake. A second
capture within the assigned policy's timing spread with lower loads would
support phase rotation as a repeatable load-shaping primitive; it would not
establish robustness under stronger inflow or wake disturbance.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and posterior traveling-wave propulsion
source_mechanism: sensor-conditioned oscillator phase modulation that preserves the propulsive rhythm
transferable_invariant: steer by a bounded phase change tied to observed route error and yaw response while preserving the traveling-wave coefficient norm and reversing the change when response outruns demand
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame bearing and rotation-invariant LOS rate for desired yaw, recoil-conditioned yaw error for response, and current joint angle and velocity for the posterior phase gradient within the two-joint state-feedback contract
falsification: reject if capture is lost or delayed beyond 19.2335T, alternating wake coherence degrades, posterior limit occupancy exceeds 76.1%, or force and moment RMS exceed 0.01357 and 0.00707

The new CFD result is intentionally not claimed here; it becomes evidence only
after this worker exits.

## Validation status

- The required guidance semantic/schema check and solver edit-boundary check
  pass. The candidate is byte-identical to the sampled, finite phase-rotation
  policy whose evidence is summarized above.
- The configured lightweight Julia contract probe was invoked, but this
  environment has no `julia` executable. No CFD was run and no result for the
  new evaluation is claimed.
