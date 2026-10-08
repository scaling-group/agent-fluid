# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm snapshot, finite actions, and `capture` termination. The available
  top-down rows show continuous target-directed translation and an attached
  alternating red/blue mid-plane street from wake formation through capture,
  so the motion is self-propelled rather than imposed advection. Every sampled
  oblique sheet is black, including the view-specific files, and therefore
  provides no independent three-dimensional wake evidence. The inherited
  complete two-view carrier evidence remains the applicable visual control;
  the current blank renders must not be interpreted as either wake loss or new
  3D confirmation.
- The two strongest sampled policies differ only cosmetically and exactly
  reproduce a `23.424515T`, 4,259-step capture, `0.749902L` crossing,
  `2.184349L` mean distance, and `-0.287480` score. They translate the existing
  bounded anterior recovery gate from inertial forward speed to normalized
  body-water axial speed. Against the matched inertial-speed controller without
  a moment reflex (`solver_4f671efd576e`), this advances capture from
  `23.864521T`, lowers mean distance from `2.192138L`, and preserves the same
  top-down route. Peak normalized force/moment remain finite at about
  `0.029780/0.015287`, with anterior/posterior rate-cap occupancy about
  `11.74/6.65%`. This is a semantic observation improvement, not support for a
  recovery-gain increase.
- The assigned parent (`solver_e1bb5f5ea1fa`) keeps inertial-speed recovery but
  adds a dead-banded adverse-moment residual to the posterior target. Relative
  to the matched inertial no-reflex sample, it advances capture to
  `23.545517T` and lowers mean distance to `2.188316L` and peak force/moment to
  about `0.029290/0.015223`. Mean action instead rises from about `57.57` to
  `57.91`, and near-target mean action rises from `41.56` to `44.20`, so this
  is a route/load improvement rather than an effort improvement. Offline
  replay of the unchanged residual gate
  on the strongest water-relative trace gives a mean absolute posterior offset
  of about `0.38 deg`, a `2.70 deg` maximum, and no change to the anterior
  oscillator or terminal law. Thus the reflex is independently useful and
  bounded, but its compatibility with water-relative locomotor recovery remains
  unevaluated.

## One candidate hypothesis

Preserve the assigned parent's joint-state traveling carrier, water-relative
lateral route loop, target-gated posterior rudder, phase-qualified terminal
relief, and adverse-moment rejection. Change only the locomotor-recovery
observation from inertial `-state.velocity_body_U[1]` to the sign-equivalent
through-water speed `state.relative_flow_velocity_body_U[1]`, as in the two
exactly reproduced strongest samples. This produces one small compatible
combination: slow target geometry owns route turning, body-water axial speed
owns bounded carrier recruitment, and only adverse normalized yaw moment owns
the soft posterior disturbance residual. It adds no gain, clock, global
coordinate, route memory, or prescribed vortex phase.

The current fixed-pose evaluation can test compatibility but cannot establish
multi-wake or pose robustness. Falsify the combination if capture is lost or
later than `23.424515T`, mean distance exceeds `2.184349L`, the preterminal
route changes adversely, or mean/near-target effort, `11.74/6.65%` rate-cap
occupancy, `0.029780/0.015287` peak load, or the established carrier wake
materially worsens. A complete oblique render is required before claiming new
3D-wake evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction feedback
source_mechanism: preserve a traveling rhythmic carrier while separating locomotor-relative sensing, slow target steering, and soft adverse-load rejection
transferable_invariant: normalized body-water advance should gate only carrier recovery, persistent body-frame target geometry should own route direction, and a bounded dead-banded load residual should oppose only target-adverse yaw without cancelling the rhythm
nontransferable_details: published gains, dimensional speeds and frequencies, species or robot kinematics, exact vortex phases, cylinder geometry, prescribed maneuver timing, and task-specific routes
policy_translation: retain the sampled posterior moment residual and every actuator allocation, but feed the existing smooth anterior recovery gate with sign-correct `relative_flow_velocity_body_U[1]` instead of inertial forward speed
falsification: reject if capture is later than 23.424515T or lost, mean distance exceeds 2.184349L, or route, wake, saturation, effort, force, or moment envelopes worsen
