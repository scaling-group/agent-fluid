# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no numerical instability. Their top-down sheets show
  continuous target-directed translation along the inherited S-shaped route
  while a red/blue alternating caudal street remains attached to the fish.
  With no imposed flow, the coincident body progress and posterior wake are
  evidence of self-propulsion rather than advection. Every sampled oblique row
  is black, however, so this generation supplies no independent visual claim
  about three-dimensional Lambda2 structure.
- The prefilled assigned-parent composition captures at `23.864521T`, with
  score-metric mean distance `2.192138L`, score `-0.294271`, mean action norm
  about `57.572`, and peak normalized force/moment
  `0.029479/0.015344`. It is the most informative lower-performing control:
  its wake and route remain useful, but its oscillator-recovery gate measures
  inertial forward speed even though its slow route loop already measures
  body motion relative to local water.
- Two semantically identical samples replace only that recovery observation
  with normalized through-water axial speed. They reproduce exactly the same
  `23.424515T` capture, `2.184349L` mean distance, `0.749902L` crossing, and
  `-0.287480` score. Their top-down route remains in the same class and their
  peak force/moment stay close at `0.029780/0.015287`; mean action rises to
  about `58.289`, near-target mean action to `45.013`, and anterior/posterior
  exact rate-cap occupancy is about `11.74/6.64%`. This is a reproducible
  semantic improvement in locomotor sensing, not evidence for a larger drive
  gain or for held-out wake robustness.
- A distinct sampled controller retains the parent's inertial recovery signal
  and adds only a target-signed posterior residual when measured normalized yaw
  moment opposes the requested turn. It captures at `23.545517T`, lowers mean
  distance to `2.188316L`, and improves score to `-0.291201`, while reducing
  peak force/moment to `0.029290/0.015223` and keeping mean action finite at
  about `57.906`. Its route and alternating mid-plane wake remain visibly in
  the inherited class. This independently positive load pathway is more
  informative than another exhausted terminal-gate or scalar-recovery edit.

## One candidate hypothesis

Use the twice-reproduced through-water recovery controller as the baseline and
add the sampled adverse-moment residual unchanged. Preserve its joint-state
traveling carrier, water-relative slow-route feedback, full target geometry,
anterior redirect, phase-selective posterior carrier, reactive-rudder sign,
and target-side response-qualified terminal relief. The anterior recovery
loop then reacts only to measured body-water axial progress, while a separate
bounded posterior residual rejects only normalized yaw load whose sign opposes
the persistent target-side turn. This is a small compatibility test between
two independently positive observation pathways; it adds no clock, route
memory, world coordinate, scalar gain change, or attempt to cancel every
lateral load.

Falsify the composition if capture is lost or later than the reproduced
`23.424515T` baseline, mean distance exceeds `2.184349L`, score falls below
`-0.287480`, or the established route, alternating top-down wake, mean-action,
`11.74/6.64%` rate-cap, `0.029780` peak-force, or `0.015287` peak-moment
envelopes materially worsen. A positive fixed-pose still-water result would
support compatibility only; complete oblique evidence plus a changed pose or
hydrodynamic condition is required before claiming three-dimensional or
multi-wake robustness.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling rhythmic carrier while separating locomotor recovery from bounded rejection of target-opposing yaw disturbance
transferable_invariant: normalized body-water advance may recruit anterior carrier energy while measured adverse yaw moment drives only a small target-signed posterior residual, leaving slow target geometry responsible for the route
nontransferable_details: published gains, dimensional thresholds, species or robot kinematics, exact vortex phases, cylinder geometry, prescribed timing, and task-specific routes
policy_translation: retain the evidenced joint-state carrier and through-water axial recovery, and add the sampled smooth dead-banded `moment_z_L2` residual only when its sign opposes the body-frame target turn
falsification: reject if capture is later than 23.424515T or lost, mean distance exceeds 2.184349L, score worsens below -0.287480, or route, wake, action, saturation, force, or moment envelopes worsen
