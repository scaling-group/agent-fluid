# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=(0,0,0)`) and terminate in capture at `25.1185226 T` after 268
  moving-window shifts. Three samples are byte-identical v26 policies and
  trajectories: score `-0.528107835`, mean distance `2.429111372 L`, and final
  distance `0.746167541 L`.
- Both rows of the combined sheets were inspected for the repeated v26 rollout
  and the distinct v28 rollout. The top-down row shows self-propelled compact
  turning with a coherent alternating wake through the outer approach, then a
  smooth quiet glide into the capture circle. The oblique Lambda2 row confirms
  spatially coherent shed structures without a collision, boundary exit, wake
  collapse, or visible terminal oscillation. The sheets are visually
  indistinguishable at their resolution. No sampled rollout is a failure, so
  the informative contrast is the only distinct mechanism rather than a
  nonexistent failure sheet.
- v28 adds course-alignment-conditioned paired carrier release below `1.6 L`.
  It improves score by only `0.000004618`, mean distance by `0.000003640 L`,
  and final distance by `0.000004888 L`, without changing the capture step or
  trajectory class. Replay of the logged geometry shows that the course gate
  is active: signed target-minus-velocity course error falls from `0.4431` to
  `0.3103 rad` inside `1.6 L`. Yet v28 slightly increases that error relative
  to v26 at termination and raises the inside-band maximum lateral force from
  `0.0020376` to `0.0021364` while maximum command rises from
  `0.0964/0.2431` to `0.0979/0.2456 rad/T^2`.
- The inherited parent establishes v26's crossflow/closure-supported coupled
  allocation relief as the terminal baseline and rejects broad carrier
  stacking, yaw-rate-error curvature, and crossflow-based mean unloading. The
  inherited score logs add a mean-unloading regression at `-0.529558279` and a
  separate sampled capture at `-0.528123269`; neither is a reason to increase
  carrier release.

## Policy hypothesis

Preserve v26's outer carrier, target-angle redirect, crossflow-supported
allocation relief, and exact preterminal behavior. Only after the existing
late proximity, positive-closure, helpful-crossflow, and settled-response
conditions agree, form the signed angle from the normalized body-frame target
direction to the normalized body-frame velocity course. Add a small bounded
correction with that sign to the existing terminal mean-curvature equilibrium,
distributed over both joints in the already established head/tail redirect
ratio. This tests translational direction tracking at a different actuator
locus from v28's extra carrier allocation: the sampled positive course error
should strengthen the same-sign terminal bend just enough to rotate velocity
toward the capture corridor, rather than treating residual bearing as an
isolated yaw error or globally increasing propulsion.

Expected invariants are byte-equivalent commands outside `1.6 L`, continuous
activation, no clock or route state, no change of steering sign, and a
correction that vanishes at zero course error or without closure/helpful
crossflow/settled bend. Falsify the mechanism if capture is delayed or lost,
course error or radial closure fails to improve, the outer path changes, joint
stops or large terminal commands return, lateral force/moment grow materially,
or either visual row loses its coherent-wake/quiet-handoff topology.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and terminal approach control
source_mechanism: bounded sensory residual modulates a rhythmic controller while near-target drive and steering are scheduled by observed approach state
transferable_invariant: preserve the propulsive oscillator and apply only a bounded state-feedback directional correction that vanishes when measured velocity course agrees with target direction
nontransferable_details: published oscillator gains, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: signed target-to-course angle from normalized body-frame target and velocity vectors adds a late closure/crossflow/settled-gated two-joint mean-curvature correction in the existing redirect allocation ratio
falsification: reject if course alignment and radial closure do not improve without delaying capture, or if outer motion, wake coherence, saturation, joint-stop dwell, force, or moment regress
